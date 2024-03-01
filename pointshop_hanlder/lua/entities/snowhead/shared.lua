ENT.Type = "anim"
ENT.Base = "base_follower"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()
	
	self.ModelString = 'models/props/cs_office/Snowman_face.mdl'
	self.ModelScale = 0.8
	self.OffsetAngle = -90
	self.Particles = "snowflakes"
	self.Shadows = true;
	
	self.BaseClass.Initialize( self )
	
end