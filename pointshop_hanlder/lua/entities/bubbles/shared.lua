ENT.Type = "anim"
ENT.Base = "base_follower"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()
	
	self.ModelString = 'models/props/de_tides/Vending_turtle.mdl'
	self.ModelScale = 0.8
	self.Particles = "bubble_beauty"
	self.OffsetAngle = -90
	self.Shadows = true;
	
	self.BaseClass.Initialize( self )
end