AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Rinic Custom's 'P99'"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "f"
	killicon.AddFont("cw_deagle", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = true

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/cw2/weapons/w_james_p99.mdl"
	SWEP.WMPos = Vector(-1.168, 0.2, -1.0)
	SWEP.WMAng = Vector(-4.452, 0, -171.924)
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.5
	SWEP.ShellOffsetMul = 0
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
		
	SWEP.DocterPos = Vector(-2.738, -4.18, 0.379)
	SWEP.DocterAng = Vector(0, 0, 0)

	SWEP.IronsightPos = Vector(-2.195, -2.651, 0.522)


	SWEP.IronsightAng = Vector(1.674, -0.643, 0)
	
	SWEP.SprintPos = Vector(-0.603, 0.402, 2.009)
	SWEP.SprintAng = Vector(-26.734, -2.814, 6.5)

	SWEP.PronePos = Vector(-0.633, -6.593, -2.26)
	SWEP.ProneAng = Vector(11.078, 1.549, 0.757)

	SWEP.CustomizePos = Vector(3.233, -2.264, -0.789)
    	SWEP.CustomizeAng = Vector(12.31, 32.655, 3.729)
	
	SWEP.AlternativePos = Vector(-0.88, 1.325, -0.561)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.241, -4.728, -1.568), [2] = Vector(0, 0, 0)}}
	
	SWEP.MoveType = 2
	SWEP.ViewModelMovementScale = 1.2
	SWEP.FullAimViewmodelRecoil = false
	SWEP.BoltBone = "bolt"
	SWEP.BoltShootOffset = Vector(0, -1.2, 0)
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1.5, roll = 0, forward = 15, pitch = 20}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.BoltBonePositionRecoverySpeed = 25 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.AttachmentModelsVM = {
		["md_docter"] = {model = "models/wystan/attachments/2octorrds.mdl", bone = "Slide", rel = "", pos = Vector(0.263, -0.438, 0.261), angle = Angle(0, 180, 0), size = Vector(1, 1, 1)},
		["md_lasersight"] = {model = "models/rageattachments/pistoltribeam.mdl", bone = "wpn_body", rel = "", pos = Vector(-0.215, -7.281, 0.331), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_csgo_silencer_rifle"] = {model = "models/kali/weapons/csgo/eq_suppressor_rifle.mdl", bone = "wpn_body", rel = "", pos = Vector(-0.244, -9.917, 2.131), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5)}
	}

	SWEP.LaserPosAdjust = Vector(1, 5, -2)
	SWEP.LaserAngAdjust = Angle(0.5, 0.5, 0) 
end

SWEP.BarrelBGs = {main = 1, regular = 0, compensator = 1, extended = 2}
SWEP.LuaViewmodelRecoil = false
SWEP.ADSFireAnim = true
SWEP.CanRestOnObjects = false
SWEP.ZoomAmount = 5

SWEP.Attachments = {[1] = {header = "Laser", offset = {450, -350}, atts = {"md_lasersight"}},
[2] = {header = "Barrel", offset = {-400, -350}, atts = {"md_csgo_silencer_rifle"}},
["+attack2"] = {header = "Perks", offset = {-400, 200}, atts = {"pk_sleightofhand", "pk_light"}},
["+reload"] = {header = "Ammo", offset = {650, 0}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1"},
	reload = "reload",
	reload_empty = "reload_empty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {[1] = {time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {[1] = {time = 0.41, sound = "CW_JAMES_P99_MAGOUT"},
	[2] = {time = 0.97, sound = "CW_JAMES_P99_MAGIN"}},

	reload_empty = {[1] = {time = 0.41, sound = "CW_JAMES_P99_MAGOUT"},
	[2] = {time = 0.97, sound = "CW_JAMES_P99_MAGIN"},
	[3] = {time = 1.89, sound = "CW_JAMES_P99_SLIDEBACK"},
	[4] = {time = 1.97, sound = "CW_JAMES_P99_SLIDEFORWARD"}}}

SWEP.SpeedDec = 10

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 Rinic's Pack"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/weapons/v_james_p99.mdl"
SWEP.WorldModel		= "models/cw2/weapons/w_james_p99.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 15
SWEP.Primary.DefaultClip	= 45
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_JAMES_P99_FIRE"
SWEP.FireSoundSuppressed = "CW_JAMES_P99_FIRE_SUPPRESSED"
SWEP.Recoil = 0.35

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.002
SWEP.VelocitySensitivity = 1.2
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.32
SWEP.Shots = 1
SWEP.Damage = 27
SWEP.DeployTime = 0.5
SWEP.Chamberable = true

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.25
SWEP.ReloadHalt = 1.35
SWEP.ReloadTime_Empty = 2.15
SWEP.ReloadHalt_Empty = 2.25
SWEP.SnapToIdlePostReload = false