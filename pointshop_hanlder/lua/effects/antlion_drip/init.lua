 function EFFECT:Init( data ) 	
	
	local ent = data:GetEntity()
	if ( not IsValid( ent ) ) then return end
	
	self.Owner = ent
	self.Emitter = ParticleEmitter( self.Owner:GetPos() )
	
end  

local particleDelay = 0.02
function EFFECT:Think()	
	if ( IsValid( self.Owner ) && self.Owner:GetPos() ~= null ) then 		
		
		local pos = self.Owner:GetPos()
		self.Emitter:SetPos( pos )
		
		local particle
		if ( not self.nextParticle ) or ( self.nextParticle < CurTime() ) then
			particle = self.Emitter:Add( "Effects/energysplash" , pos + Vector( math.random(-3,3),math.random(-3,3),math.random(-5,0) ) ) 
			self.nextParticle = CurTime() + particleDelay
		end
		
		
		if (particle) then
			particle:SetVelocity( Vector(0, 0, -80 ))
			particle:SetLifeTime(0) 
			particle:SetDieTime(0.5) 
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(3) 
			particle:SetRoll( 0 )
			particle:SetEndSize(2)
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle( 0,0,0 ) ) 
			
			local val = math.random( 200, 255 )
			particle:SetColor( 110, 150, 0, 255)
			//particle:SetGravity( Vector(0,0,-200) ) 
			particle:SetAirResistance(-1)  
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