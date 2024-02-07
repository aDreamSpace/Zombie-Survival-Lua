AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Berreta Samurai Edge"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "a"
	killicon.AddFont("cw_ar15", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_suppressed"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.5
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 1, y = -1, z = 2}
	
	SWEP.SightWithRail = true
	
	SWEP.BoltBone = "slide"
    SWEP.BoltShootOffset = Vector(0, 1.35, 0)
	
--	SWEP.BoltBonePositionRecoverySpeed = 25

--	SWEP.OffsetBoltDuringNonEmptyReload = true
--	SWEP.BoltReloadOffset = Vector(0, -1.35, 0)
--	SWEP.ReloadBoltBonePositionRecoverySpeed = 25
--	SWEP.ReloadBoltBonePositionMoveSpeed = 100
--	SWEP.StopReloadBoneOffset = 0.9
--	SWEP.EmptyBoltHoldAnimExclusion = "reload"
--	SWEP.HoldBoltWhileEmpty = true
--	SWEP.DontHoldWhenReloading = true
--	SWEP.DisableSprintViewSimulation = true
	SWEP.FOVPerShot = 0.2
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_pist_m92_samurai_edge.mdl"
	SWEP.WMPos = Vector(0, 0.2, 0)
    SWEP.WMAng = Vector(180, 190, 0)
	
	SWEP.IronsightPos = Vector(3.542, 0, 1.48)
	SWEP.IronsightAng = Vector(-0.52, 0, 0)
	
	SWEP.MicroT1Pos = Vector(3.499, -1.145, 0.449)
	SWEP.MicroT1Ang = Vector(-2.116, -0.051, 0)
	
	SWEP.DocterPos = Vector(3.543, 0, 1.205)
	SWEP.DocterAng = Vector(-1.101, -0.01, 0)
	
    SWEP.RMRPos = Vector(3.519, 0, 0)
    SWEP.RMRAng = Vector(1.134, -0.04, 0)

--	SWEP.DeltaPointPos = Vector(-1.752, 0, 0)
--  SWEP.DeltaPointAng = Vector(-0.85, 0.568, 0)
	
	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.CustomizePos = Vector(-4.185, -1.598, -2.089)
	SWEP.CustomizeAng = Vector(14.26, -27.417, 0)
	
	SWEP.SprintPos = Vector(-0.464, 0, 0)
	SWEP.SprintAng = Vector(-5.697, -11.15, 0)
	
	SWEP.PronePos = Vector(-6.525, -3.544, -5.35)
	SWEP.ProneAng = Vector(2.714, -28.521, 16.284)
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
	    ["md_insight_x2"] = {model = "models/cw2/attachments/pistollaser.mdl", bone = "P99", rel = "", pos = Vector(0, -1.852, 0.966), angle = Angle(0, -90, 0), size = Vector(0.162, 0.162, 0.162)},
	    ["md_rail"] = {model = "models/cw2/attachments/pistolrail.mdl", bone = "P99", rel = "", pos = Vector(0, -0.551, -0.601), angle = Angle(0, -90, 0), size = Vector(0.199, 0.155, 0.214)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "P99", rel = "", pos = Vector(0.009, -1.56, 3.075), angle = Angle(0, -180, 0), size = Vector(0.405, 0.405, 0.405)},
	    ["md_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "P99", rel = "", pos = Vector(0.31, 3.188, -1.8), angle = Angle(0, 90, 0), size = Vector(0.824, 0.824, 0.824)},
		["md_pist_docter"] = {model = "models/attachments/2octorrds.mdl", bone = "Slide", rel = "", pos = Vector(0.224, 1.898, 0.648), angle = Angle(0, 180, 0), size = Vector(0.957, 0.957, 0.957)}
	--  ["md_special_pistol_sight"] = {model = "models/attachments/delta_point.mdl", bone = "slide", rel = "", pos = Vector(0.009, -0.005, 0.045), angle = Angle(0, 90, 0), size = Vector(0.948, 0.948, 0.948)}
	}
	
	SWEP.AttachmentPosDependency = {
	["md_insight_x2"] = {["md_microt1"] = Vector(-0.188, -1.8, 0.63), ["md_rmr"] = Vector(-0.188, -1.8, 0.63)}}
	
	SWEP.MoveType = 1

	SWEP.CustomizationMenuScale = 0.0065
	
    SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1.5, roll = 2, forward = 2, pitch = 2}
	
	SWEP.LaserPosAdjust = Vector(1, 0, -2.4)
	SWEP.LaserAngAdjust = Angle(2, 180, 0) 
end

SWEP.MuzzleVelocity = 350 -- in meter/s

SWEP.LuaViewmodelRecoil = true


    SWEP.Attachments = {
       [1] = {header = "Sight", offset = {200, -700}, atts = {"md_pist_docter", "md_rmr", "md_microt1"}},
       [2] = {header = "Rail", offset = {-600, 400}, atts = {"md_insight_x2"}},
	   [3] = {header = "Magazine Upgrade", offset = {-500, 850}, atts = {"a_zsmagpistol1", "a_zsmagpistol2", "a_zsmagpistol3"}},
	   [4] = {header = "Perks", offset = {1300, 400}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
       ["+reload"] = {header = "Ammo", offset = {650, 1100}, atts = {"am_magnum2", "am_matchgrade2", "am_duplex2", "am_ricochet2", "am_tracers2", "am_luckylast2", "am_rifdepleteduranium2"}}}
	

SWEP.Animations = {fire = {"shoot1"},
    fire_dry = "shoot_empty",
	reload = "reload_tac",
	reload_empty = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {
   draw = {
   {time = 0, sound = "CW_FOLEY_LIGHT"},
   {time = 0.15, sound = "CW_M92_BOLT"},
   {time = 0.55, sound = "CW_M92_BOLT_RELEASE"}},
   
    reload_tac = {
	[1] = {time = 0.35, sound = "CW_M92_MAGOUT"},
	[2] = {time = 1.23, sound = "CW_M92_MAGIN"}},
   
	reload = {
	[1] = {time = 0.35, sound = "CW_M92_MAGOUT"},
	[2] = {time = 1.23, sound = "CW_M92_MAGIN"},
	[3] = {time = 2.65, sound = "CW_M92_BOLT_RELEASE"}}}

SWEP.SpeedDec = 15

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "3burst", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "[CW2.0] Yan's Guns"

SWEP.Author			= "Xxyan700xX"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/v_pist_m92_samurai_edge.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_m92_samurai_edge.mdl"
SWEP.SprintingEnabled = false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 280
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Pistol"

SWEP.FireDelay = 0.056
SWEP.FireSound = "CW_M92_FIRE"
SWEP.FireSoundSuppressed = "CW_AR15_FIRE_SUPPRESSED"
SWEP.Recoil = 0.5

SWEP.HipSpread = 0.050
SWEP.AimSpread = 0.008
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.12
SWEP.Shots = 1
SWEP.Damage = 32
SWEP.DeployTime = 0.45

SWEP.ReloadSpeed = 1.15
SWEP.ReloadTime = 2.55
SWEP.ReloadTime_Empty = 3.2
SWEP.ReloadHalt = 2.55
SWEP.ReloadHalt_Empty = 3.2
SWEP.SnapToIdlePostReload = true