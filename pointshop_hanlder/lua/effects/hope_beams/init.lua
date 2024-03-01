 function EFFECT:Init( data ) 	
	
	local ent = data:GetEntity()
	if ( not IsValid( ent ) ) then return end
	
	self.Owner = ent
	self.Emitter = ParticleEmitter( self.Owner:GetPos() )
	
end  

local particleDelay = 0.07
function EFFECT:Think()	
	if ( IsValid( self.Owner ) ) then 		
		
		local pos = self.Owner:GetPos()
		self.Emitter:SetPos( pos )
		
		local particle
		if ( not self.nextParticle ) or ( self.nextParticle < CurTime() ) then
			particle = self.Emitter:Add( "Effects/spark" , pos + Vector( math.random(-3,3),math.random(-3,3),math.random(4,6) ) ) 
			self.nextParticle = CurTime() + particleDelay
		end
		
		if (particle) then
			particle:SetVelocity( Vector(math.random(-50,50),math.random(-50,50), math.random( -20, -10 ) ))
			particle:SetLifeTime(0) 
			particle:SetDieTime(0.5) 
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(3) 
			particle:SetRoll( 0 )
			particle:SetEndSize(1)
			particle:SetAngles(Angle( math.random( 0, 10 ),math.random( 0, 10 ),math.random( 0, 10 ) )  )
			particle:SetAngleVelocity( Angle( math.random( 0, 10 ),math.random( 0, 10 ),math.random( 0, 10 ) ) ) 
			
			local val = math.random( 150, 200 )
			particle:SetColor( 200,200,255, 255)
			particle:SetGravity( Vector( 0, 0, 120 ) )
			particle:SetAirResistance(20)  
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