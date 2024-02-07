local pos
local norm
local strBreak = "zsounds/explode/brute_belly_puss_shared_0"
local strWav = ".wav"
local strHard = "zsounds/explode/brute_belly_puss_shared_0"
local strBlood = "noxctf/sprite_bloodspray"
local particle
local emitter
function EFFECT:Init(data)
	pos = data:GetOrigin()
	norm = data:GetNormal()

	sound.Play(strBreak..math.random(1, 4)..strWav, pos, 77, math.Rand(90, 110))
	for i=0, math.random(2, 3) do
		timer.SimpleEx(i * math.Rand(0.1, 0.3), sound.Play, strHard..math.random(1, 4)..strWav, pos, 77, math.Rand(90, 110))
	end

	emitter = ParticleEmitter(pos)

	for i=1, 8 do
		particle = emitter:Add(strBlood..math.random(8), pos)
		particle:SetVelocity(norm * 32 + VectorRand() * 16)
		particle:SetDieTime(math.Rand(1.5, 2.5))
		particle:SetStartAlpha(120)
		particle:SetEndAlpha(0)
		particle:SetStartSize(math.Rand(13, 14))
		particle:SetEndSize(math.Rand(10, 12))
		particle:SetRoll(180)
		particle:SetDieTime(3)
		particle:SetColor(255, 255, 0)
		particle:SetLighting(true)
	end

	particle = emitter:Add(strBlood..math.random(8), pos)
	particle:SetVelocity(norm * 32)
	particle:SetDieTime(math.Rand(2.25, 3))
	particle:SetStartAlpha(120)
	particle:SetEndAlpha(0)
	particle:SetStartSize(math.Rand(28, 32))
	particle:SetEndSize(math.Rand(14, 28))
	particle:SetRoll(180)
	particle:SetColor(255, 255, 0)
	particle:SetLighting(true)

	emitter:Finish()

	util.Blood(pos, math.random(16, 22), Vector(0,0,1), 300)
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
