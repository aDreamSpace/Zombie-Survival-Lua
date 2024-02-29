local Player = FindMetaTable( "Player" )
local delay = 10
local lastOccurance = -delay -- Ensure the first trigger attempt will work


function EFFECT:Init( data ) 	
	
	local ent = data:GetEntity()
	entity = data:GetEntity()
	if ( not IsValid( ent ) ) then return end
	
	self.Owner = ent
	self.Emitter = ParticleEmitter( self.Owner:GetPos() ) 
	
end  

function EFFECT:Think()	
	if ( IsValid( self.Owner ) ) then 		
		
		local pos = self.Owner:GetPos()
		self.Emitter:SetPos( pos )
		function myFunc()
			if (IsValid( entity )) then
				local timeElapsed = CurTime() - lastOccurance
					if timeElapsed < delay then -- If the time elapsed since the last occurance is less than 2 seconds
				else		
					self.Owner:AddEffects( EF_ITEM_BLINK )
					sound.Play( "creeper/creeper_explosion.wav", pos )
					timer.Simple( 4.4, function() explosionCreeper() end )
					lastOccurance = CurTime()
				end
			end
		end	
		hook.Add( "KeyPress", "keypress_creeper", function( ply, key )
			if ( input.IsMouseDown(MOUSE_FIRST) and IsValid( entity )) then
				myFunc()
			end
		end )

		function explosionCreeper()
			if (IsValid( self.Owner ) and IsValid( entity )) then
				local pos = self.Owner:GetPos() -- The origin position of the effect
				
				local emitter = ParticleEmitter( pos ) -- Particle emitter in this position
				for i = 0, 1 do -- Do 100 particles
					local part = emitter:Add( "particles/flamelet3", pos )
					-- Create a new particle at pos
					if ( part ) then
						part:SetDieTime( 1 ) -- How long the particle should "live"
				
						part:SetStartAlpha( 255 ) -- Starting alpha of the particle
						part:SetEndAlpha( 0 ) -- Particle size at the end if its lifetime
				
						part:SetStartSize( 50 ) -- Starting size
						part:SetEndSize( 0 ) -- Size when removed
				
						part:SetGravity( Vector( 0, 0, 0 ) ) -- Gravity of the particle
						part:SetVelocity( VectorRand() * 50 ) -- Initial velocity of the particle
					end
				end
				
				emitter:Finish()
				self.Owner:RemoveEffects( EF_ITEM_BLINK )
				hook.Remove( "KeyPress", "keypress_creeper" )
			end
		end
			
		local particle = self.Emitter:Add( "particle/particle_smokegrenade1", pos + Vector( math.random(-6,5),math.random(-5,5),math.random(-5,5) ) ) 

		if (particle) then
			particle:SetVelocity(Vector(math.random(-4,4),math.random(-4,4),math.random(0,1)))
			particle:SetLifeTime(0) 
			particle:SetDieTime(1) 
			particle:SetStartAlpha(255)
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