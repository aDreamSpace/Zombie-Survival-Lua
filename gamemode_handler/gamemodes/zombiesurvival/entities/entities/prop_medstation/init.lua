AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local function RefreshCrateOwners(pl)
	for _, ent in pairs(ents.FindByClass("prop_medstation")) do
		if ent:IsValid() and ent:GetObjectOwner() == pl then
			ent:SetObjectOwner(NULL)
		end
	end
end
hook.Add("PlayerDisconnected", "MedicalStation.PlayerDisconnected", RefreshCrateOwners)
hook.Add("OnPlayerChangedTeam", "MedicalStation.OnPlayerChangedTeam", RefreshCrateOwners)

ENT.MaxMeds = 200
ENT.GiveMedInterval = 15
ENT.HealAmt = 1
ENT.Range = 16384 --use sqr of whatever val for range, marginally faster

ENT.TimeToCheck = 0
ENT.CheckTime = 0.1

ENT.Waiting = false
ENT.DispenseTime = 6
ENT.DispensingTime = 0

ENT.WaitingTime = 0

function ENT:Initialize()
	self:SetModel("models/props/deployable/medstation_1.mdl")
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end

	self:SetMaxObjectHealth(200)
	self:SetObjectHealth(self:GetMaxObjectHealth())

	self:SetStoredMeds(0)
	self:SetPos(self:GetPos() - Vector(0,0,-30))
	timer.Simple(0, function()
		local owner = self:GetObjectOwner()
		if owner:IsValid() then
			owner.MedCooldownTbl = owner.MedCooldownTbl or {}
			local cooldown = owner.MedCooldownTbl[#owner.MedCooldownTbl]
			if cooldown then
				self.WaitingTime = cooldown
				table.remove(owner.MedCooldownTbl)
			end

			owner.MedPwrTbl = owner.MedPwrTbl or {}
			local medpwr = owner.MedPwrTbl[#owner.MedPwrTbl]
			if medpwr then
				self:SetStoredMeds(medpwr)
				table.remove(owner.MedPwrTbl)
			end
		else
			print("Medstation created by NULL entity, not a player!")
		end
	end)
	
end

function ENT:KeyValue(key, value)
	key = string.lower(key)
	if key == "maxcratehealth" then
		value = tonumber(value)
		if not value then return end

		self:SetMaxObjectHealth(value)
	elseif key == "cratehealth" then
		value = tonumber(value)
		if not value then return end

		self:SetObjectHealth(value)
	end
end

function ENT:AcceptInput(name, activator, caller, args)
	if name == "setcratehealth" then
		self:KeyValue("cratehealth", args)
		return true
	elseif name == "setmaxcratehealth" then
		self:KeyValue("maxcratehealth", args)
		return true
	end
end

function ENT:SetObjectHealth(health)
	self:SetDTFloat(0, health)
	if health <= 0 and not self.Destroyed then
		self.Destroyed = true

		local ent = ents.Create("prop_physics")
		if ent:IsValid() then
			ent:SetModel(self:GetModel())
			ent:SetMaterial(self:GetMaterial())
			ent:SetAngles(self:GetAngles())
			ent:SetPos(self:GetPos())
			ent:SetSkin(self:GetSkin() or 0)
			ent:SetColor(self:GetColor())
			ent:Spawn()
			ent:Fire("break", "", 0)
			ent:Fire("kill", "", 0.1)
		end
	end
end

function ENT:OnTakeDamage(dmginfo)
	self:TakePhysicsDamage(dmginfo)

	local attacker = dmginfo:GetAttacker()
	if not (attacker:IsValid() and attacker:IsPlayer() and attacker:Team() == TEAM_HUMAN) then
		self:SetObjectHealth(self:GetObjectHealth() - dmginfo:GetDamage())
		self:ResetLastBarricadeAttacker(attacker, dmginfo)
	end
end

function ENT:AltUse(activator, tr)
	self:PackUp(activator)
end

function ENT:OnPackedUp(pl)
	pl:GiveEmptyWeapon("weapon_zs_medstation")
	pl:GiveAmmo(1, "smg1_grenade")

	pl:PushPackedItem(self:GetClass(), self:GetObjectHealth())
	pl.MedPwrTbl = pl.MedPwrTbl or {}
	pl.MedPwrTbl[#pl.MedPwrTbl+1] = self:GetStoredMeds()

	pl.MedCooldownTbl = pl.MedCooldownTbl or {}
	pl.MedCooldownTbl[#pl.MedCooldownTbl+1] = self.WaitingTime

	self:Remove()
end

function ENT:StartDispensing()
	if !self:GetObjectOwner():IsValid() then return end
	self:EmitSound("hl1/ambience/steamburst1.wav")
	self:SetDispensing(true)
	self.DispensingTime = CurTime() + self.DispenseTime
end

function ENT:StopDispensing()
	self:SetDispensing(false)
	self.WaitingTime = CurTime() + self.WaitTime
end
local cacheRefresh
local medSupply
local cachedMedUpdate
local medDifference
local plys
local strPCanHeal = "PlayerCanBeHealed"
local bStatus
local iStored
local fCT
function ENT:Think()
	if self.Destroyed then
		self:Remove()
	end

	fCT = CurTime()
	bStatus = self:GetDispensing()
	iStored = self:GetStoredMeds()

	if self.WaitingTime < fCT and self.DispensingTime < fCT and !bStatus and iStored > 0 then
		self:StartDispensing() --start dispensing makes this statement false and will go to the next one eventually
		return
	end
	
	if self.DispensingTime < fCT and bStatus then
		self:StopDispensing() --false until dispense time is up, goes to next block
	end
	
	if self.DispensingTime > fCT and self.TimeToCheck < fCT and iStored > 0 then
		self.TimeToCheck = fCT + self.CheckTime
		medSupply = self:GetStoredMeds()
		cachedMedUpdate = medSupply
		
		plys = player.GetAll()
		for i = 1, #plys do
			ply = plys[i]
			if ply and ply:IsValid() and ply:Team() == TEAM_HUMAN and ply:Alive() and gamemode.Call(strPCanHeal, ply) and ply:Health() < ply:GetMaxHealth() and cachedMedUpdate - self.HealAmt >= 0 then
				if ply:GetPos():DistToSqr(self:GetPos()) < self.Range then
					ply:SetHealth(ply:Health() + self.HealAmt)
					gamemode.Call("PlayerHealedTeamMember", self:GetObjectOwner(), ply, self.HealAmt, self)
					cachedMedUpdate = cachedMedUpdate - self.HealAmt
				end
			end
		end

		medDifference = medSupply - cachedMedUpdate
		if medDifference > 0 then
			self:SetStoredMeds(cachedMedUpdate)
		end
	end	
end

function ENT:Use(activator, caller)
	if activator:Team() ~= TEAM_HUMAN or not activator:Alive() then return end

	if not self:GetObjectOwner():IsValid() then
		self:SetObjectOwner(activator)
	end

	local meds = activator:GetAmmoCount("battery")
	local medsInv = self:GetStoredMeds()
	local wpn = activator:GetWeapon("weapon_zs_medicalkit")
	local medsInKit = 0
	if wpn:IsWeapon() then
		medsInKit = wpn:Clip1()
	end
	--need to sanitize player's medkit, since sometimes they'll have 30 or something medpower left over but cannot give it
	--this fixes the issue that was on QG
	if medsInKit > 0 then
		activator:GetWeapon("weapon_zs_medicalkit"):SetClip1(0)
		activator:GiveAmmo(medsInKit, "battery", true)
		meds = meds + medsInKit
		medsInKit = 0
	end
	
	if meds > 0 and medsInv < self.MaxMeds then
		--middle arg prevents not being able to put in the last 15 medpower
		--this was an ALSO an issue on QG that is fixed here
		local medsToGive = math.min(meds, (self.MaxMeds - medsInv), self.GiveMedInterval)
		if medsToGive <= 0 then return end
		self:SetStoredMeds(self:GetStoredMeds() + medsToGive)
		activator:RemoveAmmo(medsToGive, "battery")
		self:EmitSound("npc/turret_floor/click1.wav")
		if activator ~= self:GetObjectOwner() then
			gamemode.Call("PlayerHealedTeamMember", activator, self, medsToGive * (1/2), self)
		end
	end
end
