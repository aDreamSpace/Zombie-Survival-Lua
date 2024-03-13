CLASS.Name = "Bonemesh"
CLASS.TranslationName = "class_bonemesh"
CLASS.Description = "description_bonemesh"
CLASS.Help = "controls_bonemesh"

CLASS.Wave = 0
CLASS.Threshold = 0
CLASS.Unlocked = true
CLASS.Hidden = true
CLASS.Boss = true

CLASS.Health = 5200
CLASS.Speed = 150

CLASS.FearPerInstance = 1

CLASS.Points = 30
CLASS.DamageResistance = 0.4
CLASS.SWEP = "weapon_zs_bonemesh"

CLASS.Model = Model("models/player/zombie_fast.mdl")

CLASS.VoicePitch = 0.8

CLASS.Hull = {Vector(-16, -16, 0), Vector(16, 16, 58)}
CLASS.HullDuck = {Vector(-16, -16, 0), Vector(16, 16, 32)}
CLASS.ViewOffset = Vector(0, 0, 50)
CLASS.ViewOffsetDucked = Vector(0, 0, 24)

CLASS.PainSounds = {"npc/zombie/zombie_pain1.wav", "npc/zombie/zombie_pain2.wav", "npc/zombie/zombie_pain3.wav", "npc/zombie/zombie_pain4.wav", "npc/zombie/zombie_pain5.wav", "npc/zombie/zombie_pain6.wav"}
CLASS.DeathSounds = {"npc/zombie/zombie_die1.wav", "npc/zombie/zombie_die2.wav", "npc/zombie/zombie_die3.wav"}

local STEPSOUNDTIME_NORMAL = STEPSOUNDTIME_NORMAL
local STEPSOUNDTIME_WATER_FOOT = STEPSOUNDTIME_WATER_FOOT
local STEPSOUNDTIME_ON_LADDER = STEPSOUNDTIME_ON_LADDER
local STEPSOUNDTIME_WATER_KNEE = STEPSOUNDTIME_WATER_KNEE
local ACT_ZOMBIE_LEAPING = ACT_ZOMBIE_LEAPING
local ACT_HL2MP_RUN_ZOMBIE_FAST = ACT_HL2MP_RUN_ZOMBIE_FAST

function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)
	if iFoot == 0 then
		pl:EmitSound("npc/antlion_guard/foot_light1.wav", 70, math.random(115, 120))
	else
		pl:EmitSound("npc/antlion_guard/foot_light2.wav", 70, math.random(115, 120))
	end

	return true
end

function CLASS:PlayerStepSoundTime(pl, iType, bWalking)
	if iType == STEPSOUNDTIME_NORMAL or iType == STEPSOUNDTIME_WATER_FOOT then
		return 450 - pl:GetVelocity():Length()
	elseif iType == STEPSOUNDTIME_ON_LADDER then
		return 400
	elseif iType == STEPSOUNDTIME_WATER_KNEE then
		return 550
	end

	return 250
end

function CLASS:CalcMainActivity(pl, velocity)
	if not pl:OnGround() or pl:WaterLevel() >= 3 then
		return ACT_ZOMBIE_LEAPING, -1
	end

	return ACT_HL2MP_RUN_ZOMBIE_FAST, -1
end

function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)
	if not pl:OnGround() or pl:WaterLevel() >= 3 then
		pl:SetPlaybackRate(1)

		if pl:GetCycle() >= 1 then
			pl:SetCycle(pl:GetCycle() - 1)
		end

		return true
	end
end

function CLASS:Move(pl, mv)
	if mv:GetForwardSpeed() <= 0 then
		mv:SetMaxSpeed(mv:GetMaxSpeed() * 0.33)
		mv:SetMaxClientSpeed(mv:GetMaxClientSpeed() * 0.33)
	end
end

function CLASS:DoAnimationEvent(pl, event, data)
	if event == PLAYERANIMEVENT_ATTACK_PRIMARY then
		pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_RANGE_ZOMBIE_SPECIAL, true)
		return ACT_INVALID
	end
end

if SERVER then
    function CLASS:OnSpawned(pl)
        local status = pl:GiveStatus("overridemodel")
        if status and status:IsValid() then
            status:SetModel("models/Zombie/Poison.mdl")
        end

        pl:CreateAmbience("bonemeshambience")

        -- Start a timer that runs every second
        timer.Create("HealZombies"..pl:EntIndex(), 1, 0, function()
            if not IsValid(pl) then return end  -- Stop if the Bonemesh is no longer valid

            -- Get all entities in a certain radius around the Bonemesh
            local entities = ents.FindInSphere(pl:GetPos(), 200)

            -- Loop over all entities
            for _, ent in pairs(entities) do
                -- If the entity is a player and is on TEAM_UNDEAD, increase their health
                if ent:IsPlayer() and ent:Team() == TEAM_UNDEAD then
                    ent:SetHealth(math.min(ent:GetMaxHealth(), ent:Health() + 35))  -- Increase health by 35, but don't go above max health
                end
            end
        end)
    end

    function CLASS:SwitchedAway(pl)
        timer.Remove("HealZombies"..pl:EntIndex())  -- Stop the timer when the Bonemesh is no longer the current class
    end
end


if not CLIENT then return end

CLASS.Icon = "materials/zombiesurvival/killicons2/bonemesh.png"