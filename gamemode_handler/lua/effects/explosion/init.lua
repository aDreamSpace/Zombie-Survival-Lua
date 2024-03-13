


function EFFECT:Init( data )

	local tr = util.TraceLine( {
		start  = data:GetOrigin(),
		endpos = data:GetOrigin() - Vector(0,0,60),
		mask   = MASK_SOLID_BRUSHONLY
	} )

	if tr.HitWorld then 
		ParticleEffect(table.Random({"har_explosion_a","har_explosion_b","har_explosion_c"}), data:GetOrigin(), Angle(0,math.random(0,360),0), nil)

	else
		ParticleEffect(table.Random({"har_explosion_a_air","har_explosion_b_air","har_explosion_c"}), data:GetOrigin(), Angle(0,math.random(0,360),0), nil)

	end

	sound.Play( "hd/new_grenadeexplo.mp3", data:GetOrigin(), 100, math.random(90,110), 1)
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end





	