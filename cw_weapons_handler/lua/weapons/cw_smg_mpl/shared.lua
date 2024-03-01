AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Walther MPL"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.5
	
	SWEP.IconLetter = "x"
	killicon.AddFont("cw_mp5", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 2, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.8
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.87

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/cw2/weapons/w_smg_mpl.mdl"
	SWEP.WMPos = Vector(-0.7, -4, -2)
	SWEP.WMAng = Vector(-5, 1, 180)
	
	SWEP.IronsightPos = Vector(-1.989, -2.26, 0.465)

	SWEP.IronsightAng = Vector(0.4, 0, 0)

	SWEP.MicroT1Pos = Vector(-1.994, -2.745, -0.396)
	SWEP.MicroT1Ang = Vector(0, 0, 0)	
		
	SWEP.EoTechPos = Vector(-2.001, -3.812, -0.842)

	SWEP.EoTechAng = Vector(2.469, 0, 0)
	
	SWEP.AimpointPos = Vector(-2, -3.812, -0.343)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.CoD4ReflexPos = Vector(-1.991, -3.812, -0.144)

	SWEP.CoD4ReflexAng = Vector(0, 0, 0)

	SWEP.CSGOACOGPos = Vector(-1.989, -3.812, -0.369)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(3.625, 0, -1.974)
	SWEP.SprintAng = Vector(-15.032, 30.462, -18.241)

	SWEP.CustomizePos = Vector(5.335, -0.542, 0)

	SWEP.CustomizeAng = Vector(6.223, 30.996, 0)
	
	SWEP.AlternativePos = Vector(0, 1.325, -0.801)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(2.028, -5.613, -1.124), [2] = Vector(0, 0, 0)}}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	SWEP.CSGOACOGAxisAlign = {right = 0, up = 0, forward = -40}

	SWEP.AttachmentModelsVM = {
		["md_rail"] = {model = "models/wystan/attachments/rail.mdl", bone = "MAIN", rel = "", pos = Vector(0.135, 3.749, 1.2), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_cod4_reflex"] = {model = "models/v_cod4_reflex.mdl", bone = "MAIN", rel = "", pos = Vector(-0.109, 6.643, 1.05), angle = Angle(0, -90, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "MAIN", rel = "", pos = Vector(-0.12, 3.963, 3.193), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "MAIN", rel = "", pos = Vector(-0.362, 15.355, -7.693), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "MAIN", rel = "", pos = Vector(0.107, 8.696, -1.512), angle = Angle(0, 180, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_csgo_acog"] = {model = "models/kali/weapons/csgo/eq_optic_acog.mdl", bone = "MAIN", rel = "", pos = Vector(-0.144, 9.46, -0.146), angle = Angle(0, 90, 0), size = Vector(0.699, 0.699, 0.699)},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "MAIN", rel = "", pos = Vector(-0.165, -10.573, 0.172), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8)}
	}

	SWEP.ForegripOverridePos = {
		["bg_mp5_sdbarrel"] = {
			["Bip01 R Finger02"] = {pos = Vector(0, 0, 0), angle = Angle(-4.029, 14.069, 0) },
			["Bip01 R Finger0"] = {pos = Vector(0, 0, 0), angle = Angle(0, -8.988, 0) }
		},
		
		["bg_mp5_kbarrel"] = {
			["Bip01 R Hand"] = {pos = Vector(0, 0, 0), angle = Angle(0.263, 23.951, -31.754) },
			["Bip01 R Finger2"] = {pos = Vector(0, 0, 0), angle = Angle(-0.894, 32.728, 3.026) },
			["Bip01 R Finger21"] = {pos = Vector(0, 0, 0), angle = Angle(0, 12.1, 0) },
			["Bip01 R Finger01"] = {pos = Vector(0, 0, 0), angle = Angle(0, 25.451, 0) },
			["Bip01 R Clavicle"] = {pos = Vector(-6.856, 2.325, 2.252), angle = Angle(48.464, 28.256, 12.512) },
			["Bip01 R Finger4"] = {pos = Vector(0, 0, 0), angle = Angle(0, 0, 14.687) },
			["Bip01 R Finger1"] = {pos = Vector(0, 0, 0), angle = Angle(-1.813, 71.625, 0) },
			["Bip01 R Finger41"] = {pos = Vector(0, 0, 0), angle = Angle(0, -26.932, 0) },
			["Bip01 R Finger31"] = {pos = Vector(0, 0, 0), angle = Angle(0, -16.4, 0) },
			["Bip01 R Finger02"] = {pos = Vector(0, 0, 0), angle = Angle(0, 89.527, 0) },
			["Bip01 R Finger3"] = {pos = Vector(0, 0, 0), angle = Angle(0, 18.952, 11.305) },
			["Bip01 R Finger0"] = {pos = Vector(0, 0, 0), angle = Angle(-15.782, -6.495, 33.964) },
			["Bip01 R Finger32"] = {pos = Vector(0, 0, 0), angle = Angle(0, 54.675, -4.284) },
			["Bip01 R Finger42"] = {pos = Vector(0, 0, 0), angle = Angle(0, 67.799, 0) }
		}
	}
	
	SWEP.AttachmentPosDependency = {["md_tundra9mm"] = {["bg_mp5_kbarrel"] = Vector(-0.038, -10.749, 0.324)}}

	SWEP.LaserPosAdjust = {x = 1, y = 0, z = 0}
	SWEP.LaserAngAdjust = {p = 2, y = 180, r = 0}
	SWEP.SightWithRail = true
	SWEP.CustomizationMenuScale = 0.015
end

SWEP.SightBGs = {main = 1, none = 1}
SWEP.StockBGs = {main = 2, regular = 0, mpl_stock = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {700, -400}, atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_csgo_acog"}},
[2] = {header = "Barrel", offset = {200, -400}, atts = {"md_tundra9mm"}},
[3] = {header = "Stock", offset = {700, 350}, atts = {"bg_mpl_stock"}},
["+attack2"] = {header = "Perks", offset = {-600, -400}, atts = {"pk_sleightofhand", "pk_light"}},
["+reload"] = {header = "Ammo", offset = {700, 0}, atts = {"am_magnum", "am_matchgrade"}}}

	if CustomizableWeaponry_KK_HK416 then
		table.insert(SWEP.Attachments[1].atts, 2, "md_cod4_reflex")		
end

SWEP.Animations = {fire = {"fire1", "fire2"},
	reload = "reload",
	reload_empty = "reload_empty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload = {[1] = {time = 0.6, sound = "CW_MPL_MAGOUT"},
	[2] = {time = 1.25, sound = "CW_MPL_MAGIN"}},
	
	reload_empty = {[1] = {time = 0.6, sound = "CW_MPL_MAGOUT"},
	[2] = {time = 1.25, sound = "CW_MPL_MAGIN"},
	[3] = {time = 1.9, sound = "CW_MPL_BOLT"}}}

SWEP.SpeedDec = 15

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 Rinic's Pack"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/weapons/v_smg_mpl.mdl"
SWEP.WorldModel		= "models/cw2/weapons/w_smg_mpl.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 32
SWEP.Primary.DefaultClip	= 128
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 0.064
SWEP.FireSound = "CW_MPL_FIRE"
SWEP.FireSoundSuppressed = "CW_MPL_FIRE_SUPPRESSED"
SWEP.Recoil = 0.55

SWEP.HipSpread = 0.085
SWEP.AimSpread = 0.008
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.005
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 30
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 1.35
SWEP.ReloadTime = 1.67
SWEP.ReloadTime_Empty = 2.4
SWEP.ReloadHalt = 1.87
SWEP.ReloadHalt_Empty = 2.6