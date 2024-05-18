if CustomizableWeaponry then

SWEP.magType = "arMag"

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "HK XM8"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	killicon.AddFont("cw_g3a3", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6
	
	SWEP.DrawTraditionalWorldModel = true
	
	SWEP.CustomizePos = Vector(-5.6, -2.401, -2.401)
	SWEP.CustomizeAng = Vector(18.2, -35.8, -7.401)
	
	SWEP.IronsightPos = Vector(2.556, -3.543, 0.778)
	SWEP.IronsightAng = Vector(1.143, 0, 0)
	
	SWEP.EoTechPos = Vector(2.575, -5.119, -0.35)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(2.539, -5.119, -0.132)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(2.569, -6.2, 0.019)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ACOGPos = Vector(2.575, -4, -0.35)
	SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.SG1Pos = Vector(-1.614, -0.861, -0.51)
	SWEP.SG1Ang = Vector(0, 0, 0)
	
	SWEP.CmorePos = Vector(2.575, -6.238, -0.024)
	SWEP.CmoreAng = Vector(0, 0, 0)
	
	SWEP.ReflexPos = Vector(2.575, -6.238, 0.108)
	SWEP.ReflexAng = Vector(0, 0, 0)
	
	SWEP.BallisticPos = Vector(-2.02, -4, 0.363)
	SWEP.BallisticAng = Vector(0, 0, 0)
	
	SWEP.ELCANPos = Vector(2.539, -3, -0.44)
	SWEP.ELCANAng = Vector(0, 0, 0)
	
	SWEP.TrijiconPos = Vector(2.528, -6.2, -0.058)
	SWEP.TrijiconAng = Vector(0, 0, 0)
	
	SWEP.CSGOACOGPos = Vector(2.575, -5.401, -0.12)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.CSGOSSGPos = Vector(-2.02, -3.217, 0.34)
	SWEP.CSGOSSGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(-4.2, -1.8, 0)
	SWEP.SprintAng = Vector(-8.2, -42.201, 0)
	
	SWEP.BackupSights = {
	["md_elcan"] = {[1] = Vector(2.539, -3, -1.35), [2] = Vector(0, 0, 0)},
	["md_acog_fixed"] = {[1] = Vector(2.56, -3, -1.275), [2] = Vector(0.2, 0, 0)}
	}

	SWEP.SightWithRail = true
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.AlternativePos = Vector(0.2, 0, -1)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.M203OffsetCycle_Reload = 0.81
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0
	
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}

	SWEP.BaseArm = "r-forearm"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)
	
	SWEP.M203HoldPos = {
		["r-upperarm-movement"] = {pos = Vector(2.8, -0.46, -1.8), angle = Angle(0, 0, 0)}
	}

	SWEP.AttachmentModelsVM = {
		["md_uecw_usgimag"] = { type = "Model", model = "models/gmod4phun/usgimag.mdl", bone = "Mag", rel = "", pos = Vector(0, 0, -2), angle = Angle(0, 180, 0), size = Vector(0.625, 0.625, 0.625), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_uecw_emag"] = { type = "Model", model = "models/gmod4phun/emag.mdl", bone = "Mag", rel = "", pos = Vector(0, 0, -2.75), angle = Angle(0, 180, 0), size = Vector(0.625, 0.625, 0.625), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_uecw_60rnd"] = { type = "Model", model = "models/gmod4phun/60rndmag.mdl", bone = "Mag", rel = "", pos = Vector(0, -1.201, -1.5), angle = Angle(0, 180, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_uecw_cmag"] = { type = "Model", model = "models/wystan/cmag.mdl", bone = "Mag", rel = "", pos = Vector(0.165, 4.21, -1.892), angle = Angle(0, 90, 0), size = Vector(0.68, 0.68, 0.68), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_rail"] = { type = "Model", model = "models/wystan/attachments/rail.mdl", bone = "Base", rel = "", pos = Vector(0.234, 1.019, 0.804), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "Base", rel = "", pos = Vector(0, 0, 2.628), angle = Angle(0, 180, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "Base", rel = "", pos = Vector(0, -1.777, 2.831), angle = Angle(0, 180, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "Base", rel = "", pos = Vector(0.057, -8.466, -1.925), angle = Angle(0, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} },
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "Base", rel = "", pos = Vector(-0.269, 11.149, -8.875), angle = Angle(4.443, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "Base", rel = "", pos = Vector(0.194, 6.616, -2.481), angle = Angle(0, 180, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--		["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "Base", rel = "", pos = Vector(-0.601, -8.801, 0), angle = Angle(0, -90, 90), size = Vector(0.5, 0.5, 0.5)},
		["md_foregrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "Base", rel = "", pos = Vector(-0.401, -17.066, -3.633), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "Base", rel = "", pos = Vector(-0.015, 1.12, 2.779), angle = Angle(0, 0, 0), size = Vector(0.34, 0.34, 0.34)},
		["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "Base", rel = "", pos = Vector(0, 5.44, -3.181), angle = Angle(0, 180, 0), size = Vector(1, 1, 1)},
		["md_m203"] = { type = "Model", model = "models/cw2/attachments/m203.mdl", bone = "Base", rel = "", pos = Vector(-2.34, 10.659, 2.4), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), animated = true},
		["md_acog_fixed"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "Base", rel = "", pos = Vector(0.3, 5.719, -1.885), angle = Angle(0, 180, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "Base", rel = "", pos = Vector(0.298, 5.892, -2.497), angle = Angle(0, 180, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_trijicon"] = { type = "Model", model = "models/att_trijicon.mdl", bone = "Base", rel = "", pos = Vector(-0.04, -1.201, 0.419), angle = Angle(0, 180, 0), size = Vector(1.899, 1.899, 1.899)},
		["md_uecw_csgo_acog"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "Base", rel = "", pos = Vector(-0.04, 6.199, -0.51), angle = Angle(0, 90, 0), size = Vector(0.699, 0.699, 0.699)},
		["md_csgo_silencer_rifle"] = { type = "Model", model = "models/kali/weapons/csgo/eq_suppressor_rifle.mdl", bone = "Base", rel = "", pos = Vector(0, -15.341, -1.101), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
	}

	SWEP.ForeGripHoldPos = {
		["r-forearm"] = {vector = Vector(0, 0, 0), angle = Angle(-8.5, 14.8, -82.5)},
		["r-thumb-tip"] = {vector = Vector(0, 0, 0), angle = Angle(57.558, 0, 0)},
		["r-thumb-mid"] = {vector = Vector(0, 0, 0), angle = Angle(29.489, 0, 0)},
		["r-middle-tip"] = {vector = Vector(0, 0, 0), angle = Angle(47.895, 0, 0)},
		["r-thumb-low"] = {vector = Vector(0, 0, 0), angle = Angle(7.638, 26.665, 0)},
		["r-pinky-low"] = {vector = Vector(0, 0, 0), angle = Angle(-8.7, 0, 0)},
		["r-index-low"] = {vector = Vector(0, 0, 0), angle = Angle(51.199, 23.795, 7.397)},
		["r-ring-tip"] = {vector = Vector(0, 0, 0), angle = Angle(51.741, 0, 0)},
		["r-middle-low"] = {vector = Vector(0, 0, 0), angle = Angle(28.035, 7.127, -1.678)},
		["r-index-tip"] = {vector = Vector(0, 0, 0), angle = Angle(11.036, 0, 0)},
		["r-ring-low"] = {vector = Vector(0, 0, 0), angle = Angle(7.001, 4.373, 0)},
		["r-rist"] = {vector = Vector(0, 0, 0), angle = Angle(0, -22.463, 0)},
		["r-pinky-tip"] = {vector = Vector(0, 0, 0), angle = Angle(58.548, 0, 0)}
	}
	
	SWEP.ForegripOverridePos = {
		["md_uecw_cmag"] = {
			["r-upperarm-movement"] = { scale = Vector(1, 1, 1), pos = Vector(2.599, 0, 0), angle = Angle(0, 0, 0) }
		},
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	
	SWEP.BoltBone = "Bolt"
	SWEP.BoltShootOffset = Vector(0, 2, 0)
	
	SWEP.LaserPosAdjust = Vector(0.5, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
	SWEP.MagBoneName = "Mag"
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {400, -600},  atts = {"md_microt1", "md_cmore", "md_reflex", "md_trijicon", "md_eotech", "md_aimpoint", "md_elcan", "md_acog_fixed", "md_uecw_csgo_acog"}},
	[2] = {header = "Barrel extension", offset = {-300, -600},  atts = {"md_saker", "md_csgo_silencer_rifle"}},
	[3] = {header = "Handguard", offset = {-300, -100}, atts = {"md_foregrip", "md_bipod", "md_m203"}},
	[4] = {header = "Magazine Upgrade", offset = {200, -300}, atts = {"a_zsmagar1", "a_zsmagar2", "a_zsmagar3"}},
	 [5] = {header = "Perks", offset = {500, 300}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
	["+reload"] = {header = "Ammo", offset = {800, -100}, atts = {"am_highcaliberrounds2", "am_hqb2", "am_magnum2", "am_matchgrade2", "am_luckylast2", "am_duplex2", "am_depleteduranium2"}}}
	
SWEP.AttachmentExclusions = {
	["md_foregrip"] = {"md_uecw_cmag"},
	["md_uecw_cmag"] = {"md_foregrip", "md_m203"},
	["md_m203"] = {"md_uecw_cmag"}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {reload = {{time = 0.5, sound = "CW_XM8_FOLEY"},
	{time = 0.95, sound = "CW_XM8_MAGOUT"},
	{time = 1.2, sound = "CW_FOLEY_LIGHT"},
	{time = 1.7, sound = "CW_XM8_MAGIN"},
	{time = 1.75, sound = "CW_FOLEY_LIGHT"},
	{time = 1.9, sound = "CW_XM8_MAGTAP"},
	{time = 2.5, sound = "CW_XM8_BOLT"},
	{time = 2.6, sound = "CW_FOLEY_MEDIUM"}},
	draw = {{time = 0.01, sound = "CW_XM8_CLOTH"},
	{time = 0.55, sound = "CW_XM8_SAFETY"}}}

SWEP.SpeedDec = 40

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - UECW"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/v_cstm_xm8.mdl"
SWEP.WorldModel		= "models/weapons/w_rif_m4a1.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "AR2"

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_XM8_FIRE"
SWEP.FireSoundSuppressed = "CW_XM8_FIRE_SUPPRESSED"
SWEP.Recoil = 1.5

SWEP.HipSpread = 0.048
SWEP.AimSpread = 0.0025
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.15
SWEP.Shots = 1
SWEP.Damage = 47
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.2
SWEP.ReloadTime_Empty = 3.6
SWEP.ReloadHalt = 2.5
SWEP.ReloadHalt_Empty = 3.8

SWEP.SnapToIdlePostReload = true

end