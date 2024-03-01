ENT.Type = "anim"
ENT.Base = "base_follower"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.AutomaticFrameAdvance = true 

function ENT:Initialize()

	self.ModelString = 'models/headcrabclassic.mdl'
	self.ModelScale = 0.7
	self.Particles = "lamar_blood"
	
	self.BaseClass.Initialize( self )
	
	if SERVER then
		self:Fo_AddRandomSound( "npc/headcrab/idle1.wav", 100, 100 )
		self:Fo_AddRandomSound( "npc/headcrab/idle2.wav", 100, 100 )
		self:Fo_AddRandomSound( "npc/headcrab/idle3.wav", 100, 100 )
	end
	
end

function ENT:Fo_UpdatePet( speed, weight )

	local sequence = self:LookupSequence( "Idle01" )
	if ( weight >= 1 ) then
		sequence = self:LookupSequence( "Run1" )
	end
	self:SetPlaybackRate( 1 )
	self:ResetSequence(sequence)

end