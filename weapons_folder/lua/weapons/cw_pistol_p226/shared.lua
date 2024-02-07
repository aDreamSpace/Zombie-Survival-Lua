AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "P226 (Ghosts)"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "f"
	killicon.AddFont("cw_deagle", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = true

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/cw2/weapons/w_ghosts_p226.mdl"
	SWEP.WMPos = Vector(-0.5, -0.5, -1.0)
	SWEP.WMAng = Vector(-4, 0, -180)
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.6
	SWEP.ShellOffsetMul = 0
	SWEP.ShellPosOffset = {x = 0, y = 0, z = -1}
		
	SWEP.DocterPos = Vector(2.466, -5.068, 0.291)
	SWEP.DocterAng = Vector(0, 0, 0)

	SWEP.IronsightPos = Vector(2.463, -2.495, 0.62)
	SWEP.IronsightAng = Vector(-0.285, 0, 0)
	
	SWEP.SprintPos = Vector(-0.603, 0.402, 2.009)
	SWEP.SprintAng = Vector(-26.734, -2.814, 6.5)

	SWEP.PronePos = Vector(-0.708, -7.081, -0.112)
	SWEP.ProneAng = Vector(-20.098, -39.134, 9.512)

	SWEP.CustomizePos = Vector(-5.557, -3.441, -1.877)
	SWEP.CustomizeAng = Vector(14.769, -29.254, -2.878)
	
	SWEP.AlternativePos = Vector(-0.88, 1.325, -0.561)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.241, -4.728, -1.568), [2] = Vector(0, 0, 0)}}
	
	SWEP.KAP40BoneMod = {
		["Bone_L_UpperArm01"] = { scale = Vec1, pos = Vec0, angle = Angle(0, 0, 0) }
	}
	
	SWEP.MoveType = 2
	SWEP.ViewModelMovementScale = 1.2
	SWEP.FullAimViewmodelRecoil = true
	SWEP.BoltBone = "Slide"
	SWEP.BoltShootOffset = Vector(0, 1.5, 0)
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = false
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1.5, roll = 12, forward = 10, pitch = 12}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.BoltBonePositionRecoverySpeed = 25 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.AttachmentModelsVM = {
		["md_docter"] = {model = "models/wystan/attachments/2octorrds.mdl", bone = "slide", rel = "", pos = Vector(0.231, -0.007, 0.657), angle = Angle(0, 180, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_lasersight"] = {model = "models/rageattachments/pistoltribeam.mdl", bone = "gun", rel = "", pos = Vector(-0.033, -2.211, -0.692), angle = Angle(0, 90, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_csgo_silencer_rifle"] = {model = "models/kali/weapons/csgo/eq_suppressor_rifle.mdl", bone = "gun", rel = "", pos = Vector(0.02, -5.281, 1.11), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5)}
	}
			
	SWEP.LaserPosAdjust = Vector(1.9, 15, -2)
	SWEP.LaserAngAdjust = Angle(0, 0, 0) 
end

SWEP.BarrelBGs = {main = 1, regular = 0, compensator = 1, extended = 2}
SWEP.LuaViewmodelRecoil = true
SWEP.CanRestOnObjects = false
SWEP.ZoomAmount = 5

SWEP.Attachments = {[1] = {header = "Sight", offset = {450, -350}, atts = {"md_docter"}},
[2] = {header = "Barrel", offset = {-400, -350}, atts = {"md_csgo_silencer_rifle"}},
[3] = {header = "Magazine Upgrade", offset = {-400, 350}, atts = {"a_zsmagpistol1", "a_zsmagpistol2", "a_zsmagpistol3"}},
 [4] = {header = "Perks", offset = {100, 300}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
["+reload"] = {header = "Ammo", offset = {-650, 0}, atts = {"am_magnum2", "am_matchgrade2", "am_duplex2", "am_ricochet2", "am_tracers2", "am_luckylast2", "am_rifdepleteduranium2"}}}

SWEP.Animations = {fire = {"shoot1"},
	reload = "reload",
	reload_empty = "reload_empty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {[1] = {time = 0, sound = "CW_FOLEY_LIGHT"},
	[2] = {time = 0.43, sound = "CW_GHOSTS_P226_SLIDE"}},

	reload = {[1] = {time = 0.4, sound = "CW_GHOSTS_P226_MAGOUT"},
	[2] = {time = 1.18, sound = "CW_GHOSTS_P226_MAGIN"}},

	reload_empty = {[1] = {time = 0.4, sound = "CW_GHOSTS_P226_MAGOUT"},
	[2] = {time = 1.18, sound = "CW_GHOSTS_P226_MAGIN"},
	[3] = {time = 1.79, sound = "CW_GHOSTS_P226_SLIDEBACK"},
	[4] = {time = 2.02, sound = "CW_GHOSTS_P226_SLIDE"}}}

SWEP.SpeedDec = 10

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 Rinic's Pack"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 54
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/cw2/weapons/v_ghosts_p226.mdl"
SWEP.WorldModel		= "models/cw2/weapons/w_ghosts_p226.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 14
SWEP.Primary.DefaultClip	= 56
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Pistol"

SWEP.FireDelay = 0.0851063829787234
SWEP.FireSound = "CW_GHOSTS_P226_FIRE"
SWEP.FireSoundSuppressed = "CW_GHOSTS_P226_FIRE_SUPPRESSED"
SWEP.Recoil = 0.4

SWEP.HipSpread = 0.055
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.2
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.32
SWEP.Shots = 1
SWEP.Damage = 34
SWEP.DeployTime = 0.5
SWEP.Chamberable = true

SWEP.ReloadSpeed = 1.3
SWEP.ReloadTime = 1.6
SWEP.ReloadHalt = 1.75

SWEP.ReloadTime_Empty = 1.95
SWEP.ReloadHalt_Empty = 2
SWEP.SnapToIdlePostReload = false

function SWEP:IndividualThink()
		self.Animations.draw = "draw_norm"
			if self.Animations.draw == "draw_norm" then
		self.DeployTime = 0.3
	end
end