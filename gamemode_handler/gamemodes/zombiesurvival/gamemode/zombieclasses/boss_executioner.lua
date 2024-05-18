CLASS.Name = "The Executioner"
CLASS.TranslationName = "class_executioner"
CLASS.Description = "description_executioner"
CLASS.Help = "controls_executioner"

CLASS.Wave = 0
CLASS.Threshold = 0
CLASS.Unlocked = false
CLASS.Hidden = true
CLASS.Boss = true

CLASS.Health = 5500
CLASS.Speed = 170
CLASS.ArmorRegenRate = 75
CLASS.CanTaunt = true
CLASS.DamageResistance = 0.4
CLASS.FearPerInstance = 1

CLASS.Points = 30

CLASS.SWEP = "cw_melee_zugs"

CLASS.Model = Model("models/player/pyramid_head.mdl")

CLASS.VoicePitch = 0.65

CLASS.PainSounds = {"npc/zombie/zombie_pain1.wav", "npc/zombie/zombie_pain2.wav", "npc/zombie/zombie_pain3.wav", "npc/zombie/zombie_pain4.wav", "npc/zombie/zombie_pain5.wav", "npc/zombie/zombie_pain6.wav"}
CLASS.DeathSounds = {"npc/zombie/zombie_die1.wav", "npc/zombie/zombie_die2.wav", "npc/zombie/zombie_die3.wav"}

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
	"physics/metal/metal_canister_impact_hard1.wav",
	"physics/metal/metal_canister_impact_hard2.wav",
	"physics/metal/metal_canister_impact_hard3.wav"
}
local StepRightSounds = {
	"physics/metal/metal_canister_impact_hard1.wav",
	"physics/metal/metal_canister_impact_hard2.wav",
	"physics/metal/metal_canister_impact_hard3.wav"
}
function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)
	if iFoot == 0 then
		pl:EmitSound(StepLeftSounds[mathrandom(#StepLeftSounds)], 70)
	else
		pl:EmitSound(StepRightSounds[mathrandom(#StepRightSounds)], 70)
	end

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

if SERVER then
	function CLASS:OnSpawned(pl)
		pl:CreateAmbience("executionerambience")
		local hands = ents.Create("zs_hands")
		if hands:IsValid() then
			hands:DoSetup(pl)
			hands:Spawn()
		end
	end

	local function MakeButcherKnife(pos)
		local ent = ents.Create("prop_weapon")
		if ent:IsValid() then
			ent:SetPos(pos)
			ent:SetAngles(AngleRand())
			ent:SetWeaponType("cw_melee_zweihander")
			ent:Spawn()

			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then
				phys:Wake()
				phys:SetVelocityInstantaneous(VectorRand():GetNormalized() * math.Rand(24, 100))
				phys:AddAngleVelocity(VectorRand() * 200)
			end
		end
	end

	function CLASS:OnKilled(pl, attacker, inflictor, suicide, headshot, dmginfo, assister)
		local pos = pl:LocalToWorld(pl:OBBCenter())
		timer.Simple(0, function()
			MakeButcherKnife(pos)
		end)
	end
end

if not CLIENT then return end

CLASS.Icon = "materials/zombiesurvival/killicons2/executioner.png"
CLASS.IconColor = COLOR_RED

local matSkin = Material("models/zombie_fast/fast_zombie_sheet")
function CLASS:PrePlayerDraw(pl)
	render.ModelMaterialOverride(matSkin)
end

function CLASS:PostPlayerDraw(pl)
	render.ModelMaterialOverride()
end

