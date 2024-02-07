AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

CustomizableWeaponry:registerAmmo("9x19MM", "9x19MM Rounds", 9, 19)

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Calico M950"
	
	SWEP.IconLetter = "a"
	killicon.AddFont("", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_PISTOL"
	SWEP.PosBasedMuz = true

	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.8
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 1, z = -9}

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/tfa_l4d2/w_calico.mdl"
	SWEP.WMPos = Vector(-1, 7, 3.6)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.IronsightPos = Vector(-6.455, 0, 1.179)
	SWEP.IronsightAng = Vector(0.975, -0.6, -1.701)

	SWEP.MicroT1Pos = Vector(-2.135, 0, -0.237)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.SprintPos = Vector(2.526, -9.506, -8.24)
	SWEP.SprintAng = Vector(30, 0, 0)
	
	SWEP.CustomizePos = Vector(5.848, -3.968, -4.751)
	SWEP.CustomizeAng = Vector(16.186, 26.364, 0)

	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.9
	SWEP.FullAimViewmodelRecoil = true
	--SWEP.BoltBone = "TomGroup_2"
	--SWEP.BoltShootOffset = Vector(-0.7, 0, 0)
	--SWEP.BoltBonePositionRecoverySpeed = 25
	--SWEP.StopReloadBoneOffset = 0.8
	--SWEP.HoldBoltWhileEmpty = false
	--SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	SWEP.SightWithRail = false
	SWEP.FOVPerShot = 0.3

	SWEP.AttachmentModelsVM = {
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "f_frame", rel = "", pos = Vector(0, -3.54, 16.711), angle = Angle(0, 0, 90), size = Vector(1.077, 1.077, 1.077)},
	    ["md_special_pistol_sight"] = {model = "models/attachments/delta_point.mdl", bone = "f_frame", rel = "", pos = Vector(0, -3.54, 16.711), angle = Angle(0, 0, 90), size = Vector(1.077, 1.077, 1.077)},
	    ["md_special_suppressor"] = {model = "models/attachments/special_suppressor.mdl", bone = "f_frame", rel = "", pos = Vector(0, -1.15, 15.906), angle = Angle(0, 180, 90), size = Vector(0.85, 0.85, 0.85)},
	    ["md_insight_x2"] = {model = "models/cw2/attachments/pistollaser.mdl", bone = "f_frame", rel = "", pos = Vector(-0.551, -2.161, 7), angle = Angle(-90, 180, -180), size = Vector(0.184, 0.184, 0.184)}
		--["md_rail"] = {model = "models/cw2/attachments/pistolrail.mdl", bone = "wpn_body", pos = Vector(-0.173, -4.663, 0.777), angle = Angle(0, -90, 0), size = Vector(0.15, 0.15, 0.15)},
		--["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "wpn_body", pos = Vector(-0.179, -5.311, 3.41), angle = Angle(0, 0, 0), size = Vector(0.37, 0.37, 0.37)},
	}
	
	SWEP.AttachmentPosDependency = {
	["md_tundra9mm"] = {["bg_carbine_barrel"] = Vector(0, -3.55, 24)},
	["md_special_suppressor"] = {["bg_carbine_barrel"] = Vector(0, -1.2, 23)}}
	
	SWEP.LaserPosAdjust = Vector(0.5, 0, -1)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
	SWEP.LuaVMRecoilAxisMod = {vert = 0.25, hor = 0.5, roll = 2, forward = 0, pitch = 1}
	SWEP.CustomizationMenuScale = 0.025
	SWEP.BoltBonePositionRecoverySpeed = 17 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
			
end

SWEP.MuzzleVelocity = 450 -- in meter/s

SWEP.BarrelBGs = {main = 4, longris = 0, long = 1, short = 0, magpul = 0, ris = 0, regular = 0}
SWEP.StockBGs = {main = 5, regular = 0, stock = 1, nostock = 0, none = 2}

SWEP.LuaViewmodelRecoilOverride = false
SWEP.CanRestOnObjects = false



    SWEP.Attachments = {
       [1] = {header = "Barrel", offset = {-700, -300}, atts = {"md_tundra9mm", "md_special_suppressor"}},
       [2] = {header = "Muzzle", offset = {-300, -550}, atts = {"bg_carbine_barrel"}},
       [3] = {header = "Rail", offset = {-400, 200}, atts = {"md_insight_x2"}},
	   [4] = {header = "Stock", offset = {200, -500}, atts = {"bg_pist_stock"}},
	   [5] = {header = "Magazine Upgrade", offset = {-200, 50}, atts = {"a_zsmagpistol1", "a_zsmagpistol2", "a_zsmagpistol3"}},
	   [6] = {header = "Perks", offset = {600, -200}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
	   ["+reload"] = {header = "Ammo", offset = {700, 240}, atts = {"am_magnum2", "am_matchgrade2", "am_duplex2", "am_ricochet2", "am_tracers2", "am_luckylast2", "am_rifdepleteduranium2"}}}

	

SWEP.Animations = {reload = "reload",
	fire = {"fire1"},
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {{time = 0.05, sound = "CLOTH2"},
	{time = 0.15, sound = "CW_CALICO_MAGOUT"},
	{time = 0.8, sound = "CW_CALICO_MAGIN"},
	{time = 1.3, sound = "CLOTH1"},
	{time = 1.4, sound = "CW_CALICO_SLIDERELEASE"},
	{time = 1.6, sound = "CW_CALICO_SLIDEBACK"}}
}

SWEP.SpeedDec = 5

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "[CW2.0] Yan's Guns"

SWEP.Author			= "Xxyan700xX"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/tfa_l4d2/c_tfa_calico.mdl"
SWEP.WorldModel		= "models/weapons/tfa_l4d2/w_calico.mdl"
SWEP.UseHands       = true

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 50
SWEP.Primary.DefaultClip	= 200
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Pistol"

SWEP.FireDelay = 0.1
SWEP.FireSound = "CW_CALICO_FIRE"
SWEP.FireSoundSuppressed = "CW_CALICO_FIRE_SUPPRESSED"
SWEP.Recoil = 0.6

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 1.2
SWEP.MaxSpreadInc = 0.08
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 90
SWEP.DeployTime = 0.4
--SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1
SWEP.ReloadHalt = 1.4

SWEP.ReloadTime_Empty = 1
SWEP.ReloadHalt_Empty = 2.1

SWEP.SnapToIdlePostReload = true