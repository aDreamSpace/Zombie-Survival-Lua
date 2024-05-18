AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Pancor Jackhammer"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "q"
	killicon.AddFont("cw_jack", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("vgui/hud/jack")
	
	SWEP.MuzzleEffect = "muzzleflash_m3"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.Shell = nil
	SWEP.ShellDelay = 0.3
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_pancor_jackhammer.mdl"
	SWEP.WMPos = Vector(1, 0, -1)
	SWEP.WMAng = Vector(-10, 0, 180)
	SWEP.Shell = "shotshell"
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 1
	
	SWEP.ReticleInactivityPostFire = 1.0
	
	SWEP.SightWithRail = true
		
	SWEP.IronsightPos = Vector(4.026, -2.296, 0.917)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.FrontRearPos = Vector(-4.841, -6.052, 1.159)
    SWEP.FrontRearAng = Vector(0, 0.101, 0)
	
	SWEP.MicroT1Pos = Vector(-4.801, -5.904, 1.24)
    SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(4, 0, -0.721)
    SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.CoD4TascoPos = Vector(4.059, -3.58, -0.24)
    SWEP.CoD4TascoAng = Vector(1.636, 0, 0)
	
	SWEP.CoD4ReflexPos = Vector(4.039, -3.073, -0.32)
    SWEP.CoD4ReflexAng = Vector(0.689, 0, 0)
	
	SWEP.AimpointPos = Vector(3.98, -3.468, -0.461)
    SWEP.AimpointAng = Vector(1.116, -0.62, 0)
			
	SWEP.ACOGPos = Vector(4, -2.985, -0.7)
    SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(-3.116, -3.935, 0.492)
    SWEP.SprintAng = Vector(-19.894, -47.624, 10.902)
	
	SWEP.CustomizePos = Vector(0, 0, 0)
	SWEP.CustomizeAng = Vector(16.954, 0, 0)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(3.98, -2.985, -1.683), [2] = Vector(0, 0, 0)}}

	SWEP.SightWithRail = true
	SWEP.ACOGAxisAlign = {right = 0, up = 91.8, forward = 0}
	SWEP.CSGO556AxisAlign = {right = 0, up = 0, forward = 50.5}
	
	SWEP.AlternativePos = Vector(-0.64, 0.294, -0.978)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.CustomizationMenuScale = 0.016
	SWEP.ReticleInactivityPostFire = 0.6

	SWEP.AttachmentModelsVM = { 
	["md_rail"] = {model = "models/wystan/attachments/rail.mdl", bone = "SMDImport", rel = "", pos = Vector(0.82, 11.411, 5.144), angle = Angle(178.852, 88.135, 0), size = Vector(1.052, 0.898, 1.355)},
	["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "SMDImport", rel = "", pos = Vector(0.421, -0.069, 13.77), angle = Angle(-178.433, 89.644, 0), size = Vector(1.018, 1.018, 1.018)},
    ["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "SMDImport", rel = "", pos = Vector(0.8, 6.298, 7.176), angle = Angle(-178.618, -1.068, 1.6), size = Vector(0.82, 0.82, 0.82)},
    ["md_cod4_reflex"] = {model = "models/v_cod4_reflex.mdl", bone = "SMDImport", rel = "", pos = Vector(0.699, 7.316, 4.907), angle = Angle(-179.079, -91.526, -0.703), size = Vector(0.699, 0.699, 0.699)},
    ["md_cod4_aimpoint_v2"] = { type = "Model", model = "models/v_cod4_aimpoint.mdl", bone = "SMDImport", rel = "", pos = Vector(0.796, 7.275, 5.42), angle = Angle(-179, -92.238, 0), size = Vector(0.857, 0.857, 0.857), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }

}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	
	SWEP.LaserPosAdjust = Vector(0.8, 0, 0.3)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = true
SWEP.ADSFireAnim = false

SWEP.Attachments = { [1] = {header = "Sight", offset = {100, -300}, atts = {"md_eotech", "md_aimpoint"}},
[2] = {header = "Drum Magazines", offset = {300, 250}, atts = {"a_zsmagshotgun1", "a_zsmagshotgun2", "a_zsmagshotgun3"}},
	 [3] = {header = "Perks", offset = {-900, 300}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
	["+reload"] = {header = "Ammo", offset = {-900, 0}, atts = {"am_flechetterounds2", "am_slugrounds2", "am_shrapnel2", "am_minishells2", "am_sabots2", "am_dragonsbreath2", "am_explosive2", "am_kristallnacht2"}}
}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload= "reload",
	draw = "draw"}
	
SWEP.Sounds = { draw = {{time = 0.1, sound = "CW_JACK_DRAW"}},

reload = {[1] = {time = 1, sound = "CW_JACK_CLIPOUT"},
	[2] = {time = 1.8, sound = "CW_JACK_MAGIN"},
	[3] = {time = 2.4, sound = "CW_JACK_CLOTH"}}}

SWEP.SpeedDec = 15

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto","semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 Shotgun Pack"

SWEP.Author			= "Shot"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/shotgun/v_jackhammer2.mdl"
SWEP.WorldModel		= "models/weapons/w_pancor_jackhammer.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Buckshot"

SWEP.FireDelay = 0.250
SWEP.FireSound = "CW_JACK_FIRE"
SWEP.FireSoundSuppressed = "CW_SHOTGUN_FIRESIL"
SWEP.Recoil = 2

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.9
SWEP.MaxSpreadInc = 0.06
SWEP.ClumpSpread = 0.020
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.8
SWEP.Shots = 12
SWEP.Damage = 50
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 2.5
SWEP.ReloadTime = 1.5
SWEP.ReloadTime_Empty = 2
SWEP.ReloadHalt = 2
SWEP.ReloadHalt_Empty = 2
SWEP.SnapToIdlePostReload = true
SWEP.Chamberable = false