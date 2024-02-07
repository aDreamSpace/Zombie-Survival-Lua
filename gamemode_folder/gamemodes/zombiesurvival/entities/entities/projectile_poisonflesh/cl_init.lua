include("shared.lua")

ENT.NextEmit = 0

function ENT:Initialize()
	self:DrawShadow(false)
	self.Size = math.Rand(10, 14)
end

local colFlesh = Color(255, 255, 255, 255)
local matFlesh = Material("decals/Yblood1")
function ENT:Draw()
	local size = self.Size

	render.SetMaterial(matFlesh)
	local pos = self:GetPos()
	render.DrawSprite(pos, size, size, colFlesh)

	if CurTime() < self.NextEmit then return end
	self.NextEmit = CurTime() + 0.1 -- Increase the delay between emissions

	local emitter = ParticleEmitter(pos)
	emitter:SetNearClip(36, 44)

	local particle = emitter:Add("decals/Yblood"..math.random(1, 6), pos + VectorRand():GetNormalized())
	particle:SetVelocity(VectorRand():GetNormalized())
	particle:SetDieTime(math.Rand(0.3, 0.45)) -- Reduce the lifespan of particles
	particle:SetStartAlpha(255)
	particle:SetEndAlpha(255)
	particle:SetStartSize(size * 0.1) -- Reduce the start size
	particle:SetEndSize(0)
	particle:SetRoll(math.Rand(0, 360))
	particle:SetRollDelta(math.Rand(-2, 2)) -- Reduce the roll delta
	particle:SetLighting(true)

	emitter:Finish()
end