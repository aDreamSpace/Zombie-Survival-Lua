AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

--[[
local function RefreshConstructorOwners(pl)
	for _, ent in pairs(ents.GetAll()) do
		if ent.IsConstructor and ent:IsValid() and ent:GetObjectOwner() == pl then
			ent:SetObjectOwner(NULL)
		end
	end
end
hook.Add("PlayerDisconnected", "Constructor.PlayerDisconnected", RefreshConstructorOwners)
hook.Add("OnPlayerChangedTeam", "Constructor.OnPlayerChangedTeam", RefreshConstructorOwners)
]]

function ENT:Initialize()
	self:SetModel("models/props_c17/gravestone_cross001a.mdl")
	self:SetModelScale(0.5)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetUseType(SIMPLE_USE)
	self:SetCustomCollisionCheck(true)
	self:CollisionRulesChanged()
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMaxObjectHealth(2000)
	self:SetObjectHealth(self:GetMaxObjectHealth())
	
	self:SetMaxObjectFuel(500)
	self:SetPos(self:GetPos() - Vector(0,0,-30))
	-- Added this so we don't have to set the players ammo.
	if not self.AmmoSet then
		self:SetObjectFuel(500)
		self.AmmoSet = true
	else
		self:SetObjectFuel(self:GetObjectFuel())
	end


	local phys = self:GetPhysicsObject()
	if (IsValid(phys)) then
		phys:EnableMotion(false)
	
	end
	
	self.IsConstructor = true
end

function ENT:Think()
	if (self.Destroyed) then
		local pos = self:LocalToWorld(self:OBBCenter())
	
		local eff = EffectData()
		eff:SetOrigin(pos)
		util.Effect("Explosion", eff)
		self:Remove()
	else
		if (!self.ns or CurTime() >= self.ns) then
			if (self:GetObjectFuel() <= 0) then
				return
			end
			
			local play = false
		
			self.ns = CurTime() + 3
			for _, v in pairs (ents.FindByClass("prop_nail")) do
				if (v:GetPos():Distance(self:GetPos()) <= 256) then
					local hp, max = v:GetNailHealth(), v:GetMaxNailHealth()
					if (hp < max) then
						play = true
					
						v:GetBaseEntity():SetBarricadeHealth(math.min(max, hp + 30))
						self:SetObjectFuel(math.max(0, self:GetObjectFuel() - 0))
						
						if (self:GetObjectFuel() <= 0) then
							break
						end
					end
				end
			end

			if (play) then
				local snd = math.random(1,12)
				if snd == 4 or snd == 9 or snd == 11 then snd = snd + 1 end
				self:EmitSound("npc/scanner/combat_scan1.wav", 60, 250)
			end
		end
	end
end

function ENT:Use(activator, caller)
	if self.Removing or not activator:IsPlayer() or self:GetMaterial() ~= "" then return end

	if activator:Team() == TEAM_HUMAN then
		if self:GetObjectOwner():IsValid() then
			local curfuel = self:GetObjectFuel()
			local togive = math.min(math.min(5, activator:GetAmmoCount("Pulse")), self:GetMaxObjectFuel() - curfuel)
			if togive > 0 then
				self:SetObjectFuel(curfuel + togive)
				activator:RemoveAmmo(togive, "Pulse")
				activator:RestartGesture(ACT_GMOD_GESTURE_ITEM_GIVE)
				self:EmitSound("npc/turret_floor/click1.wav")
				--gamemode.Call("PlayerRepairedObject", activator, self, togive, self)
			end
		else
			self:SetObjectOwner(activator)
		end
	end
end

function ENT:OnTakeDamage(dmginfo)
	self:TakePhysicsDamage(dmginfo)

	local attacker = dmginfo:GetAttacker()
	if not (attacker:IsValid() and attacker:IsPlayer() and attacker:Team() == TEAM_HUMAN) then
		self:ResetLastBarricadeAttacker(attacker, dmginfo)
		self:SetObjectHealth(self:GetObjectHealth() - dmginfo:GetDamage())
	end
end

