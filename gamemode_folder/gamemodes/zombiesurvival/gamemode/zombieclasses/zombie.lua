CLASS.Name = "Zombie"
CLASS.TranslationName = "class_zombie"
CLASS.Description = "description_zombie"
CLASS.Help = "controls_zombie"

CLASS.Wave = 0
CLASS.Unlocked = true
CLASS.IsDefault = true
CLASS.Order = 0
CLASS.NoGibs = true
CLASS.NoFallDamage = true
CLASS.Health = 365
CLASS.Speed = 130

CLASS.CanTaunt = true

CLASS.Points = 8

CLASS.SWEP = "weapon_zs_zombie"

CLASS.Model = Model("models/player/zombie_classic.mdl")

CLASS.PainSounds = {"npc/zombie/zombie_pain1.wav", "npc/zombie/zombie_pain2.wav", "npc/zombie/zombie_pain3.wav", "npc/zombie/zombie_pain4.wav", "npc/zombie/zombie_pain5.wav", "npc/zombie/zombie_pain6.wav"}


CLASS.VoicePitch = 0.65

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



if not CLIENT then return end

CLASS.Icon = "materials/zombiesurvival/killicons2/zombie.png"

