CLASS.Name = "Ancient Nightmare"
CLASS.TranslationName = "class_ancientnightmare"
CLASS.Description = "description_nightmare"
CLASS.Help = "controls_nightmare"

CLASS.Wave = 0

CLASS.KnockbackScale = 0

CLASS.Health = 5000
CLASS.Speed = 165 -- 150
CLASS.Boss = true 

CLASS.CanTaunt = true

CLASS.Points = 50

CLASS.SWEP = "weapon_zs_ancientnightmare"

CLASS.Model = Model("models/player/skeleton.mdl")


CLASS.VoicePitch = 0.65

CLASS.PainSounds = {"npc/zombie/zombie_pain1.wav", "npc/zombie/zombie_pain2.wav", "npc/zombie/zombie_pain3.wav", "npc/zombie/zombie_pain4.wav", "npc/zombie/zombie_pain5.wav", "npc/zombie/zombie_pain6.wav"}
CLASS.DeathSounds = {"npc/zombie/zombie_die1.wav", "npc/zombie/zombie_die2.wav", "npc/zombie/zombie_die3.wav"}

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

function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)
	local len2d = velocity:Length2D()
	if len2d > 0.5 then
		pl:SetPlaybackRate(math_min(len2d / maxseqgroundspeed, 3))
	else
		pl:SetPlaybackRate(1)
	end

	return true
end

-- Add a hook for the EntityTakeDamage event
hook.Add("EntityTakeDamage", "NightmareDamageReduction", function(target, dmginfo)
    -- Check if the target is a player and is a Scorpio
    if target:IsPlayer() and target:Team() == TEAM_UNDEAD and target:GetZombieClassTable().Name == "Ancient Nightmare" then
        -- Reduce the damage by 51%
        dmginfo:ScaleDamage(0.6)
    end
end)


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

CLASS.Icon = "materials/zombiesurvival/killicons2/nightmare.png"
CLASS.IconColor = COLOR_YELLOW 


local render_SetMaterial = render.SetMaterial
local render_DrawSprite = render.DrawSprite
local angle_zero = angle_zero
local LocalToWorld = LocalToWorld
local matSkin = Material("models/weapons/v_crossbow/rebar_glow")
local colGlow = Color(255, 0, 0)
local matGlow = Material("sprites/glow04_noz")
local vecEyeLeft = Vector(4, -4.6, -1)
local vecEyeRight = Vector(4, -4.6, 1)

function CLASS:PrePlayerDraw(pl)
    render.SetColorModulation(0, 0, 0)
    render.ModelMaterialOverride(matSkin)
end

function CLASS:PostPlayerDraw(pl)
    render.SetColorModulation(0, 0, 0)
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
    local numParticles = 2
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
            particle:SetStartSize(2)
            particle:SetEndSize(0)
            particle:SetColor(174, 0, 255)
        end
    end
	--Color(0, 173, 101)
    emitter:Finish()
end

