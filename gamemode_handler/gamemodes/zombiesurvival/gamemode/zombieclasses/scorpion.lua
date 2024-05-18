CLASS.Name = "Scorpion"
CLASS.TranslationName = "class_scorpio"

CLASS.Wave = 5 / 5

CLASS.Health = 1105
CLASS.Speed = 175

CLASS.Points = 12

CLASS.CanTaunt = true

CLASS.SWEP = "weapon_zs_scorpion"

CLASS.Model = Model("models/echo/ark/scorpion_pm.mdl")
CLASS.DamageResistance = 0.33
CLASS.VoicePitch = 0.4



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
    "playermodel_scorpion.footsteps",
}

function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)
    pl:EmitSound(StepSounds[math_random(#StepSounds)], 70)

    return true
end

function CLASS:CalcMainActivity(pl, velocity)
    if pl:WaterLevel() >= 3 then
        return ACT_HL2MP_SWIM, -1
    end

    if pl:Crouching() and pl:OnGround() then
        if velocity:Length2DSqr() <= 1 then
            return ACT_HL2MP_IDLE_CROUCH, -1
        else
            return ACT_HL2MP_WALK_CROUCH, -1
        end
    end

    return ACT_HL2MP_RUN, -1
end

function CLASS:PlayDeathSound(pl)
    pl:EmitSound("playermodel_scorpion.die", 70, math_random(80, 120))

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
        pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE, true)
        return ACT_INVALID
    elseif event == PLAYERANIMEVENT_RELOAD then
        pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RELOAD, true)
        return ACT_INVALID
    end
end


if not CLIENT then return end

CLASS.Icon = "materials/zombiesurvival/killicons2/ghoul.png"
CLASS.IconColor = COLOR_BLUE

if CLIENT then
    hook.Add("CalcView", "ScorpioThirdPersonView", function(ply, pos, angles, fov)
        if ply:GetZombieClassTable().Name == "Scorpion" then
            local view = {}
            view.origin = pos - (angles:Forward() * 120)
            view.angles = angles
            view.fov = fov
            return view
        end
    end)

    hook.Add("ShouldDrawLocalPlayer", "ScorpioThirdPerson", function(ply)
        if ply:GetZombieClassTable().Name == "Scorpion" then
            ply:DrawViewModel(false) -- Hide the viewmodel
            return true
        else
            ply:DrawViewModel(true) -- Show the viewmodel when not in third person
        end
    end)
end