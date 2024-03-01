local Player = FindMetaTable( "Player" )
local Entity = FindMetaTable( "Entity" )

print("Server ON2")
local files, directories = file.Find("sound/creeper/*", "GAME")
for _,name in pairs(directories) do
	resource.AddSingleFile("sound/creeper/"..name)
	Msg("HurtSounds:File Added to client download list "..name.."\n")
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

function Player:Fo_GetFollower( entName )
	return self.Fo_Followers[entName]
end

function Player:Fo_AddFollower( ent )
	if ( not IsValid( self ) ) or ( not IsValid( ent ) ) then return end
	self.Fo_Followers[ent:GetClass()] = ent;
end

// Create a follower with this entity name.
function Player:Fo_CreateFollower( entName )
	
	if ( not self.Fo_Followers ) then self.Fo_Followers = {} end
	if ( IsValid( self.Fo_Followers[entName] ) ) then SafeRemoveEntity( self.Fo_Followers[entName] ) end
	
	local ent = ents.Create( entName )
	ent:Fo_SetOwner( self )
	ent:SetPos( self:GetPos() + Vector( 0, 0, 60 ) )
	ent:Spawn()
	
	self:Fo_AddFollower( ent )
	
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

function Entity:Fo_SetOwner( ply )
	
	if ( not IsValid( ply ) ) then return end
	self:SetDTEntity( 0, ply )
	
end

function Entity:Fo_MoveFollower()

	local ply = self:Fo_GetOwner()

	if ( not IsValid( ply ) ) then
		SafeRemoveEntity( self )
		return 
	end
	
	local plyAng = Angle( 0, ply:GetAngles().y, 0 )
	local origin = ply:GetPos() + fo.Origin;
	local targetPos = origin + plyAng:Right() * fo.Right + plyAng:Up() * fo.Up + plyAng:Forward() * fo.Forward;
	
	local trace = {}
	trace.start = ply:GetPos() + fo.Origin
	trace.endpos = targetPos;
	trace.filter = { ply }
	// ADD TRACE MASK FOR WORLD ONLY.
	
	local tr = util.TraceLine( trace )
	
	targetPos = tr.HitPos + Vector( 0, 0, 1 ) * math.sin( CurTime() * fo.WobbleSpeed ) * fo.Wobble
	
	//local targetVec = LerpVector( FrameTime() * fo.Speed, self:GetPos(), targetPos )
	local posToDo = ( targetPos - self:GetPos() )
	local velocity = math.Clamp( posToDo:Length(), fo.MinSpeed, fo.MaxSpeed )
	posToDo:Normalize()
	self:SetLocalVelocity( posToDo * velocity * fo.SpeedMult )

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