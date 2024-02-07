AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

CustomizableWeaponry:registerAmmo("9x19MM", "9x19MM Rounds", 9, 19)

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Glock-18T"
	
	SWEP.IconLetter = "a"
	killicon.AddFont("", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = false

	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.55
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 1, y = -0.5, z = -0.5}
	
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.65
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_pist_codol_glock18.mdl"
    SWEP.WMPos = Vector(-0.25, 0.0, -0.5)
    SWEP.WMAng = Vector(180, 190, 0)

	SWEP.IronsightPos = Vector(-1.852, 0, 0.312)
	SWEP.IronsightAng = Vector(0.05, -0.045, 0)
	
--	SWEP.No_Aim_AnimPos = Vector(-1.852, 0, 0.312)
--	SWEP.No_Aim_AnimAng = Vector(-0.105, -0.03, 0)
	
	SWEP.MicroT1Pos = Vector(-1.8, 0, -1.043)
	SWEP.MicroT1Ang = Vector(0.2, 0.155, 0)
	
	SWEP.DocterPos = Vector(-1.803, 0, -0.143)
	SWEP.DocterAng = Vector(0.32, 0.125, 0)
	
    SWEP.RMRPos = Vector(-1.851, 0, -0.091)
    SWEP.RMRAng = Vector(0.33, -0.025, 0)
	
	SWEP.DeltaPointPos = Vector(-1.752, 0, 0)
    SWEP.DeltaPointAng = Vector(-0.85, 0.568, 0)

	SWEP.SprintPos = Vector(2.526, -9.506, -8.24)
	SWEP.SprintAng = Vector(70, 0, 0)
	
	SWEP.CustomizePos = Vector(4.329, -1.415, -1.754)
    SWEP.CustomizeAng = Vector(8.552, 25, 0)

	SWEP.ReticleInactivityPostFire = 0.24

	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	
	SWEP.FullAimViewmodelRecoil = true
	
	SWEP.DisableSprintViewSimulation = true
	SWEP.SightWithRail = true
	SWEP.FOVPerShot = 0.25

	SWEP.AttachmentModelsVM = {
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "barrel", rel = "", pos = Vector(0, -5.301, -0.82), angle = Angle(0, 0, 0), size = Vector(0.635, 0.635, 0.635)},
		["md_rail"] = {model = "models/cw2/attachments/pistolrail.mdl", bone = "weapon", rel = "", pos = Vector(0, -1.92, 0.462), angle = Angle(0, -90, 0), size = Vector(0.16, 0.16, 0.16)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "weapon", rel = "", pos = Vector(-0.02, -2.454, 3.256), angle = Angle(0, 0, 0), size = Vector(0.368, 0.368, 0.368)},
		["md_insight_x2"] = {model = "models/cw2/attachments/pistollaser.mdl", bone = "weapon", rel = "", pos = Vector(-0, -3.184, 1.526), angle = Angle(0, -90, 0), size = Vector(0.12, 0.12, 0.12)},
	    ["md_pist_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "slide", rel = "", pos = Vector(0.219, 3.707, -3.668), angle = Angle(0, 90, 0), size = Vector(0.694, 0.56, 0.694)},
		["md_pist_docter"] = {model = "models/attachments/2octorrds.mdl", bone = "slide", rel = "", pos = Vector(0.189, 0.266, 0.4), angle = Angle(0, 180, 0), size = Vector(0.828, 0.828, 0.828)},
	    ["md_special_pistol_sight"] = {model = "models/attachments/delta_point.mdl", bone = "slide", rel = "", pos = Vector(0.009, -0.005, 0.045), angle = Angle(0, 90, 0), size = Vector(0.948, 0.948, 0.948)},
	    ["md_special_suppressor"] = {model = "models/attachments/special_suppressor.mdl", bone = "barrel", rel = "", pos = Vector(0, -4.86, -0.655), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5)}
	}
	
	SWEP.ForegripOverridePos = {
    ["One_Hand"] = {
	["L UpperArm"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 85.851, -22.089) }}
	}

	
	SWEP.LaserPosAdjust = Vector(0.5, 0, -1.5)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
	SWEP.LuaVMRecoilAxisMod = {vert = 0.25, hor = 0.5, roll = 2, forward = 0, pitch = 1}
	SWEP.BoltBonePositionRecoverySpeed = 17 -- how fast does the bolt bone move back into it's initial position after the weapon has fired
	
	--SWEP.MagBGs = {main = 2, round30 = 1} --round15 = 2,
	
	SWEP.AttachmentPosDependency = {
	["md_insight_x2"] = {["md_microt1"] = Vector(-0.188, -3.4, 1.2)}, 
	["md_tundra9mm"] = {["bg_pist_long_barrel"] = Vector(0, -6.3, -0.818)},
	["md_special_suppressor"] = {["bg_pist_long_barrel"] = Vector(0, -5.85, -0.665)}}

	SWEP.LuaViewmodelRecoil = false
    SWEP.LuaViewmodelRecoilOverride = false
    SWEP.FullAimViewmodelRecoil = false
	
--	SWEP.CustomizationMenuScale = 0.01

    SWEP.CustomizationMenuScale = 0.0075

end

SWEP.BarrelBGs = {main = 2, longris = 0, long = 1, short = 0, magpul = 0, ris = 0, regular = 0}
SWEP.MagBGs = {main = 3, regular = 0, glockround36 = 1,}
SWEP.StockBGs = {main = 4, regular = 0, stock = 1, nostock = 0, none = 2}

-- SWEP.GripBGs = {main = 0, on = 0, off = 0}

SWEP.MuzzleVelocity = 600 -- in meter/s

SWEP.CanRestOnObjects = false


    SWEP.Attachments = {
       [1] = {header = "Sight", offset = {100, -850}, atts = {"md_pist_docter", "md_pist_rmr", "md_special_pistol_sight", "md_microt1"}},
       [2] = {header = "Barrel", offset = {-1000, -300}, atts = {"md_tundra9mm", "md_special_suppressor"}},
	--   [3] = {header = "Muzzle", offset = {-500, -650}, atts = {"bg_pist_long_barrel"}},
	   [4] = {header = "Rail", offset = {-1000, 200}, atts = {"md_insight_x2"}},
	--   [6] = {header = "Stock", offset = {800, 600}, atts = {"bg_pist_stock"}},
       [5] = {header = "Handling", offset = {1100, -450}, atts = {"cw_one_hand"}},
	   [6] = {header = "Magazine Upgrade", offset = {-200, -250}, atts = {"a_zsmagpistol1", "a_zsmagpistol2", "a_zsmagpistol3"}},
	   [7] = {header = "Perks", offset = {1000, 200}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
	   ["+reload"] = {header = "Ammo", offset = {-200, 100}, atts = {"am_magnum2", "am_matchgrade2", "am_duplex2", "am_ricochet2", "am_tracers2", "am_luckylast2", "am_rifdepleteduranium2"}}}
	

SWEP.Animations = {reload = "base_reload",
	reload_empty = "base_reloadempty",
	fire = {"base_fire", "base_fire2", "base_fire3"},
	fire_dry = "fire_last",
	idle = "base_idle",
	draw = "base_draw"} 
--  draw2 = "base_idle"}
	
SWEP.Sounds = {base_draw = {{time = 0, sound = "CW_FOLEY_LIGHT"},
    {time = 0, sound = ""}},
	
	base_reload = {{time = 0.3, sound = "CW_g18_MAGOUT"},
	{time = 0.9, sound = "CW_g18_MAGIN"},
	{time = 1.05, sound = "CW_g18_MAG_RELEASE"},
	{time = 1.15, sound = "CW_g18_LEAN"},
	{time = 1.45, sound = "CW_g18_MAGINTAP"},
	{time = 1.45, sound = "CW_g18_MAGINTAP2"}},
	
	base_reloadempty = {{time = 0, sound = "CW_g18_SLIDEBACK"},
	{time = 0.3, sound = "CW_g18_MAGOUT"},
	{time = 0.9, sound = "CW_g18_MAGIN"},
	{time = 1.05, sound = "CW_g18_MAG_RELEASE"},
	{time = 1.15, sound = "CW_g18_LEAN"},
	{time = 1.45, sound = "CW_g18_MAGINTAP"},
	{time = 1.45, sound = "CW_g18_MAGINTAP2"},
	{time = 1.65, sound = "CW_g18_SLIDEFORWARD"}}
}


SWEP.SpeedDec = 5

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi", "3burst", "auto"}
SWEP.Base = "cw_base"
SWEP.Category = "[CW2.0] Yan's Guns"

SWEP.Author			= "Xxyan700xX"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_pist_codol_glock18.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_codol_glock18.mdl"

SWEP.ADSFireAnim = true

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 280
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Pistol"

SWEP.FireDelay = 0.05 -- 0.15 orginal
SWEP.FireSound = "CW_g18_FIRE"
SWEP.FireSoundSuppressed = "CW_g18_FIRE_SUPPRESSED"
SWEP.Recoil = 0.62

SWEP.HipSpread = 0.036
SWEP.AimSpread = 0.017
SWEP.VelocitySensitivity = 0.75
SWEP.MaxSpreadInc = 0.074
SWEP.SpreadPerShot = 0.008
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 47
SWEP.DeployTime = 0.3

SWEP.BurstCooldownMul = 5
SWEP.BurstSpreadIncMul = 1.0
SWEP.BurstRecoilMul = 0.4

-- SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.3
SWEP.ReloadHalt = 2.3

SWEP.ReloadTime_Empty = 2.3
SWEP.ReloadHalt_Empty = 2.3

SWEP.SnapToIdlePostReload = true