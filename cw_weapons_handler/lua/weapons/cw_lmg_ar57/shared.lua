AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "AR 57"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "x"
	killicon.AddFont("cw_mp5", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.5
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.8
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.87

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/cw2/weapons/w_pdw_ar57.mdl"
	SWEP.WMPos = Vector(-0.6, 0, -0.5)
	SWEP.WMAng = Vector(-8.5, -2, 180)
	
	SWEP.IronsightPos = Vector(-1.838, -1.362, -0.35)
	SWEP.IronsightAng = Vector(0.813, 0, 0)

	SWEP.MicroT1Pos = Vector(-1.846, 0, -0.242)
	SWEP.MicroT1Ang = Vector(0, 0, 0)	
		
	SWEP.EoTechPos = Vector(-1.861, -2.001, -0.528)
	SWEP.EoTechAng = Vector(1.103, 0, 0)
	
	SWEP.CoD4TascoPos = Vector(-1.866, -1.27, 0.193)
	SWEP.CoD4TascoAng = Vector(0, 0, 0)
	
	SWEP.CoD4ReflexPos = Vector(-1.851, -1.604, -0.134)

	SWEP.CoD4ReflexAng = Vector(0, 0, 0)
	
	SWEP.CSGOACOGPos = Vector(-1.851, -1.374, -0.227)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.888, 0, 0.31)
	SWEP.SprintAng = Vector(-21.56, 23.951, -8.037)

	SWEP.CustomizePos = Vector(4.085, 0, 0)
	SWEP.CustomizeAng = Vector(11.576, 25.934, 7.383)
	
	SWEP.AlternativePos = Vector(0, 1.325, -0.801)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(2.028, -5.613, -1.124), [2] = Vector(0, 0, 0)}}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	SWEP.CSGOACOGAxisAlign = {right = 0, up = 0, forward = -40}

	SWEP.AttachmentModelsVM = {
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "AR57_Body", rel = "", pos = Vector(-0.015, -0.857, 1.516), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "AR57_Body", rel = "", pos = Vector(-0.26, 10.027, -9.388), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_csgo_acog"] = {model = "models/kali/weapons/csgo/eq_optic_acog.mdl", bone = "AR57_Body", rel = "", pos = Vector(-0.038, 4.368, -1.816), angle = Angle(0, 90, 0), size = Vector(0.699, 0.699, 0.699)},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "AR57_Body", rel = "", pos = Vector(-0.028, -15.098, -0.81), angle = Angle(0, 0, 0), size = Vector(0.699, 0.699, 0.699)}
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
	SWEP.CustomizationMenuScale = 0.012
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = false

SWEP.Attachments = {[1] = {header = "Sight", offset = {700, -400}, atts = {"md_microt1", "md_eotech", "md_csgo_acog"}},
[2] = {header = "Barrel", offset = {200, -400}, atts = {"md_tundra9mm"}},
[3] = {header = "Bullet Belts", offset = {-200, 0}, atts = {"a_zsmagslmg1", "a_zsmagslmg2", "a_zsmagslmg3"}},
[4] = {header = "Perks", offset = {400, 300}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap"}},
["+reload"] = {header = "Ammo", offset = {700, 0}, atts = {"am_magnum2", "am_matchgrade2", "am_duplex2", "am_ricochet2", "am_tracers2", "am_luckylast2", "am_rifdepleteduranium2"}}}



SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	reload_empty = "reload_empty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload = {[1] = {time = 0.5, sound = "CW_RINIC_AR57_MAGOUT"},
	[2] = {time = 1.67, sound = "CW_RINIC_AR57_MAGOUT"},
	[3] = {time = 1.98, sound = "CW_RINIC_AR57_MAGIN"}},
	
	reload_empty = {[1] = {time = 0.5, sound = "CW_RINIC_AR57_MAGOUT"},
	[2] = {time = 1.67, sound = "CW_RINIC_AR57_MAGOUT"},
	[3] = {time = 1.98, sound = "CW_RINIC_AR57_MAGIN"},
	[4] = {time = 2.6, sound = "CW_RINIC_AR57_BOLTBACK"},
	[5] = {time = 2.7, sound = "CW_RINIC_AR57_BOLTFORWARD"}}}

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

SWEP.ViewModelFOV	= 65
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/weapons/v_pdw_ar57.mdl"
SWEP.WorldModel		= "models/cw2/weapons/w_pdw_ar57.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 75
SWEP.Primary.DefaultClip	= 200
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Alyxgun"

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_RINIC_AR57_FIRE"
SWEP.FireSoundSuppressed = "CW_RINIC_AR57_FIRE_SUPPRESSED"
SWEP.Recoil = 0.25

SWEP.HipSpread = 0.095
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = 0.055
SWEP.SpreadPerShot = 0.017
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 27
SWEP.DeployTime = 0.8

SWEP.ReloadSpeed = 0.95
SWEP.ReloadTime = 2.3
SWEP.ReloadTime_Empty = 2.7
SWEP.ReloadHalt = 2.5
SWEP.ReloadHalt_Empty = 2.9

function SWEP:IndividualThink()
	if self.FireMode == "2burst" then
		self.FireDelay = 0.0638297872340426
	else 
		self.FireDelay = 0.08
	end
end