CLASS.Name = "The Butcher"
CLASS.TranslationName = "class_butcher"
CLASS.Description = "description_butcher"
CLASS.Help = "controls_butcher"

CLASS.Wave = 0
CLASS.Threshold = 0
CLASS.Unlocked = true
CLASS.Disabled = true 

CLASS.Health = 1100
CLASS.Speed = 100

CLASS.CanTaunt = true
CLASS.ModelScale = 1.25
CLASS.FearPerInstance = 1

CLASS.Points = 10

CLASS.SWEP = "weapon_zs_butcherknifez"

CLASS.Model = Model("models/player/corpse1.mdl")

CLASS.VoicePitch = 0.65

CLASS.PainSounds = {"npc/zombie/zombie_pain1.wav", "npc/zombie/zombie_pain2.wav", "npc/zombie/zombie_pain3.wav", "npc/zombie/zombie_pain4.wav", "npc/zombie/zombie_pain5.wav", "npc/zombie/zombie_pain6.wav"}

local ACT_HL2MP_SWIM_MELEE = ACT_HL2MP_SWIM_MELEE
local ACT_HL2MP_IDLE_CROUCH_MELEE = ACT_HL2MP_IDLE_CROUCH_MELEE
local ACT_HL2MP_WALK_CROUCH_MELEE = ACT_HL2MP_WALK_CROUCH_MELEE
local ACT_HL2MP_IDLE_MELEE = ACT_HL2MP_IDLE_MELEE
local ACT_HL2MP_RUN_ZOMBIE = ACT_HL2MP_RUN_ZOMBIE
local ACT_HL2MP_RUN_MELEE = ACT_HL2MP_RUN_MELEE
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
	pl:EmitSound("zsounds/death/death0"..mathrandom(1, 6)..".wav", 70, mathrandom(50, 70))

	return true
end

function CLASS:CalcMainActivity(pl, velocity)
	if pl:WaterLevel() >= 3 then
		return ACT_HL2MP_SWIM_MELEE, -1
	end

	if pl:Crouching() then
		if velocity:Length2DSqr() <= 1 then
			return ACT_HL2MP_IDLE_CROUCH_MELEE, -1
		end

		return ACT_HL2MP_WALK_CROUCH_MELEE, -1
	end

	local swinging = false
	local wep = pl:GetActiveWeapon()
	if wep:IsValid() and CurTime() < wep:GetNextPrimaryFire() then
		swinging = true
	end

	if velocity:Length2DSqr() <= 1 then
		if swinging then
			return ACT_HL2MP_IDLE_MELEE, -1
		end

		return ACT_HL2MP_RUN_ZOMBIE, -1
	end

	if swinging then
		return ACT_HL2MP_RUN_MELEE, -1
	end

	return ACT_HL2MP_RUN_ZOMBIE, -1
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

CLASS.Icon = "materials/zombiesurvival/killicons2/zombie.png"
CLASS.IconColor = COLOR_PURPLE 

local render_SetMaterial = render.SetMaterial
local render_DrawSprite = render.DrawSprite
local angle_zero = angle_zero
local LocalToWorld = LocalToWorld
local matSkin = Material("models/zombie_fast/fast_zombie_sheet")
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
end