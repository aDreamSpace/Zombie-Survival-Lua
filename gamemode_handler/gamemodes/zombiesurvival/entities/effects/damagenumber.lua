EFFECT.LifeTime = 3

local TEXT_ALIGN_CENTER = TEXT_ALIGN_CENTER
local TEXT_ALIGN_TOP = TEXT_ALIGN_TOP
local draw = draw
local cam = cam

local Particles = {}

local col = Color(220, 0, 0)
local colprop = Color(220, 220, 0)
local done
local curtime
local ang, right
local c
local strFont = "ZS3D2DFont2Big"
hook.Add("PostDrawTranslucentRenderables", "DrawDamage", function()
	if #Particles == 0 then return end

	done = true
	curtime = CurTime()

	ang = EyeAngles()
	right = ang:Right()
	ang:RotateAroundAxis(ang:Up(), -90)
	ang:RotateAroundAxis(ang:Forward(), 90)

	for _, particle in pairs(Particles) do
		if particle and curtime < particle.DieTime then
			c = particle.Type == 1 and colprop or col

			done = false

			c.a = math.Clamp(particle.DieTime - curtime, 0, 1) * 220

			cam.Start3D2D(particle:GetPos(), ang, 0.1)
				draw.SimpleText(particle.Amount, strFont, 0, 0, c, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			cam.End3D2D()
		end
	end

	if done then
		Particles = {}
	end
end)

local gravity = Vector(0, 0, -500)

function EFFECT:Init(data)
	local pos = data:GetOrigin()
	local amount = data:GetMagnitude()
	local Type = data:GetScale()

	local vel = VectorRand()
	vel.z = math.Rand(0.7, 0.98)
	vel:Normalize()

	local emitter = ParticleEmitter(pos)
	local particle = emitter:Add("sprites/glow04_noz", pos)
	particle:SetDieTime(2)
	particle:SetStartAlpha(0)
	particle:SetEndAlpha(0)
	particle:SetStartSize(0)
	particle:SetEndSize(0)
	particle:SetCollide(true)
	particle:SetBounce(0.7)
	particle:SetAirResistance(32)
	particle:SetGravity(gravity)
	particle:SetVelocity(math.Clamp(amount, 5, 50) * 4 * vel)

	particle.Amount = amount
	particle.DieTime = CurTime() + 2
	particle.Type = Type

	table.insert(Particles, particle)

	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
