ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.AutomaticFrameAdvance = true;

function ENT:SetPetName(name)
    self.PetName = name
end

function ENT:Initialize()

	self.ModelString = self.ModelString or 'models/props/cs_office/Snowman_face.mdl'
	self.ModelScale = self.ModelScale or 1
	self.Particles = self.Particles
	self.PetColor = self.PetColor or Color( 255, 255, 255, 255 )
	self.OffsetAngle = self.OffsetAngle or 0
	self.Shadows = self.Shadows or false

	if SERVER then
		self:SetModel( self.ModelString )
		self:SetMoveType( MOVETYPE_NOCLIP )
		self:SetSolid( SOLID_NONE )
		self:SetCollisionGroup( COLLISION_GROUP_NONE )
	end

	if CLIENT then
		if self.Particles then self:Fo_AttachParticles( self.Particles ) end
		self:DrawShadow( self.Shadows )
	end
	
	self:SetModelScale( self.ModelScale, 0 )
	self:SetColor( self.PetColor )
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	
end

function ENT:Think()

	if SERVER then
		self:Fo_MoveFollower()
	end

	local speed,weight = self:Fo_SetAngles( self.OffsetAngle )
	
	if ( self.Fo_UpdatePet ) then 
		self:Fo_UpdatePet( speed, weight ) 
		
		if SERVER and fo.SmoothAnimations then
			self:NextThink( CurTime() )
			return true
		end
	end
	
end

if CLIENT then
	function ENT:Draw()
		self:Fo_Draw()
	end
end