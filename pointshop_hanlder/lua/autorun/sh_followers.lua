local Player = FindMetaTable( "Player" )
local Entity = FindMetaTable( "Entity" )

fo = {}

fo.SmoothAnimations	= true				// TURN THIS SETTING OFF TO DISABLE FAST ANIM, IMPROVES SERVER PERFORMANCE.
fo.ShowFirstPersonParticles = true		// Setting this to false will remove particle attachments from the owner's point of view.
fo.ShowFirstPersonFollower = true		// Setting this to false will disable the player's follower model from being show to him.

fo.EnableSounds = true					// Set this to false to disable sounds.
fo.SoundsMinTime = 15
fo.SoundsMaxTime = 60

fo.EnableAllParticles = true			// Set this to false to disable particles.

fo.Origin = Vector( 0, 0, 60 )
fo.Forward = -10
fo.Right = -20
fo.Up = 10
fo.Wobble = 4;
fo.WobbleSpeed = 1.5;
fo.MinSpeed = 0;
fo.MaxSpeed = 150;
fo.SpeedMult = 3;

function Entity:Fo_GetOwner()
	if ( IsValid( self ) ) then return self:GetDTEntity( 0 ) end
end

function Entity:Fo_SetAngles( offset )

	if ( not self.angWeight ) then self.angWeight = 0 end
	local ply = self:Fo_GetOwner()
	local vel = self:GetVelocity()
	local speed = vel:LengthSqr() * 0.0005
	
	if speed > 1.5 then
		self.angWeight = math.Approach( self.angWeight, 1, FrameTime() * 3 )
	else
		self.angWeight = math.Approach( self.angWeight, 0, FrameTime() * 2.5)
	end
	
	offset = offset or 0
	local angMove = Angle( 0, vel:Angle().y + offset, 0 )
	local angStop = Angle( 0, 0, 0 )
	if ( IsValid( ply ) ) then
		angStop = Angle( 0, ply:GetAngles().y + offset or 0, 0 )
	end
	
	self:SetAngles( LerpAngle( self.angWeight, angStop, angMove ) )
	
	return speed, self.angWeight

end