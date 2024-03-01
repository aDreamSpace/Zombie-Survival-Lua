AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "HK SL8"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	killicon.AddFont("cw_g3a3", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_sr25"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/cw2/weapons/w_rif_hksl8.mdl"
	SWEP.WMPos = Vector(-0.5, 0, -0.1)
	SWEP.WMAng = Vector(-5, 0, 180)
	
	SWEP.IronsightPos = Vector(-2.777, -4.186, 0.072)
	SWEP.IronsightAng = Vector(-1.032, 0, 0)
	
	SWEP.EoTechPos = Vector(-1.622, -2, -0.505)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-1.622, -1, -0.406)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-1.607, -3.024, -0.173)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ACOGPos = Vector(-1.606, -0.6, -0.487)
	SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.HKSL8Pos = Vector(-2.767, -4.119, 0.248)
	SWEP.HKSL8Ang = Vector(0, 0, 0)

	SWEP.CSGOSSGPos = Vector(-2.781, -4.344, -0.068)

	SWEP.CSGOSSGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(0.875, 0, -0.055)

	SWEP.SprintAng = Vector(-23.042, 25.528, -17.055)

	SWEP.CustomizePos = Vector(4.829, 0, -0.072)
	SWEP.CustomizeAng = Vector(6.357, 34.33, 0)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-1.606, -1.107, -1.5), [2] = Vector(0, 0, 0)}}

	SWEP.SightWithRail = false
	SWEP.HKSL8AxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.CSGOSSGAxisAlign = {right = 0, up = 0, forward = 145}

	SWEP.M203Pos = Vector(0, -1, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(0.319, 1.325, -1.04)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.M203OffsetCycle_Reload = 0.81
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0
	
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}
	
	SWEP.BoltBone = "bolt"
	SWEP.BoltShootOffset = Vector(0, -1.5, 0)
	SWEP.OffsetBoltOnBipodShoot = true
	SWEP.AimBreathingEnabled = true
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.M203HoldPos = {
		["Bip01 L Clavicle"] = {pos = Vector(4.461, 0.308, -2.166), angle = Angle(0, 0, 0)}
	}
	
	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "G3SG1_Rail", pos = Vector(-0.24, -5.63, -4.604), angle = Angle(0, 0, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "G3SG1_Rail", pos = Vector(0.266, -11.3, -10.278), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "G3SG1_Rail", pos = Vector(0.02, 0, 0.593), angle = Angle(0, 180, 0), size = Vector(0.349, 0.349, 0.349)},
		["md_sl8_scope"] = {model = "models/atts/sl8_scope.mdl", bone = "gun", rel = "", pos = Vector(1.776, 4.559, -11.145), angle = Angle(56, 90, -180), size = Vector(1, 1, 1)},
		["md_csgo_scope_ssg"] = {model = "models/kali/weapons/csgo/eq_optic_scope_ssg08.mdl", bone = "gun", rel = "", pos = Vector(0.029, -5.989, 0.629), angle = Angle(55, 90, -180), size = Vector(0.6, 0.6, 0.6)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "G3SG1", pos = Vector(-3.34, 7.82, -5.904), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_hk416_bipod"] = {model = "models/c_bipod.mdl", bone = "gun", rel = "", pos = Vector(0.027, -8.355, 9.687), angle = Angle(180, 180, 55), size = Vector(1.2, 1.2, 1.2)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "gun", rel = "", pos = Vector(0.027, -8.469, 4.136), angle = Angle(0, 180, -55), size = Vector(0.6, 0.6, 0.6)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "G3SG1_Rail", pos = Vector(-0.324, -5.626, -4.821), angle = Angle(0, 0, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_m203"] = {model = "models/cw2/attachments/m203.mdl", bone = "G3SG1", pos = Vector(-0.583, 3.305, -1.293), angle = Angle(2.538, -90, 0), size = Vector(1, 1, 1), animated = true}
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
	
	SWEP.AttachmentPosDependency = {["md_anpeq15"] = {["bg_longris"] = Vector(-0.225, 13, 3.15)},
	["md_saker"] = {["bg_longbarrel"] = Vector(-0.042, 9, -0.1), ["bg_longris"] = Vector(-0.042, 9, -0.1)}}

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {600, -700},  atts = {"md_sl8_scope", "md_csgo_scope_ssg"}},
	[2] = {header = "Barrel", offset = {-250, -300},  atts = {"md_saker"}},
	[3] = {header = "Handguard", offset = {-250, 150}, atts = {}},
	["+attack2"] = {header = "Perks", offset = {600, 100}, atts = {"pk_sleightofhand", "pk_light"}},
	["+reload"] = {header = "Ammo", offset = {600, -300}, atts = {"am_magnum", "am_matchgrade"}}}

if CustomizableWeaponry_KK_HK416 then
		table.insert(SWEP.Attachments[3].atts, 1, "md_hk416_bipod")		
end

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	reload_empty = "reload_empty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload = {[1] = {time = 0.47, sound = "CW_HK_SL8_MAGOUT"},
	[2] = {time = 1.28, sound = "CW_HK_SL8_MAGIN"},
	[3] = {time = 1.78, sound = "CW_HK_SL8_TAP"}},
	
	reload_empty = {[1] = {time = 0.47, sound = "CW_HK_SL8_MAGOUT"},
	[2] = {time = 1.28, sound = "CW_HK_SL8_MAGIN"},
	[3] = {time = 1.78, sound = "CW_HK_SL8_TAP"},
	[4] = {time = 2.52, sound = "CW_HK_SL8_BOLTBACK"},
	[5] = {time = 2.71, sound = "CW_HK_SL8_BOLTFORWARD"}}}

SWEP.SpeedDec = 40

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 Rinic's Pack"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/weapons/v_rif_hksl8.mdl"
SWEP.WorldModel		= "models/cw2/weapons/w_rif_hksl8.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.FireDelay = 0.1714285714285714
SWEP.FireSound = "CW_HK_SL8_FIRE"
SWEP.FireSoundSuppressed = "CW_HK_SL8_FIRE_SUPPRESSED"
SWEP.Recoil = 0.8

SWEP.HipSpread = 0.250
SWEP.AimSpread = 0.001
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.25
SWEP.SpreadPerShot = 0.05
SWEP.SpreadCooldown = 0.17
SWEP.Shots = 1
SWEP.Damage = 95
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2
SWEP.ReloadTime_Empty = 2.7
SWEP.ReloadHalt = 2.2
SWEP.ReloadHalt_Empty = 2.9