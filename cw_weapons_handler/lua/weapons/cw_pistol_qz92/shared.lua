AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

CustomizableWeaponry:registerAmmo("5.8x21MM", "5.8x21MM Rounds", 5.8, 21)

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "QSZ-92"
	
	SWEP.IconLetter = "a"
	killicon.AddFont("", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = false

	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.65
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0.4, y = 0, z = 1}
	
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.65
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_pist_qsz.mdl"
    SWEP.WMPos = Vector(-0.25, 0.0, -0.5)
    SWEP.WMAng = Vector(180, 190, 0)
		
	SWEP.IronsightPos = Vector(-1.92, 0, 0.442)
	SWEP.IronsightAng = Vector(0.071, 0, 0)

--	SWEP.MicroT1Pos = Vector(-1.8, 0, -1.043)
--	SWEP.MicroT1Ang = Vector(0.2, 0.155, 0)
	
	SWEP.DocterPos = Vector(-1.93, 0, 0.25)
	SWEP.DocterAng = Vector(-0.08, -0.01, 0)

--  SWEP.RMRPos = Vector(-1.851, 0, -0.091)
--  SWEP.RMRAng = Vector(0.33, -0, 0)
	
	SWEP.DeltaPointPos = Vector(-1.951, 0, 0.1)
    SWEP.DeltaPointAng = Vector(-0.009, -0.095, 0)

	SWEP.CustomizePos = Vector(4.329, -1.415, -1.754)
    SWEP.CustomizeAng = Vector(8.552, 27.051, 0)

	SWEP.SprintPos = Vector(2.526, -9.506, -8.24)
	SWEP.SprintAng = Vector(70, 0, 0)
	
	SWEP.ReticleInactivityPostFire = 0.2

	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = true
	--SWEP.BoltBone = "slide"
	--SWEP.BoltShootOffset = Vector(0, 1, 0)
	SWEP.BoltBonePositionRecoverySpeed = 25
	SWEP.OffsetBoltDuringNonEmptyReload = true
	SWEP.BoltReloadOffset = Vector(0, 0, 0)
	SWEP.EmptyBoltHoldAnimExclusion = "base_reloadempty"
	SWEP.ReloadBoltBonePositionRecoverySpeed = 20
	SWEP.ReloadBoltBonePositionMoveSpeed = 100
	SWEP.StopReloadBoneOffset = 0.8
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	SWEP.SightWithRail = false
	SWEP.FOVPerShot = 0.3

	SWEP.AttachmentModelsVM = {
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "Barrel", rel = "", pos = Vector(0, 5.035, -0.245), angle = Angle(0, 180, 0), size = Vector(0.5, 0.5, 0.5)},
		--["md_rail"] = {model = "models/cw2/attachments/pistolrail.mdl", bone = "wpn_body", pos = Vector(-0.173, -4.663, 0.777), angle = Angle(0, -90, 0), size = Vector(0.15, 0.15, 0.15)},
		--["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "wpn_body", pos = Vector(-0.179, -5.311, 3.41), angle = Angle(0, 0, 0), size = Vector(0.37, 0.37, 0.37)},
		["md_insight_x2"] = {model = "models/cw2/attachments/pistollaser.mdl", bone = "Weapon", rel = "", pos = Vector(-0.03, 1.358, -0), angle = Angle(0, 90, 0), size = Vector(0.1, 0.1, 0.1)},
	    --["md_pist_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "Barrel", rel = "", pos = Vector(-0.181, -5.761, -1.68), angle = Angle(0, -90, 0), size = Vector(0.444, 0.444, 0.444)
		["md_pist_docter"] = {model = "models/attachments/2octorrds.mdl", bone = "Slide", rel = "", pos = Vector(-0.215, -1.8, 0.45), angle = Angle(0, 0, 0), size = Vector(0.774, 0.774, 0.774)},
	    ["md_special_pistol_sight"] = {model = "models/attachments/delta_point.mdl", bone = "Slide", rel = "", pos = Vector(-0.026, -1.602, 0.23), angle = Angle(0, -90, 0), size = Vector(0.837, 0.732, 0.837)},
	    ["md_special_suppressor"] = {model = "models/attachments/special_suppressor.mdl", bone = "Barrel", rel = "", pos = Vector(-0.005, 5, -0.171), angle = Angle(0, 180, 0), size = Vector(0.444, 0.444, 0.444)}
	}
	
--	SWEP.ForegripOverridePos = {
--    ["One_Hand"] = {
--	["L UpperArm"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 85.851, -22.089) },
--	["	IK_Root"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 85.851, -22.089) }}
--	}
	
	SWEP.LaserPosAdjust = Vector(0.5, 0, -1.5)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
	SWEP.LuaVMRecoilAxisMod = {vert = 0.25, hor = 0.5, roll = 2, forward = 0, pitch = 1}
    SWEP.CustomizationMenuScale = 0.0075
	SWEP.BoltBonePositionRecoverySpeed = 17 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
    SWEP.BarrelBGs = {main = 1, longris = 0, long = 2, short = 0, magpul = 0, ris = 0, regular = 0}
    SWEP.MagBGs = {main = 2, regular = 0, glockround36 = 1,}
	
	SWEP.AttachmentPosDependency = {
	["md_tundra9mm"] = {["bg_pist_long_barrel"] = Vector(0, 5.9, -0.23)},
	["md_special_suppressor"] = {["bg_pist_long_barrel"] = Vector(0, 5.9, -0.17)}}
	
	SWEP.LuaViewmodelRecoil = false
    SWEP.LuaViewmodelRecoilOverride = false
    SWEP.FullAimViewmodelRecoil = false
end

SWEP.MuzzleVelocity = 680 -- in meter/s

SWEP.BarrelBGs = {main = 2, longris = 0, long = 1, short = 0, magpul = 0, ris = 0, regular = 0}
SWEP.MagBGs = {main = 3, regular = 0, extended = 1,}

SWEP.LuaViewmodelRecoilOverride = true
SWEP.CanRestOnObjects = false



    SWEP.Attachments = {
       [1] = {header = "Sight", offset = {200, -700}, atts = {"md_pist_docter", "md_special_pistol_sight"}},
       [2] = {header = "Barrel", offset = {-1000, -300}, atts = {"md_tundra9mm", "md_special_suppressor"}},
	   [3] = {header = "Muzzle", offset = {-500, -650}, atts = {"bg_pist_long_barrel"}},
	   [4] = {header = "Rail", offset = {-1000, 200}, atts = {"md_insight_x2"}},
	   [5] = {header = "+3 Bullets", offset = {800, 600}, atts = {"bg_extended_3_bullets"}},
	   [6] = {header = "Magazine Upgrade", offset = {-200, 50}, atts = {"a_zsmagpistol1", "a_zsmagpistol2", "a_zsmagpistol3"}},
	   [7] = {header = "Perks", offset = {800, 0}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
	   ["+reload"] = {header = "Ammo", offset = {200, -300}, atts = {"am_magnum2", "am_matchgrade2", "am_duplex2", "am_ricochet2", "am_tracers2", "am_luckylast2", "am_rifdepleteduranium2"}}
	
	} 
	


SWEP.Animations = {reload = "base_reload",
	reload_empty = "base_reloadempty",
	fire = {"base_fire", "base_fire3"},
	fire_dry = "base_firelast",
	idle = "base_idle",
	draw = "base_draw"}
	
SWEP.Sounds = {base_draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	base_reload = {
	{time = 0.3, sound = "CW_QSZ_MAGOUT2"},
	{time = 0.41, sound = "CW_QSZ_MAGOUT"},
	{time = 1.76, sound = "CW_QSZ_MAGIN"},
	{time = 2, sound = "CW_QSZ_MAGINTAP"}},
	
	base_reloadempty = {
	{time = -1, sound = "CW_QSZ_SLIDEBACK"},
	{time = 0.3, sound = "CW_QSZ_MAGOUT2"},
	{time = 0.41, sound = "CW_QSZ_MAGOUT"},
	{time = 1.76, sound = "CW_QSZ_MAGIN"},
	{time = 2, sound = "CW_QSZ_MAGINTAP"},
	{time = 2.45, sound = "CW_QSZ_SLIDEFORWARD"}}
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
SWEP.ViewModel		= "models/weapons/v_pist_qsz92.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_qsz.mdl"
SWEP.ADSFireAnim = true

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 15
SWEP.Primary.DefaultClip	= 50
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Pistol"

SWEP.FireDelay = 0.145
SWEP.FireSound = "CW_QSZ_FIRE"
SWEP.FireSoundSuppressed = "CW_QSZ_FIRE_SUPPRESSED"
SWEP.Recoil = 0.4

SWEP.HipSpread = 0.035
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 0.65
SWEP.MaxSpreadInc = 0.055
SWEP.SpreadPerShot = 0.0075
SWEP.SpreadCooldown = 0.22
SWEP.Shots = 1
SWEP.Damage = 36
SWEP.DeployTime = 0.3

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.3
SWEP.ReloadHalt = 2.3

SWEP.ReloadTime_Empty = 2.78
SWEP.ReloadHalt_Empty = 3

SWEP.SnapToIdlePostReload = true