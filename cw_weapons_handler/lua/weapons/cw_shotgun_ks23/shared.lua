AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "KS-23"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "k"
	killicon.AddFont("cw_ump45", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_m3"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.Shell = "shotshell"
	SWEP.ShellDelay = 0.3
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/world/shotguns/ks23.mdl"
	SWEP.WMPos = Vector(-1, 1.5, 0)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 1
	
	SWEP.SightWithRail = true
		
	SWEP.IronsightPos = Vector(-1.902, -4.151, 1.235)
	SWEP.IronsightAng = Vector(0.685, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-2.618, -4.803, 0.25)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	

	SWEP.EoTechPos = Vector(-2.613, -4.803, -0.06)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-2.613, -4.803, 0.064)
	SWEP.AimpointAng = Vector(0, 0, 0)
			
	SWEP.ACOGPos = Vector(-2.599, -4.803, -0.109)
	SWEP.ACOGAng = Vector(0, 0, 0)
	
		
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.593, -4.803, -1.12), [2] = Vector(0, 0, 0)}}

	SWEP.SightWithRail = true
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	

	

	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "Spas_Body", pos = Vector(-2.589, -4.256, 6.44), angle = Angle(0, 0, 180), size = Vector(1, 1, 1)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "Spas_Body", pos = Vector(-2.053, 0.184, 12.067), angle = Angle(-3.333, 90, 180), size = Vector(1, 1, 1)},
		["md_rail"] = {model = "models/wystan/attachments/rail.mdl", bone = "Spas_Body", pos = Vector(-2.064, -11.19, 2.654), angle = Angle(0, -90, 180), size = Vector(0.6, 1.1, 1)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Spas_Body", pos = Vector(-2.32, -9.9, 0.635), angle = Angle(0, -180, -180), size = Vector(0.4, 0.4, 0.4), adjustment = {min = -11, max = -9.9, inverse = true, axis = "y"}},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "Spas_Body", pos = Vector(-2.646, -4.941, 5.907), angle = Angle(0, 0, 180), size = Vector(0.899, 0.899, 0.899)}
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	
	SWEP.LaserPosAdjust = Vector(0.8, 0, 0.3)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.ADSFireAnim = true

SWEP.Attachments = {
	
	[1] = {header = "Perks", offset = {100, -100}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
	[2] = {header = "Drum Magazines", offset = {-400, -250}, atts = {"a_zsmagshotgun1", "a_zsmagshotgun2", "a_zsmagshotgun3"}},
	["+reload"] = {header = "Ammo", offset = {-200, 300}, atts = {"am_flechetterounds2", "am_slugrounds2", "am_shrapnel2", "am_minishells2", "am_sabots2", "am_dragonsbreath2", "am_explosive2", "am_kristallnacht2"}}}

SWEP.Animations = {fire = {"pump"},
	reload_start = "start",
	reload_start_empty = "start_empty",
	insert = "insert",
	reload_end = "end_nomen",
	idle = "end_nopump",
	draw = "draw"}
	
SWEP.Sounds = {draw = {[1] = {time = 0, sound = "CW_FOLEY_MEDIUM"}},

pump = {[1] = {time = 0.15, sound = "FAS2_KS23.PumpBack"},
[2] = {time = 0.35, sound = "FAS2_KS23.PumpForward"}},

idle = {[1] = {time = 0.15, sound = "FAS2_KS23.PumpBack"},
[2] = {time = 0.35, sound = "FAS2_KS23.PumpForward"}},

end_nomen = {[1] = {time = 0.15, sound = "FAS2_KS23.PumpBack"},
[2] = {time = 0.35, sound = "FAS2_KS23.PumpForward"}},

insert = {[1] = {time = 0.25, sound = "FAS2_KS23.Insert"},
[2] = {time = 0.5, sound = "CW_FOLEY_MEDIUM"}}
}




SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "shotgun"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"pump"}
SWEP.Base = "cw_base"
SWEP.Category = "cw_ks23"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/view/shotguns/ks23.mdl"
SWEP.WorldModel		= "models/weapons/world/shotguns/ks23.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 4
SWEP.Primary.DefaultClip	= 12
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Buckshot"

SWEP.FireDelay = 0.8
SWEP.FireSound = "CW_M3SUPER90_FIRE"
SWEP.Recoil = 3

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.002
SWEP.MaxSpreadInc = 0.055
SWEP.VelocitySensitivity = 1.5
SWEP.ClumpSpread = 0.050
SWEP.SpreadPerShot = 0.03
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 20
SWEP.Damage = 60
SWEP.DeployTime = 1


SWEP.ReloadStartTime = 0.7
SWEP.InsertShellTime = 0.7
SWEP.ReloadFinishWait = 0.7
SWEP.ShotgunReload = true
SWEP.ReloadHalt = 40
SWEP.ReloadHalt_Empty = 40

SWEP.Chamberable = false