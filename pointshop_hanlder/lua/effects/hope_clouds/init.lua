 function EFFECT:Init( data ) 	
	
	local ent = data:GetEntity()
	if ( not IsValid( ent ) ) then return end
	
	self.Owner = ent
	self.Emitter = ParticleEmitter( self.Owner:GetPos() ) 
	
end  

function EFFECT:Think()	
	if ( IsValid( self.Owner ) ) then 		
	
		local pos = self.Owner:GetPos()
		self.Emitter:SetPos( pos )

		local particle = self.Emitter:Add( "particle/particle_smokegrenade1", pos + Vector( math.random(-6,5),math.random(-5,5),math.random(2,12) ) ) 
		
		if (particle) then
			particle:SetVelocity(Vector(math.random(-4,4),math.random(-4,4),math.random(0,1)))
			particle:SetLifeTime(0) 
			particle:SetDieTime(1) 
			particle:SetStartAlpha(50)
			particle:SetEndAlpha(0)
			particle:SetStartSize(3) 
			particle:SetEndSize(2.5)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle( 1,1,1 ) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			particle:SetColor( 255, 255, 255, 255)
			particle:SetGravity( Vector(0,0,-10) ) 
			particle:SetAirResistance(0 )  
			particle:SetCollide(false)
			particle:SetBounce(0)
		end

		return true
	end
	
	if ( self.Emitter ) then 
		self.Emitter:Finish()
	end
	
	return false
end

function EFFECT:Render()
end