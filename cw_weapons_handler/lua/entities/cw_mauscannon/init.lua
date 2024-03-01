AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local phys, vel, owner, pos, DotProduct, traceDir, trace, ownerVel, aimVec, randomShake, random, ED, distance, relation, forceDir, pos2
local td = {}

ENT.RocketModel = "models/khrcw2/ins2rpg7rocket.mdl"
ENT.RocketSpeed = 3000
ENT.RocketName = "ent_ins2rpgrocket"
ENT.RocketDamage = 300
ENT.RocketRadius = 300

function ENT:IndividualInitialize()
	self:SetGravity(0.3)
end

function ENT:Initialize()
	self:SetModel(self.RocketModel) 
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_FLYGRAVITY)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	self:SetDTInt(0, 1)
	phys = self:GetPhysicsObject()

	if phys and phys:IsValid() then
		phys:Wake()
	end
	
	self.RocketSound = CreateSound(self, "weapons/ins2rpg7/rpg_rocket_loop.wav")
	self.RocketSound:SetSoundLevel(95)
	self.RocketSound:Play()

	spd = physenv.GetPerformanceSettings()
    spd.MaxVelocity = 4528
	
    physenv.SetPerformanceSettings(spd)
	self:IndividualInitialize()
end

function ENT:OnTakeDamage(dmginfo)
	return false
end

function ENT:Use(activator, caller)
	return false
end

function ENT:Think()

end

function ENT:Touch(ent)
	owner = self:GetOwner()
	
	if ent != owner and ent:GetClass() != "trigger_soundscape" then
		self.MissileType = 0
		self:Explode()
	end
end

function ENT:PhysicsCollide(data, physobj)
	self.MissileType = 0
	self:Explode()
end

function ENT:OnRemove()
	self.RocketSound:Stop()
	util.ScreenShake( self:GetPos(), 130, 50, 1.75, 900 )
end

function ENT:Explode()
	if self.BlewUp then
		return
	end
	
	owner = self:GetOwner()
	pos = self:GetPos()
	ED = EffectData()
	ED:SetOrigin(pos)
	
	util.Effect("Explosion", ED)
	
	ParticleEffect("rpg7_explosion_full", pos, Angle(0, 0, 0), nil)
	--ParticleEffect("dusty_explosion_rockets", pos, Angle(0, 0, 0), nil)
	
	if owner:IsValid() and owner:Alive() then
		owner.CanReload = true
	end

	util.BlastDamageEx(self, owner, pos, self.RocketRadius, self.RocketDamage, DMG_GENERIC)

	SafeRemoveEntity(self)
end