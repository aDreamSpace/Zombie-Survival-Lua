AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Carver"

	SWEP.ViewModelFOV = 65
	SWEP.ViewModelFlip = false

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/ps2models/ps2_nc_melee_carver.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.746, 1.358, 0.354), angle = Angle(172.839, 170.203, 1.891), size = Vector(0.972, 0.972, 0.972), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/ps2models/ps2_nc_melee_carver.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.18, 0.736, -0.343), angle = Angle(180, 178.845, 13.121), size = Vector(1.149, 1.149, 1.149), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.DamageType = DMG_SLASH

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/ps2models/ps2_nc_melee_carver.mdl"
SWEP.UseHands = true
SWEP.NoDroppedWorldModel = true
--[[SWEP.BoxPhysicsMax = Vector(8, 1, 4)
SWEP.BoxPhysicsMin = Vector(-8, -1, -4)]]

SWEP.MeleeDamage = 190
SWEP.MeleeRange = 68
SWEP.MeleeSize = 0.875
SWEP.Primary.Delay = 0.5

SWEP.WalkSpeed = SPEED_FAST

SWEP.UseMelee1 = true

SWEP.HitGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
SWEP.MissGesture = SWEP.HitGesture

SWEP.HitDecal = "Manhackcut"
SWEP.HitAnim = ACT_VM_MISSCENTER

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/knife/knife_slash"..math.random(2)..".wav", 72, math.Rand(85, 95))
end

function SWEP:PlayHitSound()
	self:EmitSound("weapons/knife/knife_hitwall1.wav", 72, math.Rand(55, 65))
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/flesh/flesh_squishy_impact_hard"..math.random(4)..".wav")
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav")
end

function SWEP:PostOnMeleeHit(hitent, hitflesh, tr)
	if hitent:IsValid() and hitent:IsPlayer() and hitent:Health() <= 0 then
		-- Dismember closest limb to tr.HitPos
	end
end
