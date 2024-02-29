ENT.Type = "anim"
ENT.Base = "base_follower"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()
	
	self.ModelString = 'models/props_c17/oildrum001_explosive.mdl'
	self.ModelScale = 0.3
	self.Particles = "black_drops"
	self.ArsenalUp = 13
	self.ArsenalForward = -3
	
	self.BaseClass.Initialize( self )
	
	if SERVER then
		self.Trail = util.SpriteTrail( self, 0, Color( 100, 100, 50, 200 ), false, 5, 1, 0.7, 0.125, 'trails/smoke.vmt')
	end
	
end

function ENT:Fo_UpdatePet( speed, weight )
	local noAng = self:GetAngles()
	self:SetAngles( noAng + Angle( math.sin( CurTime() * fo.WobbleSpeed ) * -8, math.cos( CurTime() * fo.WobbleSpeed ) * -8, 0 ) )
end

function ENT:Fo_OnDeath()
	if SERVER then
		local explode = ents.Create( "env_explosion" )
		explode:SetPos( self:GetPos() )
		explode:SetOwner( self )
		explode:Spawn()
		explode:SetKeyValue( "iMagnitude", "0" )
		explode:Fire( "Explode", 0, 0 )
	end
end