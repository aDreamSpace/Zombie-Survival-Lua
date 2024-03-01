AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "ARES Shrike 5.56"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "z"
	killicon.Add("cw_tr09_aresshrike", "vgui/kills/cw_tr09_aresshrike", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("vgui/kills/cw_tr09_aresshrike")
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 2.3, y = 2, z = -5}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9
	
	SWEP.IronsightPos = Vector(-3.805, -4.092, 0.480)
	SWEP.IronsightAng = Vector(0.26, -0.1, 0)
		
	SWEP.EoTechPos = Vector(-3.82, -2.5, -0.14)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-3.825, -3, 0.14)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-3.812, -0.5, 0.15)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ACOGPos = Vector(-3.79, -2, -0.03)
	SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.CustomizePos = Vector(4.794, -4.440, -1.495)
	SWEP.CustomizeAng = Vector(24.700, 40.660, 16.443)
	
	SWEP.AlternativePos = Vector(-1.12, 0, -0.16)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-3.79, -2.5, -0.82), [2] = Vector(0, 0, 0)}}

	SWEP.ACOGAxisAlign = {right = 1.4, up = 0.05, forward = 0}
	SWEP.CustomizationMenuScale = 0.012
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "Object03", rel = "", pos = Vector(-0.2, 3.394, -7.812), angle = Angle(0, 0, -90), size = Vector(0.7, 0.7, 0.7)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "Object03", rel = "", pos = Vector(0.225, 9.05, -13.633), angle = Angle(90, 0, -90), size = Vector(0.9, 0.9, 0.9)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "Cylinder16", pos = Vector(-0.09, 0.94, 0.423), angle = Angle(0, 0, -90), size = Vector(0.7, 0.7, 0.7)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Object03", pos = Vector(-0.01, -0.727, -3.539), angle = Angle(180, 0, -90), size = Vector(0.32, 0.32, 0.32)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "Object03", pos = Vector(-0.26, 3.43, -7.781), angle = Angle(0, 0, -90), size = Vector(0.7, 0.7, 0.7)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "Cylinder16", pos = Vector(0.65, -1.26, 7.003), angle = Angle(-90, 0, 0), size = Vector(0.5, 0.5, 0.5)}
	}
	
	SWEP.LaserPosAdjust = Vector(0.2, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
end

SWEP.SightBGs = {main = 1, none = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -400}, atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_acog"}},
	[2] = {header = "Barrel", offset = {-400, -400}, atts = {"md_saker"}},
	[3] = {header = "Rail", offset = {-400, 150}, atts = {"md_anpeq15"}},
	[4] = {header = "Bullet Belts", offset = {-200, 0}, atts = {"a_zsmagslmg1", "a_zsmagslmg2", "a_zsmagslmg3"}},
	[5] = {header = "Perks", offset = {400, 300}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap"}},
	["+reload"] = {header = "Ammo", offset = {700, 0}, atts = {"am_magnum2", "am_matchgrade2", "am_duplex2", "am_ricochet2", "am_tracers2", "am_luckylast2", "am_rifdepleteduranium2"}}}

	
SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_ARES_DRAW"}},

	reload = {[1] = {time = 0.36, sound = "CW_ARES_BOXOUT"},
	[2] = {time = 1.5, sound = "CW_ARES_COVERUP"},
	[3] = {time = 2.2, sound = "CW_ARES_BULLET"},
	[4] = {time = 3.0, sound = "CW_ARES_BOXIN"},
	[5] = {time = 3.7, sound = "CW_ARES_BULLET"},
	[6] = {time = 4.4, sound = "CW_ARES_COVERDOWN"}}}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "smg"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "TheRambotnic09's CW 2.0"

SWEP.Author			= "TheRambotnic09"
SWEP.Contact		= ""
SWEP.Purpose		= "To kill bad guys. Duh!"
SWEP.Instructions	= "Press your primary PEW-PEW key to kill the bad guys."

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/therambotnic09/v_mach_aresshrk.mdl"
SWEP.WorldModel		= "models/weapons/therambotnic09/w_mach_aresshrk.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/therambotnic09/w_mach_aresshrk.mdl"
SWEP.WMPos = Vector(-1, 3, 0)
SWEP.WMAng = Vector(0, 0, 180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 200
SWEP.Primary.DefaultClip	= 600
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Alyxgun"

SWEP.FireDelay = 0.069 --LOL 69 xD
SWEP.FireSound = "CW_ARES_FIRE"
SWEP.FireSoundSuppressed = "CW_AK74_RPK_FIRE_SUPPRESSED"
SWEP.Recoil = 1.2

SWEP.HipSpread = 0.075
SWEP.AimSpread = 0.008
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.010
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 54
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 1.15
SWEP.ReloadTime = 5.5
SWEP.ReloadTime_Empty = 5.5
SWEP.ReloadHalt = 5.5
SWEP.ReloadHalt_Empty = 5.5
SWEP.SnapToIdlePostReload = true