CLASS.Name = "Skeletor"
CLASS.TranslationName = "class_skeletor"
CLASS.Description = ""
CLASS.Help = ""

CLASS.Wave = 2 / 5
CLASS.Unlocked = false
CLASS.Hidden = true

CLASS.Health = 475
CLASS.Speed = 135

CLASS.Points = 7

CLASS.CanTaunt = true

CLASS.Model = "models/player/skeleton.mdl"

CLASS.SWEP = "weapon_zs_skeletor"

CLASS.PainSounds = {"npc/zombie/zombie_pain1.wav", "npc/zombie/zombie_pain2.wav", "npc/zombie/zombie_pain3.wav", "npc/zombie/zombie_pain4.wav", "npc/zombie/zombie_pain5.wav", "npc/zombie/zombie_pain6.wav"}
CLASS.DeathSounds = {"npc/zombie/zombie_die1.wav", "npc/zombie/zombie_die2.wav", "npc/zombie/zombie_die3.wav"}

CLASS.VoicePitch = 2

CLASS.CanFeignDeath = false

local mathrandom = math.random
local StepLeftSounds = {
	"npc/zombie/foot1.wav",
	"npc/zombie/foot2.wav"
}
local StepRightSounds = {
	"npc/zombie/foot2.wav",
	"npc/zombie/foot3.wav"
}

local math_ceil = math.ceil
function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)
	if iFoot == 0 then
		pl:EmitSound(StepLeftSounds[mathrandom(#StepLeftSounds)], 70)
	else
		pl:EmitSound(StepRightSounds[mathrandom(#StepRightSounds)], 70)
	end

	return true
end
--[[function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)
	if iFoot == 0 then
		pl:EmitSound("Zombie.FootstepLeft")
	else
		pl:EmitSound("Zombie.FootstepRight")
	end

	return true
end]]

function CLASS:CalcMainActivity(pl, velocity)
    if pl:WaterLevel() >= 3 then
        return ACT_HL2MP_SWIM, -1
    end

    if pl:Crouching() and pl:OnGround() then
        return ACT_HL2MP_WALK_CROUCH, -1
    end

    if velocity:Length2DSqr() > 0.5 then
        return ACT_HL2MP_RUN, -1
    end

    return ACT_HL2MP_IDLE, -1
end

function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)
    local len2d = velocity:Length2D()
    if len2d > 0.5 then
        pl:SetPlaybackRate(math.min(len2d / maxseqgroundspeed, 3))
    else
        pl:SetPlaybackRate(1)
    end

    return true
end

function CLASS:DoAnimationEvent(pl, event, data)
	if event == PLAYERANIMEVENT_ATTACK_PRIMARY then
		pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_RANGE_ZOMBIE, true)
		return ACT_INVALID
	end
end


function CLASS:DoesntGiveFear(pl)
	return pl.FeignDeath and pl.FeignDeath:IsValid()
end

if SERVER then
	function CLASS:OnKilled(pl, attacker, inflictor, suicide, headshot, dmginfo)
		pl:SetZombieClass(GAMEMODE.DefaultZombieClass)
	end

	function CLASS:AltUse(pl)
		pl:StartFeignDeath()
	end
end

if not CLIENT then return end

CLASS.Icon = "zombiesurvival/killicons2/zombie.png"
CLASS.IconColor = COLOR_YELLOW 

CLASS.Icon = "materials/zombiesurvival/killicons2/juggernaut.png"
CLASS.IconColor = COLOR_RORANGE 

local render_SetMaterial = render.SetMaterial
local render_DrawSprite = render.DrawSprite
local angle_zero = angle_zero
local LocalToWorld = LocalToWorld
local matSkin = Material("models/weapons/v_crossbow/rebar_glow")
local colGlow = Color(255, 111, 0)
local matGlow = Material("sprites/glow04_noz")
local vecEyeLeft = Vector(4, -4.6, -1)
local vecEyeRight = Vector(4, -4.6, 1)

function CLASS:PrePlayerDraw(pl)
    render.SetColorModulation(0.012, 0.059, 0.984)
    render.ModelMaterialOverride(matSkin)
end

function CLASS:PostPlayerDraw(pl)
    render.SetColorModulation(0.012, 0.239, 0.984)
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
            particle:SetStartSize(4)
            particle:SetEndSize(0)
            particle:SetColor(55, 255, 0)
        end
    end

    emitter:Finish()
end