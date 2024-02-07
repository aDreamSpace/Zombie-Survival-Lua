AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

CustomizableWeaponry:registerAmmo("9x19MM", "9x19MM Rounds", 9, 40)

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "CZ75B-SP01 SHADOW"
	
	SWEP.IconLetter = "a"
	killicon.AddFont("", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = false

	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.66
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 2, y = -0.5, z = -0.25}
	
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.63
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.63
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_pist_cz75bsp01.mdl"
    SWEP.WMPos = Vector(-0.25, 0.0, -0.5)
    SWEP.WMAng = Vector(180, 190, 0)
		
	SWEP.IronsightPos = Vector(-1.83, 0, 0.393)
	SWEP.IronsightAng = Vector(1.17, 0.02, 0)
	
	SWEP.MicroT1Pos = Vector(-1.841, 0, -0.88)
	SWEP.MicroT1Ang = Vector(-0.101, -0.015, 0)

	SWEP.DocterPos = Vector(-1.85, 0, 0.05)
	SWEP.DocterAng = Vector(0.8, -0.02, 0)
	
    SWEP.RMRPos = Vector(-1.833, 0, -0.663)
    SWEP.RMRAng = Vector(0.1, 0.04, 0)

	SWEP.DeltaPointPos = Vector(-1.86, 0, -0.053)
    SWEP.DeltaPointAng = Vector(0.912, 0, 0)

	SWEP.SprintPos = Vector(2.526, -9.506, -8.24)
	SWEP.SprintAng = Vector(70, 0, 0)
	
	SWEP.PronePos = Vector(3.676, -2.179, -5.183)
	SWEP.ProneAng = Vector(3.792, 16.666, -16.285)
	
	SWEP.CustomizePos = Vector(2.046, -2.279, -2.346)
    SWEP.CustomizeAng = Vector(13.166, 14.786, 0)
	
	SWEP.ReticleInactivityPostFire = 0.24

	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.80
	SWEP.FullAimViewmodelRecoil = true
	
--	SWEP.BoltBonePositionRecoverySpeed = 25
	SWEP.OffsetBoltDuringNonEmptyReload = true
	SWEP.BoltReloadOffset = Vector(0, 0, 0)
	
	SWEP.ReloadBoltBonePositionRecoverySpeed = 20
	SWEP.ReloadBoltBonePositionMoveSpeed = 100
	SWEP.StopReloadBoneOffset = 0.8
	
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	SWEP.SightWithRail = true
	
	SWEP.FOVPerShot = 0.45

	SWEP.AttachmentModelsVM = {
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "barrel", rel = "", pos = Vector(0, -5.401, -0.82), angle = Angle(0, 0, 0), size = Vector(0.624, 0.624, 0.624)},
	    ["md_rail"] = {model = "models/cw2/attachments/pistolrail.mdl", bone = "weapon", rel = "", pos = Vector(0, -2.656, 0), angle = Angle(0, -90, 0), size = Vector(0.135, 0.14, 0.2)},
	    ["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "weapon", rel = "", pos = Vector(0.009, -3.339, 3.44), angle = Angle(0, -180, 0), size = Vector(0.375, 0.375, 0.375)},
		["md_insight_x2"] = {model = "models/cw2/attachments/pistollaser.mdl", bone = "weapon", rel = "", pos = Vector(0, -3.7, 1.4), angle = Angle(0, -90, 0), size = Vector(0.119, 0.119, 0.119)},
	    ["md_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "weapon", rel = "", pos = Vector(0.294, 1.1, -1.18), angle = Angle(0, 90, 0), size = Vector(0.787, 0.787, 0.787)},
		["md_pist_docter"] = {model = "models/attachments/2octorrds.mdl", bone = "slide", rel = "", pos = Vector(0.21, 0.5, 0.4), angle = Angle(0, 180, 0), size = Vector(0.828, 0.828, 0.828)},
	    ["md_special_pistol_sight"] = {model = "models/attachments/delta_point.mdl", bone = "slide", rel = "", pos = Vector(0.004, 0.155, 0.019), angle = Angle(0, 90, 0), size = Vector(1.009, 1.009, 1.009)},
	    ["md_special_suppressor"] = {model = "models/attachments/special_suppressor.mdl", bone = "barrel", rel = "", pos = Vector(0, -4.8, -0.62), angle = Angle(0, 0, 0), size = Vector(0.479, 0.479, 0.479)}
	}
	
	SWEP.ForegripOverridePos = {
    ["One_Hand"] = {
	["L UpperArm"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 85.851, -22.089) }}
	}	
	
	SWEP.AttachmentPosDependency = {
	["md_insight_x2"] = {["md_microt1"] = Vector(-0.188, -3.4, 1.2), ["md_rmr"] = Vector(-0.188, -3.4, 1.2)}, 
	["md_tundra9mm"] = {["bg_pist_long_barrel"] = Vector(0, -6.3, -0.818)},
	["md_special_suppressor"] = {["bg_pist_long_barrel"] = Vector(0, -5.85, -0.665)}}
	
	SWEP.LaserPosAdjust = Vector(0.5, 0, -1.5)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
	SWEP.LuaVMRecoilAxisMod = {vert = 0.25, hor = 0.5, roll = 2, forward = 0, pitch = 1}
	SWEP.BoltBonePositionRecoverySpeed = 17 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	-- SWEP.AttachmentPosDependency = {["md_insight_x2"] = {["md_microt1"] = Vector(-0.188, -5.661, 1.4)}}
	
	SWEP.LuaViewmodelRecoil = false
    SWEP.LuaViewmodelRecoilOverride = false
    SWEP.FullAimViewmodelRecoil = false
	
	SWEP.CustomizationMenuScale = 0.0065

end

SWEP.BarrelBGs = {main = 2, longris = 0, long = 1, short = 0, magpul = 0, ris = 0, regular = 0}
SWEP.MagBGs = {main = 3, regular = 0, extended = 1,}
SWEP.StockBGs = {main = 4, regular = 0, stock = 1, nostock = 0, none = 2}

SWEP.MuzzleVelocity = 520 -- in meter/s

SWEP.CanRestOnObjects = false


    SWEP.Attachments = {
       [1] = {header = "Sight", offset = {100, -850}, atts = {"md_pist_docter", "md_rmr", "md_special_pistol_sight", "md_microt1"}},
       [2] = {header = "Barrel", offset = {-1000, -300}, atts = {"md_tundra9mm", "md_special_suppressor"}},
	   [3] = {header = "Muzzle", offset = {-500, -650}, atts = {"bg_pist_long_barrel"}},
	   [4] = {header = "Rail", offset = {-1000, 200}, atts = {"md_insight_x2"}},
	   [5] = {header = "Stock", offset = {800, 600}, atts = {"bg_pist_stock"}},
       [6] = {header = "Handling", offset = {1100, -450}, atts = {"cw_one_hand_cz_75_sp01"}},
	   [7] = {header = "Magazine Upgrade", offset = {-200, 250}, atts = {"a_zsmagpistol1", "a_zsmagpistol2", "a_zsmagpistol3"}},
	   [8] = {header = "Perks", offset = {1000, 200}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
	   ["+reload"] = {header = "Ammo", offset = {-300, -200}, atts = {"am_magnum2", "am_matchgrade2", "am_duplex2", "am_ricochet2", "am_tracers2", "am_luckylast2", "am_rifdepleteduranium2"}}
    } 
	


SWEP.Animations = {reload = "reload",
	reload_empty = "reloadempty",
	fire = {"fire", "fire2", "fire3"},
	fire_dry = "firelast",
	idle = "idle",
	draw = "ready"}
	
SWEP.Sounds = {

    ready = {
    {time = 0, sound = "CW_FOLEY_LIGHT"},
    {time = 0.05, sound = "CW_CZ75_SLIDEBACK"},
    {time = 0.45, sound = "CW_CZ75_SLIDEFORWARD"}}, --CW_CZ75_SLIDEFORWARD
	
	draw = {
    {time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {
	{time = 0.32, sound = "CW_CZ75_MAGOUT"},
	{time = 0.95, sound = "CW_CZ75_MAGIN"},
	{time = 1.06, sound = "CW_CZ75_MAG_RELEASE"},
	{time = 1.45, sound = "CW_CZ75_MAGINTAP"},
	{time = 1.45, sound = "CW_CZ75_MAGINTAP2"}},
	
	reloadempty = {
	{time = 0, sound = "CW_CZ75_SLIDEBACK"},
	{time = 0.32, sound = "CW_CZ75_MAGOUT"},
	{time = 0.95, sound = "CW_CZ75_MAGIN"},
	{time = 1.06, sound = "CW_CZ75_MAG_RELEASE"},
	{time = 1.45, sound = "CW_CZ75_MAGINTAP"},
	{time = 1.45, sound = "CW_CZ75_MAGINTAP2"},
	{time = 1.79, sound = "CW_CZ75_SLIDEFORWARD"}}
}

SWEP.SpeedDec = 5

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "[CW2.0] Yan's Guns"

SWEP.Author			= "Xxyan700xX"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_pist_cz75bsp01.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_cz75bsp01.mdl"
SWEP.ADSFireAnim = true

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 17
SWEP.Primary.DefaultClip	= 80
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Pistol"

SWEP.FireDelay = 0.21
SWEP.FireSound = "CW_CZ75_FIRE"
SWEP.FireSoundSuppressed = "CW_CZ75_FIRE_SUPPRESSED"
SWEP.Recoil = 0.82

SWEP.HipSpread = 0.012
SWEP.AimSpread = 0.008
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = 0.042
SWEP.SpreadPerShot = 0.025
SWEP.SpreadCooldown = 0.16
SWEP.Shots = 1
SWEP.Damage = 55
SWEP.DeployTime = 0.6
--SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.3
SWEP.ReloadHalt = 2.3

SWEP.ReloadTime_Empty = 2.3
SWEP.ReloadHalt_Empty = 2.3

SWEP.SnapToIdlePostReload = true