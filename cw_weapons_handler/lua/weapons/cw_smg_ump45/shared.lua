if CustomizableWeaponry then

SWEP.magType = "smgMag"

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "HK UMP .45 (New)"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "w"
	killicon.AddFont("cw_ar15", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9
	
	SWEP.M203OffsetCycle_Reload = 0.65
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0
	
	SWEP.CustomizePos = Vector(-10.5, -5.8, 0.4)
	SWEP.CustomizeAng = Vector(27, -50, -30)
	
	SWEP.IronsightPos = Vector(2.27, 0, 0.839)
	SWEP.IronsightAng = Vector(0.49, 0, 0)
	
	SWEP.FrontRearPos = Vector(-3.221, -1.181, 0.14)
	SWEP.FrontRearAng = Vector(-0.5, -0.2, 0)
	
	SWEP.EoTechPos = Vector(2.26, -2.914, 0.122)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(2.27, -2.914, 0.261)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.ReflexPos = Vector(2.27, -2.914, 0.574)
	SWEP.ReflexAng = Vector(0, 0, 0)
	
	SWEP.SpecterPos = Vector(2.279, -2.8, 0.2)
	SWEP.SpecterAng = Vector(0, 0, 0)
	
	SWEP.BallisticPos = Vector(-3.19, -4, -0.06)
	SWEP.BallisticAng = Vector(0, 0, 0)
	
	SWEP.CmorePos = Vector(2.27, -2.914, 0.243)
	SWEP.CmoreAng = Vector(0.49, 0, 0)
	
	SWEP.MicroT1Pos = Vector(2.28, -2.8, 0.3)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.TrijiconPos = Vector(2.286, -2.8, 0.419)
	SWEP.TrijiconAng = Vector(0, 0, 0)
	
	SWEP.ACOGPos = Vector(2.28, -2.8, -0.036)
	SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.CSGOACOGPos = Vector(2.266, -2.8, 0.26)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.CSGO556Pos = Vector(2.27, -2.8, 0.44)
	SWEP.CSGO556Ang = Vector(0, 0, 0)
	
	SWEP.CSGOSSGPos = Vector(-3.19, -2.8, -0.06)
	SWEP.CSGOSSGAng = Vector(0, 0, 0)
	
	SWEP.ELCANPos = Vector(2.26, -2.8, -0.14)
	SWEP.ELCANAng = Vector(0, 0, 0)
	
	SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)
	
	SWEP.FAS2AimpointPos = Vector(2.25, -4.2, 0.135)
	SWEP.FAS2AimpointAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(-0.801, -0.601, 1)
	SWEP.SprintAng = Vector(-13, -26, 0)

	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.BackupSights = {
	["md_elcan"] = {[1] = Vector(2.269, -3.6, -1.091), [2] = Vector(0.05, 0.059, 0)},
	["md_acog"] = {[1] = Vector(2.279, -3.6, -1.14), [2] = Vector(0.05, 0.059, 0)},
	["md_uecw_csgo_556"] = {[1] = Vector(2.266, -3.6, -0.5), [2] = Vector(0.899, 0, 0)}
	}

	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.M203CameraRotation = {p = 0, y = 0, r = 0}
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "smdimport", rel = "", pos = Vector(0, 5.559, -1.601), angle = Angle(0, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255)},
		["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint.mdl", bone = "smdimport", rel = "", pos = Vector(0.059, -4.481, 2.74), angle = Angle(0, 90, 0), size = Vector(1.2, 1.2, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroups = {[4] = 1, [2] = 1, [3] = 1} },
		["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "smdimport", rel = "", pos = Vector(0.579, -9.681, 2.5), angle = Angle(0, -90, -90), size = Vector(0.349, 0.349, 0.349), color = Color(255, 255, 255, 255)},
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "smdimport", rel = "", pos = Vector(0.079, -0.801, 3.5), angle = Angle(0, 0, 0), size = Vector(0.449, 0.449, 0.449), color = Color(255, 255, 255, 255)},
		["md_acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "smdimport", rel = "", pos = Vector(0.46, 4.675, -2.401), angle = Angle(0, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255)},
		["md_elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "smdimport", rel = "", pos = Vector(0.439, 3.599, -2.36), angle = Angle(0, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255)},
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "smdimport", rel = "", pos = Vector(0.337, 4.484, -2.358), angle = Angle(0, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "smdimport", rel = "", pos = Vector(0.09, -3.421, 3.476), angle = Angle(0, 180, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "smdimport", rel = "", pos = Vector(0.083, -2, 3.311), angle = Angle(0, 180, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "smdimport", rel = "", pos = Vector(-0.196, 9.074, -8.157), angle = Angle(4.443, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_uecw_csgo_acog"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "smdimport", rel = "", pos = Vector(0.039, 5.199, -0.281), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255)},
		["md_uecw_csgo_556"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_sig.mdl", bone = "smdimport", rel = "", pos = Vector(0.039, -1.201, 3.119), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255)},
		["md_csgo_silencer_rifle"] = { type = "Model", model = "models/kali/weapons/csgo/eq_suppressor_rifle.mdl", bone = "smdimport", rel = "", pos = Vector(0.05, -15.16, 0.5), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255)},
		["md_trijicon"] = { type = "Model", model = "models/att_trijicon.mdl", bone = "smdimport", rel = "", pos = Vector(0.1, -3.201, 0.649), angle = Angle(0, 180, 0), size = Vector(2.2, 2.2, 2.2), color = Color(255, 255, 255, 255)},
--		["md_specter"] = { type = "Model", model = "models/weapons/upgrades/a_optic_elcan.mdl", bone = "smdimport", rel = "", pos = Vector(0.1, -1.601, 3.259), angle = Angle(0, 180, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255)},
	}
	
	SWEP.LaserPosAdjust = Vector(1, 0, 1)--{x = 1, y = 0, z = 0}
	SWEP.LaserAngAdjust = Angle(0, 180, 0) --{p = 2, y = 180, r = 0}
end

--SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = false
SWEP.CustomizationMenuScale = 0.012

SWEP.Attachments = {[1] = {header = "Sight", offset = {200, -500},  atts = {"md_microt1","md_cmore", "md_reflex", "md_trijicon", "md_eotech", "md_elcan", "md_aimpoint", "md_acog", "md_uecw_csgo_acog", "md_uecw_csgo_556"}, exclusions = {bg_ris = true, bg_longbarrel = true}},
	[2] = {header = "Barrel extension", offset = {-300, -500}, atts = {"md_saker", "md_csgo_silencer_rifle"}},
	[3] = {header = "Rail", offset = {-300, -50}, atts = {"md_anpeq15"}},
	[4] = {header = "Magazine Upgrade", offset = {1200, 50}, atts = {"a_zsmagsmg1", "a_zsmagsmg2", "a_zsmagsmg3"}},
	 [5] = {header = "Perks", offset = {100, 100}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
	["+reload"] = {header = "Ammo", offset = {-300, 400}, atts = {"am_magnum2", "am_matchgrade2", "am_duplex2", "am_ricochet2", "am_tracers2", "am_luckylast2", "am_rifdepleteduranium2"}}}

if CustomizableWeaponry_KK_HK416 then
	table.insert( SWEP.Attachments[1].atts, 8, "md_fas2_aimpoint" )
end
	
SWEP.AttachmentDependencies = {["md_m203"] = {"bg_longris"}} -- this is on a PER ATTACHMENT basis, NOTE: the exclusions and dependencies in the Attachments table is PER CATEGORY

SWEP.Animations = {fire = {"ump45_fire1", "ump45_fire2", "ump45_fire3"},
	reload = "ump45_reload",
	idle = "ump45_idle",
	draw = "ump45_draw"}
	
SWEP.Sounds = {ump45_reload = {[1] = {time = 0.6, sound = "CW_UMP.45_MAGOUT"},
	[2] = {time = 1.6, sound = "CW_UMP.45_MAGIN"},
	[3] = {time = 1.8, sound = "CW_UMP.45_TAP"},
	[4] = {time = 2.45, sound = "CW_UMP.45_BOLTBACK"},
	[5] = {time = 2.6, sound = "CW_UMP.45_BOLTFORWARD"}},
	ump45_draw = {{time = 0.01, sound = "CW_XM8_CLOTH"}}}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "2burst", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - UECW"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/v_cstm_ump45.mdl"
SWEP.WorldModel		= "models/weapons/w_smg_ump45.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 25
SWEP.Primary.DefaultClip	= 25
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SMG1"

SWEP.FireDelay = 0.1
SWEP.FireSound = "CW_UMP.45_FIRE"
SWEP.FireSoundSuppressed = "CW_UMP.45_FIRE_SUPPRESSED"
SWEP.Recoil = 1.05

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 82
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.15
SWEP.ReloadTime_Empty = 3.1
SWEP.ReloadHalt = 2.3
SWEP.ReloadHalt_Empty = 3.3
SWEP.SnapToIdlePostReload = true

end