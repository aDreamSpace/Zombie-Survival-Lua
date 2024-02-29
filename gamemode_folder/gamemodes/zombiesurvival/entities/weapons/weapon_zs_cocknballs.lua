
-----------------------------------------------------
AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "The Giant Golden Cock n' Balls"

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

	SWEP.VElements = {
		["base1"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.2, 1, -10), angle = Angle(180, 45, 0), size = Vector(5, 5, 5), color = Color(255, 215, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["base2"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.2, 1, -10), angle = Angle(180, 135, 0), size = Vector(5, 5, 5), color = Color(255, 215, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["base3"] = { type = "Model", model = "models/props_c17/lampshade001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.2, 1, -60), angle = Angle(0, 0, 180), size = Vector(2, 2, 2), color = Color(255, 215, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["base1"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.599, 1, -30), angle = Angle(180, 90, 0), size = Vector(3, 3, 3), color = Color(255, 215, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["base2"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.599, 1, -30), angle = Angle(180, 180, 0), size = Vector(3, 3, 3), color = Color(255, 215, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["base3"] = { type = "Model", model = "models/Combine_Helicopter/helicopter_bomb01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 5*2.599, 25), angle = Angle(180, 135, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 215, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["base4"] = { type = "Model", model = "models/Combine_Helicopter/helicopter_bomb01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5*2.599, 5, 25), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 215, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["base5"] = { type = "Model", model = "models/props_c17/lampshade001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.599, 1, -70), angle = Angle(0, 0, 180), size = Vector(1.5, 1.5, 1.5), color = Color(255, 215, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.DamageType = DMG_CLUB

SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/props_canal/mattpipe.mdl"
SWEP.UseHands = false

SWEP.MeleeDamage = 1000
SWEP.MeleeRange = 110
SWEP.MeleeSize = 0.875
SWEP.Primary.Delay = 0.5


SWEP.WalkSpeed = SPEED_FASTEST

SWEP.UseMelee1 = true

SWEP.HitGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
SWEP.MissGesture = SWEP.HitGesture
SWEP.SwingHoldType = "grenade"

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(55, 65))
end

function SWEP:PlayHitSound()
	self:EmitSound("physics/metal/metal_canister_impact_hard"..math.random(3)..".wav", 75, math.random(115, 125))
end