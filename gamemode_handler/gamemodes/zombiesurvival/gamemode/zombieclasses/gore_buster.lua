CLASS.Name = "Gore Buster"
CLASS.TranslationName = "class_gorebuster"
CLASS.Description = "description_gorebuster"
CLASS.Help = "controls_gorebuster"

CLASS.Wave = 2 / 5
CLASS.ModelScale = 1
CLASS.Health = 380
CLASS.Speed = 150
--CLASS.JumpPower = 225
--CLASS.Mass = DEFAULT_MASS * 2

CLASS.CanTaunt = true

CLASS.Points = 7

--[[
CLASS.ZTraits = {
	["25hlth"] = {safename = "+25% Health", cost = 150},
	["bloatbomb"] = {safename = "Bile Bomb", cost = 100, desc = "Increase amount of poison particles on death"},
	["acidic"] = {safename = "Acidic Poison", cost = 150, desc = "Increase damage of poison particles"},
}
]]

CLASS.SWEP = "weapon_zs_gorebuster"

CLASS.Model = Model("models/player/zombie_classic.mdl")



CLASS.VoicePitch = 0.6

CLASS.CanFeignDeath = false

sound.Add({
	name = "fatty.footstep",
    channel = CHAN_BODY,
    volume = 0.8,
    soundlevel = 65,
    pitchstart = 75,
    pitchend = 75,
    sound = {"npc/zombie/foot1.wav", "npc/zombie/foot2.wav", "npc/zombie/foot3.wav"}
})

sound.Add({
	name = "fatty.footscuff",
    channel = CHAN_BODY,
    volume = 0.8,
    soundlevel = 65,
    pitchstart = 75,
    pitchend = 75,
    sound = {"npc/zombie/foot_slide1.wav", "npc/zombie/foot_slide2.wav", "npc/zombie/foot_slide3.wav"}
})

local math_random = math.random 
local math_ceil = math.ceil
local DIR_BACK = DIR_BACK
local ACT_HL2MP_ZOMBIE_SLUMP_RISE = ACT_HL2MP_ZOMBIE_SLUMP_RISE
local ACT_HL2MP_SWIM_PISTOL = ACT_HL2MP_SWIM_PISTOL
local ACT_HL2MP_IDLE_CROUCH_ZOMBIE = ACT_HL2MP_IDLE_CROUCH_ZOMBIE
local ACT_HL2MP_WALK_CROUCH_ZOMBIE_01 = ACT_HL2MP_WALK_CROUCH_ZOMBIE_01
local ACT_HL2MP_RUN_ZOMBIE = ACT_HL2MP_RUN_ZOMBIE

function CLASS:PlayPainSound(pl)
	pl:EmitSound("npc/zombie_poison/pz_idle"..math.random(2, 3)..".wav", 72, math.Rand(55, 65))

	return true
end
function CLASS:PlayDeathSound(pl)
	pl:EmitSound("zsounds/death/death0"..math_random(1, 6)..".wav", 70, math_random(80, 120))

	return true
end
local mathrandom = math.random
local StepSounds = {
	"npc/zombie/foot1.wav",
	"npc/zombie/foot2.wav",
	"npc/zombie/foot3.wav"
}
local ScuffSounds = {
	"npc/zombie/foot_slide1.wav",
	"npc/zombie/foot_slide2.wav",
	"npc/zombie/foot_slide3.wav"
}
function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)
	if mathrandom() < 0.15 then
		pl:EmitSound(ScuffSounds[mathrandom(#ScuffSounds)], 70, 75)
	else
		pl:EmitSound(StepSounds[mathrandom(#StepSounds)], 70, 75)
	end

	return true
end

function CLASS:CalcMainActivity(pl, velocity)
	local feign = pl.FeignDeath
	if feign and feign:IsValid() then
		if feign:GetDirection() == DIR_BACK then
			return 1, pl:LookupSequence("zombie_slump_rise_02_fast")
		end

		return ACT_HL2MP_ZOMBIE_SLUMP_RISE, -1
	end

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
	local feign = pl.FeignDeath
	if feign and feign:IsValid() then
		if feign:GetState() == 1 then
			pl:SetCycle(1 - math.max(feign:GetStateEndTime() - CurTime(), 0) * 0.666)
		else
			pl:SetCycle(math.max(feign:GetStateEndTime() - CurTime(), 0) * 0.666)
		end
		pl:SetPlaybackRate(0)
		return true
	end

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
	function CLASS:AltUse(pl)
		pl:StartFeignDeath()
	end

	local function Bomb(pl, pos, dir)
		if not IsValid(pl) then return end

		dir:RotateAroundAxis(dir:Right(), 30)

		local effectdata = EffectData()
			effectdata:SetOrigin(pos)
			effectdata:SetNormal(dir:Forward())
		util.Effect("fatexplosion", effectdata, true)

		local amt = 6
		if pl:GetZTraitCurrent("bloatbomb") then
			amt = amt * 2
		end

		local bAddDmg = false
		if pl:GetZTraitCurrent("acidic") then
			bAddDmg = true
		end

		for i=1, amt do
			local ang = Angle()
			ang:Set(dir)
			ang:RotateAroundAxis(ang:Up(), math.Rand(-30, 30))
			ang:RotateAroundAxis(ang:Right(), math.Rand(-30, 30))

			local heading = ang:Forward()

			local ent = ents.CreateLimited("projectile_poisonflesh")
			if ent:IsValid() then
				ent:SetPos(pos)
				ent:SetOwner(pl)
				if bAddDmg then
					ent.Damage = ent.Damage + 3
				end
				ent:Spawn()

				local phys = ent:GetPhysicsObject()
				if phys:IsValid() then
					phys:Wake()
					phys:SetVelocityInstantaneous(heading * math.Rand(120, 250))
				end
			end
		end
	end

	function CLASS:OnKilled(pl, attacker, inflictor, suicide, headshot, dmginfo, assister)
		if attacker ~= pl and not suicide then
			local pos = pl:LocalToWorld(pl:OBBCenter())
			local ang = pl:SyncAngles()
			timer.Simple(0, function() Bomb(pl, pos, ang) end)
		end
	end
end

if CLIENT then
CLASS.Icon = "materials/zombiesurvival/killicons2/gorebuster.png"
end

local matSkin = Material("models/zombie_fast/fast_zombie_sheet")
function CLASS:PrePlayerDraw(pl)
 render.SetColorModulation(1, 0.1, 0.4)
	render.ModelMaterialOverride(matSkin)
end

function CLASS:PostPlayerDraw(pl)
 render.SetColorModulation(1, 0.2, 0.1)
	render.ModelMaterialOverride()
end