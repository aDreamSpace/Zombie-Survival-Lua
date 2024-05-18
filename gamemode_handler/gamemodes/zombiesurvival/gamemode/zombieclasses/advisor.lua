CLASS.Name = "Advisor"
CLASS.TranslationName = "class_advisor"
CLASS.Description = "description_advisor"
CLASS.Help = "controls_advisor"

CLASS.Wave = 5 / 5
CLASS.ArmorRegenRate = 75
CLASS.Health = 1025
CLASS.Speed = 150

--[[
CLASS.ZTraits = {
	["10spd"] = {safename = "+10% Speed", cost = 400},
}
]]

CLASS.Points = 8
CLASS.DamageResistance = 0.7
CLASS.CanTaunt = true

CLASS.SWEP = "weapon_zs_advisor"

CLASS.Model = Model("models/echo/hla/advisor_pm.mdl")

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

function CLASS:PlayFootstepSound(pl)
    if GetConVarNumber("mute_advisor_footsteps") == 1 and pl:Alive() then
        pl:EmitSound("playermodel_advisor.footsteps")
        return true
    end
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
    if GetConVarNumber("player_advisor_sounds") == 1 then
        pl:EmitSound("playermodel_advisor.die")
        return true
    end
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
        pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_TAUNT_ZOMBIE, true)
        return ACT_INVALID
    end
end

function CLASS:PlayPainSound(pl)
    if GetConVarNumber("player_advisor_sounds") == 1 then
        pl:EmitSound("playermodel_advisor.pain")
        return true
    end
end

if not CLIENT then return end

CLASS.Icon = "materials/zombiesurvival/killicons2/juggernaut.png"
CLASS.IconColor = COLOR_GREEN 

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
	render.SetColorModulation(0, 0, 0)
end

function CLASS:PostPlayerDraw(pl)
    render.SetColorModulation(0, 0, 0)
    render.ModelMaterialOverride()
    if pl == MySelf and not pl:ShouldDrawLocalPlayer() or pl.SpawnProtection then return end

    -- Get the player's bounding box
    local min, max = pl:GetModelBounds()

    -- Calculate the number of particles to emit
    local numParticles = 1 -- Adjust this to the desired number of particles

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
            particle:SetStartSize(5) -- Set the size to 10
            particle:SetEndSize(0)
            particle:SetColor(252, 181, 0) -- Set the color to red
        end
    end
--Color(252, 181, 0)
    -- Release the emitter
    emitter:Finish()
end


if CLIENT then
    hook.Add("CalcView", "AdvisorThirdPersonView", function(ply, pos, angles, fov)
        if ply:Alive() and ply:GetZombieClassTable().Name == "Advisor" then
            local view = {}
            view.origin = pos - (angles:Forward() * 120)
            view.angles = angles
            view.fov = fov
            view.drawviewer = true

            return view
        end
    end)
end

