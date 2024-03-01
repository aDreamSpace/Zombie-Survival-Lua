local Entity = FindMetaTable( "Entity" )

// Set the owner of this entity.
function Entity:Fo_SetOwner( ply )
	if ( not IsValid( ply ) ) then return end
	self:SetNWEntity( "fo_PetOwner", ply )
end

// Set the state of the entity and call a state change if needed.
function Entity:Fo_SetState( state )
	if ( not IsValid( self ) ) then return end
	
	self:Fo_SetLastState( self:GetNWInt( "fo_State" ) )
	
	if ( self:GetNWInt( "fo_State" ) != state ) and ( self.Fo_OnStateChange ) then
		self:Fo_OnStateChange( state );
	end
	
	self:SetNWInt( "fo_State", state )
end

// Sets the last state of the pet.
function Entity:Fo_SetLastState( state )
	if ( state != fo.STATE_ATTACK and state != fo.STATE_CUSTOM ) then self.fo_lastState = state end
end

// Return last state
function Entity:Fo_GetLastState()
	return self.fo_lastState or fo.STATE_FOLLOW
end

// On state change.
function Entity:Fo_OnStateChange( state )
	
	if ( state == fo.STATE_CONTROLLED ) then
		self:Fo_GetOwner():Fo_SetSpecEntity( self );
	elseif ( state == fo.STATE_ATTACK ) then
		self:Fo_SetAttackPos( self:GetPos() )
	else
		self:Fo_GetOwner():Fo_SetSpecEntity( nil );
	end

end

// Sets a custom position.
function Entity:Fo_SetCustomPos( pos )
	if ( IsValid( self ) ) then self.fo_customPos = pos end
end

// Gets a custom pos.
function Entity:Fo_GetCustomPos()
	if ( not IsValid( self ) ) then return end
	if ( not self.fo_customPos ) then return self:Fo_GetOwner():GetPos() end
	return self.fo_customPos
end

// Set the target position of the entity.
function Entity:Fo_SetIdlePos( pos )
	if ( IsValid( self ) ) then self.fo_idlePos = pos end
end

// Get the target position.
function Entity:Fo_GetIdlePos()
	if ( not IsValid( self ) ) then return end
	if ( not self.fo_idlePos ) then self:Fo_SetIdlePos( self:GetPos() ) end
	return self.fo_idlePos;
end

// Set the attack position.
function Entity:Fo_SetAttackPos( pos )
	if ( IsValid( self ) ) then self.fo_attackPos = pos end
end

// Get the attack position.
function Entity:Fo_GetAttackPos()
	if ( not IsValid( self ) ) then return end
	if ( not self.fo_attackPos ) then self:Fo_SetAttackPos( self:GetPos() ) end
	return self.fo_attackPos;
end

// Set Attack Target Pos
function Entity:Fo_SetAttackTargetPos( pos )
	if ( IsValid( self ) ) then self.fo_attackTargetPos = pos end
end

// Get the attack position.
function Entity:Fo_GetAttackTargetPos()
	if ( not IsValid( self ) ) then return end
	if ( not self.fo_attackTargetPos ) then self:Fo_SetAttackTargetPos( self:GetPos() ) end
	return self.fo_attackTargetPos;
end

// Set amount of time before the "attack" ends.
function Entity:Fo_SetPauseTime( time )
	if ( IsValid( self ) ) then self.fo_pauseTime = CurTime() + ( time or fo.DefaultAttackTime ) end
end

// Get the time for the next Next.
function Entity:Fo_GetPauseTime()
	if ( not IsValid( self ) ) then return end
	if ( not self.fo_pauseTime ) then self:Fo_SetPauseTime( 0 ) end
	return self.fo_pauseTime;
end

// Sets the target entity for chase state.
function Entity:Fo_SetChaseEntity( ent )

	if ( not IsValid( self ) ) or ( not IsValid( ent ) ) then return end
	self.fo_chaseEnt = ent;

end

// Return the entity being chased.
function Entity:Fo_GetChaseEntity()

	if ( not IsValid( self ) ) or ( not self.fo_chaseEnt ) then return end
	return self.fo_chaseEnt;

end

function Entity:Fo_MoveFollower()

	local ply = self:Fo_GetOwner()

	if ( not IsValid( ply ) ) then
		SafeRemoveEntity( self )
		return 
	end
	
	local targetPos = self:Fo_GetTargetPos();

	local posToDo = ( targetPos - self:GetPos() )
	local velocity = math.Clamp( posToDo:Length(), fo.MinSpeed, fo.MaxSpeed )
	posToDo:Normalize()
	self:SetLocalVelocity( posToDo * velocity * fo.SpeedMult )

end


-- Function to retrieved the location where the pet should be.
function Entity:Fo_GetTargetPos()
	
	local ply = self:Fo_GetOwner();
	
	// CUSTOM STATE.
	if ( self:Fo_GetState() == fo.STATE_CUSTOM ) then
	
		return self:Fo_GetCustomPos()
	
	// ATTACK STATE.
	elseif ( self:Fo_GetState() == fo.STATE_ATTACK ) then
		
		if ( self:Fo_GetPauseTime() <= CurTime() ) then self:Fo_SetState( self:Fo_GetLastState() ) end
		return self:Fo_GetAttackPos() + Vector( 0, 0, 1.5 ) * math.sin( CurTime() * fo.WobbleSpeed ) * fo.Wobble;
	
	// FOLLOW STATE.
	elseif ( self:Fo_GetState() == fo.STATE_FOLLOW ) then
	
		local plyAng = Angle( 0, ply:GetAngles().y, 0 )
		local origin = ply:GetPos() + fo.Origin;
		local tPos = origin + plyAng:Right() * fo.Right + plyAng:Up() * fo.Up + plyAng:Forward() * fo.Forward;
		
		local trace = {}
		trace.start = ply:GetPos() + fo.Origin
		trace.endpos = tPos;
		trace.filter = { ply, self }
		// ADD TRACE MASK FOR WORLD ONLY.
		
		local tr = util.TraceLine( trace )
		
		return tr.HitPos + Vector( 0, 0, 1 ) * math.sin( CurTime() * fo.WobbleSpeed ) * fo.Wobble
		
	// CHASE STATE.
	elseif ( self:Fo_GetState() == fo.STATE_CHASE ) then
		
		self.fo_angleChase = self.fo_angleChase or Angle( 0, 0, 0 );
		
		local chaseEnt = self:Fo_GetChaseEntity();
		if ( not IsValid( chaseEnt ) ) then chaseEnt = ply end
		
		
		self.fo_angleChase.y = (self.fo_angleChase.y + FrameTime() * fo.ChaseCircleSpeed * 1) % 360;
		local origin = chaseEnt:GetPos() + fo.Origin;
		local tPos = origin + self.fo_angleChase:Right() * 50;
		
		local trace = {}
		trace.start = chaseEnt:GetPos() + fo.Origin
		trace.endpos = tPos;
		trace.filter = { chaseEnt, self }
		// ADD TRACE MASK FOR WORLD ONLY.
		
		local tr = util.TraceLine( trace )
		
		return tr.HitPos + Vector( 0, 0, 1 ) * math.sin( CurTime() * fo.WobbleSpeed ) * fo.Wobble
	
	// CONTROLLED STATE
	elseif ( self:Fo_GetState() == fo.STATE_CONTROLLED ) then

		local ang = ply:GetAimVector():Angle();
		local fw = 0
		local side = 0
		local up = 0
		
		if ( ply:KeyDown( IN_FORWARD ) ) then
			fw = fw + fo.ForwardSpeed;
		end
		if ( ply:KeyDown( IN_BACK ) ) then
			fw = fw - fo.ForwardSpeed;
		end
		if ( ply:KeyDown( IN_MOVERIGHT ) ) then
			side = side + fo.SideSpeed;
		end
		if ( ply:KeyDown( IN_MOVELEFT ) ) then
			side = side - fo.SideSpeed;
		end
		if ( ply:KeyDown( IN_JUMP ) ) then
			up = up + fo.UpSpeed;
		end
		if ( ply:KeyDown( IN_DUCK ) ) then
			up = up - fo.UpSpeed;
		end
		
		local vel = Vector( fw, side, up );
		vel:Normalize();
		vel = vel * fo.Speed;
		
		self.fo_fw = Lerp( FrameTime() * fo.Acceleration, self.fo_fw, vel.x );
		self.fo_side = Lerp( FrameTime() * fo.Acceleration, self.fo_side, vel.y );
		self.fo_up = Lerp( FrameTime() * fo.Acceleration, self.fo_up, vel.z );
		
		local targetPos = self:GetPos() + ang:Forward() * self.fo_fw + ang:Right() * self.fo_side + ang:Up() * self.fo_up;
		
		
		local trace = {}
		trace.start = self:GetPos()
		trace.endpos = targetPos;
		trace.filter = { ply, self, MASK_PLAYERSOLID_BRUSHONLY }
		
		tr = util.TraceLine( trace )
		
		return tr.HitPos or targetPos;
		
	// IDLE STATE.
	elseif ( self:Fo_GetState() == fo.STATE_IDLE ) then
	
		return self:Fo_GetIdlePos() + Vector( 0, 0, 1.5 ) * math.sin( CurTime() * fo.WobbleSpeed ) * fo.Wobble;
		
	end

end


// Use this function to add a random sound to our entity.
function Entity:Fo_AddRandomSound( soundPath, dist, pitch )
	
	if ( not fo.EnableSounds ) then return end
	if ( not self.PetSounds ) then self.PetSounds = {} end
	
	local tbl = {}
	tbl.soundPath = soundPath
	tbl.dist = dist or 100
	tbl.pitch = pitch or 100
	
	table.insert( self.PetSounds, tbl )
	
	self:Fo_CreateSoundTimer( fo.SoundsMinTime, fo.SoundsMaxTime )

end

// Creates the timer used for sounds.
function Entity:Fo_CreateSoundTimer( min, max )
	
	if ( not self.PetSounds ) then return end
	
	local fn = function()
			if ( not IsValid( self ) ) or ( not self.PetSounds ) then return end
			local num = math.random(#self.PetSounds)
			local tbl = self.PetSounds[num]
			self:EmitSound( tbl.soundPath or "", tbl.dist or 100, tbl.pitch or 100 )
			self:Fo_CreateSoundTimer( min, max )
	end
	
	if ( not timer.Exists( "Fo_PetSounds" .. self:EntIndex() ) ) then 
		timer.Create( "Fo_PetSounds" .. self:EntIndex(), math.random( min, max ), 1, fn )
	else
		timer.Adjust( "Fo_PetSounds" .. self:EntIndex(), math.random( min, max ), 1, fn )
	end

end