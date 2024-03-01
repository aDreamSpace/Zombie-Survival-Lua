local Player = FindMetaTable( "Player" )
local Entity = FindMetaTable( "Entity" )

function Entity:Fo_AttachParticles( effectName )
	
	if ( not effectName ) or ( not fo.EnableAllParticles ) then return end
	if ( not fo.ShowFirstPersonParticles ) and ( self:Fo_GetOwner() == LocalPlayer() ) then return end
	
	local vPoint = self:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart( vPoint ) // not sure if ( we need a start and origin ( endpoint ) for this effect, but whatever
	effectdata:SetOrigin( vPoint )
	effectdata:SetEntity( self )
	effectdata:SetScale( 1 )
	util.Effect( effectName, effectdata )

end

function Entity:Fo_Draw()
	if ( fo.ShowFirstPersonFollower ) then self:DrawModel()	end
end

/// PARTICLE EMITTER BUG FIX?!
//
// Safe ParticleEmitter Josh 'Acecool' Moser
//
// This should be placed in a CLIENT run directory - such as addons/acecool_particleemitter_override/lua/autorun/client/_particleemitter.lua
// -- http://facepunch.com/showthread.php?t=1309609&p=42275212#post42275212
//
function isLoaded()
	if (_pos == null) then
		isLoaded()
	else
		if ( !PARTICLE_EMITTER ) then PARTICLE_EMITTER = ParticleEmitter; end
		function ParticleEmitter( _pos, _use3D )
			if ( !_GLOBAL_PARTICLE_EMITTER ) then 
				_GLOBAL_PARTICLE_EMITTER = { };
			end
		
			if ( _use3D ) then
				if ( !_GLOBAL_PARTICLE_EMITTER.use3D ) then
					_GLOBAL_PARTICLE_EMITTER.use3D = PARTICLE_EMITTER( _pos, true );
				else
					_GLOBAL_PARTICLE_EMITTER.use3D:SetPos( _pos );
				end
		
				return _GLOBAL_PARTICLE_EMITTER.use3D;
			else
				if ( !_GLOBAL_PARTICLE_EMITTER.use2D ) then
					_GLOBAL_PARTICLE_EMITTER.use2D = PARTICLE_EMITTER( _pos, false );
				else
					_GLOBAL_PARTICLE_EMITTER.use2D:SetPos( _pos );
				end
		
				return _GLOBAL_PARTICLE_EMITTER.use2D;
			end
		end
	end
end
