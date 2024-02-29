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
		
		local waveAngs = {}
		waveAngs[1] = ang + Angle( 0, 65, 0 )
		waveAngs[2] = ang + Angle( 0, -65, 0 )
		
		for i=1,2 do
			local particle = self.Emitter:Add( "particle/particle_smokegrenade1", pos + ang:Forward() * 12 + Vector( 0, 0, -2 ) ) 
			
			if (particle) then
				local vec = waveAngs[i]:Forward()
				particle:SetVelocity( Vector( vec.x * -20, vec.y * -20, 20 ))
				particle:SetLifeTime(0) 
				particle:SetDieTime(1) 
				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				particle:SetStartSize(1) 
				particle:SetEndSize(10)
				particle:SetAngles( Angle(0,0,0) )
				particle:SetAngleVelocity( Angle( 1,1,1 ) ) 
				particle:SetRoll(math.Rand( 0, 360 ))
				
				local val = math.random( 100, 125 )
				particle:SetColor( val, val + 50, 255, 255)
				particle:SetGravity( Vector( vec.x * -30, vec.y * -30,-50) ) 
				particle:SetAirResistance(0 )  
				particle:SetCollide(false)
				particle:SetBounce(0)
			end
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