AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.GrenadeDamage = 756

function ENT:Initialize()
	self.DieTime = CurTime() + self.LifeTime

	self:SetModel("models/weapons/w_grenade.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		phys:SetMass(4)
		phys:SetMaterial("metal")
	end
end

function ENT:PhysicsCollide(data, phys)
	
	if not self.Entity.Hit then self.Entity.Hit = false end
	if self.Entity.Hit then return end

	self.Entity.Hit = true

	phys:EnableMotion(false)
	phys:Sleep()
	
	if data.HitEntity:IsValid() then
		if data.HitEntity:IsNPC() or data.HitEntity:IsPlayer() then
			self.Entity:SetParent(data.HitEntity)
		else
			self.Entity.HitEnt = data.HitEntity
			self.Entity.HitWeld = true
		end

		phys:EnableMotion(true)
		phys:Wake()
	end
	
end


function ENT:Think()
	if self.Exploded then
		self:Remove()
	elseif self.DieTime <= CurTime() then
		self:Explode()
	end
end

function ENT:Explode()
	if self.Exploded then return end
	self.Exploded = true

	local owner = self:GetOwner()
	if owner:IsValid() and owner:IsPlayer() and owner:Team() == TEAM_HUMAN then
		local pos = self:GetPos()

		util.BlastDamage2(self, owner, pos, self.GrenadeRadius or 256, self.GrenadeDamage or 756)

		local effectdata = EffectData()
			effectdata:SetOrigin(pos)
		util.Effect("Explosion", effectdata)
	end
end
