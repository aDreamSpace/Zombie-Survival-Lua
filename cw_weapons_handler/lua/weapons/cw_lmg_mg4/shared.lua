AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "MG4"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "w"
	killicon.AddFont("", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_sf2_mg4.mdl"
	SWEP.WMPos = Vector(0, 2.5, 0.5)
	SWEP.WMAng = Vector(-5, 0, 180)
	
	SWEP.MuzzleEffect = "muzzleflash_SR25"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.SightWithRail = false
	SWEP.ShellPosOffset = {x = 0, y = 0, z = -5}
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9
	
	SWEP.M203OffsetCycle_Reload = 0.65
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0
	
	SWEP.IronsightPos = Vector(-2.731, 0, 0.419)
	SWEP.IronsightAng = Vector(1.2, 0, 0)
	
	SWEP.FoldSightPos = Vector(-2.208, -4.3, 0.143)
	SWEP.FoldSightAng = Vector(0.605, 0, -0.217)
		
	SWEP.EoTechPos = Vector(-2.688, 5, -0.445)
	SWEP.EoTechAng = Vector(0.017, 0.2, 0)
	
	SWEP.AimpointPos = Vector(-2.691, 2.009, 0.435)
	SWEP.AimpointAng = Vector(0.228, 0.08, 0)
	
	SWEP.MicroT1Pos = Vector(-2.681, 8, 0.453)
	SWEP.MicroT1Ang = Vector(0.45, 0.2, 0)
	
	SWEP.ACOGPos = Vector(-2.651, 5, 0.15)
	SWEP.ACOGAng = Vector(-1.158, 0.15, 0)
	
	SWEP.ShortDotPos = Vector(-2.201, -4.148, 0.425)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.7, 2.612, -1.484), [2] = Vector(-0.05, -0, 0)}}

	SWEP.ACOGAxisAlign = {right = 1.13, up = -0.13, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = -2, up = 0, forward = 0}
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "weapon_bodycover", rel = "", pos = Vector(-12.113, 0.455, -5.555), angle = Angle(0, 90, 0), size = Vector(1.312, 1.312, 1.312)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "weapon_root", rel = "", pos = Vector(22.792, -1.601, 6.348), angle = Angle(180, 0, -90), size = Vector(0.615, 0.615, 0.615)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "weapon_bodycover", rel = "", pos = Vector(-9.634, 0.3, -5.236), angle = Angle(0, 90, 0), size = Vector(1.256, 1.256, 1.256)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "weapon_bodycover", rel = "", pos = Vector(-26.41, -0.561, -20.614), angle = Angle(0, 0, 0), size = Vector(2.089, 2.089, 2.089)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "weapon_bodycover", rel = "", pos = Vector(-2.116, 0.029, 2.036), angle = Angle(0, 90, 0), size = Vector(0.564, 0.564, 0.564)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "weapon_root", rel = "", pos = Vector(8.215, 0.017, 2.855), angle = Angle(0, 90, 0), size = Vector(1.256, 1.256, 1.256)}
	}
	
	SWEP.LaserPosAdjust = Vector(-1, 0, 0.5)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
    SWEP.LuaVMRecoilAxisMod = {vert = 0.1, hor = 0.5, roll = 0.3, forward = 0.6, pitch = 0.3}
end

SWEP.BoltBone = "weapon_cartridge"
SWEP.BoltShootOffset = Vector(-4, 0, 0)

SWEP.MuzzleVelocity = 880 -- in meter/s

SWEP.SightBGs = {main = 2, none = 1}
	
SWEP.LuaViewmodelRecoil = false
SWEP.LuaViewmodelRecoilOverride = false

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300}, atts = {"md_microt1", "md_aimpoint",  "md_eotech", "md_acog"}},
	[2] = {header = "Rail", offset = {-300, 100}, atts = {"md_anpeq15"}},
	[3] = {header = "Barrel", offset = {-500, -500}, atts = {"md_saker"}},
	[4] = {header = "Bullet Belts", offset = {-100, -100}, atts = {"a_zsmagslmg1", "a_zsmagslmg2", "a_zsmagslmg3"}},
	[5] = {header = "Perks", offset = {400, 300}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap"}},
	["+reload"] = {header = "Ammo", offset = {700, 0}, atts = {"am_magnum2", "am_matchgrade2", "am_duplex2", "am_ricochet2", "am_tracers2", "am_luckylast2", "am_rifdepleteduranium2"}}}


SWEP.Animations = {fire = {"sequence_2", "sequence_2"},
	reload = "sequence_4",
	idle = "sequence_1",
	draw = "sequence_5"}
	
SWEP.Sounds = {sequence_5 = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	sequence_4 = {[1] = {time = 0.1, sound = "CW_MG4_CLOTH1"},
	[2] = {time = 0.6, sound = "CW_MG4_MAGOUT"},
	[3] = {time = 1.3, sound = "CW_MG4_OPEN"},
	[4] = {time = 2.3, sound = "CW_MG4_CLOTH"},
	[5] = {time = 2.6, sound = "CW_MG4_MAGIN"},
	[6] = {time = 2.8, sound = "CW_MG4_CLOTH2"},
	[7] = {time = 3.1, sound = "CW_MG4_CHAIN"},
	[8] = {time = 3.5, sound = "CW_MG4_CLOSE"},
	[9] = {time = 3.8, sound = "CW_MG4_CLOTH3"},
	[10] = {time = 4, sound = "CW_MG4_CLOSETAP"},
	[11] = {time = 5.2, sound = "CW_MG4_BOLT"},
	[12] = {time = 5.4, sound = "CW_MG4_BOLT_RELEASE"}}}
	
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
SWEP.ViewModel		= "models/weapons/v_sf2_mg4.mdl"
SWEP.WorldModel		= "models/weapons/w_sf2_mg4.mdl"
SWEP.ADSFireAnim = false
SWEP.UseHands       = true

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 400
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Alyxgun"

SWEP.FireDelay = 0.115
SWEP.FireSound = "CW_MG4_FIRE"
SWEP.FireSoundSuppressed = "CW_M249_OFFICIAL_FIRE_SUPPRESSED"
SWEP.Recoil = 1.35 --1.4

SWEP.HipSpread = 0.070
SWEP.AimSpread = 0.0020
SWEP.VelocitySensitivity = 2.4
SWEP.MaxSpreadInc = 0.020
SWEP.SpreadPerShot = 0.0025
SWEP.SpreadCooldown = 0.07
SWEP.Shots = 1
SWEP.Damage = 39
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 5.8
SWEP.ReloadTime_Empty = 5.8
SWEP.ReloadHalt = 5.8
SWEP.ReloadHalt_Empty = 5.8

