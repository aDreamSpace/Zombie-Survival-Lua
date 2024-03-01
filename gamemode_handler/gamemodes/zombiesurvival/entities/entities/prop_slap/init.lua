AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.ExplosionDamage = 250
ENT.ExplosionRadius = 384
ENT.ExplosiveName = "prop_slap"
ENT.DetonatorName = "weapon_zs_slapremote"
local function RefreshDetpackOwners(pl)
	for _, ent in pairs(ents.FindByClass("prop_slap")) do
		if ent:IsValid() and ent:GetOwner() == pl then
			ent:SetOwner(NULL)
		end
	end
end
hook.Add("PlayerDisconnected", "Slap.PlayerDisconnected", RefreshDetpackOwners)
hook.Add("OnPlayerChangedTeam", "Slap.OnPlayerChangedTeam", RefreshDetpackOwners)

ENT.NextBlip = 0

function ENT:Initialize()
	self:SetModel("models/weapons/w_slam.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
		phys:Wake()
	end

	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
end

function ENT:AltUse(activator, tr)
	self:PackUp(activator)
end

function ENT:OnTakeDamage(dmginfo)
	self:TakePhysicsDamage(dmginfo)

	if not self.Exploded and dmginfo:GetDamage() >= 9 then
		local attacker = dmginfo:GetAttacker()
		if not (attacker:IsValid() and attacker:IsPlayer() and attacker:Team() == TEAM_HUMAN) then
			self.ForceExplode = true
			self:Explode()
		end
	end
end

function ENT:Use(activator, caller)
	if self.Exploded or self:GetExplodeTime() ~= 0 or not activator:IsPlayer() or activator:Team() ~= TEAM_HUMAN or self:GetMaterial() ~= "" then return end

	local owner = self:GetOwner()
	if owner == activator or not owner:IsValid() then
		self:SetOwner(activator)

		if not activator:HasWeapon(self.DetonatorName) then
			activator:Give(self.DetonatorName)
		end
		activator:SelectWeapon(self.DetonatorName)
	end
end

function ENT:Explode()
	if self.Exploded then return end
	self.Exploded = true

	local owner = self:GetOwner()
	if owner:IsValid() and owner:IsPlayer() and owner:Team() == TEAM_HUMAN then
		local pos = self:GetPos()

		util.BlastDamage2(self, owner, pos, 320, self.ExplosionDamage)

		local effectdata = EffectData()
		effectdata:SetOrigin(pos)
		
		util.Effect("Explosion", effectdata)
	end
end

function ENT:Think()
	if self.Exploded then
		self:Remove()
		return
	end

	if self:GetExplodeTime() ~= 0 then
		if CurTime() >= self:GetExplodeTime() then
			self:Explode()
		elseif self.NextBlip <= CurTime() then
			self.NextBlip = CurTime() + 0.4
			self:EmitSound("weapons/c4/c4_beep1.wav")
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:OnPackedUp(pl)
	pl:GiveEmptyWeapon("weapon_zs_slap")
	pl:GiveAmmo(1, "detslap")

	self:Remove()
end
