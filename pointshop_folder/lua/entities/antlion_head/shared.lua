ENT.Type = "anim"
ENT.Base = "base_follower"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()

	self.ModelString = 'models/Gibs/Antlion_gib_Large_2.mdl'
	self.ModelScale = 0.7
	self.Particles = "antlion_drip"
	
	self.BaseClass.Initialize( self )
	
end