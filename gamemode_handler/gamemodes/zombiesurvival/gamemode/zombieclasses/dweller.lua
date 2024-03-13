CLASS.Name = "Dweller"
CLASS.TranslationName = "class_dweller"
CLASS.Description = "description_dweller"
CLASS.Help = "controls_dweller"

CLASS.Wave = 1 / 5
CLASS.Unlocked = true

CLASS.Health = 325
CLASS.Speed = 143

--[[
CLASS.ZTraits = {
	["10spd"] = {safename = "+10% Speed", cost = 400},
}
]]

CLASS.Points = 8

CLASS.CanTaunt = true

CLASS.SWEP = "weapon_zs_dweller"

CLASS.Model = Model("models/player/stalker/packboy.mdl")

CLASS.VoicePitch = 0.4

CLASS.CanFeignDeath = true

local math_random = math.random
local math_Rand = math.Rand
local math_min = math.min
local math_ceil = math.ceil
local CurTime = CurTime

local ACT_HL2MP_SWIM_PISTOL = ACT_HL2MP_SWIM_PISTOL
local ACT_HL2MP_IDLE_CROUCH_ZOMBIE = ACT_HL2MP_IDLE_CROUCH_ZOMBIE
local ACT_HL2MP_WALK_CROUCH_ZOMBIE_01 = ACT_HL2MP_WALK_CROUCH_ZOMBIE_01
local ACT_HL2MP_RUN_ZOMBIE = ACT_HL2MP_RUN_ZOMBIE

local StepSounds = {
	"npc/zombie/foot1.wav",
	"npc/zombie/foot2.wav",
	"npc/zombie/foot3.wav"
}
function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)
	pl:EmitSound(StepSounds[math_random(#StepSounds)], 70)

	return true
end

function CLASS:CalcMainActivity(pl, velocity)
	if pl:WaterLevel() >= 3 then
		return ACT_HL2MP_SWIM_PISTOL, -1
	end

	if pl:Crouching() and pl:OnGround() then
		if velocity:Length2DSqr() <= 1 then
			return ACT_HL2MP_IDLE_CROUCH_ZOMBIE, -1
		end

		return ACT_HL2MP_WALK_CROUCH_ZOMBIE_01 - 1 + math_ceil((CurTime() / 4 + pl:EntIndex()) % 3), -1
	end

	return ACT_HL2MP_RUN_ZOMBIE, -1
end

function CLASS:PlayDeathSound(pl)
	pl:EmitSound("zsounds/death/death0"..math_random(1, 6)..".wav", 70, math_random(80, 120))

	return true
end


function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)
	local len2d = velocity:Length2D()
	if len2d > 0.5 then
		pl:SetPlaybackRate(math_min(len2d / maxseqgroundspeed, 3))
	else
		pl:SetPlaybackRate(1)
	end

	return true
end

function CLASS:DoAnimationEvent(pl, event, data)
	if event == PLAYERANIMEVENT_ATTACK_PRIMARY then
		pl:DoZombieAttackAnim(data)
		return ACT_INVALID
	elseif event == PLAYERANIMEVENT_RELOAD then
		pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_TAUNT_ZOMBIE, true)
		return ACT_INVALID
	end
end


if not CLIENT then return end

CLASS.Icon = "materials/zombiesurvival/killicons2/ghoul.png"
CLASS.IconColor = COLOR_ORANGE

local render_SetMaterial = render.SetMaterial
local render_DrawSprite = render.DrawSprite
local angle_zero = angle_zero
local LocalToWorld = LocalToWorld
local matSkin = Material("models/weapons/v_crossbow/rebar_glow")
local colGlow = Color(240, 36, 0)
local matGlow = Material("sprites/glow04_noz")
local vecEyeLeft = Vector(4, -4.6, -1)
local vecEyeRight = Vector(4, -4.6, 1)

function CLASS:PrePlayerDraw(pl)
	render.SetColorModulation(0.702, 0, 1)
end

function CLASS:PostPlayerDraw(pl)
    render.SetColorModulation(0.4, 0.1, 0.6)
    render.ModelMaterialOverride()
    if pl == MySelf and not pl:ShouldDrawLocalPlayer() or pl.SpawnProtection then return end

    -- Get the player's bounding box
    local min, max = pl:GetModelBounds()

    -- Calculate the number of particles to emit
    local numParticles = 2 -- Adjust this to the desired number of particles

    -- Create a particle emitter
    local emitter = ParticleEmitter(pl:GetPos())

    -- Emit particles at random points within the bounding box
    for i = 1, numParticles do
        local pos = Vector(
            math.Rand(min.x, max.x),
            math.Rand(min.y, max.y),
            math.Rand(min.z, max.z)
        )

        -- Create a new particle at the position
        local particle = emitter:Add("sprites/glow04_noz", pl:LocalToWorld(pos))

        if particle then
            particle:SetDieTime(1) -- Set the lifetime to 2 seconds
            particle:SetStartAlpha(255)
            particle:SetEndAlpha(0)
            particle:SetStartSize(2) -- Set the size to 10
            particle:SetEndSize(0)
            particle:SetColor(240, 36, 0) -- Set the color to red
        end
    end

    -- Release the emitter
    emitter:Finish()
end




