if CustomizableWeaponry then

SWEP.magType = "pistolMag"

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "FN Five-seveN"
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
	
	SWEP.DocterPos = Vector(2.61, -2.757, 1.204)
	SWEP.DocterAng = Vector(0, 0, 0)

	SWEP.IronsightPos = Vector(2.608, -2.757, 1.394)
	SWEP.IronsightAng = Vector(1.263, 0, 0)
	
	SWEP.ACOGPos = Vector(-2.247, -6.5, -0.602)
	SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.634, -8.28, -8.311)
	SWEP.SprintAng = Vector(70, 0, 0)
	
	SWEP.AlternativePos = Vector(1, 0.8, 0.4)
	SWEP.AlternativeAng = Vector(0, 0, 0)

--	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.241, -4.728, -1.568), [2] = Vector(0, 0, 0)}}
	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = false
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1.5, roll = 3, forward = 1, pitch = 4}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.BoltBonePositionRecoverySpeed = 25 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	SWEP.AttachmentModelsVM = {
		["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "frame", rel = "", pos = Vector(-3, 0, 0.2), angle = Angle(0, 0, 90), size = Vector(0.349, 0.349, 0.349)},
		["md_docter"] = { type = "Model", model = "models/wystan/attachments/2octorrds.mdl", bone = "slide", rel = "", pos = Vector(-0.2, 0.284, -0.08), angle = Angle(90, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_csgo_silencer_pistol"] = { type = "Model", model = "models/kali/weapons/csgo/eq_suppressor_pistol.mdl", bone = "frame", rel = "", pos = Vector(5.26, -6.26, 0.159), angle = Angle(180, 0, 90), size = Vector(1, 1, 1)},
		["md_csgo_taclight"] = { type = "Model", model = "models/kali/weapons/csgo/eq_taclight_pistol.mdl", bone = "frame", rel = "", pos = Vector(4.36, 4.5, 0.15), angle = Angle(180, 0, -90), size = Vector(1, 1, 1)},
	}
	
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.BoltBone = "slide"
	SWEP.BoltShootOffset = Vector(-1.25, 0, 0)

	SWEP.LaserPosAdjust = Vector(-0.2, 0, 0)--{x = 1, y = 0, z = 0}
	SWEP.LaserAngAdjust = Angle(0, 180, 0) --{p = 2, y = 180, r = 0}
	
end

SWEP.BarrelBGs = {main = 1, regular = 0, compensator = 1, extended = 2}
SWEP.LuaViewmodelRecoil = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Sight", offset = {0, -500}, atts = {"md_docter"}},
[2] = {header = "Barrel extension", offset = {-700, -500}, atts = {"md_csgo_silencer_pistol"}},
[3] = {header = "Rail", offset = {-700, -100}, atts = {"md_anpeq15", "md_csgo_taclight"}},
["+reload"] = {header = "Ammo", offset = {400, -100}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot", "shoot2"},
	fireDry = "shoot_last",
	reload = "reload",
	reload_empty = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {reload = {[1] = {time = 0.1, sound = "CW_FIVESEVEN_MAGPOUCH"},
	[2] = {time = 0.6, sound = "CW_FIVESEVEN_MAGOUT"},
	[3] = {time = 1.8, sound = "CW_FIVESEVEN_MAGIN"},
	[4] = {time = 2.0, sound = "CW_FIVESEVEN_MAGTAP"},
	[5] = {time = 2.5, sound = "CW_FIVESEVEN_SLIDERELEASE"}},
	shoot_last = {[1] = {time = 0.1, sound = "CW_FIVESEVEN_SLIDEBACK"}},
	draw = {{time = 0.01, sound = "CW_XM8_CLOTH"},
	{time = 0.6, sound = "CW_FIVESEVEN_SAFETY"}}}

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
SWEP.ViewModel		= "models/weapons/v_cstm_fiveseven.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_fiveseven.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "FN 5.7x28MM"

SWEP.FireDelay = 0.12
SWEP.FireSound = "CW_FIVESEVEN_FIRE"
SWEP.FireSoundSuppressed = "CW_FIVESEVEN_FIRE_SUPPRESSED"
SWEP.Recoil = 0.78

SWEP.HipSpread = 0.022
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 1.2
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.32
SWEP.Shots = 1
SWEP.Damage = 20
SWEP.DeployTime = 1
SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3
SWEP.ReloadHalt = 3
SWEP.ReloadTime_Empty = 3
SWEP.ReloadHalt_Empty = 3
SWEP.SnapToIdlePostReload = true

end