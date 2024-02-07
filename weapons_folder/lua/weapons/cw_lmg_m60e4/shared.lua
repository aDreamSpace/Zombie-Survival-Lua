AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M60E4"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	CustomizableWeaponry:registerAmmo("7.62X54mmR", "7.62X54mmR Rounds", 7.62, 51)
	
	SWEP.EffectiveRange_Orig = 100 * 230
	SWEP.DamageFallOff_Orig = .37
	
	SWEP.IconLetter = "w"
	killicon.AddFont("cw_ar15", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_SR25"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.SightWithRail = false
	SWEP.ShellPosOffset = {x = 0, y = 0, z = -5}
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	
	SWEP.IronsightPos = Vector(2.849, 1.205, 0.685)
	SWEP.IronsightAng = Vector(-0.113, 0.49, 0)

	SWEP.EoTechPos = Vector(2.77, 0, 0)
	SWEP.EoTechAng = Vector(1.547, 0.28, 0)

	SWEP.AimpointPos = Vector(2.789, 0, 0.519)
	SWEP.AimpointAng = Vector(-0, 0.4, 0)
	
	SWEP.MicroT1Pos = Vector(2.766, 3, 0.649)
	SWEP.MicroT1Ang = Vector(0, 0.1, 0)

	SWEP.ACOGPos = Vector(2.763, 0.878, 0.201)
	SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.RMRPos = Vector(2.75, 0, 0.787)
	SWEP.RMRAng = Vector(0, 0.2, 0)

	SWEP.ShortDotPos = Vector(-2.201, -4.148, 0.425)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.SwimPos = Vector(-2.753, 0, 0)
	SWEP.SwimAng = Vector(5.175, -25.035, 0)
	
	SWEP.PronePos = Vector(-6.525, -3.544, -5.35)
	SWEP.ProneAng = Vector(2.714, -28.521, 16.284)
	
	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(-1.724, 0, 0)
	SWEP.SprintAng = Vector(-9.554, -25.893, 0)
		
	SWEP.CustomizePos = Vector(-2.642, 0, 0)
	SWEP.CustomizeAng = Vector(6.719, -22.857, 0)  
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_mach_m249para.mdl"
	SWEP.WMPos = Vector(0, 2.5, 0.5)
	SWEP.WMAng = Vector(-5, 0, 180)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(2.789, 0.878, -0.604), [2] = Vector(-0.278, 0.3, 0)}}

	SWEP.ACOGAxisAlign = {right = 0, up = -90, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = -2, up = 0, forward = 0}
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "MAGWELL", rel = "", pos = Vector(0.43, -5.891, 2.976), angle = Angle(0, -90, 180), size = Vector(0.662, 0.662, 0.662)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "tag_weapon", rel = "", pos = Vector(-6.815, 1.465, 2.815), angle = Angle(0, 0, 90), size = Vector(0.5, 0.5, 0.5)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "MAGWELL", rel = "", pos = Vector(0.379, -8.056, 3.329), angle = Angle(0, 180, 180), size = Vector(0.725, 0.725, 0.725)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "MAGWELL", rel = "", pos = Vector(-0.071, -15.318, 9.949), angle = Angle(0, -90, -180), size = Vector(1.001, 1.001, 1.001)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "MAGWELL", rel = "", pos = Vector(0.209, -3.912, -0.866), angle = Angle(0, -180, -180), size = Vector(0.298, 0.298, 0.298)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "tag_weapon", rel = "", pos = Vector(-2.918, 0.173, -0.04), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8)}
	}
	
	SWEP.LaserPosAdjust = Vector(-0.7, 0, 0)
	SWEP.LaserAngAdjust = Angle(0.5, 180, 0) 
	
	SWEP.LaserAngAdjustAim = Angle(0, 180 - 0.5, 0)
	
    SWEP.LuaVMRecoilAxisMod = {vert = 0.1, hor = 0.5, roll = 0.3, forward = 0.6, pitch = 0.3}
end

SWEP.BoltBone = "BOLT"
SWEP.BoltShootOffset = Vector(-4, 0, 0)

SWEP.MuzzleVelocity = 880 -- in meter/s

SWEP.SightBGs = {main = 1, none = 2}
	
SWEP.LuaViewmodelRecoil = false
SWEP.LuaViewmodelRecoilOverride = false

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300}, atts = {"md_rmr", "md_microt1", "md_aimpoint", "md_eotech"}},
	[2] = {header = "Rail", offset = {0, 200}, atts = {"md_anpeq15"}},
	[3] = {header = "Barrel", offset = {-300, -300}, atts = {"md_saker"}},
	[4] = {header = "Bullet Belts", offset = {-200, 0}, atts = {"a_zsmagslmg1", "a_zsmagslmg2", "a_zsmagslmg3"}},
	[5] = {header = "Perks", offset = {400, 300}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap"}},
	["+reload"] = {header = "Ammo", offset = {700, 0}, atts = {"am_magnum2", "am_matchgrade2", "am_duplex2", "am_ricochet2", "am_tracers2", "am_luckylast2", "am_rifdepleteduranium2"}}}


SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload = {[1] = {time = 0.25, sound = "CW_M60_BOLT"},
	[2] = {time = 0.3, sound = "CW_M60_CLOTH1"},
	[3] = {time = 0.5, sound = "CW_M60_CLOTH2"},
	[4] = {time = 1.95, sound = "CW_M60_OPEN"},
	[5] = {time = 2.8, sound = "CW_M60_MAGOUT"},
	[6] = {time = 3.3, sound = "CW_M60_CLOTH"},
	[7] = {time = 3.6, sound = "CW_M60_MAGIN"},
	[8] = {time = 4.4, sound = "CW_M60_SHELLS"},
	[9] = {time = 4.5, sound = "CW_M60_PKP_CLOTH"},
	[10] = {time = 4.8, sound = "CW_M60_???"},
	[11] = {time = 5.5, sound = "CW_M60_CLOTH3"},
	[12] = {time = 5.6, sound = "CW_M60_CLOSE"},
	[13] = {time = 6, sound = "CW_M60_TAP"},
	[14] = {time = 6, sound = "CW_M60_CLOTH4"}}}
	
SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "[CW2.0] Yan's Guns"

SWEP.Author			= "Xxyan700xX"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/v_bf3_m60e4.mdl"
SWEP.WorldModel		= "models/weapons/w_mach_m249para.mdl"
SWEP.ADSFireAnim = false
SWEP.UseHands       = true

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 200
SWEP.Primary.DefaultClip	= 400
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Alyxgun"

SWEP.FireDelay = 0.11
SWEP.FireSound = "CW_M60A4_FIRE"
SWEP.FireSoundSuppressed = "CW_M60A4_OFFICIAL_FIRE_SUPPRESSED"
SWEP.Recoil = 1.4

SWEP.HipSpread = 0.060
SWEP.AimSpread = 0.0010
SWEP.VelocitySensitivity = 2.4
SWEP.MaxSpreadInc = 0.020
SWEP.SpreadPerShot = 0.004
SWEP.SpreadCooldown = 0.05
SWEP.Shots = 1
SWEP.Damage = 78
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 7.3
SWEP.ReloadTime_Empty = 7.3
SWEP.ReloadHalt = 7.3
SWEP.ReloadHalt_Empty = 7.3

function SWEP:IndividualThink()

	self.EffectiveRange = 100 * 230
	self.DamageFallOff = .37
	
end