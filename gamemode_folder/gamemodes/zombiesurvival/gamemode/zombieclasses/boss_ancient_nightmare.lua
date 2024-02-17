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


-- Server-side code
if SERVER then
	-- Store the original walk speeds to restore them later
	local originalWalkSpeeds = {}

	hook.Add("PlayerTick", "AncientNightmareSlow", function(pl, mv)
		-- Only affect humans
		if pl:Team() == TEAM_HUMAN then
			-- Find all Ancient Nightmares
			for _, zombie in pairs(team.GetPlayers(TEAM_UNDEAD)) do
				if zombie:GetZombieClassTable().Name == "Ancient Nightmare" then
					-- Calculate the distance to the Ancient Nightmare
					local distance = pl:GetPos():Distance(zombie:GetPos())

					-- If the player is within a certain distance of the Ancient Nightmare
					if distance < 500 then
						-- Store the original walk speed if it hasn't been stored yet
						if not originalWalkSpeeds[pl] then
							originalWalkSpeeds[pl] = pl:GetWalkSpeed()
						end

						-- Reduce the player's walk speed based on their proximity to the Ancient Nightmare
						pl:SetWalkSpeed(math.max(50, originalWalkSpeeds[pl] * (distance / 500)))
					else
						-- If the player is far enough away from the Ancient Nightmare, restore their original walk speed
						if originalWalkSpeeds[pl] then
							pl:SetWalkSpeed(originalWalkSpeeds[pl])
							originalWalkSpeeds[pl] = nil
						end
					end
				end
			end
		end
	end)
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

CLASS.Icon = "materials/zombiesurvival/killicons2/nightmare.png"
CLASS.IconColor = COLOR_YELLOW 

function CLASS:PrePlayerDraw(pl)
	render.SetColorModulation(0, 0, 0)
end

function CLASS:PostPlayerDraw(pl)
	render.SetColorModulation(0, 0, 0)
end