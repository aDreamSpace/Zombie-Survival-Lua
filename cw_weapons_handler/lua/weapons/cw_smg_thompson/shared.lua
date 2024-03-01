AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Rinic Custom's 'Thompson'"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "x"
	killicon.AddFont("cw_mp5", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -1, y = -2, z = -1}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.8
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.87

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/cw2/weapons/w_tac_thompson.mdl"
	SWEP.WMPos = Vector(-0.9, 1 -2)
	SWEP.WMAng = Vector(-10, 2, 180)

	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector (0, 3, 0)
	SWEP.OffsetBoltOnBipodShoot = true
	
	SWEP.IronsightPos = Vector(-3.457, -3.768, 1.386)

	SWEP.IronsightAng = Vector(0.181, 0.052, 0)

	SWEP.MicroT1Pos = Vector(-3.48, -4.29, 0.837)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.CoD4ReflexPos = Vector(-3.474, -4.29, 0.964)
	SWEP.CoD4ReflexAng = Vector(0, 0, 0)
		
	SWEP.EoTechPos = Vector(-3.474, -4.243, 0.448)
	SWEP.EoTechAng = Vector(3.042, 0, 0)
	
	SWEP.AimpointPos = Vector(-3.477, -4.617, 0.781)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.CSGOACOGPos = Vector(-3.456, -4.256, 0.745)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(4.716, 0, 1.896)
	SWEP.SprintAng = Vector(-25.713, 31.646, -10.363)

	SWEP.CustomizePos = Vector(4.873, -4.584, 0)
	SWEP.CustomizeAng = Vector(11.836, 33.539, 4.823)
	
	SWEP.AlternativePos = Vector(0, 1.325, -0.801)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(2.028, -5.613, -1.124), [2] = Vector(0, 0, 0)}}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 3, pitch = 1}
	SWEP.CSGOACOGAxisAlign = {right = 0, up = 0, forward = -40}

	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "wpn_body", rel = "", pos = Vector(-0.265, -8.438, -2.824), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "wpn_body", rel = "", pos = Vector(0.261, -13.396, -7.903), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_csgo_silencer_rifle"] = {model = "models/kali/weapons/csgo/eq_suppressor_rifle.mdl", bone = "wpn_body", rel = "", pos = Vector(0, 17.287, 1.042), angle = Angle(0, -90, 0), size = Vector(0.85, 0.85, 0.85)},
		["md_cod4_reflex"] = {model = "models/v_cod4_reflex.mdl", bone = "wpn_body", rel = "", pos = Vector(-0.005, -6.016, -0), angle = Angle(0, 90, 0), size = Vector(0.85, 0.85, 0.85)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "wpn_body", rel = "", pos = Vector(0, -2.606, 3.033), angle = Angle(0, 180, 0), size = Vector(0.449, 0.449, 0.449)},
		["md_csgo_acog"] = {model = "models/kali/weapons/csgo/eq_optic_acog.mdl", bone = "wpn_body", rel = "", pos = Vector(0.05, -8.629, -0.976), angle = Angle(0, -90, 0), size = Vector(0.85, 0.85, 0.85)},
		["md_lasersight"] = {model = "models/rageattachments/anpeqbf.mdl", bone = "wpn_body", rel = "", pos = Vector(0.949, 12.258, 2.611), angle = Angle(0, -90, 90), size = Vector(0.8, 0.8, 0.8)}
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

	SWEP.LaserPosAdjust = {x = 1, y = 15, z = 3.5}
	SWEP.LaserAngAdjust = {p = 0, y = 0, r = 0}
	SWEP.CustomizationMenuScale = 0.015
end

SWEP.SightBGs = {main = 1, none = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {900, -400}, atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_csgo_acog"}},
[2] = {header = "Barrel", offset = {200, -400}, atts = {"md_csgo_silencer_rifle"}}, 
[3] = {header = "Magazine Upgrade", offset = {-200, -50}, atts = {"a_zsmagsmg1", "a_zsmagsmg2", "a_zsmagsmg3"}},
 [4] = {header = "Perks", offset = {100, 400}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
["+reload"] = {header = "Ammo", offset = {700, 0}, atts = {"am_magnum2", "am_matchgrade2", "am_duplex2", "am_ricochet2", "am_tracers2", "am_luckylast2", "am_rifdepleteduranium2"}}}


SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload = {[1] = {time = 0.4, sound = "CW_TACTICAL_THOMPSON_MAGOUT"},
	[2] = {time = 1.62, sound = "CW_TACTICAL_THOMPSON_MAGIN"},
	[3] = {time = 2.32, sound = "CW_TACTICAL_THOMPSON_BOLT"}}}

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
SWEP.ViewModel		= "models/cw2/weapons/v_tac_thompson.mdl"
SWEP.WorldModel		= "models/cw2/weapons/w_tac_thompson.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 35
SWEP.Primary.DefaultClip	= 140
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SMG1"

SWEP.FireDelay = 0.09
SWEP.FireSound = "CW_TACTICAL_THOMPSON_FIRE"
SWEP.FireSoundSuppressed = "CW_TACTICAL_THOMPSON_FIRE_SUPPRESSED"
SWEP.Recoil = 0.5

SWEP.HipSpread = 0.055
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.005
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage =  215
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 1.19
SWEP.ReloadTime = 2.1
SWEP.ReloadTime_Empty = 2.5
SWEP.ReloadHalt = 2.3
SWEP.ReloadHalt_Empty = 2.7
SWEP.SnapToIdlePostReload = true