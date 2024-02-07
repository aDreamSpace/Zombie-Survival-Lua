include("shared.lua")

local matGlow = Material("effects/splashwake1")
local matGlow2 = Material("sprites/glow04_noz")
local matWhite = Material("models/debug/debugwhite")
local vector_origin = vector_origin

function ENT:Draw()
	local alt = self:GetDTBool(0)

    render.ModelMaterialOverride(matWhite)
	render.SetColorModulation(0.322, 0, 0.667)
	render.SuppressEngineLighting(true)
	self:DrawModel()
	render.SuppressEngineLighting(false)
	render.SetColorModulation(0, 0.224, 0.886)
	render.ModelMaterialOverride(nil)

	local pos = self:GetPos()

	if self:GetVelocity() ~= vector_origin then
		render.SetMaterial(matGlow2)
		render.DrawSprite(pos, alt and 25 or 50, alt and 25 or 50, Color(143, alt and 89 or 100, 240, 240))
		render.SetMaterial(matGlow)
		render.DrawSprite(pos, alt and 6 or 12, alt and 6 or 12, Color(143, alt and 88 or 240, 240))

		local emitter = ParticleEmitter(pos)
		emitter:SetNearClip(24, 32)
		local particle
		for i=0, 1 do
			particle = emitter:Add(matGlow2, pos)
			particle:SetVelocity(VectorRand() * 5)
			particle:SetDieTime(0.1)
			particle:SetStartAlpha(alt and 65 or 125)
			particle:SetEndAlpha(0)
			particle:SetStartSize(5)
			particle:SetEndSize(0)
			particle:SetRollDelta(math.Rand(-10, 10))
			particle:SetColor(135, alt and 66 or 200, 100)
		end
		emitter:Finish() emitter = nil collectgarbage("step", 64)
	end
end

function ENT:OnRemove()
	local pos = self:GetPos()
	local alt = self:GetDTBool(0)

	sound.Play("weapons/physcannon/energy_bounce1.wav", pos, 75, math.random(60, 70)) 

	local emitter = ParticleEmitter(pos)
	emitter:SetNearClip(24, 32)
	local particle
	for i=0, 19 do
		particle = emitter:Add(matGlow, pos)
		particle:SetVelocity(VectorRand() * 75)
		particle:SetDieTime(0.3)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(math.Rand(2, 3))
		particle:SetEndSize(0)
		particle:SetRoll(math.Rand(-0.8, 0.8))
		particle:SetRollDelta(math.Rand(-3, 3))
		particle:SetColor(103, alt and 77 or 233, 220)
	end
	for i=0,5 do
		particle = emitter:Add(matGlow, pos)
		particle:SetVelocity(VectorRand() * 5)
		particle:SetDieTime(0.3)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(math.Rand(24, 25))
		particle:SetEndSize(0)
		particle:SetRoll(math.Rand(-0.8, 0.8))
		particle:SetRollDelta(math.Rand(-3, 3))
		particle:SetColor(103, 78, 240)
	end
	for i=1, 45 do
		particle = emitter:Add("effects/splash2", pos)
		particle:SetDieTime(0.1)
		particle:SetColor(105, alt and 77 or 235, 220)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(5)
		particle:SetEndSize(0)
		particle:SetStartLength(1)
		particle:SetEndLength(5)
		particle:SetVelocity(VectorRand():GetNormal() * 100)
	end
	emitter:Finish() emitter = nil collectgarbage("step", 64)
end

function ENT:Initialize()
end

function ENT:Think()
end
