ENT.Type = "anim"
ENT.Base = "base_follower"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()

	self.ModelString = 'models/Gibs/HGIBS.mdl'
	self.ModelScale = 1.4
	self.Shadows = true
	self.Particles = "skull_flames" 
	self.PetColor = Color( 255, 150, 100, 255 )
	
	self.BaseClass.Initialize( self )
	
end