 function EFFECT:Init( data ) 	
	
	local ent = data:GetEntity()
	if ( not IsValid( ent ) ) then return end
	
	self.Owner = ent
	self.Emitter = ParticleEmitter( self.Owner:GetPos() )
	
end  

function EFFECT:Think()	
	if ( IsValid( self.Owner ) ) then 		
		
		local ent = self.Owner
		local ang = self.Owner:GetAngles()
		local pos = self.Owner:GetPos()
		self.Emitter:SetPos( pos )

		
		local particle = self.Emitter:Add( "particle/particle_smokegrenade1", pos + ang:Forward() * -5 + Vector( 0, 0, 2 ) ) 
			
		if (particle) then
			local vec = ang:Forward()
			particle:SetVelocity( Vector( vec.x * math.random( -20, 20 ), vec.y * math.random( -20, 20 ), math.Rand( 0, 5 ) ))
			particle:SetLifeTime(0) 
			particle:SetDieTime(0.8) 
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize( math.Rand( 0,2 ) ) 
			particle:SetEndSize( math.Rand( 6,10 ) + ent:Fo_Speed() * 0.5 )
			particle:SetAngles( Angle(0,0,0) )
			particle:SetAngleVelocity( Angle( 1,1,1 ) ) 
			particle:SetRoll(math.Rand( 0, 360 ))
			
			local val = math.random( 50, 100 )
			particle:SetColor( val, val, val, 255)
			particle:SetGravity( Vector(0, 0, 0 ) ) 
			particle:SetAirResistance(0 )  
			particle:SetCollide(false)
			particle:SetBounce(0)
		end
		
		if ent:Fo_Speed() > 1 then
			local particle = self.Emitter:Add( "particles/flamelet3", pos + ang:Forward() * -6 + Vector( 0, 0, 2 ) ) 	 		
		
			if (particle) then 			
				particle:SetVelocity(Vector(math.random(0,0),math.random(0,0),math.random(0,0))) 			
				particle:SetLifeTime(0)  			
				particle:SetDieTime(0.2)  			
				particle:SetStartAlpha(255) 			
				particle:SetEndAlpha(0) 			
				particle:SetStartSize( math.Clamp( ent:Fo_Speed() * 0.1, 0, 10 ))  			
				particle:SetEndSize( math.Clamp( ent:Fo_Speed() * 0.15, 0, 12 )) 			
				particle:SetAngles( Angle(0,0,0) ) 			
				particle:SetAngleVelocity( Angle(0,0,0) )  			
				particle:SetRoll(math.Rand( 0, 360 )) 			
				
				// Green n Blue Values
				local val = math.random( 100, 200 )
				particle:SetColor( 200, val , val , 150 ) 			
				particle:SetGravity( Vector(math.random(0,5),math.random(0,5),60) )  			
				particle:SetAirResistance(0 )   			
				particle:VelocityDecay( false ) 			
				particle:SetCollide(false) 			
				particle:SetBounce(0) 		
			end 
		end
	
		return true
	end
	
	// Added self.Emitter:Finish() back.
	if ( self.Emitter ) then self.Emitter:Finish() end
	
	return false
end

function EFFECT:Render()
end