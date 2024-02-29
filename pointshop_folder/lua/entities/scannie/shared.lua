ENT.Type = "anim"
ENT.Base = "base_follower"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.AutomaticFrameAdvance = true 

function ENT:Initialize()
	
	self.ModelString = 'models/combine_scanner.mdl'
	self.ModelScale = 0.6
	self.Particles = "scanner_particles" 
	self.ArsenalUp = -8

	self.BaseClass.Initialize( self )
	
	if SERVER then
		self:Fo_AddRandomSound( "npc/scanner/scanner_alert1.wav", 100, 100 )
		self:Fo_AddRandomSound( "npc/scanner/scanner_electric2.wav", 100, 100 )
		self:Fo_AddRandomSound( "npc/scanner/scanner_scan1.wav", 100, 100 )
		self:Fo_AddRandomSound( "npc/scanner/scanner_scan2.wav", 100, 100 )
	end

end

function ENT:Fo_UpdatePet( speed, weight )
	
	local z = self:GetVelocity().z
	local sequence = self:LookupSequence( "ragdoll" )
	if ( weight >= 1 ) and z < 0 then
		sequence = self:LookupSequence( "ragdoll" )
	end
	
	self:SetPlaybackRate( 1 )
	self:ResetSequence(sequence)

end