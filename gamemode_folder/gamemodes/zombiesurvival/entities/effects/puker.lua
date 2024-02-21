function EFFECT:Init(data)
	local pos = data:GetOrigin()
	local norm = data:GetNormal()
	local ent = data:GetEntity()

	if ent and ent:IsValid() then
		ent:EmitSound("physics/flesh/flesh_squishy_impact_hard"..math.random(4)..".wav", hitpos, 50, math.Rand(160, 170))

		if ent:IsPlayer() then
			ent:EmitSound("weapons/crossbow/hitbod"..math.random(2)..".wav", 70, 140)
		end
	else
		sound.Play("physics/flesh/flesh_squishy_impact_hard"..math.random(4)..".wav", pos, 50, math.Rand(160, 170))
	end
	local emitter = ParticleEmitter(pos)
	emitter:SetNearClip(16, 24)

	for i=1, 32 do
		local ang = norm:Angle()
		ang:RotateAroundAxis(ang:Up(), math.Rand(0, 360))
		ang:RotateAroundAxis(ang:Right(), math.Rand(-80, 80))

		local particle = emitter:Add("particle/smokestack", pos)
		particle:SetVelocity(ang:Forward() * math.Rand(4, 32))
		particle:SetDieTime(math.Rand(0.75, 1.25))
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(0)
		particle:SetEndSize(6)
		particle:SetColor(10, 255, 10)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-4, 4))
		particle:SetGravity(Vector(0, 0, -10))
		particle:SetAirResistance(100)
	end

	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end

