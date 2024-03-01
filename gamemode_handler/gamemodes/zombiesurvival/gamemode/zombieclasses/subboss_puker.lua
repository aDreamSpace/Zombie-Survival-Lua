CLASS.Name = "Puker"
CLASS.TranslationName = "class_puker"
CLASS.Description = "description_puker"
CLASS.Help = "controls_puker"

CLASS.Wave = 0
CLASS.Threshold = 0

CLASS.Disabled = true 


CLASS.FearPerInstance = 1

CLASS.Health = 1100
CLASS.SWEP = "weapon_zs_puker"

CLASS.Model = Model("models/player/zombie_classic.mdl")
CLASS.ModelScale = 1.25
CLASS.Speed = 89
CLASS.Points = 10

CLASS.PainSounds = {"NPC_PoisonZombie.Pain"}
CLASS.DeathSounds = {Sound("npc/zombie_poison/pz_call1.wav")}

CLASS.VoicePitch = 0.5


CLASS.Mass = 200
--CLASS.ViewOffset = Vector(0, 0, 75)
--CLASS.ViewOffsetDucked = Vector(0, 0, 48)
--CLASS.StepSize = 25
--[[CLASS.Hull = {Vector(-22, -22, 0), Vector(22, 22, 96)}
CLASS.HullDuck = {Vector(-22, -22, 0), Vector(22, 22, 58)}]]

CLASS.JumpPower = 225

local math_ceil = math.ceil

function CLASS:KnockedDown(pl, status, exists)
	pl:AnimResetGestureSlot(GESTURE_SLOT_ATTACK_AND_RELOAD)
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
		pl:EmitSound(ScuffSounds[mathrandom(#ScuffSounds)], 70)
	else
		pl:EmitSound(StepSounds[mathrandom(#StepSounds)], 70)
	end

	return true
end


function CLASS:PlayDeathSound(pl)
	pl:EmitSound("zsounds/death/death0"..mathrandom(1, 6)..".wav", 70, mathrandom(80, 120))

	return true
end

-- Sound scripts are LITERALLY 100x slower than raw file input. Test it yourself if you don't believe me.
--[[function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)
	if iFoot == 0 then
		if mathrandom() < 0.15 then
			pl:EmitSound("Zombie.ScuffLeft")
		else
			pl:EmitSound("Zombie.FootstepLeft")
		end
	else
		if mathrandom() < 0.15 then
			pl:EmitSound("Zombie.ScuffRight")
		else
			pl:EmitSound("Zombie.FootstepRight")
		end
	end

	return true
end]]

function CLASS:PlayerStepSoundTime(pl, iType, bWalking)
	if iType == STEPSOUNDTIME_NORMAL or iType == STEPSOUNDTIME_WATER_FOOT then
		return 625 - pl:GetVelocity():Length()
	elseif iType == STEPSOUNDTIME_ON_LADDER then
		return 600
	elseif iType == STEPSOUNDTIME_WATER_KNEE then
		return 750
	end

	return 450
end

function CLASS:CalcMainActivity(pl, velocity)
	local revive = pl.Revive
	if revive and revive:IsValid() then
		return ACT_HL2MP_ZOMBIE_SLUMP_RISE, -1
	end

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

	local wep = pl:GetActiveWeapon()
	if wep:IsValid() and wep.IsMoaning and wep:IsMoaning() then
		return ACT_HL2MP_RUN_ZOMBIE, -1
	end

	if velocity:Length2DSqr() <= 1 then
		if pl:Crouching() and pl:OnGround() then
			return ACT_HL2MP_IDLE_CROUCH_ZOMBIE, -1
		end

		return ACT_HL2MP_IDLE_ZOMBIE, -1
	end

	if pl:Crouching() and pl:OnGround() then
		return ACT_HL2MP_WALK_CROUCH_ZOMBIE_01 - 1 + math_ceil((CurTime() / 4 + pl:EntIndex()) % 3), -1
	end

	return ACT_HL2MP_WALK_ZOMBIE_01 - 1 + math_ceil((CurTime() / 3 + pl:EntIndex()) % 3), -1
end

function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)
	local revive = pl.Revive
	if revive and revive:IsValid() then
		pl:SetCycle(0.4 + (1 - math.Clamp((revive:GetReviveTime() - CurTime()) / revive.AnimTime, 0, 1)) * 0.6)
		pl:SetPlaybackRate(0)
		return true
	end

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
		local wep = pl:GetActiveWeapon()
		if wep:IsValid() and wep.IsMoaning and wep:IsMoaning() then
			pl:SetPlaybackRate(math.min(len2d / maxseqgroundspeed, 3))
		else
			pl:SetPlaybackRate(math.min(len2d / maxseqgroundspeed * 0.666, 3))
		end
	else
		pl:SetPlaybackRate(1)
	end

	return true
end

function CLASS:DoesntGiveFear(pl)
	return pl.FeignDeath and pl.FeignDeath:IsValid()
end

if SERVER then
	function CLASS:AltUse(pl)
		pl:StartFeignDeath()
	end

	function CLASS:ProcessDamage(pl, dmginfo)
		local attacker, inflictor, damage = dmginfo:GetAttacker(), dmginfo:GetInflictor(), dmginfo:GetDamage()
		if attacker ~= pl and damage >= pl:Health() and pl:LastHitGroup() ~= HITGROUP_HEAD and damage < 70 and not inflictor.IsMelee and not inflictor.NoReviveFromKills and dmginfo:GetDamageType() ~= DMG_BLAST and dmginfo:GetDamageType() ~= DMG_BURN and dmginfo:GetDamageType() ~= DMG_CRUSH and (pl.NextZombieRevive or 0) <= CurTime() and pl:LastHitGroup() ~= HITGROUP_LEFTLEG and pl:LastHitGroup() ~= HITGROUP_RIGHTLEG and (pl.m_MarkedBySkeletor == nil or pl.m_MarkedForSkeletor <= CurTime()) then
			pl.NextZombieRevive = CurTime() + 3

			dmginfo:SetDamage(0)
			pl:SetHealth(10)

			return true
		end
	end

	function CLASS:ReviveCallback(pl, attacker, dmginfo)
		if not pl.Revive and not dmginfo:GetInflictor().IsMelee and not dmginfo:GetInflictor().NoReviveFromKills and dmginfo:GetDamageType() ~= DMG_BLAST and dmginfo:GetDamageType() ~= DMG_BURN and (pl:LastHitGroup() == HITGROUP_LEFTLEG or pl:LastHitGroup() == HITGROUP_RIGHTLEG) then
			local classtable = math.random(1) == 3 and GAMEMODE.ZombieClasses["Zombie Legs"] or GAMEMODE.ZombieClasses["Zombie Torso"]
			if classtable then
				pl:RemoveStatus("overridemodel", false, true)
				local deathclass = pl.DeathClass or pl:GetZombieClass()
				pl:SetZombieClass(classtable.Index)
				pl:DoHulls(classtable.Index, TEAM_UNDEAD)
				pl.DeathClass = deathclass

				pl:EmitSound("physics/flesh/flesh_bloody_break.wav", 100, 75)

				if classtable == GAMEMODE.ZombieClasses["Zombie Torso"] then
					local ent = ents.Create("prop_dynamic_override")
					if ent:IsValid() then
						ent:SetModel(Model("models/Zombie/Classic_legs.mdl"))
						ent:SetPos(pl:GetPos())
						ent:SetAngles(pl:GetAngles())
						ent:Spawn()
						ent:Fire("kill", "", 1.5)
					end
				end

				pl:Gib()
				pl.Gibbed = nil

				timer.Simple(0, function()
					if pl:IsValid() then
						pl:SecondWind()
					end
				end)

				return true
			end
		end

		return false
	end

	function CLASS:OnSecondWind(pl)
		pl:EmitSound("npc/zombie/zombie_voice_idle"..math.random(1, 14)..".wav", 100, 85)
	end
end

if CLIENT then
	CLASS.Icon = "materials/zombiesurvival/killicons2/poisonzombie.png"
	CLASS.IconColor = COLOR_PINK
local render_SetMaterial = render.SetMaterial
local render_DrawSprite = render.DrawSprite
local angle_zero = angle_zero
local LocalToWorld = LocalToWorld
local matSkin = Material("models/zombie_fast/fast_zombie_sheet")
local colGlow = Color(242, 161, 0)
local matGlow = Material("sprites/glow04_noz")
local vecEyeLeft = Vector(4, -4.6, -1)
local vecEyeRight = Vector(4, -4.6, 1)

function CLASS:PrePlayerDraw(pl)
	render.SetColorModulation(0.204, 0.204, 0.204)
	render.ModelMaterialOverride(matSkin)
end

function CLASS:PostPlayerDraw(pl)
	render.SetColorModulation(0.204, 0.204, 0.204)
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
end 