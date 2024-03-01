local Player = FindMetaTable( "Player" )

local BASE = FindMetaTable("base_anim")

function BASE:Fo_SetCooldown(cooldown)
    -- TODO: Implement the functionality of the Fo_SetCooldown method
    self.cooldown = cooldown
end


function Player:Fo_AttachParticle( model, effectName )
	
	if ( model.Effect ) then return end
	
	model.Effect = true 
	self.followEnt = model
	local vPoint = self:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart( vPoint ) // not sure if ( we need a start and origin ( endpoint ) for this effect, but whatever
	effectdata:SetOrigin( vPoint )
	effectdata:SetEntity( self )
	effectdata:SetScale( 1 )
	util.Effect( effectName, effectdata )

end

// Get the player's follower list.
function Player:Fo_GetFollowers()
	return self.Fo_Followers;
end

// Get a single follower
function Player:Fo_GetFollower( entName )
	if ( self.Fo_Followers ) then
		return self.Fo_Followers[entName]
	else
		return nil
	end
end

function Player:Fo_AddFollower( ent )
	if ( not IsValid( self ) ) or ( not IsValid( ent ) ) then return end
	self.Fo_Followers[ent:GetClass()] = ent;
	ent:Fo_SetState( fo.STATE_FOLLOW );
end

// Create a follower with this entity name.
function Player:Fo_CreateFollower( entName, uniqueName )
	
	if ( not self.Fo_Followers ) then self.Fo_Followers = {} end
	if ( IsValid( self.Fo_Followers[entName] ) ) then SafeRemoveEntity( self.Fo_Followers[entName] ) end
	
	local ent = ents.Create( entName )
	ent:Fo_SetOwner( self )
	ent:SetPos( self:GetPos() + Vector( 0, 0, 60 ) )
	ent:SetPetName( uniqueName or fo.DefaultName )
	ent:Spawn()
	
	ent.fo_fw = 0;
	ent.fo_side = 0;
	ent.fo_up = 0;
	
	self:Fo_AddFollower( ent )
	
	-- Set the correct cooldown.
	ent:Fo_SetCooldown( self.fo_petCooldown or 3 ) 
	
	-- Check wheter or not we should equip the arsenal.
	if ( self.Fo_EquipArsenal ) then self:Fo_EquipArsenal() end
	
	return ent
	
end

function Player:Fo_RemoveFollower( entName )
	if ( not IsValid( self ) ) or ( not IsValid( self:Fo_GetFollower( entName ) ) ) then return end
	
	local ent = self:Fo_GetFollower( entName )
	if ( IsValid( ent ) ) then
		SafeRemoveEntity( ent )
	end
	
	if ( self.Fo_Followers ) and ( self.Fo_Followers[entName] ) then
		self.Fo_Followers[entName] = nil;
	end
end

// Set the spec entity.
function Player:Fo_SetSpecEntity( ent )

	if ( not IsValid( self ) ) or ( not IsValid( ent ) ) then return end
	self:SetNWEntity( "fo_SpecEnt", ent );

end

// Remove all followers
function Fo_RemoveAllFollowers()
	
	for _,ply in pairs( player.GetAll() ) do
		for entName,ent in pairs( ply:Fo_GetFollowers() ) do
			ply:Fo_RemoveFollower( entName )
		end
	end
	
end

// CONSOLE COMMANDS.
// FOLLOWERS IDLE
concommand.Add( "fo_idle", function( ply )
	
	if ( not fo.AllowIdleOrder ) then return end
	
	local followers = ply:Fo_GetFollowers();
	
	if ( followers ) then
	
		if ( ply.fo_idleTimer ) and ( ply.fo_idleTimer > CurTime() ) then
			ply:PrintMessage( HUD_PRINTTALK, "[Followers] You can't put your pet on idle this soon.. Wait " .. math.ceil( math.Clamp( ply.fo_idleTimer - CurTime(), 0, fo.IdleTimer ) ) .. " seconds.");
			return
		end
		
		ply.fo_idleTimer = CurTime() + fo.IdleTimer;
	
		for _,ent in pairs( followers ) do
			ent:Fo_SetIdlePos( ply:GetEyeTrace().HitPos + fo.IdleOffset )
			ent:Fo_SetState( fo.STATE_IDLE );
		end
	end

end );

// FOLLOWERS FOLLOW
concommand.Add( "fo_follow", function( ply )

	local followers = ply:Fo_GetFollowers();
	
	if ( followers ) then
		for _,ent in pairs( followers ) do
			ent:Fo_SetState( fo.STATE_FOLLOW );
		end
	end

end );

// FOLLOWERS CHASE
concommand.Add( "fo_chase", function( ply )
	
	if ( not fo.AllowChaseOrder ) then return end
	
	local followers = ply:Fo_GetFollowers();
	local chaseEnt = ply:GetEyeTrace().Entity;
	
	if ( followers ) and ( IsValid( chaseEnt ) ) and 
	(( chaseEnt:GetClass() == "prop_physics" ) or 
	( chaseEnt:IsPlayer() ) or 
	( chaseEnt:IsNPC() )) then
	
		if ( ply.fo_chaseTimer ) and ( ply.fo_chaseTimer > CurTime() ) then
			ply:PrintMessage( HUD_PRINTTALK, "[Followers] You can't put your pet on idle so soon after an 'chase' command. Wait " .. math.ceil( math.Clamp( ply.fo_chaseTimer - CurTime(), 0, fo.ChaseTimer ) ) .. " seconds.");
			return
		end
		
		ply.fo_chaseTimer = CurTime() + fo.ChaseTimer;
		
		for _,ent in pairs( followers ) do
			ent:Fo_SetChaseEntity( chaseEnt );
			ent:Fo_SetState( fo.STATE_CHASE );
		end
		
	end

end );

// FOLLOWERS CHASE
if ( fo.AllowControlOrder ) then
concommand.Add( "fo_control", function( ply )
	
	if ( not ply:IsOnGround() ) then return end
	
	local followers = ply:Fo_GetFollowers();
	
	if ( followers ) then
		
		for _,ent in pairs( followers ) do
			local state = ent:Fo_GetState();
			if ( state != fo.STATE_CONTROLLED ) then 
				ent:Fo_SetState( fo.STATE_CONTROLLED );
			else
				ent:Fo_SetState( fo.STATE_FOLLOW );
			end
		end
		
	end

end )
end