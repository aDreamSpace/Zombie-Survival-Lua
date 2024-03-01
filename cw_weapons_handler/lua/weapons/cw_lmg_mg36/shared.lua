AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "MG-36"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "w"
	killicon.AddFont("cw_ar15", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_SR25"
	SWEP.ShellPosOffset = {x = 1, y = 0, z = 0}
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_mach_m249para.mdl"
	SWEP.WMPos = Vector(0, 2.5, 0.5)
	SWEP.WMAng = Vector(-5, 0, 180)
	
	
	SWEP.IronsightPos = Vector(-2.747, 0, -0.281)
	SWEP.IronsightAng = Vector(0.1, 0.016, 0)
	
	SWEP.FoldSightPos = Vector(-2.208, -4.3, 0.143)
	SWEP.FoldSightAng = Vector(0.605, 0, -0.217)
		
	SWEP.EoTechPos = Vector(-2.75, 0, -0.44)
	SWEP.EoTechAng = Vector(-0.701, -0.02, 0)

	SWEP.AimpointPos = Vector(-2.78, 0, 0)
	SWEP.AimpointAng = Vector(-0.139, -0.051, 0)
	
	SWEP.MicroT1Pos = Vector(-2.76, 0, -0.04)
	SWEP.MicroT1Ang = Vector(-0.101, 0, 0)
	
	SWEP.ACOGPos = Vector(-2.76, 1.809, -0.146)
	SWEP.ACOGAng = Vector(-1.718, -0.02, 0)
	
	SWEP.ShortDotPos = Vector(-2.201, -4.148, 0.425)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.RMRPos = Vector(-2.727, 0, 0.266)
	SWEP.RMRAng = Vector(0, 0.08, 0)

	SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.76, -2.01, -1.573), [2] = Vector(-0.317, -0.02, 0)}}

	SWEP.ACOGAxisAlign = {right = 0, up = 90, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = -2, up = 0, forward = 0}
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "MG36", rel = "", pos = Vector(-0.22, -5.406, -1.68), angle = Angle(0, -90, 0), size = Vector(0.936, 0.936, 0.936)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "MG36", rel = "", pos = Vector(-0.13, -8.714, -1.726), angle = Angle(0, 0, 0), size = Vector(0.944, 0.944, 0.944)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "MG36", rel = "", pos = Vector(0.5, -17.258, -10.893), angle = Angle(0, -90, 0), size = Vector(1.355, 1.355, 1.355)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "MG36", rel = "", pos = Vector(0.1, 0, 3.789), angle = Angle(0, 0, 0), size = Vector(0.469, 0.469, 0.469)},
		["md_saker"] = {model =  "models/cw2/attachments/556suppressor.mdl", bone = "MG36", rel = "", pos = Vector(0.122, 5.4, -0.401), angle = Angle(0, 0, 0), size = Vector(0.61, 0.61, 0.61)}
	}
	
	SWEP.LaserPosAdjust = Vector(-1, 0, 0.5)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
    SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 0.5, roll = 0.3, forward = 0.6, pitch = 0.3}
	
	SWEP.LuaViewmodelRecoil = false
    SWEP.LuaViewmodelRecoilOverride = false
    SWEP.FullAimViewmodelRecoil = false
end

SWEP.BoltBone = "bolt"
SWEP.BoltShootOffset = Vector(0, 0, 2)

SWEP.MuzzleVelocity = 880 -- in meter/s

SWEP.SightBGs = {main = 1, none = 1}

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300}, atts = {"md_rmr", "md_microt1", "md_aimpoint", "md_eotech"}},
	[2] = {header = "Barrel", offset = {-500, -300}, atts = {"md_saker"}},
	[3] = {header = "Bullet Belts", offset = {-200, 0}, atts = {"a_zsmagslmg1", "a_zsmagslmg2", "a_zsmagslmg3"}},
	[4] = {header = "Perks", offset = {400, 300}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap"}},
	["+reload"] = {header = "Ammo", offset = {700, 0}, atts = {"am_magnum2", "am_matchgrade2", "am_duplex2", "am_ricochet2", "am_tracers2", "am_luckylast2", "am_rifdepleteduranium2"}}}


SWEP.Animations = {fire = {"shoot_1", "shoot_2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_MG36_DEPLOY"}},

	reload = {[1] = {time = 0.7, sound = "CW_MG36_MAGOUT"},
	[2] = {time = 2.3, sound = "CW_MG36_CLOTH"},
	[3] = {time = 2.65, sound = "CW_MG36_MAGIN"},
	[4] = {time = 2.7, sound = "CW_MG36_CLOTH2"},
	[5] = {time = 2.9, sound = "CW_MG36_MAGTAP"},
	[6] = {time = 3.8, sound = "CW_MG36_CLOTH1"},
	[7] = {time = 3.9, sound = "CW_MG36_BOLT"}}}

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
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_bfh_mg36.mdl"
SWEP.WorldModel		= "models/weapons/w_mach_m249para.mdl"
SWEP.UseHands       = false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 300
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Alyxgun"

SWEP.FireDelay = 0.085666666666667
SWEP.FireSound = "CW_MG36_FIRE"
SWEP.FireSoundSuppressed = "CW_MG36_OFFICIAL_FIRE_SUPPRESSED"
SWEP.Recoil = 1.1

SWEP.HipSpread = 0.050
SWEP.AimSpread = 0.0025
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.030
SWEP.SpreadPerShot = 0.008
SWEP.SpreadCooldown = 0.5
SWEP.Shots = 1
SWEP.Damage = 65
SWEP.DeployTime = 0.7

SWEP.ReloadSpeed = 1.15
SWEP.ReloadTime = 5.7
SWEP.ReloadTime_Empty = 5.7
SWEP.ReloadHalt = 5.7
SWEP.ReloadHalt_Empty = 5.7
SWEP.SnapToIdlePostReload = true