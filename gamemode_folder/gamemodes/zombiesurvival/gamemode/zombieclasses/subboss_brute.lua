CLASS.Name = "Brute"
CLASS.TranslationName = "class_brute"
CLASS.Description = "description_brute"
CLASS.Help = "controls_brute"

CLASS.Wave = 0
CLASS.Disabled = true 

CLASS.NoGibs = true
CLASS.NoFallDamage = true
CLASS.Health = 1265
CLASS.Speed = 115

CLASS.CanTaunt = true

CLASS.Points = 10

CLASS.SWEP = "weapon_zs_brute"

CLASS.Model = Model("models/player/zombie_classic.mdl")

CLASS.PainSounds = {"npc/zombie/zombie_pain1.wav", "npc/zombie/zombie_pain2.wav", "npc/zombie/zombie_pain3.wav", "npc/zombie/zombie_pain4.wav", "npc/zombie/zombie_pain5.wav", "npc/zombie/zombie_pain6.wav"}


CLASS.VoicePitch = 0.35

--[[
CLASS.ZTraits = {
	["25hlth"] = {safename = "+25% Health", cost = 100},
}
]]

if SERVER then
    function CLASS:OnSpawned(pl)
        if pl:IsBot() then
            if pl:GetZombieClassTable().Name == "Zombie" then
                pl:SetBodygroup( 1, 1 )
            end
        end
    end

    function CLASS:OnKilled(pl, attacker, inflictor, suicide, headshot, dmginfo, assister)
        if pl:IsBot() then
            if pl:GetZombieClassTable().Name == "Zombie" then
                pl:SetBodygroup( 1, 0 )
            end
        end
    end
end

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

function CLASS:PlayDeathSound(pl)
	pl:EmitSound("zsounds/death/death0"..math_random(1, 6)..".wav", 70, math_random(80, 120))

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

local math_random = math.random
local math_Approach = math.Approach
local math_min = math.min
local math_ceil = math.ceil
local math_Clamp = math.Clamp
local vecSpineOffset = Vector(8, 0, 0)
local SpineBones = {"ValveBiped.Bip01_Spine2", "ValveBiped.Bip01_Spine4", "ValveBiped.Bip01_Spine3"}
function CLASS:BuildBonePositions(pl)
	for _, bone in pairs(SpineBones) do
		local spineid = pl:LookupBone(bone)
		if spineid and spineid > 0 then
			pl:ManipulateBonePosition(spineid, vecSpineOffset)
		end
	end

	local wep = pl:GetActiveWeapon()
	if wep:IsValid() and wep.GetSwingEndTime then
		local desiredscale
		if wep:GetSwingEndTime() > 0 then
			desiredscale = 2 + (1 - math_Clamp((wep:GetSwingEndTime() - CurTime()) / wep.MeleeDelay, 0, 1)) * 10
		else
			desiredscale = 5
		end

	end
end

if not CLIENT then return end

CLASS.Icon = "materials/zombiesurvival/killicons2/zombie.png"
CLASS.IconColor = COLOR_CYAN

local render_SetMaterial = render.SetMaterial
local render_DrawSprite = render.DrawSprite
local angle_zero = angle_zero
local LocalToWorld = LocalToWorld
local matSkin = Material("models/synth/mainbody")
local colGlow = Color(0, 234, 255)
local matGlow = Material("sprites/glow04_noz")
local vecEyeLeft = Vector(4, -4.6, -1)
local vecEyeRight = Vector(4, -4.6, 1)

function CLASS:PrePlayerDraw(pl)
	render.SetColorModulation(0.518, 0.973, 0)
	render.ModelMaterialOverride(matSkin)
end

function CLASS:PostPlayerDraw(pl)
	render.SetColorModulation(0.616, 1, 0)
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