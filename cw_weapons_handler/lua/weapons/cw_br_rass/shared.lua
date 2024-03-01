AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "RSASS"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	killicon.AddFont("cw_g3a3", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_g3"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.5
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6
	SWEP.AimBreathingEnabled = true

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/cw2/weapons/w_snip_rsass.mdl"
	SWEP.WMPos = Vector(-0.5, -0.5, 0)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.IronsightPos = Vector(3.032, -6.809, 0.805)

	SWEP.IronsightAng = Vector(-0.65, 0, 0)
	
	SWEP.EoTechPos = Vector(3.029, -5.006, 0.69)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(3.026, -6.02, 1.024)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(3.022, -5.006, 0.898)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.CoD4ReflexPos = Vector(3.029, -5.006, 0.989)

	SWEP.CoD4ReflexAng = Vector(0, 0, 0)

	SWEP.BackupReflexPos = Vector(1.789, -5.873, 1.401)
	SWEP.BackupReflexAng = Vector(0, 0, -37.486)

	SWEP.LeupoldPos = Vector(3.048, -4.907, 0.773)
	SWEP.LeupoldAng = Vector(0, 0, 0)
	
	SWEP.RscopePos = Vector(3.033, -4.178, 1.003)
	SWEP.RscopeAng = Vector(0, 0, 0)

	SWEP.CSGOACOGPos = Vector(3.01, -5.007, 0.888)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)

	SWEP.CSGOSSGPos = Vector(3.006, -4.25, 0.83)
	SWEP.CSGOSSGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(-2.161, -2.393, 0.73)
	SWEP.SprintAng = Vector(-21.132, -33.882, 16.92)

	SWEP.PronePos = Vector(-0.668, -10.417, -4.231)
	SWEP.ProneAng = Vector(3.262, -70, 29.052)

	SWEP.CustomizePos = Vector(-5.283, -4.66, 0)
	SWEP.CustomizeAng = Vector(8.619, -42.065, -1.333)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-1.606, -1.107, -1.5), [2] = Vector(0, 0, 0)}}

	SWEP.SightWithRail = false
	SWEP.CSGOACOGAxisAlign = {right = 0, up = 0, forward = -40}
	SWEP.LeupoldAxisAlign = {right = 1, up = 0, forward = 0}
	SWEP.CSGOSSGAxisAlign = {right = 0, up = 0, forward = 145}
	SWEP.BFRIFLEAxisAlign = {right = 0.010, up = -0.050, forward = 0}

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
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "Base", rel = "", pos = Vector(-0.035, 5.789, -2.533), angle = Angle(0, 180, 0), size = Vector(0.699, 0.699, 0.699)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "Base", rel = "", pos = Vector(-0.482, 12.645, -9.334), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Base", rel = "", pos = Vector(-0.232, 1.491, 1.562), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_cod4_reflex"] = {model = "models/v_cod4_reflex.mdl", bone = "Base", rel = "", pos = Vector(-0.216, 4.451, -0.862), angle = Angle(0, -90, 0), size = Vector(0.699, 0.699, 0.699)},
		["md_fas2_leupold"] = {model = "models/v_fas2_leupold.mdl", bone = "Base", rel = "", pos = Vector(-0.181, 2.236, 2.426), angle = Angle(0, 90, 0), size = Vector(1.5, 1.5, 1.5)},
		["md_fas2_leupold_mount"] = {model = "models/v_fas2_leupold_mounts.mdl", bone = "Base", rel = "", pos = Vector(-0.181, 2.236, 2.426), angle = Angle(0, 90, 0), size = Vector(1.5, 1.5, 1.5)},
		["md_lasersight"] = {model = "models/rageattachments/anpeqbf.mdl", bone = "Base", rel = "", pos = Vector(-1.165, -8.374, 1.575), angle = Angle(0, 90, 90), size = Vector(0.8, 0.8, 0.8)},
		["md_csgo_scope_ssg"] = {model = "models/kali/weapons/csgo/eq_optic_scope_ssg08.mdl", bone = "Base", rel = "", pos = Vector(-0.273, -0.066, 1.248), angle = Angle(0, 90, 0), size = Vector(0.699, 0.699, 0.699)},
		["md_backup_reflex"] = {model = "models/c_docter.mdl", bone = "Base", rel = "", pos = Vector(-0.973, -5.786, 1.167), angle = Angle(0, 90, -36.904), size = Vector(0.8, 0.8, 0.8)},
		["md_bfriflescope"] = {model = "models/rageattachments/sniperscopesv.mdl", bone = "Base", rel = "", pos = Vector(-0.179, 1.363, 1.134), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "G3SG1", pos = Vector(-3.34, 7.82, -5.904), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_hk416_bipod"] = {model = "models/c_bipod.mdl", bone = "Base", rel = "", pos = Vector(-0.171, -10.414, -1.247), angle = Angle(0, 180, 0), size = Vector(1, 1, 1)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "Base", rel = "", pos = Vector(-0.21, -1.535, -2.195), angle = Angle(0, 180, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_csgo_acog"] = {model = "models/kali/weapons/csgo/eq_optic_acog.mdl", bone = "Base", rel = "", pos = Vector(-0.264, 6.565, -1.752), angle = Angle(0, 90, 0), size = Vector(0.699, 0.699, 0.699)},
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

	SWEP.LaserPosAdjust = Vector(0.5, 5, 2)
	SWEP.LaserAngAdjust = Angle(-0.1, 0.1, 0)

end

SWEP.SightBGs = {main = 1, none = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {1200, -700},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_csgo_acog", "md_bfriflescope", "md_csgo_scope_ssg"}},
	[2] = {header = "Barrel", offset = {-250, -700},  atts = {"md_saker"}},
	[3] = {header = "Handguard", offset = {-250, 200}, atts = {}},
	[4] = {header = "Back-up Sight", offset = {-250, -250}, atts = {}},
	[5] = {header = "Laser", offset = {800, -250}, atts = {"md_lasersight"}},
	["+attack2"] = {header = "Perks", offset = {400, -700}, atts = {"pk_sleightofhand", "pk_light"}},
	["+reload"] = {header = "Ammo", offset = {800, 200}, atts = {"am_magnum", "am_matchgrade"}}}

	if CustomizableWeaponry_KK_HK416 then
		table.insert(SWEP.Attachments[1].atts, 2, "md_cod4_reflex")
		table.insert(SWEP.Attachments[1].atts, 6, "md_fas2_leupold")
		table.insert(SWEP.Attachments[3].atts, 1, "md_hk416_bipod")
		table.insert(SWEP.Attachments[4].atts, 1, "md_backup_reflex")		
end

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	reload_empty = "reload_empty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {[1] = {time = 0, sound = "CW_FOLEY_MEDIUM"},
	[2] = {time = 0.4, sound = "CW_RSASS_BOLT"}},

	reload = {[1] = {time = 0.45, sound = "CW_RSASS_MAGOUT"},
	[2] = {time = 1.6, sound = "CW_RSASS_MAGIN"}},
	
	reload_empty = {[1] = {time = 0.45, sound = "CW_RSASS_MAGOUT"},
	[2] = {time = 1.6, sound = "CW_RSASS_MAGIN"},
	[3] = {time = 2.3, sound = "CW_RSASS_BOLT"}}}

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
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/cw2/weapons/v_snip_rsass.mdl"
SWEP.WorldModel		= "models/cw2/weapons/w_snip_rsass.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 80
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x51MM"

SWEP.FireDelay = 0.05
SWEP.FireSound = "CW_RSASS_FIRE"
SWEP.FireSoundSuppressed = "CW_RSASS_FIRE_SUPPRESSED"
SWEP.Recoil = 0.7

SWEP.HipSpread = 0.300
SWEP.AimSpread = 0.002
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.50
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.17
SWEP.Shots = 1
SWEP.Damage = 70
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.8
SWEP.ReloadTime_Empty = 2.4
SWEP.ReloadHalt = 2
SWEP.ReloadHalt_Empty = 2.6

function SWEP:IndividualThink()
		self.Animations.draw = "draw_norm"
			if self.Animations.draw == "draw_norm" then
		self.DeployTime = 0.3
	end
end