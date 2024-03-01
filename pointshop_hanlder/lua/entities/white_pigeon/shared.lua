ENT.Type = "anim"
ENT.Base = "base_follower"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.AutomaticFrameAdvance = true 

function ENT:Initialize()
	
	self.ModelString = 'models/pigeon.mdl'
	self.ModelScale = 1
	self.Particles = "hope_beams"

	self.BaseClass.Initialize( self )
	
	if CLIENT then
		self:Fo_AttachParticles( "hope_clouds" )
	end
	
	if SERVER then
		self:Fo_AddRandomSound( "npc/crow/alert2.wav", 100, 100 )
		self:Fo_AddRandomSound( "npc/crow/alert3.wav", 100, 100 )
		self:Fo_AddRandomSound( "npc/crow/pain2.wav", 100, 100 )
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