if CustomizableWeaponry then

SWEP.magType = "arMag"

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "HK G36C"
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
	
	SWEP.IronsightPos = Vector(4.064, -3, 1.475)
	SWEP.IronsightAng = Vector(0.237, 0, 0)
	
	SWEP.EoTechPos = Vector(4.105, -4.5, 0.64)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(3.997, -3.75, 0.714)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.ReflexPos = Vector(4.07, -3.994, 1.138)
	SWEP.ReflexAng = Vector(0, 0, 0)
	
	SWEP.BallisticPos = Vector(-3.19, -4, -0.06)
	SWEP.BallisticAng = Vector(0, 0, 0)
	
	SWEP.CmorePos = Vector(4.071, -3.994, 0.981)
	SWEP.CmoreAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(4.054, -4, 0.949)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.TrijiconPos = Vector(4.039, -4, 0.879)
	SWEP.TrijiconAng = Vector(0, 0, 0)
	
	SWEP.ACOGPos = Vector(4.079, -7, 0.584)
	SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.CSGOACOGPos = Vector(4.067, -5.801, 0.839)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.CSGO556Pos = Vector(2.27, -2.8, 0.44)
	SWEP.CSGO556Ang = Vector(0, 0, 0)
	
	SWEP.CSGOSSGPos = Vector(-3.19, -2.8, -0.06)
	SWEP.CSGOSSGAng = Vector(0, 0, 0)
	
	SWEP.ELCANPos = Vector(4.04, -5, 0.5)
	SWEP.ELCANAng = Vector(0, 0, 0)
	
	SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(-0.801, -0.601, 1)
	SWEP.SprintAng = Vector(-13, -26, 0)

	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.BackupSights = {
	["md_elcan"] = {[1] = Vector(4.065, -6.80, -0.5), [2] = Vector(0.2, 0.2, 0)},
	["md_acog_"] = {[1] = Vector(4.074, -6.80, -0.42), [2] = Vector(0, 0, 0)}
	}

	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}
	
	SWEP.BaseArm = "Right_Arm"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "BaseW", rel = "", pos = Vector(0.059, -3.661, -0.84), angle = Angle(0, 180, 0), size = Vector(1, 1, 1)},
		["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "BaseW", rel = "", pos = Vector(0.119, -14.601, 4.519), angle = Angle(0, -90, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "BaseW", rel = "", pos = Vector(0, -11.2, 4.739), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_csgo_silencer_rifle"] = { type = "Model", model = "models/kali/weapons/csgo/eq_suppressor_rifle.mdl", bone = "BaseW", rel = "", pos = Vector(0.019, -24.4, 1.2), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_trijicon"] = { type = "Model", model = "models/att_trijicon.mdl", bone = "BaseW", rel = "", pos = Vector(0, -13.4, 2), angle = Angle(0, 180, 0), size = Vector(2.2, 2.2, 2.2)},
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "BaseW", pos = Vector(-0.212, -0.169, -6.901), angle = Angle(4.512, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "BaseW", pos = Vector(0.212, -4.581, -1.032), angle = Angle(0, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_foregrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "BaseW", rel = "", pos = Vector(10.562, -17.726, -0.301), angle = Angle(0, -90, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "BaseW", rel = "", pos = Vector(0.112, -19.25, 0.537), angle = Angle(0, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} },
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "BaseW", rel = "", pos = Vector(0.037, -13.195, 4.736), angle = Angle(0, 180, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_m203"] = { type = "Model", model = "models/cw2/attachments/m203.mdl", bone = "BaseW", rel = "", pos = Vector(-2.36, 1.58, 4.699), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), animated = true},
		["md_acog_fixed"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "BaseW", rel = "", pos = Vector(0.36, -6.2, -0.52), angle = Angle(0, 180, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "BaseW", pos = Vector(0.368, -6.709, -1.157), angle = Angle(0, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_uecw_csgo_acog"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "BaseW", rel = "", pos = Vector(-0.02, -4.801, 0.959), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "BaseW", rel = "", pos = Vector(0.025, -10.483, 4.487), angle = Angle(0, 180, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.ForeGripHoldPos = {
		['Right_Forearm'] = {pos = Vector(0.6, -0.12, 4.25), angle = Angle(0, 0, 0)},
		['R_Thumb'] = {vecotr = Vector(0, 0, 0), angle = Angle(-2.9189999103546, -14.031000137329, -2.625)},
		['R_Thumb2'] = {vector = Vector(0, 0, 0), angle = Angle(-0.31900000572205, 0, -20.325000762939)}
	}
	
	SWEP.M203HoldPos = {
		["Right_Arm"] = {pos = Vector(-0.5, 0, 4), angle = Angle(0, 0, 0)}
	}

	SWEP.LaserPosAdjust = Vector(1, 0, 0)--{x = 1, y = 0, z = 0}
	SWEP.LaserAngAdjust = Angle(0, 180, 0) --{p = 2, y = 180, r = 0}
	
function SWEP:RenderTargetFunc()
	
	if !self.SkinSilencerInstalled then -- if we dont have skin silencer, hide it
	self.CW_VM:ManipulateBoneScale(self.CW_VM:LookupBone("silencer"), Vector(0.009, 0.009, 0.009))
	else
	self.CW_VM:ManipulateBoneScale(self.CW_VM:LookupBone("silencer"), Vector(1, 1, 1))
	end

end

end

SWEP.BoltBone = "slide"
SWEP.BoltShootOffset = Vector(0, 2, 0)

--SWEP.SightBGs = {main = 2, none = 1}

SWEP.LuaViewmodelRecoil = true
SWEP.CustomizationMenuScale = 0.015

SWEP.Attachments = {[1] = {header = "Sight", offset = {500, -600},  atts = {"md_microt1", "md_cmore", "md_reflex", "md_trijicon", "md_eotech", "md_aimpoint", "md_elcan", "md_acog_fixed", "md_uecw_csgo_acog"}, exclusions = {bg_ris = true, bg_longbarrel = true}},
	[2] = {header = "Barrel extension", offset = {-300, -600}, atts = {"md_saker", "md_csgo_silencer_rifle", "uecw_skin_silencer"}},
	[3] = {header = "Handguard", offset = {-300, 200}, atts = {"md_foregrip", "md_bipod", "md_m203"}},
	[4] = {header = "Magazine Upgrade", offset = {200, -150}, atts = {"a_zsmagar1", "a_zsmagar2", "a_zsmagar3"}},
	[5] = {header = "Rail", offset = {300, 300}, atts = {"md_anpeq15"}, dependencies = {md_microt1 = true, md_cmore = true, md_reflex = true, md_trijicon = true, md_eotech = true, md_aimpoint = true, md_acog_fixed = true, md_csgo_acog = true}},
	[6] = {header = "Perks", offset = {600, 500}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
	["+reload"] = {header = "Ammo", offset = {1200, 0}, atts = {"am_hqb2", "am_magnum2", "am_matchgrade2", "am_luckylast2", "am_duplex2", "am_depleteduranium2"}}}
	
--SWEP.AttachmentDependencies = {["md_anpeq15"] = {"md_microt1"}} -- this is on a PER ATTACHMENT basis, NOTE: the exclusions and dependencies in the Attachments table is PER CATEGORY

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {reload = {[1] = {time = 0.4, sound = "CW_G36C_MAGOUT"},
	[2] = {time = 1.1, sound = "CW_G36C_MAGIN"},
	[3] = {time = 2.1, sound = "CW_G36C_BOLTPULL"},
	[4] = {time = 2.35, sound = "CW_G36C_BOLTRELEASE"}},
	draw = {[1] = {time = 0.1, sound = "CW_G36C_BOLTPULL"},
	[2] = {time = 0.4, sound = "CW_G36C_BOLTRELEASE"}},
	drawkek = {{time = 0.01, sound = "CW_XM8_CLOTH"}}}

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
SWEP.ViewModel		= "models/weapons/v_rif_g36c.mdl"
SWEP.WorldModel		= "models/weapons/w_rif_ak47.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "AR2"

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_G36C_FIRE"
SWEP.FireSoundSuppressed = "CW_G36C_FIRE_SUPPRESSED"
SWEP.Recoil = 1.05

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 41
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.6
SWEP.ReloadTime_Empty = 2.6
SWEP.ReloadHalt = 1.8
SWEP.ReloadHalt_Empty = 3
SWEP.SnapToIdlePostReload = true

end