AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "L115A3 (Ghosts)"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	killicon.AddFont("cw_g3a3", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_sr25"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.55
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6
	SWEP.ShellDelay = 0.75
	SWEP.AimBreathingEnabled = true

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/cw2/weapons/w_ghosts_l115a3.mdl"
	SWEP.WMPos = Vector(-0.5, 0, 1.1)
	SWEP.WMAng = Vector(-9, 0, 180)
	
	SWEP.IronsightPos = Vector(-2.817, -5.213, 0.507)
	SWEP.IronsightAng = Vector(-2.227, -0.094, 0)

	SWEP.EoTechPos = Vector(-2.803, -4.398, 0.323)
	SWEP.EoTechAng = Vector(0, 0.035, 0)

	SWEP.LeupoldPos = Vector(-2.794, -4.398, 0.634)
	SWEP.LeupoldAng = Vector(0, 0, 0)
	
	SWEP.CoD4TascoPos = Vector(-2.816, -4.398, 0.907)
	SWEP.CoD4TascoAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-2.82, -2.422, 0.578)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.L115A3Pos = Vector(-2.797, -3.615, 0.639)

	SWEP.L115A3Ang = Vector(0, 0, 0)

	
	SWEP.CSGOACOGPos = Vector(-2.809, -4.398, 0.546)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)

	SWEP.CSGOSSGPos = Vector(-2.79, -3.576, 0.574)
	SWEP.CSGOSSGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(2.407, 0, 0)

	SWEP.SprintAng = Vector(-19.341, 35.276, -16.581)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-1.606, -1.107, -1.5), [2] = Vector(0, 0, 0)}}

	SWEP.SightWithRail = false
	SWEP.CSGOACOGAxisAlign = {right = -0.1, up = -0.1, forward = -40}
	SWEP.LeupoldAxisAlign = {right = 1, up = 0, forward = 0}
	SWEP.CSGOSSGAxisAlign = {right = 0, up = 0, forward = 145}
	SWEP.L115A3AxisAlign = {right = 0, up = 0, forward = 180}

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

	SWEP.ReticleInactivityPostFire = 1.5
	
	SWEP.M203HoldPos = {
		["Bip01 L Clavicle"] = {pos = Vector(4.461, 0.308, -2.166), angle = Angle(0, 0, 0)}
	}

	SWEP.AttachmentModelsVM = {
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "Base", rel = "", pos = Vector(0.223, -13.181, -10.198), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_fas2_leupold"] = {model = "models/v_fas2_leupold.mdl", bone = "Base", rel = "", pos = Vector(-0.04, -2.83, 1.355), angle = Angle(0, -90, 0), size = Vector(1.2, 1.2, 1.2)},
		["md_fas2_leupold_mount"] = {model = "models/v_fas2_leupold_mounts.mdl", bone = "Base", rel = "", pos = Vector(-0.04, -2.83, 1.355), angle = Angle(0, -90, 0), size = Vector(1.2, 1.2, 1.2)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Base", rel = "", pos = Vector(-0.042, -1.892, 0.669), angle = Angle(0, 180, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "G3SG1", pos = Vector(-3.34, 7.82, -5.904), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_lasersight"] = {model = "models/rageattachments/anpeqbf.mdl", bone = "Base", rel = "", pos = Vector(0.828, 10.399, -1.642), angle = Angle(0, -90, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_csgo_scope_ssg"] = {model = "models/kali/weapons/csgo/eq_optic_scope_ssg08.mdl", bone = "Base", rel = "", pos = Vector(0.007, -1.356, 0.375), angle = Angle(0, -90, 0), size = Vector(0.649, 0.649, 0.649)},
		["md_l115a3_scope"] = {model = "models/atts/aw_scope.mdl", bone = "Base", rel = "", pos = Vector(2.763, -10.728, 1.963), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_csgo_silencer_rifle"] = {model = "models/kali/weapons/csgo/eq_suppressor_rifle.mdl", bone = "Base", rel = "", pos = Vector(-0.029, 22.74, -0.886), angle = Angle(0, -90, 0), size = Vector(0.85, 0.85, 0.85)},
		["md_hk416_bipod"] = {model = "models/c_bipod.mdl", bone = "Base", rel = "", pos = Vector(0.046, 7.01, -2.201), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)},
		["md_pgm_bipod"] = {model = "models/attachments/pgm_hecate_bipod.mdl", bone = "gun-main", rel = "", pos = Vector(13.217, 0.291, -0.339), angle = Angle(0, 0, -90), size = Vector(0.4, 0.4, 0.4)},
		["md_csgo_acog"] = {model = "models/kali/weapons/csgo/eq_optic_acog.mdl", bone = "Base", rel = "", pos = Vector(-0.007, -7.244, -2.623), angle = Angle(0, -90, 0), size = Vector(0.699, 0.699, 0.699)},
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
	
	SWEP.LaserPosAdjust = Vector(1, 15, 0)
	SWEP.LaserAngAdjust = Angle(0, 0.5, 0)

end

SWEP.SightBGs = {main = 1, none = 1}
SWEP.LuaViewmodelRecoil = false

SWEP.Attachments = {[1] = {header = "Sight", offset = {600, -300},  atts = {"md_microt1", "md_eotech", "md_csgo_acog", "md_csgo_scope_ssg", "md_l115a3_scope"}},
	[2] = {header = "Barrel", offset = {-500, -400},  atts = {"md_csgo_silencer_rifle"}},
	[3] = {header = "Magazine Upgrade", offset = {-200, 250}, atts = {"a_zsmagssniper1", "a_zsmagssniper2", "a_zsmagssniper3"}},
  [4] = {header = "Perks", offset = {500, 600}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
	["+reload"] = {header = "Ammo", offset = {600, 200}, atts = {"am_magnum2", "am_matchgrade2", "am_heavyhandload2", "am_grapeshot2", "am_rifdepleteduranium2", "am_ricochet2"}}}

if CustomizableWeaponry_KK_HK416 then
	
		table.insert(SWEP.Attachments[1].atts, 5, "md_fas2_leupold")
	
end

SWEP.Animations = {fire = {"fire"},
	reload = "reload",
	reload_empty = "reload_empty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	fire = {[1] = {time = 0.55, sound = "CW_GHOSTS_L115A3_BOLTBACK"},
	[2] = {time = 0.75, sound = "CW_GHOSTS_L115A3_BOLTFORWARD"}},

	reload = {[1] = {time = 0.35, sound = "CW_GHOSTS_L115A3_BOLTTAP"},
	[2] = {time = 0.78, sound = "CW_GHOSTS_L115A3_MAGOUT"},
	[3] = {time = 1.48, sound = "CW_GHOSTS_L115A3_MAGTAP"},
	[4] = {time = 1.97, sound = "CW_GHOSTS_L115A3_MAGIN"}},

	reload_empty = {[1] = {time = 0.35, sound = "CW_GHOSTS_L115A3_BOLTTAP"},
	[2] = {time = 0.78, sound = "CW_GHOSTS_L115A3_MAGOUT"},
	[3] = {time = 1.48, sound = "CW_GHOSTS_L115A3_MAGTAP"},
	[4] = {time = 1.97, sound = "CW_GHOSTS_L115A3_MAGIN"},
	[5] = {time = 2.42, sound = "CW_FOLEY_light"},
	[6] = {time = 2.97, sound = "CW_GHOSTS_L115A3_BOLTBACK"},
	[7] = {time = 3.17, sound = "CW_GHOSTS_L115A3_BOLTFORWARD"}}}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 Rinic's Pack"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/weapons/v_ghosts_l115a3.mdl"
SWEP.WorldModel		= "models/cw2/weapons/w_ghosts_l115a3.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ADSFireAnim = true
SWEP.BipodFireAnim = true
SWEP.ForceBackToHipAfterAimedShot = false

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "357"

SWEP.FireDelay = 1.5
SWEP.FireSound = "CW_GHOSTS_L115A3_FIRE"
SWEP.FireSoundSuppressed = "CW_GHOSTS_L115A3_FIRE_SUPPRESSED"
SWEP.Recoil = 0.8

SWEP.HipSpread = 0.015
SWEP.AimSpread = 0.0000001
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.35
SWEP.SpreadCooldown = 0.17
SWEP.Shots = 1
SWEP.Damage = 366
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1.1
SWEP.ReloadTime = 2.4
SWEP.ReloadTime_Empty = 3.1
SWEP.ReloadHalt = 2.6
SWEP.ReloadHalt_Empty = 3.3