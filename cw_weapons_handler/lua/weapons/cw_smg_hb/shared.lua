AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "AAC Honey Badger (Ghosts)"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "w"
	killicon.AddFont("cw_ar15", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.5
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.83

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/cw2/weapons/w_ghosts_hb.mdl"
	SWEP.WMPos = Vector(-0.5, 0, 0.2)
	SWEP.WMAng = Vector(-2, 0, 180)
	
	SWEP.M203OffsetCycle_Reload = 0.65
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0
	
	SWEP.IronsightPos = Vector(-2.06, -2.816, 0.231)
	SWEP.IronsightAng = Vector(0.388, 0.046, 0)
	
	SWEP.FoldSightPos = Vector(-2.208, -4.3, 0.143)
	SWEP.FoldSightAng = Vector(0.605, 0, -0.217)
		
	SWEP.EoTechPos = Vector(-2.053, -2.665, 0.005)
	SWEP.EoTechAng = Vector(2.023, 0, 0)
	
	SWEP.AimpointPos = Vector(-2.06, -2.448, 0.416)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-2.07, -2.987, 0.359)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.CoD4ReflexPos = Vector(-2.072, -3.106, 0.521)
	SWEP.CoD4ReflexAng = Vector(0, 0, 0)

	SWEP.CSGOACOGPos = Vector(-2.046, -3.086, 0.256)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.317, 0, 0.175)
	SWEP.SprintAng = Vector(-21.021, 23.322, -14.811)

	SWEP.CustomizePos = Vector(3.108, 0, 0)
	SWEP.CustomizeAng = Vector(5.627, 27.722, -2.139)

	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.211, -4, -0.95), [2] = Vector(-2, 0, 0)}}

	SWEP.CSGOACOGAxisAlign = {right = 0, up = 0, forward = -40}
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "Honey_Body", rel = "", pos = Vector(-0.239, 4.833, 42.411), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "Honey_Body", rel = "", pos = Vector(0.231, -1.435, 36.186), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "Honey_Body", rel = "", pos = Vector(-0.511, 4.046, 43.07), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_csgo_acog"] = {model = "models/kali/weapons/csgo/eq_optic_acog.mdl", bone = "Honey_Body", rel = "", pos = Vector(0.013, 4.236, 43.292), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_lasersight"] = {model = "models/rageattachments/anpeqbf.mdl", bone = "Honey_Body", rel = "", pos = Vector(0.916, 16.319, 47.108), angle = Angle(0, -90, 90), size = Vector(0.8, 0.8, 0.8)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "smdimport001", pos = Vector(-0.042, 4.362, 0.1), angle = Angle(0, 0, 2), size = Vector(0.75, 0.75, 0.75)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Honey_Body", rel = "", pos = Vector(-0.033, 10.19, 47.099), angle = Angle(0, 180, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "smdimport001", pos = Vector(-0.401, -3.291, -2.22), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "smdimport001", pos = Vector(-0.225, 9.715, 3.15), angle = Angle(0, 90, 0), size = Vector(0.699, 0.699, 0.699)},
		["md_m203"] = {model = "models/cw2/attachments/m203.mdl", bone = "smdimport001", pos = Vector(2.299, -6.611, 4.138), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), animated = true}
	}
	
	SWEP.M203HoldPos = {
		["Bip01 L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-2.76, 2.651, 1.386), angle = Angle(0, 0, 0) }
	}

	SWEP.ForeGripHoldPos = {
		["Bip01 L Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-4.496, 32.819, 21.371) },
	
		["Bip01 L Finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(5.951, 16.391, 0) },
	
		["Bip01 L UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0.658, 0, 54.549) },
	
		["Bip01 L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(1.016, -0.069, 1.554), angle = Angle(24.44, 25.722, 3.828) },
	
		["Bip01 L Finger22"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-1.782, 18.034, 0) },
	
		["Bip01 L Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 24.252, 0) },
	
		["Bip01 L Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 78.248, 0) },
	
		["Bip01 L Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-33.106, 29.884, 0) },
	
		["Bip01 L Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-15.197, 12.375, 27.636) },
	
		["Bip01 L Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(12.298, 89.277, 13.534) },
	
		["Bip01 L Finger42"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(12.843, 61.909, 0.16) },
	
		["Bip01 L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(28.641, -17.772, 8.703) },
	
		["Bip01 L Finger32"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 42.575, 0) },
	
		["Bip01 L Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-9.664, 39.549, 13.243) },
	
		["Bip01 L Finger12"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-0.361, 36.347, 0) },
	
		["Bip01 L Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(5.136, 18.177, -1.221) },
	
		["Bip01 L Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 26.033, 0) },
	
		["Bip01 L Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(3.948, 64, 34.053) }
	}
	
	SWEP.AttachmentPosDependency = {["md_anpeq15"] = {["bg_longris"] = Vector(-0.225, 13, 3.15)},
	["md_saker"] = {["bg_longbarrel"] = Vector(-0.042, 9, -0.1), ["bg_longris"] = Vector(-0.042, 9, -0.1)}}
	
	SWEP.LaserPosAdjust = Vector(0, 5, 1.5)
	SWEP.LaserAngAdjust = Angle(0, 0, 0) 
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -500}, atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_csgo_acog"}},
	[2] = {header = "Handguard", offset = {-400, 0}, atts = {"md_foregrip"}},
	[3] = {header = "Magazine Upgrade", offset = {-200, -350}, atts = {"a_zsmagsmg1", "a_zsmagsmg2", "a_zsmagsmg3"}},
 [4] = {header = "Perks", offset = {200, 400}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
	["+reload"] = {header = "Ammo", offset = {800, 0}, atts = {"am_magnum2", "am_matchgrade2", "am_hqb2", "am_duplex2", "am_highcaliberrounds2", "am_luckylast2"}}}
	


SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	reload_empty = "reload_empty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload = {[1] = {time = 0.25, sound = "CW_GHOSTS_HB_MAGOUT"},
	[2] = {time = 1.65, sound = "CW_GHOSTS_HB_MAGIN"}},

	reload_empty = {[1] = {time = 0.25, sound = "CW_GHOSTS_HB_MAGOUT"},
	[2] = {time = 1.65, sound = "CW_GHOSTS_HB_MAGIN"},
	[3] = {time = 2.5, sound = "CW_GHOSTS_HB_BOLT"}}}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "3burst", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 Rinic's Pack"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/weapons/v_ghosts_hb.mdl"
SWEP.WorldModel		= "models/cw2/weapons/w_ghosts_hb.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 150
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SMG1"

SWEP.FireDelay = 0.075
SWEP.FireSound = "CW_GHOSTS_HB_FIRE"
SWEP.FireSoundSuppressed = "CW_GHOSTS_HB_FIRE_SUPPRESSED"
SWEP.Recoil = 0.5

SWEP.HipSpread = 0.095
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 60
SWEP.DeployTime = 0.5

SWEP.ReloadSpeed = 1.45
SWEP.ReloadTime = 2.1
SWEP.ReloadTime_Empty = 2.8
SWEP.ReloadHalt = 2.3
SWEP.ReloadHalt_Empty = 3
SWEP.SnapToIdlePostReload = false

SWEP.SuppressedOnEquip = true