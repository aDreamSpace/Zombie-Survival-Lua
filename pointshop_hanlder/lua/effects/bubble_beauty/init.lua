 function EFFECT:Init( data ) 	
	
	local ent = data:GetEntity()
	if ( not IsValid( ent ) ) then return end
	
	self.Owner = ent
	self.Emitter = ParticleEmitter( self.Owner:GetPos() ) 	 
	
end  

local particleDelay = 0.05
function EFFECT:Think()	
	if ( IsValid( self.Owner ) ) then 		
	
		local pos = self.Owner:GetPos()
		self.Emitter:SetPos( pos )
		
		local particle
		if ( not self.nextParticle ) or ( self.nextParticle < CurTime() ) then
			particle = self.Emitter:Add( "particle/Particle_Ring_Sharp", pos + Vector( math.random(-3,3),math.random(-3,3), math.random( 0, 5 ) ) ) 
			self.nextParticle = CurTime() + particleDelay
		end
		
		if (particle) then
			particle:SetVelocity(Vector(math.random(-4,4),math.random(-4,4), 10))
			particle:SetLifeTime(0) 
			particle:SetDieTime(1) 
			particle:SetStartAlpha(200)
			particle:SetEndAlpha(0)
			particle:SetStartSize(math.random(0,1) + 1) 
			particle:SetEndSize(math.random(0,1) + 2)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle( 1,1,1 ) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			local val = math.random( 100, 255 )
			particle:SetColor( val, 255, 255, 255)
			particle:SetGravity( Vector(math.random(-5,5),math.random(-5,5), 120) ) 
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