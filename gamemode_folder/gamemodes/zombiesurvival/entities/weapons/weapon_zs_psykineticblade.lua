AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Psykinetic Blade"

	SWEP.ViewModelFOV = 65
	SWEP.ViewModelFlip = false

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/ps2models/ps2_melee_ancient_psykinetic_blade.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.413, 1.442, 1.213), angle = Angle(180, 119.68, 7.219), size = Vector(2.322, 2.322, 2.322), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/ps2models/ps2_melee_ancient_psykinetic_blade.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, 0), angle = Angle(-104.412, 0, 0), size = Vector(2.815, 2.815, 2.815), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}	
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.DamageType = DMG_SHOCK 

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/ps2models/ps2_melee_ancient_psykinetic_blade.mdl"
SWEP.UseHands = true
SWEP.NoDroppedWorldModel = true
--[[SWEP.BoxPhysicsMax = Vector(8, 1, 4)
SWEP.BoxPhysicsMin = Vector(-8, -1, -4)]]
SWEP.HoldType = "knife"
SWEP.MeleeDamage = 500
SWEP.MeleeRange = 63
SWEP.MeleeSize = 0.875
SWEP.Primary.Delay = 0.25

SWEP.WalkSpeed = SPEED_FAST

SWEP.UseMelee1 = true

SWEP.HitGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
SWEP.MissGesture = SWEP.HitGesture

SWEP.HitDecal = "Manhackcut"
SWEP.HitAnim = ACT_VM_MISSCENTER

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/knife/knife_slash"..math.random(2)..".wav", 72, math.Rand(125, 135))
end

function SWEP:PlayHitSound()
	self:EmitSound("weapons/knife/knife_hitwall1.wav", 72, math.Rand(125, 165))
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
