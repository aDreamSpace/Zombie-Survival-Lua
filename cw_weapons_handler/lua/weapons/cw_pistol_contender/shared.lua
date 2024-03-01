if CustomizableWeaponry then

SWEP.magType = "srMag"

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "G2 Contender"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "w"
	killicon.AddFont("cw_ar15", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_SR25"
	SWEP.NoSilMuz = true
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = 3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9
	SWEP.SightWithRail = false
	SWEP.AimBreathingEnabled = true
	
	SWEP.M203OffsetCycle_Reload = 0.65
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0
	
--	SWEP.CustomizePos = Vector(-10.5, -5.8, 0.4)
--	SWEP.CustomizeAng = Vector(27, -50, -30)
	
	SWEP.IronsightPos = Vector(-2.994, -1.448, 1.21)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.FrontRearPos = Vector(-2.722, -1.882, 0.43)
	SWEP.FrontRearAng = Vector(0.33, 0.15, 0)
	
	SWEP.EoTechPos = Vector(-3, -3.961, 0.216)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-2.995, -3.961, 0.44)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.ReflexPos = Vector(-2.991, -3.961, 0.736)
	SWEP.ReflexAng = Vector(0, 0, 0)
	
	SWEP.BallisticPos = Vector(-2.98, -4.488, 0.426)
	SWEP.BallisticAng = Vector(0, 0, 0)
	
	SWEP.CmorePos = Vector(-2.985, -3.961, 0.592)
	SWEP.CmoreAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-3.01, -2.8, 0.75)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ACOGPos = Vector(-3, -3.961, 0.251)
	SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.CSGOACOGPos = Vector(-3, -4.6, 0.52)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.CSGO556Pos = Vector(-3, -4.6, 0.78)
	SWEP.CSGO556Ang = Vector(0, 0, 0)
	
	SWEP.CSGOSSGPos = Vector(-2.995, -5.2, 0.61)
	SWEP.CSGOSSGAng = Vector(0, 0, 0)
	
	SWEP.ELCANPos = Vector(-2.98, -3.961, 0.112)
	SWEP.ELCANAng = Vector(0, 0, 0)
	
	SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_ballistic"] = { type = "Model", model = "models/bunneh/scope01.mdl", bone = "Front", rel = "", pos = Vector(-7.042, -1.65, 1.264), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "Front", rel = "", pos = Vector(-5, 4.05, 0.333), angle = Angle(-90, 0, -90), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "Front", rel = "", pos = Vector(-4.566, 3.92, 0.228), angle = Angle(-90, 0, -90), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "Front", rel = "", pos = Vector(-4.5, 3.95, 0.321), angle = Angle(-90, 0, -90), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "Front", rel = "", pos = Vector(3.045, -1.3, -0.004), angle = Angle(-90, 0, -90), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "Front", rel = "", pos = Vector(1.161, -1.1, -0.004), angle = Angle(-90, 0, -90), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "Front", rel = "", pos = Vector(-9.367, 10.33, -0.264), angle = Angle(0, 4.443, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "Front", rel = "", pos = Vector(1.649, -0.7, -1.5), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255)},
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "Front", rel = "", pos = Vector(-0.35, -1.26, 0), angle = Angle(90, -90, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255)},		["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "Front", rel = "", pos = Vector(0.059, 14, -0.12), angle = Angle(-180, -90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_uecw_csgo_acog"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "Front", rel = "", pos = Vector(-5.56, 2.009, -0.04), angle = Angle(0, 0, -90), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255)},
		["md_uecw_csgo_556"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_sig.mdl", bone = "Front", rel = "", pos = Vector(-0.42, -0.981, -0.02), angle = Angle(0, 0, -90), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255)},
		["md_uecw_csgo_scope_ssg"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_scope_bender.mdl", bone = "Front", rel = "", pos = Vector(0.4, -1, -0.04), angle = Angle(0, 0, -90), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255)},
		["md_csgo_silencer_ballistic"] = { type = "Model", model = "models/kali/weapons/csgo/eq_dsr50_suppressor.mdl", bone = "Front", rel = "", pos = Vector(-5.401, -0.681, -0.051), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255)},
		["md_csgo_silencer_rifle"] = { type = "Model", model = "models/kali/weapons/csgo/eq_suppressor_rifle.mdl", bone = "Front", rel = "", pos = Vector(12.96, -0.661, -0.721), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255)},
		}

	SWEP.LaserPosAdjust = Vector(1, 0, 0)--{x = 1, y = 0, z = 0}
	SWEP.LaserAngAdjust = Angle(2, 180, 0) --{p = 2, y = 180, r = 0}
	
end

SWEP.LuaViewmodelRecoil = false
SWEP.ADSFireAnim = true
SWEP.ForceBackToHipAfterAimedShot = true
SWEP.GlobalDelayOnShoot = 0.5
SWEP.CustomizationMenuScale = 0.01

SWEP.Attachments = {[1] = {header = "Sight", offset = {0, -500},  atts = {"md_microt1", "md_cmore", "md_reflex", "md_elcan", "md_eotech", "md_aimpoint", "md_acog", "md_uecw_csgo_acog", "md_uecw_csgo_556", "md_uecw_csgo_scope_ssg", "md_ballistic"}, exclusions = {md_frontsight = true, md_rearsight = true}},
	[2] = {header = "Barrel extension", offset = {-500, -500}, atts = {"md_saker", "md_csgo_silencer_rifle", "md_csgo_silencer_ballistic"}},
--	[3] = {header = "Magazine Upgrade", offset = {-200, 250}, atts = {"a_zsmagpistol1", "a_zsmagpistol2", "a_zsmagpistol3"}},
	[3] = {header = "Perks", offset = {-200, -200}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
	["+reload"] = {header = "Ammo", offset = {800, 0}, atts = {"am_magnum2", "am_matchgrade2", "am_duplex2", "am_ricochet2", "am_tracers2", "am_luckylast2", "am_rifdepleteduranium2"}}}
	
--SWEP.AttachmentDependencies = {} -- this is on a PER ATTACHMENT basis, NOTE: the exclusions and dependencies in the Attachments table is PER CATEGORY

SWEP.Animations = {fire = "awm_fire",
	fireDry = "awm_fire",
	reload = "awm_reload",
	idle = "awm_idle",
	draw = "awm_draw"}
	
SWEP.Sounds = {awm_reload = {[1] = {time = 0.5, sound = "CW_G2_OPEN"},
	[2] = {time = 0.55, sound = "CW_G2_CLIPOUT"},
	[3] = {time = 1.0, sound = "CW_G2_SHELL"},
	[4] = {time = 1.35, sound = "CW_G2_CLIPIN"},
	[5] = {time = 2.2, sound = "CW_G2_CLOSE"}},
	awm_draw = {{time = 0.01, sound = "CW_XM8_CLOTH"},
	{time = 0.25, sound = "CW_G2_COCK"}}}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - UECW"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_cstm_g2.mdl"
SWEP.WorldModel		= "models/weapons/w_snip_scout.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Pistol"
SWEP.Chamberable = false

SWEP.FireDelay = 0.1
SWEP.FireSound = "CW_G2_FIRE"
SWEP.FireSoundSuppressed = "CW_G2_FIRE_SUPPRESSED"
SWEP.Recoil = 2.6

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 336
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.6
SWEP.ReloadTime_Empty = 2.6
SWEP.ReloadHalt = 3
SWEP.ReloadHalt_Empty = 3
SWEP.SnapToIdlePostReload = true

end