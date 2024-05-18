CLASS.Name = "Mech Dog"
CLASS.TranslationName = "class_mechdog"


CLASS.Wave = 4   / 5

CLASS.Health = 1075 
CLASS.Speed = 200

--[[
CLASS.ZTraits = {
	["10spd"] = {safename = "+10% Speed", cost = 400},
}
]]

CLASS.Points = 9

CLASS.CanTaunt = true

CLASS.SWEP = "weapon_zs_mechdog"

CLASS.Model = Model("models/player/dog.mdl")
CLASS.DamageResistance = 0.65
CLASS.HealthRegenRate = 22 
CLASS.VoicePitch = 0.4
CLASS.NoFallDamage = true
CLASS.NoFallSlowdown = true

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

CLASS.Icon = "materials/zombiesurvival/killicons2/juggernaut.png"
CLASS.IconColor = COLOR_PINK 

local render_SetMaterial = render.SetMaterial
local render_DrawSprite = render.DrawSprite
local angle_zero = angle_zero
local LocalToWorld = LocalToWorld
local matSkin = Material("models/weapons/v_crossbow/rebar_glow")
local colGlow = Color(162, 0, 255)
local matGlow = Material("sprites/glow04_noz")
local vecEyeLeft = Vector(4, -4.6, -1)
local vecEyeRight = Vector(4, -4.6, 1)

function CLASS:PrePlayerDraw(pl)
    render.SetColorModulation(1, 0, 0)
    render.ModelMaterialOverride(matSkin)
end

function CLASS:PostPlayerDraw(pl)
    render.SetColorModulation(0.984, 0.012, 0.012)
    render.ModelMaterialOverride()

    if pl == MySelf and not pl:ShouldDrawLocalPlayer() or pl.SpawnProtection then return end

    local id = pl:LookupBone("ValveBiped.Bip01_Head1")
    if id and id > 0 then
        local pos, ang = pl:GetBonePositionMatrixed(id)
        if pos then
            render_SetMaterial(matGlow)
            render_DrawSprite(LocalToWorld(vecEyeLeft, angle_zero, pos, ang), 4, 4, colGlow)
            render_DrawSprite(LocalToWorld(vecEyeRight, angle_zero, pos, ang), 4, 4, colGlow)
        end
    end

    local min, max = pl:GetModelBounds()
    local numParticles = 1
    local emitter = ParticleEmitter(pl:GetPos())

    for i = 1, numParticles do
        local pos = Vector(
            math.Rand(min.x, max.x),
            math.Rand(min.y, max.y),
            math.Rand(min.z, max.z)
        )

        local particle = emitter:Add("sprites/glow04_noz", pl:LocalToWorld(pos))

        if particle then
            particle:SetDieTime(1)
            particle:SetStartAlpha(255)
            particle:SetEndAlpha(0)
            particle:SetStartSize(3)
            particle:SetEndSize(0)
            particle:SetColor(0, 173, 101)
        end
    end

    emitter:Finish()
end


if CLIENT then
    hook.Add("CalcView", "DogThirdPersonView", function(ply, pos, angles, fov)
        if ply:GetZombieClassTable().Name == "Mech Dog" then
            local view = {}
            view.origin = pos - (angles:Forward() * 120) -- Increase this value to move the camera further away
            view.angles = angles
            view.fov = fov
            ply:DrawViewModel(false) -- Hide the viewmodel
            return view
        else
            ply:DrawViewModel(true) -- Show the viewmodel when not in third person
        end
    end)

    hook.Add("ShouldDrawLocalPlayer", "MechDogThirdPerson", function(ply)
        if ply:GetZombieClassTable().Name == "Mech Dog" then
            return true
        end
    end)
end