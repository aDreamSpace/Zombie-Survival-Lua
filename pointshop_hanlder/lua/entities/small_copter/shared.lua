ENT.Type = "anim"
ENT.Base = "base_follower"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()
	
	self.ModelString = 'models/Gibs/helicopter_brokenpiece_06_body.mdl'
	self.ModelScale = 0.3
	self.Particles = "clouds"
	
	self.BaseClass.Initialize( self )
	
	if SERVER then
		self.Trail = util.SpriteTrail( self, 0, Color( 255, 255, 255, 150 ), false, 15, 1, 1, 0.125, 'trails/smoke.vmt')
	end

end

function ENT:Fo_UpdatePet( speed, weight )

	self:SetAngles( self:GetAngles() + Angle( weight * 20, 0, 0 ) )

end