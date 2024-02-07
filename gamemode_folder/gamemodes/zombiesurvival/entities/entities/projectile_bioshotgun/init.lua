AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self.DeathTime = CurTime() + 30

	self:SetModel("models/dav0r/hoverball.mdl")
	self:SetColor(Color(123, 0, 230))
	self:SetModelScale(1.2)
	self:PhysicsInitSphere(10)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetupGenericProjectile(false)

	self.LastPhysicsUpdate = UnPredictedCurTime()
end
local vecDown = Vector()
function ENT:PhysicsUpdate(phys)
	local dt = UnPredictedCurTime() - self.LastPhysicsUpdate
	self.LastPhysicsUpdate = UnPredictedCurTime()

	vecDown.z = dt * -100
	phys:AddVelocity(vecDown)
end

function ENT:Think()
	if self.PhysicsData then
		self:Hit(self.PhysicsData.HitPos, self.PhysicsData.HitNormal, self.PhysicsData.HitEntity)
	end

	if self.DeathTime <= CurTime() then
		self:Remove()
	end
end

function ENT:Hit(vHitPos, vHitNormal, eHitEntity)
	if self.Exploded then return end
	self.Exploded = true
	self.DeathTime = 0

	local owner = self:GetOwner()
	if not owner:IsValid() then owner = self end

	vHitPos = vHitPos or self:GetPos()
	vHitNormal = vHitNormal or Vector(0, 0, 1)

	local effectdata = EffectData()
		effectdata:SetOrigin(vHitPos)
		effectdata:SetNormal(vHitNormal)
	util.Effect("explosion_doomball", effectdata)

	-- Massive damage to drones and manhacks.
	if eHitEntity and eHitEntity:IsValid() then
		eHitEntity:TakeDamage(520, owner, self)

		if eHitEntity.FizzleStatusAOE then return end
	end

	for _, ent in pairs(util.BlastAlloc(self, owner, vHitPos, 128)) do
		if ent:IsValidLivingPlayer() and gamemode.Call("PlayerShouldTakeDamage", ent, owner) and ent ~= owner then
			ent:GiveStatus("dimvision", 10)
			local gt = ent:GiveStatus("enfeeble", 5)
			if gt and gt:IsValid() then
				gt.Applier = owner
			end
			ent:GiveStatus("slow", 5)
		end
	end
end

function ENT:PhysicsCollide(data, phys)
	self.PhysicsData = data
	self:NextThink(CurTime())
end
