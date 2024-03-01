ENT.Type = "anim"
ENT.Base = "base_follower"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.AutomaticFrameAdvance = true 

function ENT:Initialize()
	
	self.ModelString = 'models/crow.mdl'
	self.ModelScale = 1
	self.Particles = "feathers_black"

	self.BaseClass.Initialize( self )
	
	if CLIENT then
		self:Fo_AttachParticles( "dark_clouds" )
	end
	
	if SERVER then
		self:Fo_AddRandomSound( "npc/crow/idle3.wav", 100, 100 )
		self:Fo_AddRandomSound( "npc/crow/idle4.wav", 100, 100 )
		self:Fo_AddRandomSound( "npc/crow/pain1.wav", 100, 100 )
	end

end

function ENT:Fo_UpdatePet( speed, weight )
	
	local z = self:GetVelocity().z
	local sequence = self:LookupSequence( "Fly01" )
	if ( weight >= 1 ) and z < 0 then
		sequence = self:LookupSequence( "Soar" )
	end
	
	self:SetPlaybackRate( 1 )
	self:ResetSequence(sequence)

end