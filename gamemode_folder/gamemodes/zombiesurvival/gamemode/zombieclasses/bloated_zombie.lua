CLASS.Name = "Bloated Zombie"
CLASS.TranslationName = "class_bloated_zombie"
CLASS.Description = "description_bloated_zombie"
CLASS.Help = "controls_bloated_zombie"

CLASS.Wave = 2 / 5

CLASS.Health = 650
CLASS.Speed = 140
--CLASS.JumpPower = 225
--CLASS.Mass = DEFAULT_MASS * 2

CLASS.CanTaunt = true

CLASS.Points = 5

--[[
CLASS.ZTraits = {
	["25hlth"] = {safename = "+25% Health", cost = 150},
	["bloatbomb"] = {safename = "Bile Bomb", cost = 100, desc = "Increase amount of poison particles on death"},
	["acidic"] = {safename = "Acidic Poison", cost = 150, desc = "Increase damage of poison particles"},
}
]]

CLASS.SWEP = "weapon_zs_bloatedzombie"

CLASS.Model = Model("models/player/fatty/fatty.mdl")



CLASS.VoicePitch = 0.6

CLASS.CanFeignDeath = true

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
	pl:EmitSound("npc/zombie_poison/pz_idle"..math.random(2, 3)..".wav", 72, math.Rand(75, 85))

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
CLASS.Icon = "materials/zombiesurvival/killicons2/bloatedzombie.png"
end

local render_SetMaterial = render.SetMaterial
local render_DrawSprite = render.DrawSprite
local angle_zero = angle_zero
local LocalToWorld = LocalToWorld
local matSkin = Material("models/zombie_fast/fast_zombie_sheet")
local colGlow = Color(0, 235, 176)
local matGlow = Material("sprites/glow04_noz")
local vecEyeLeft = Vector(4, -4.6, -1)
local vecEyeRight = Vector(4, -4.6, 1)

function CLASS:PrePlayerDraw(pl)
	render.SetColorModulation(0.322, 0.016, 0.016)
	render.ModelMaterialOverride(matSkin)
end

function CLASS:PostPlayerDraw(pl)
	render.SetColorModulation(0.247, 0.012, 0.012)
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