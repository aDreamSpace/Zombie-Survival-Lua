ENT.Type = "anim"
ENT.Base = "base_follower"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()
	
	self.ModelString = 'models/props_canal/boat002b.mdl'
	self.ModelScale = 0.2
	self.Particles = "boat_waves"

	self.BaseClass.Initialize( self )
	
end

function ENT:Fo_UpdatePet( speed, weight )
	self:SetAngles( self:GetAngles() + Angle( math.sin( CurTime() * fo.WobbleSpeed ) * -8, 0, 0 ) )
end