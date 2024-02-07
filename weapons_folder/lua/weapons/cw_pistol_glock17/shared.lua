if CustomizableWeaponry then

SWEP.magType = "pistolMag"

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Glock 17"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "f"
	killicon.AddFont("cw_deagle", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = true
	
	SWEP.DryFire = true
	
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 1
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 2, y = 0, z = 1}
	
	SWEP.CustomizePos = Vector(-3.8, -3.6, -2.8)
	SWEP.CustomizeAng = Vector(16.6, -28.4, -2.6)

	SWEP.MicroT1Pos = Vector(-2.115, -2.8, 0.04)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.EoTechPos = Vector(-2.08, -2.8, 0.13)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.DocterPos = Vector(2, -4.046, 0.639)
	SWEP.DocterAng = Vector(0, 0, 0)

	SWEP.IronsightPos = Vector(2, -4.046, 1.095)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.ACOGPos = Vector(-2.247, -6.5, -0.602)
	SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.634, -8.28, -8.311)
	SWEP.SprintAng = Vector(70, 0, 0)
	
	SWEP.AlternativePos = Vector(-0.88, 1.325, -0.561)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.241, -4.728, -1.568), [2] = Vector(0, 0, 0)}}
	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = false
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1.5, roll = 3, forward = 1, pitch = 4}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.BoltBonePositionRecoverySpeed = 25 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.AttachmentModelsVM = {
		["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "Glock18", rel = "", pos = Vector(0, -2.241, 0.899), angle = Angle(0, -90, 180), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255)},
		["md_docter"] = { type = "Model", model = "models/wystan/attachments/2octorrds.mdl", bone = "Glock18 Slide", rel = "", pos = Vector(0.246, 10.06, 0.426), angle = Angle(0, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_tundra9mm"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "Glock18 Barrel", rel = "", pos = Vector(0, -6.35, 0.779), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255)},		["md_csgo_taclight"] = { type = "Model", model = "models/kali/weapons/csgo/eq_taclight_pistol.mdl", bone = "gun", rel = "", pos = Vector(0.039, 4.3, -2.76), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255)},
		["md_csgo_silencer_pistol"] = { type = "Model", model = "models/kali/weapons/csgo/eq_suppressor_pistol.mdl", bone = "Glock18 Barrel", rel = "", pos = Vector(0, 6.329, -3.901), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255)},	
		["md_csgo_taclight"] = { type = "Model", model = "models/kali/weapons/csgo/eq_taclight_pistol.mdl", bone = "Glock18", rel = "", pos = Vector(0, 4.38, -3.12), angle = Angle(0, 90, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255)},
	}
	
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.BoltBone = "Glock18 Slide"
	SWEP.BoltShootOffset = Vector(-1.25, 0, 0)
	
	SWEP.LaserPosAdjust = Vector(0.2, 0, 0)--{x = 1, y = 0, z = 0}
	SWEP.LaserAngAdjust = Angle(0, 180, 0) --{p = 2, y = 180, r = 0}
	
end

SWEP.BarrelBGs = {main = 1, regular = 0, compensator = 1, extended = 2}
SWEP.LuaViewmodelRecoil = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Sight", offset = {400, -550}, atts = {"md_docter"}},
[2] = {header = "Barrel extension", offset = {-600, -350}, atts = {"md_tundra9mm", "md_csgo_silencer_pistol"}},
[3] = {header = "Rail", offset = {-300, 200}, atts = {"md_anpeq15", "md_csgo_taclight"}},
["+reload"] = {header = "Ammo", offset = {400, -100}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = "shoot_1",
	fireDry = "shoot_last",
	reload = "glock_reload",
	reload_empty = "glock_reload",
	idle = "glock_idle",
	draw = "glock_draw"}
	
SWEP.Sounds = {glock_reload = {[1] = {time = 0.4, sound = "CW_GLOCK17_MAGOUT"},
	[2] = {time = 1.5, sound = "CW_GLOCK17_MAGIN"},
	[3] = {time = 2.1, sound = "CW_GLOCK17_SLIDE"}},
	
	glock_draw = {[1] = {time = 0.1, sound = "CW_GLOCK17_DRAW"}}}

SWEP.SpeedDec = 10

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - UECW"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/v_pist_glock17.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_glock18.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 17
SWEP.Primary.DefaultClip	= 17
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 0.075
SWEP.FireSound = "CW_GLOCK17_FIRE"
SWEP.FireSoundSuppressed = "CW_GLOCK17_FIRE_SUPPRESSED"
SWEP.Recoil = 0.75

SWEP.HipSpread = 0.020
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 1.2
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.32
SWEP.Shots = 1
SWEP.Damage = 16
SWEP.DeployTime = 1
SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3
SWEP.ReloadHalt = 3
SWEP.ReloadTime_Empty = 3
SWEP.ReloadHalt_Empty = 3
SWEP.SnapToIdlePostReload = true

end