AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "G3A3"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	killicon.AddFont("cw_g3a3", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_g3"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6
	
	SWEP.IronsightPos = Vector(-1.612, -1.107, 0.388)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-1.622, -2, -0.505)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-1.622, -1, -0.406)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-1.607, 1.5, -0.173)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ACOGPos = Vector(-1.606, -0.6, -0.487)
	SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.NXSPos = Vector(-1.624, 1, -0.382)
	SWEP.NXSAng = Vector(0, 0, 0)

	SWEP.SG1Pos = Vector(-1.614, 0, -0.51)
	SWEP.SG1Ang = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
	
	SWEP.ShortDotPos = Vector(-1.601, -1.157, -0.299)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-1.606, -1.107, -1.5), [2] = Vector(0, 0, 0)}}

	SWEP.SightWithRail = true
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.NXSAlign = {right = 0, up = 0, forward = 0}

	SWEP.M203Pos = Vector(0, -1, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(0.319, 1.325, -1.04)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.M203OffsetCycle_Reload = 0.81
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0
	
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.M203HoldPos = {
		["Bip01 L Clavicle"] = {pos = Vector(4.461, 0.308, -2.166), angle = Angle(0, 0, 0)}
	}

	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "G3SG1_Rail", pos = Vector(-0.24, -5.63, -4.604), angle = Angle(0, 0, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "G3SG1_Rail", pos = Vector(0.266, -11.3, -10.278), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "G3SG1_Rail", pos = Vector(0.02, -0.65, 0.593), angle = Angle(0, 180, 0), size = Vector(0.349, 0.349, 0.349)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "G3SG1", pos = Vector(-3.34, 7.82, -5.904), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "G3SG1", pos = Vector(-2.921, 15.373, -4.996), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "G3SG1_Rail", pos = Vector(-0.324, -5.626, -4.821), angle = Angle(0, 0, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_m203"] = {model = "models/cw2/attachments/m203.mdl", bone = "G3SG1", pos = Vector(-0.583, 3.305, -1.293), angle = Angle(2.538, -90, 0), size = Vector(1, 1, 1), animated = true},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "G3SG1", pos = Vector(-3.01, 10.85, -1.385), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "G3SG1_Rail", pos = Vector(-0.278, -5.081, -4.053), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_nightforce_nxs"] = {model = "models/cw2/attachments/l96_scope.mdl", bone = "G3SG1", pos = Vector(-3.027, 9.477, -0.247), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)}
	}

	SWEP.ForeGripHoldPos = {
		["Bip01 L Finger3"] = {pos = Vector(0, 0, 0), angle = Angle(-8.907, 29.332, 27.155) },
		["Bip01 L Finger41"] = {pos = Vector(0, 0, 0), angle = Angle(0, 3.367, 0) },
		["Bip01 L Clavicle"] = {pos = Vector(4.335, -6.652, -3.984), angle = Angle(-42.875, 42.837, 0) },
		["Bip01 L Finger22"] = {pos = Vector(0, 0, 0), angle = Angle(0, -13.565, 0) },
		["Bip01 L Finger31"] = {pos = Vector(0, 0, 0), angle = Angle(0, 9.633, 0) },
		["Bip01 L Finger02"] = {pos = Vector(0, 0, 0), angle = Angle(0, 96.544, 0) },
		["Bip01 L Finger11"] = {pos = Vector(0, 0, 0), angle = Angle(0, 25.826, 0) },
		["Bip01 L Finger4"] = {pos = Vector(0, 0, 0), angle = Angle(-3.777, 13.736, 42.478) },
		["Bip01 L Finger1"] = {pos = Vector(0, 0, 0), angle = Angle(-4.395, 78.736, 22.27) },
		["Bip01 L Finger42"] = {pos = Vector(0, 0, 0), angle = Angle(0, 58.242, 0) },
		["Bip01 L Hand"] = {pos = Vector(0, 0, 0), angle = Angle(5.883, 57.971, -2.382) },
		["Bip01 L Finger32"] = {pos = Vector(0, 0, 0), angle = Angle(0, 18.07, 0) },
		["Bip01 L Finger0"] = {pos = Vector(0, 0, 0), angle = Angle(33.303, 1.07, 0) },
		["Bip01 L Finger12"] = {pos = Vector(0, 0, 0), angle = Angle(0, 28.163, 0) },
		["Bip01 L Finger21"] = {pos = Vector(0, 0, 0), angle = Angle(0, 25.208, 0) },
		["Bip01 L Finger01"] = {pos = Vector(0, 0, 0), angle = Angle(0, 19.94, 0) },
		["Bip01 L Finger2"] = {pos = Vector(0, 0, 0), angle = Angle(-5.336, 58.977, 28.6) }
	}
	
	SWEP.LaserPosAdjust = Vector(1, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
end

SWEP.MuzzleVelocity = 800 -- in meter/s

SWEP.RailBGs = {main = 3, on = 1, off = 0}
SWEP.BipodBGs = {main = 4, on = 1, off = 0}
SWEP.SightBGs = {main = 2, sg1 = 1, none = 0}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -350},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_schmidt_shortdot", "md_acog", "bg_sg1scope", "md_nightforce_nxs"}},
	[2] = {header = "Barrel", offset = {-300, -300},  atts = {"md_saker"}},
	[3] = {header = "Handguard", offset = {-300, 150}, atts = {"md_foregrip", "md_m203", "bg_bipod"}},
	[4] = {header = "Rail", offset = {800, -20}, atts = {"md_anpeq15"}, dependencies = {md_microt1 = true}},
	[5] = {header = "Magazine Upgrade", offset = {200, 350}, atts = {"a_zsmagar1", "a_zsmagar2", "a_zsmagar3"}},
    [6] = {header = "Perks", offset = {300, -50}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
	["+reload"] = {header = "Ammo", offset = {800, 430}, atts = {"am_highcaliberrounds2", "am_hqb2", "am_magnum2", "am_matchgrade2", "am_luckylast2", "am_duplex2", "am_depleteduranium2"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload_full",
	reload_empty = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload_full = {[1] = {time = 0.6, sound = "CW_G3A3_HANDLE"},
	[2] = {time = 0.9, sound = "CW_G3A3_MAGOUT"},
	[3] = {time = 2.3, sound = "CW_G3A3_MAGIN"}},
	
	reload = {[1] = {time = 0.6, sound = "CW_G3A3_BOLTBACK"},
	[2] = {time = 1.55, sound = "CW_G3A3_HANDLE"},
	[3] = {time = 1.7, sound = "CW_G3A3_MAGOUT"},
	[4] = {time = 3.1, sound = "CW_G3A3_MAGIN"},
	[5] = {time = 3.85, sound = "CW_G3A3_BOLTFORWARD"}}}

SWEP.SpeedDec = 40

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/rifles/g3a3.mdl"
SWEP.WorldModel		= "models/weapons/w_snip_g3sg1.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "AR2"

SWEP.FireDelay = 0.14
SWEP.FireSound = "CW_G3A3_FIRE"
SWEP.FireSoundSuppressed = "CW_G3A3_FIRE_SUPPRESSED"
SWEP.Recoil = 1.5

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.002
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.17
SWEP.Shots = 1
SWEP.Damage = 92
SWEP.DeployTime = 0.8
SWEP.NearWallDistance = 40

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.5
SWEP.ReloadTime_Empty = 3.3
SWEP.ReloadHalt = 3.05
SWEP.ReloadHalt_Empty = 4.85