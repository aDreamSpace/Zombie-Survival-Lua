CLASS.Name = "Juggernaut"
CLASS.TranslationName = "class_jugg"
CLASS.Description = "description_jugg"
CLASS.Help = "controls_jugg"

CLASS.Wave = 5 / 5


CLASS.Health = 950
CLASS.Speed = 170

--[[
CLASS.ZTraits = {
	["10spd"] = {safename = "+10% Speed", cost = 400},
	["25health"] ={safename = "+75% HP", cost= 1500}, 
}
]]


CLASS.Points = 7

CLASS.CanTaunt = true

CLASS.SWEP = "weapon_zs_jugg"

CLASS.Model = Model("models/player/corpse1.mdl")

CLASS.VoicePitch = 0.7

CLASS.CanFeignDeath = true



local ACT_HL2MP_SWIM_MELEE = ACT_HL2MP_SWIM_MELEE
local ACT_HL2MP_IDLE_CROUCH_MELEE = ACT_HL2MP_IDLE_CROUCH_MELEE
local ACT_HL2MP_WALK_CROUCH_MELEE = ACT_HL2MP_WALK_CROUCH_MELEE
local ACT_HL2MP_IDLE_CROUCH_MELEE2 = ACT_HL2MP_IDLE_CROUCH_MELEE2
local ACT_HL2MP_WALK_CROUCH_MELEE2 = ACT_HL2MP_WALK_CROUCH_MELEE2
local ACT_HL2MP_IDLE_MELEE = ACT_HL2MP_IDLE_MELEE
local ACT_HL2MP_IDLE_MELEE2 = ACT_HL2MP_IDLE_MELEE2
local ACT_HL2MP_RUN_ZOMBIE = ACT_HL2MP_RUN_ZOMBIE
local ACT_HL2MP_RUN_MELEE = ACT_HL2MP_RUN_MELEE
local ACT_HL2MP_RUN_MELEE2 = ACT_HL2MP_RUN_MELEE2
local ACT_HL2MP_WALK_MELEE2 = ACT_HL2MP_WALK_MELEE2
local ACT_HL2MP_RUN_ZOMBIE = ACT_HL2MP_RUN_ZOMBIE

local mathrandom = math.random
local StepLeftSounds = {
	"npc/fast_zombie/foot1.wav",
	"npc/fast_zombie/foot2.wav"
}
local StepRightSounds = {
	"npc/fast_zombie/foot3.wav",
	"npc/fast_zombie/foot4.wav"
}
function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)
	if iFoot == 0 then
		pl:EmitSound(StepLeftSounds[mathrandom(#StepLeftSounds)], 70)
	else
		pl:EmitSound(StepRightSounds[mathrandom(#StepRightSounds)], 70)
	end

	return true
end

function CLASS:PlayDeathSound(pl)
	pl:EmitSound("zsounds/death/death0"..mathrandom(1, 6)..".wav", 70, mathrandom(80, 120))

	return true
end

function CLASS:CalcMainActivity(pl, velocity)
	if pl:WaterLevel() >= 3 then
		return ACT_HL2MP_SWIM_MELEE, -1
	end

	if pl:Crouching() then
		if velocity:Length2DSqr() <= 1 then
			return ACT_HL2MP_IDLE_CROUCH_MELEE2, -1
		end

		return ACT_HL2MP_WALK_CROUCH_MELEE2, -1
	end

	local swinging = false
	local wep = pl:GetActiveWeapon()
	if wep:IsValid() and CurTime() < wep:GetNextPrimaryFire() then
		swinging = true
	end

	if velocity:Length2DSqr() <= 1 then
		if swinging then
			return ACT_HL2MP_IDLE_MELEE2, -1
		end

		return ACT_HL2MP_RUN_MELEE2, -1
	end

	if swinging then
		return ACT_HL2MP_RUN_MELEE, -1
	end

	return ACT_HL2MP_RUN_MELEE2, -1
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
		pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE, true)
		return ACT_INVALID
	end
end



if not CLIENT then return end

CLASS.Icon = "materials/zombiesurvival/killicons2/juggernaut.png"
CLASS.IconColor = COLOR_RORANGE 

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
    render.SetColorModulation(0.984, 0.012, 0.012)
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
            particle:SetColor(255, 251, 0)
        end
    end

    emitter:Finish()
end