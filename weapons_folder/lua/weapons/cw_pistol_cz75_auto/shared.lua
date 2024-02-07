AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

CustomizableWeaponry:registerAmmo("9x21", "9x21 Rounds", 9, 21)

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "CZ-75 Auto"
	
	SWEP.IconLetter = "a"
	killicon.AddFont("", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = true
	SWEP.MuzzlePosMod = {x = 0, y = 0, z = 1}

--	SWEP.ShellScale = 0.7
--	SWEP.ShellPosOffset = {x = 0, y = -1, z = -1}

	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.6
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 2.5, y = 0.6, z = -0.1}
	
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.72
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.72
	
	SWEP.IronsightPos = Vector(-2.641, 0, 0.944)
	SWEP.IronsightAng = Vector(0.77, 0, 0)

--	SWEP.MicroT1Pos = Vector(-2.135, 0, -0.237)
--	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.DocterPos = Vector(-2.645, 0, 0.7)
	SWEP.DocterAng = Vector(0.45, -0.005, 0)

--  SWEP.RMRPos = Vector(-1.851, 0, -0.091) 
--  SWEP.RMRAng = Vector(0.33, -0, 0)
	
	SWEP.DeltaPointPos = Vector(-2.62, 0, 0.894)
    SWEP.DeltaPointAng = Vector(-0.7, 0.12, 0)

	SWEP.SprintPos = Vector(0.8, -6.641, -6.41)
	SWEP.SprintAng = Vector(45.027, -5.62, -7.893)

	SWEP.CustomizePos = Vector(3.743, -3.643, -2.3)
    SWEP.CustomizeAng = Vector(13.675, 25.354, 0)
	
	SWEP.ReticleInactivityPostFire = 0.35

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_cz75a.mdl"
    SWEP.WMPos = Vector(-0.25, 0.0, -0.5)
    SWEP.WMAng = Vector(180, 190, 0)
	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = true
	
--	SWEP.BoltBone = "sig_slide"
--	SWEP.BoltShootOffset = Vector(0, 1, 0)

	SWEP.BoltBonePositionRecoverySpeed = 25
	SWEP.OffsetBoltDuringNonEmptyReload = true
	SWEP.BoltReloadOffset = Vector(0, 0, 0)
    SWEP.EmptyBoltHoldAnimExclusion = "base_reloadempty"
	SWEP.ReloadBoltBonePositionRecoverySpeed = 20
	SWEP.ReloadBoltBonePositionMoveSpeed = 100
	SWEP.StopReloadBoneOffset = 0.8
	SWEP.HoldBoltWhileEmpty = false
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	SWEP.SightWithRail = false
	SWEP.FOVPerShot = 0.35

	SWEP.AttachmentModelsVM = {
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "sig_frame", rel = "", pos = Vector(0, 8.513, 1.049), angle = Angle(0, -180, 0), size = Vector(0.657, 0.657, 0.657)},
	--	["md_rail"] = {model = "models/cw2/attachments/pistolrail.mdl", bone = "weapon", rel = "", pos = Vector(0, -1.92, 0.462), angle = Angle(0, -90, 0), size = Vector(0.16, 0.16, 0.16)},
	--	["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "weapon", rel = "", pos = Vector(-0.02, -2.454, 3.256), angle = Angle(0, 0, 0), size = Vector(0.368, 0.368, 0.368)},
		["md_pist_insight_x2"] = {model = "models/cw2/attachments/pistollaser.mdl", bone = "sig_frame", rel = "", pos = Vector(0.019, 2.599, 1.25), angle = Angle(0, 90, 0), size = Vector(0.116, 0.116, 0.116)},
    --  ["md_pist_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "slide", rel = "", pos = Vector(0.219, 3.707, -3.668), angle = Angle(0, 90, 0), size = Vector(0.694, 0.56, 0.694)},
		["md_pist_docter"] = {model = "models/attachments/2octorrds.mdl", bone = "sig_slide", rel = "", pos = Vector(-0.212, -0.401, 0.259), angle = Angle(0, 0, 0), size = Vector(0.93, 0.93, 0.93)},
	    ["md_special_pistol_sight"] = {model = "models/attachments/delta_point.mdl", bone = "sig_slide", rel = "", pos = Vector(0.019, -0.25, 0.071), angle = Angle(0, -90, 0), size = Vector(0.829, 0.779, 0.829)},
	    ["md_special_suppressor"] = {model = "models/attachments/special_suppressor.mdl", bone = "sig_frame", rel = "", pos = Vector(0.002, 7.604, 1.25), angle = Angle(0, -180, 0), size = Vector(0.486, 0.486, 0.486)}
	}
	
	SWEP.ForegripOverridePos = {
    ["One_Hand"] = {
--	["l-upperarm-movement"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 85.851, -22.089) },
	["l-upperarm"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, -80, -22.089) }}
	}
	
	SWEP.LaserPosAdjust = Vector(0.5, 0, -1.5)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
	SWEP.LaserAngAdjustAim = Angle(0, 180.03, 0)
	
	SWEP.LuaVMRecoilAxisMod = {vert = 0.25, hor = 0.5, roll = 2, forward = 0, pitch = 1}
	SWEP.BoltBonePositionRecoverySpeed = 17 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
--	SWEP.AttachmentPosDependency = {["md_insight_x2"] = {["md_microt1"] = Vector(-0.188, -5.661, 1.4)}}
	
    SWEP.FullAimViewmodelRecoil = false
	
	SWEP.CustomizationMenuScale = 0.0075
	
	
end

SWEP.MuzzleVelocity = 400 -- in meter/s

SWEP.MagBGs = {main = 2, regular = 0, extended = 1}
SWEP.StockBGs = {main = 3, regular = 0, stock = 1, nostock = 0, none = 2}
SWEP.ExtrasBGs = {main = 1, front_mag = 1, regular = 0}

SWEP.LuaViewmodelRecoilOverride = true
SWEP.CanRestOnObjects = false


    SWEP.Attachments = {
       [1] = {header = "Sight", offset = {150, -800}, atts = {"md_pist_docter", "md_special_pistol_sight"}},
       [2] = {header = "Barrel", offset = {-1000, -300}, atts = {"md_tundra9mm", "md_special_suppressor"}},
	   [3] = {header = "Rail", offset = {-1000, 200}, atts = {"md_pist_insight_x2"}},
	   [4] = {header = "Stock", offset = {950, 600}, atts = {"bg_pist_stock"}},
	   [5] = {header = "Handling", offset = {1200, -450}, atts = {"cw_one_hand"}},
	   [6] = {header = "Magazine Upgrade", offset = {-200, 50}, atts = {"a_zsmagpistol1", "a_zsmagpistol2", "a_zsmagpistol3"}},
	   [7] = {header = "Perks", offset = {1100, 200}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
	   ["+reload"] = {header = "Ammo", offset = {300, 600}, atts = {"am_magnum2", "am_matchgrade2", "am_duplex2", "am_ricochet2", "am_tracers2", "am_luckylast2", "am_rifdepleteduranium2"}}}
	
	

	
-- [6] = {header = "Handling", offset = {1050, -100}, atts = {"cw_one_hand"}},

SWEP.Animations = {
    reload = "reload_tac",
	reload_empty = "reload",
	fire = {"shoot1", "shoot1", "shoot3"},
	fire_dry = "shoot_empty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {
   {time = 0, sound = ""},
   {time = 0.1, sound = "CW_CZA_DEPLOY"}},

	reload_tac = {
	{time = 0.2, sound = "CW_CLOTH"},
	{time = 0.15, sound = "CW_SHIFT"},
	{time = 0.38, sound = "CW_CZA_MAGOUT"},
	{time = 1.3, sound = "CW_FOLEY"},
	{time = 1.38, sound = "CW_CZA_MAGIN"},
	{time = 1.68, sound = "CW_CZA_MAGSHOVE"},
	{time = 1.65, sound = "CW_CZ_CLOTH1"}},
	
	reload = {
	{time = 0.2, sound = "CW_CLOTH"},
	{time = 0.15, sound = "CW_SHIFT"},
	{time = 0.38, sound = "CW_CZA_MAGOUT"},
	{time = 1.3, sound = "CW_FOLEY"},
	{time = 1.38, sound = "CW_CZA_MAGIN"},
	{time = 1.68, sound = "CW_CZA_MAGSHOVE"},
	{time = 1.65, sound = "CW_CZ_CLOTH1"},
	{time = 2.1, sound = "CW_CZA_SLIDERELEASE"}}
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
SWEP.ViewModel		= "models/weapons/v_pist_cz75a.mdl"
SWEP.WorldModel		= "models/weapons/w_cz75a.mdl"
SWEP.ADSFireAnim    = true
SWEP.Spawnable		= true
SWEP.AdminSpawnable	= true

SWEP.Primary.ClipSize		= 17
SWEP.Primary.DefaultClip	= 255
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Pistol"

SWEP.FireDelay = 0.1
SWEP.FireSound = "CW_CZ75A_FIRE"
SWEP.FireSoundSuppressed = "CW_CZ75A_FIRE_SUPPRESSED"
SWEP.Recoil = 0.91

SWEP.HipSpread = 0.035
SWEP.AimSpread = 0.020
SWEP.VelocitySensitivity = 1.65
SWEP.MaxSpreadInc = 0.32
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.1
SWEP.Shots = 1
SWEP.Damage = 60
SWEP.DeployTime = 0.7
-- SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.55
SWEP.ReloadHalt = 2.55

SWEP.ReloadTime_Empty = 2.7
SWEP.ReloadHalt_Empty = 2.7

SWEP.SnapToIdlePostReload = true