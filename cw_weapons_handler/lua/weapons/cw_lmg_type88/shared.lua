AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Type 88"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "w"
	killicon.AddFont("", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.DrawTraditionalWorldModel = false
    SWEP.WM = "models/weapons/w_bf4_type88.mdl"
    SWEP.WMPos = Vector(-1, 1, -1)
    SWEP.WMAng = Vector(-10, 2, 180)    
	
	SWEP.MuzzleEffect = "muzzleflash_SR25"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.SightWithRail = false
	SWEP.ShellPosOffset = {x = -1, y = -1, z = 2}
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9
	
	SWEP.M203OffsetCycle_Reload = 0.65
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0
	
	SWEP.IronsightPos = Vector(-2.748, 0, -0.32)
	SWEP.IronsightAng = Vector(0.4, 0, 0)
	
	SWEP.FoldSightPos = Vector(-2.208, -4.3, 0.143)
	SWEP.FoldSightAng = Vector(0.605, 0, -0.217)
		
	SWEP.EoTechPos = Vector(-2.77, 0.998, -1.022)
	SWEP.EoTechAng = Vector(-0.413, 0, 0)
	
	SWEP.AimpointPos = Vector(-2.757, 0, -0.5)
	SWEP.AimpointAng = Vector(-0.08, 0.039, 0)

	SWEP.MicroT1Pos = Vector(-2.747, 5, -0.339)
	SWEP.MicroT1Ang = Vector(-0.45, 0.05, 0)
	
	SWEP.ACOGPos = Vector(-3.75, -3.619, -0.153)
	SWEP.ACOGAng = Vector(-0.099, 0.514, 0)
	
	SWEP.ShortDotPos = Vector(-2.201, -4.148, 0.425)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.708, 0, 0)
	SWEP.SprintAng = Vector(-7.171, 16.158, 0)
	
	SWEP.CustomizePos = Vector(3.119, -3.04, -1.481)
	SWEP.CustomizeAng = Vector(7.199, 38.599, 0) 
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-3.8, -3.619, -1.408), [2] = Vector(-0.222, 0.029, 0)}}
	
	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 2.5, roll = 0.5, forward = 0.3, pitch = -0.1}

	SWEP.ACOGAxisAlign = {right = 0, up = -0.5, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = -2, up = 0, forward = 0}
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_bipod"] = {model = "models/wystan/attachments/bipod.mdl", bone = "MAGWELL", pos = Vector(1000, 1000, 1000), angle = Angle(0, 0, 0), size = Vector(0.699, 0.699, 0.699)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "MAGWELL", rel = "", pos = Vector(-0.491, -12.466, -4), angle = Angle(0, 0, 0), size = Vector(0.823, 0.823, 0.823)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "MAGWELL", rel = "", pos = Vector(0.05, -21.13, -12.862), angle = Angle(0, -90, 0), size = Vector(1.264, 1.264, 1.264)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "MAGWELL", rel = "", pos = Vector(-0.29, -6.454, 0.796), angle = Angle(0, 0, 0), size = Vector(0.356, 0.356, 0.356)}
	}
	
	SWEP.LaserPosAdjust = Vector(-1, 0, 0.5)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
    SWEP.LuaVMRecoilAxisMod = {vert = 0.1, hor = 0.5, roll = 0.3, forward = 0.6, pitch = 0.3}
end

SWEP.BoltBone = "bolt"
SWEP.BoltShootOffset = Vector(0, 4, 0)

SWEP.MuzzleVelocity = 700 -- in meter/s

SWEP.SightBGs = {main = 1, none = 1}
	
SWEP.LuaViewmodelRecoil = false
SWEP.LuaViewmodelRecoilOverride = false

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300}, atts = {"md_microt1", "md_aimpoint", "md_eotech"}},
[2] = {header = "Bullet Belts", offset = {-200, 0}, atts = {"a_zsmagslmg1", "a_zsmagslmg2", "a_zsmagslmg3"}},
[3] = {header = "Perks", offset = {400, 300}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap"}},
["+reload"] = {header = "Ammo", offset = {700, 0}, atts = {"am_magnum2", "am_matchgrade2", "am_duplex2", "am_ricochet2", "am_tracers2", "am_luckylast2", "am_rifdepleteduranium2"}}}


SWEP.Animations = {fire = {"fire1", "fire2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload = {[1] = {time = 0.4, sound = "CW_Type88_OPEN"},
	[2] = {time = 1.0, sound = "CW_Type88_CLOTH1"},
	[3] = {time = 1.3, sound = "CW_Type88_OUT"},
	[4] = {time = 1.9, sound = "CW_Type88_CLOTH2"},
	[5] = {time = 1.8, sound = "CW_CLOTH"},
	[6] = {time = 2.1, sound = "CW_Type88_IN"},
	[7] = {time = 2.3, sound = "CW_CLOTH1"},
	[8] = {time = 2.4, sound = "CW_Type88_HIT"},
	[9] = {time = 2.7, sound = "CW_CLOTH2"},
	[10] = {time = 2.8, sound = "CW_Type88_CHAIN"},
	[11] = {time = 3.2, sound = "CW_CLOTH3"},
	[12] = {time = 3.3, sound = "CW_Type88_CLOSE"},
	[13] = {time = 4.1, sound = "CW_CLOTH4"},
	[14] = {time = 4.2, sound = "CW_Type88_BOLT"},
	[15] = {time = 4.4, sound = "CW_CLOTH4"}}}
	
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
SWEP.ViewModel		= "models/weapons/v_bf4_type88.mdl"
SWEP.WorldModel		= "models/weapons/w_bf4_type88.mdl"
SWEP.BipodFireAnim = true
SWEP.ADSFireAnim = false
SWEP.UseHands       = false
SWEP.BipodInstalled = true


SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 400
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Alyxgun"

SWEP.FireDelay = 0.12
SWEP.FireSound = "CW_MG4_FIRE"
SWEP.FireSoundSuppressed = "CW_M249_OFFICIAL_FIRE_SUPPRESSED"
SWEP.Recoil = 1.3

SWEP.HipSpread = 0.060
SWEP.AimSpread = 0.0030
SWEP.VelocitySensitivity = 2.4
SWEP.MaxSpreadInc = 0.010
SWEP.SpreadPerShot = 0.003
SWEP.SpreadCooldown = 0.08
SWEP.Shots = 1
SWEP.Damage = 59
SWEP.DeployTime = 0.85

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 5.8
SWEP.ReloadTime_Empty = 5.8
SWEP.ReloadHalt = 5.8
SWEP.ReloadHalt_Empty = 5.8