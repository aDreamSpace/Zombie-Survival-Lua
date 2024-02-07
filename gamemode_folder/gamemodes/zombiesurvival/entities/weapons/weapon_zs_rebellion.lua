AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Rebellion"

	SWEP.ViewModelFOV = 55
	SWEP.ViewModelFlip = false

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/tiggomods/weapons/dmc5/rebellion.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.239, 1.523, -3.264), angle = Angle(180, 180, -2.521), size = Vector(0.625, 0.625, 0.625), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/tiggomods/weapons/dmc5/rebellion.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.184, 0.776, -1.254), angle = Angle(-180, -179.411, -7.864), size = Vector(0.81, 0.81, 0.81), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/tiggomods/weapons/dmc5/rebellion.mdl"
SWEP.UseHands = true

SWEP.HoldType = "melee2"

SWEP.MeleeDamage = 621
SWEP.MeleeRange = 60
SWEP.MeleeSize = 1.5
SWEP.MeleeKnockBack = 32

SWEP.WalkSpeed = SPEED_FAST

SWEP.SwingTime = 0.85
SWEP.SwingRotation = Angle(0, -20, -40)
SWEP.SwingOffset = Vector(10, 0, 0)
SWEP.SwingHoldType = "melee"

SWEP.HitDecal = "Manhackcut"

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(60, 65))
end

function SWEP:PlayHitSound()
	self:EmitSound("weapons/melee/golf club/golf_hit-0"..math.random(4)..".ogg", 75, math.random(69, 80))
end
function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav")
end
