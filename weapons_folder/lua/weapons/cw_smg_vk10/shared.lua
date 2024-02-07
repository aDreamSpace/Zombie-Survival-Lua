AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Vector K10"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "x"
	killicon.AddFont("cw_mp5", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.8
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.87

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/cw2/weapons/w_vectorsmg.mdl"
	SWEP.WMPos = Vector(-0.5, -0.5, -1)
	SWEP.WMAng = Vector(-15, 0, 180)
	
	SWEP.IronsightPos = Vector(2.519, -2.402, 1.172)
	SWEP.IronsightAng = Vector(0, -0.005, 0)

	SWEP.MicroT1Pos = Vector(2.523, -3.708, 0.964)
	SWEP.MicroT1Ang = Vector(0, 0, 0)	

	SWEP.CoD4ReflexPos = Vector(2.538, -4.884, 1.077)
	SWEP.CoD4ReflexAng = Vector(0, 0, 0)
		
	SWEP.EoTechPos = Vector(2.512, -6.641, 0.666)

	SWEP.EoTechAng = Vector(2.694, -0.058, 0)
	
	SWEP.AimpointPos = Vector(2.516, -6.099, 1.059)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.CSGOACOGPos = Vector(2.5, -5.375, 0.962)

	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(-4.444, -1, 0.082)
	SWEP.SprintAng = Vector(-12.849, -39.23, 0)

	SWEP.PronePos = Vector(-0.668, -10.417, -4.231)
	SWEP.ProneAng = Vector(3.262, -70, 29.052)

	SWEP.CustomizePos = Vector(-8.174, -1.27, -1.288)
	SWEP.CustomizeAng = Vector(17.954, -40.578, -18.357)
	
	SWEP.AlternativePos = Vector(0, 1.325, -0.801)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(2.028, -5.613, -1.124), [2] = Vector(0, 0, 0)}}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	SWEP.CSGOACOGAxisAlign = {right = 0, up = 0, forward = -40}

	SWEP.AttachmentModelsVM = {
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "SMDImport01", rel = "", pos = Vector(0.067, -3.406, -1.53), angle = Angle(0, 180, 180), size = Vector(0.449, 0.449, 0.449)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "SMDImport01", rel = "", pos = Vector(0.331, 7.195, 9.42), angle = Angle(0, 90, 180), size = Vector(1, 1, 1)},
		["md_cod4_reflex"] = {model = "models/v_cod4_reflex.mdl", bone = "SMDImport01", rel = "", pos = Vector(0.05, 0.707, 1.48), angle = Angle(180, 90, 0), size = Vector(0.85, 0.85, 0.85)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "SMDImport01", rel = "", pos = Vector(-0.171, 2.381, 3.796), angle = Angle(180, 180, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_csgo_acog"] = {model = "models/kali/weapons/csgo/eq_optic_acog.mdl", bone = "SMDImport01", rel = "", pos = Vector(0.112, 2.959, 2.279), angle = Angle(0, 90, 180), size = Vector(0.8, 0.8, 0.8)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "SMDImport01", rel = "", pos = Vector(0.052, -0.518, 2.217), angle = Angle(0, 0, 180), size = Vector(0.6, 0.6, 0.6)}
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
	SWEP.SightWithRail = false
	SWEP.CustomizationMenuScale = 0.012
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {700, -400}, atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_csgo_acog"}},
[2] = {header = "Barrel", offset = {200, -400}, atts = {"md_saker"}},
[3] = {header = "Magazine Upgrade", offset = {-400, -250}, atts = {"a_zsmagsmg1", "a_zsmagsmg2", "a_zsmagsmg3"}},
 [4] = {header = "Perks", offset = {-300, 100}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
["+reload"] = {header = "Ammo", offset = {700, 0}, atts = {"am_magnum2", "am_matchgrade2", "am_duplex2", "am_ricochet2", "am_tracers2", "am_luckylast2", "am_rifdepleteduranium2"}}}



SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},
	
	reload = {[1] = {time = 0.4, sound = "CW_VECTOR_K10_MAGOUT"},
	[2] = {time = 1.57, sound = "CW_VECTOR_K10_MAGIN"},
	[3] = {time = 2.18, sound = "CW_VECTOR_K10_BOLTBACK"},
	[4] = {time = 2.35, sound = "CW_VECTOR_K10_BOLTFORWARD"}}}

SWEP.SpeedDec = 15

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "2burst", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 Rinic's Pack"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/cw2/weapons/v_vectorsmg.mdl"
SWEP.WorldModel		= "models/cw2/weapons/w_vectorsmg.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 36
SWEP.Primary.DefaultClip	= 144
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SMG1"

SWEP.FireDelay = 0.064034151547492
SWEP.FireSound = "CW_VECTOR_K10_FIRE"
SWEP.FireSoundSuppressed = "CW_VECTOR_K10_FIRE_SUPPRESSED"
SWEP.Recoil = 0.29

SWEP.HipSpread = 0.095
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = 0.09
SWEP.SpreadPerShot = 0.009
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 86
SWEP.DeployTime = 0.45

SWEP.ReloadSpeed = 1.2
SWEP.ReloadTime = 2
SWEP.ReloadTime_Empty = 2.5
SWEP.ReloadHalt = 2.2
SWEP.ReloadHalt_Empty = 2.7
SWEP.SnapToIdlePostReload = true