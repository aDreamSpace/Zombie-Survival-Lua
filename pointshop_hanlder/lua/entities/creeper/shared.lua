ENT.Type = "anim"
ENT.Base = "base_follower"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()
	local colWhite = Color( 255, 255, 255, 255 )
	self.ModelString = 'models/player/creeper.mdl'
	self.ModelScale = 0.2
	self.Particles = "creeper"

	self.BaseClass.Initialize( self )

	if SERVER then
		self:Fo_AddRandomSound( "creeper/creeper1.wav", 100, 100 ) 
		self:Fo_AddRandomSound( "creeper/creeper2.wav", 100, 100 )
		self:Fo_AddRandomSound( "creeper/creeper3.wav", 100, 100 )
	end
	
end

function ENT:Fo_UpdatePet( speed, weight )
	self:SetAngles( self:GetAngles() + Angle( math.sin( CurTime() * fo.WobbleSpeed ) * -8, 0, 0 ) )
end