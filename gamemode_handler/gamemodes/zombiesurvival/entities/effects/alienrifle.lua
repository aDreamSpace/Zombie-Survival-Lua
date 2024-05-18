function EFFECT:Think()
	return false
end

function EFFECT:Render()
end

local function CollideCallback(particle, hitpos, hitnormal)
	if particle:GetDieTime() == 0 then return end
	particle:SetDieTime(0)

	if math.random(3) == 3 then
		sound.Play("buttons/button14.wav", hitpos, 50, math.Rand(140, 150)) -- HL2 button sound
	end

	if math.random(3) == 3 then
		util.Decal("Impact.AlienFlesh", hitpos + hitnormal, hitpos - hitnormal)
	end
end

function EFFECT:Init(data)
	local pos = data:GetOrigin()
	local hitnormal = data:GetNormal() * -1

	local emitter = ParticleEmitter(pos)
	emitter:SetNearClip(24, 48)

	local grav = Vector(0, 0, -500)
	local numParticles = 1
	for i = 1, numParticles do
		local particle = emitter:Add("particles/smokey", pos)
		particle:SetVelocity(VectorRand():GetNormalized() * math.Rand(32, 72) + hitnormal * math.Rand(48, 198))
		particle:SetDieTime(math.Rand(0.2, 0.5))
		particle:SetStartAlpha(200)
		particle:SetEndAlpha(0)
		particle:SetStartSize(math.Rand(1, 3))
		particle:SetEndSize(0)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-15, 15))
		particle:SetColor(math.Rand(200, 255), math.Rand(200, 255), math.Rand(0, 50)) -- Orange and Yellow and Green colors
		particle:SetLighting(false)
		particle:SetGravity(grav)
		particle:SetCollide(true)
		particle:SetCollideCallback(CollideCallback)
	end
	emitter:Finish()

	util.Decal("Impact.AlienFlesh", pos + hitnormal, pos - hitnormal)
end
