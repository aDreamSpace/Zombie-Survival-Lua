AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

CustomizableWeaponry:registerAmmo(".357 Magnum", ".357 Magnum Rounds", 9, 30)

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Colt 357 magnum"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.SelectIcon = surface.GetTextureID("weaponicons/mr96")
	killicon.Add("cw_mr96", "weaponicons/mr96", Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = true
	SWEP.MuzzlePosMod = {x = 0, y = 0, z = 1.85}
	SWEP.NoShells = true
	
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.65
	
	SWEP.ReticleInactivityPostFire = 0.5
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_pist_357.mdl"
    SWEP.WMPos = Vector(0, -0.3, 0)
    SWEP.WMAng = Vector(180, 190, 0)
	
	SWEP.IronsightPos = Vector(-2.015, 0, 0.715)
	SWEP.IronsightAng = Vector(0.119, 0.02, 0)

	SWEP.RMRPos = Vector(-2.06, 0, 0)
	SWEP.RMRAng = Vector(1.4, -0.15, 0)

	SWEP.MicroT1Pos = Vector(-1.971, 0, 0)
	SWEP.MicroT1Ang = Vector(0.65, 0.23, 0)

	SWEP.DocterPos = Vector(-2.045, 0, 0.185)
	SWEP.DocterAng = Vector(1.2, -0.095, 0) -- 1.2, -0.95, 0

--	SWEP.NXSPos = Vector(-2.05, -6.526, 0.119)
--	SWEP.NXSAng = Vector(-0.25, -0.181, 0)

	SWEP.AlternativePos = Vector(-0.281, 1.325, -0.52)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.CustomizePos = Vector(2.046, -2.279, -2.346) -- -2.279
    SWEP.CustomizeAng = Vector(13.166, 14.786, 0) 
	
	SWEP.SprintPos = Vector(1.312, -6.54, -6.189)
	SWEP.SprintAng = Vector(53.439, -5.745, 0)
	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.HUD_MagText = "CYLINDER: "

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 2.5, roll = 1, forward = 1, pitch = 4}
    SWEP.CustomizationMenuScale = 0.0075
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.LuaViewmodelRecoil = false
    SWEP.LuaViewmodelRecoilOverride = false
    SWEP.FullAimViewmodelRecoil = true
	
--	SWEP.ACOGAxisAlign = {right = 0, up = -0.5, forward = 0}
--	SWEP.NXSAlign = {right = -1.19, up = -0.27, forward = 0}

	SWEP.AttachmentModelsVM = {
	  ["md_insight_x2"] = {model = "models/cw2/attachments/pistollaser.mdl", bone = "base", rel = "", pos = Vector(0.019, 2.266, 0.62), angle = Angle(0, 90, 0), size = Vector(0.1, 0.1, 0.1)},
	  ["md_pist_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "base", rel = "", pos = Vector(-0.267, -1.8, -2.62), angle = Angle(0, -90.001, 0), size = Vector(0.762, 0.762, 0.762)},
	  ["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "base", rel = "", pos = Vector(-0, 2, 1.82), angle = Angle(0, -0, 0), size = Vector(0.331, 0.331, 0.331)},
	  ["md_pist_docter"] = {model = "models/attachments/2octorrds.mdl", bone = "base", rel = "", pos = Vector(-0.181, 1.562, 1.679), angle = Angle(0, -0, 0), size = Vector(0.811, 0.811, 0.811)}
	--  ["md_nightforce_nxs"] = {model = "models/cw2/attachments/l96_scope.mdl", bone = "base", rel = "", pos = Vector(-0.055, 4.034, 2.569), angle = Angle(0, -90, 0), size = Vector(0.811, 0.811, 0.811)}
	}
	
    SWEP.ForegripOverridePos = {
    ["One_Hand"] = {
		["L Forearm"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 85.851, -22.089) },
	    ["L UpperArm"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 85.851, -22.089) },
	    ["L ForeTwist"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 85.851, -22.089) },
	    ["L ForeTwist1"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 85.851, -22.089) },
	    ["L ForeTwist2"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 85.851, -22.089) },
	    ["L ForeTwist3"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 85.851, -22.089) },
	    ["L ForeTwist4"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 85.851, -22.089) },
	    ["L ForeTwist5"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 85.851, -22.089) },
	    ["L ForeTwist6"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 85.851, -22.089) }}
	}
	
	SWEP.LaserPosAdjust = Vector(0.5, 0, -1.5)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
	SWEP.LaserAngAdjustAim = Angle(0, 180.2, 0)
	
end

SWEP.MuzzleVelocity = 450 -- in meter/s, assuming round is a 165 grain JHP

SWEP.BarrelBGs = {main = 2, regular = 0, long = 1, short = 2}
SWEP.StockBGs = {main = 3, regular = 0, stock = 1, nostock = 0, none = 2}

SWEP.CanRestOnObjects = true

if CustomizableWeaponry_OP_Perks then

    SWEP.Attachments = {
       [1] = {header = "Sight", offset = {100, -700}, atts = {"md_pist_docter", "md_pist_rmr", "md_microt1"}},
       [2] = {header = "Muzzle", offset = {-600, -550}, atts = {"bg_pist_revolver_long_barrel", "bg_pist_revolver_short_barrel"}},
       [3] = {header = "Rail", offset = {-950, 110}, atts = {"md_insight_x2"}},
       [4] = {header = "Handling", offset = {1200, -350}, atts = {"cw_one_hand"}},
	   [5] = {header = "Stock", offset = {900, 100}, atts = {"bg_pist_stock"}},
	   [6] = {header = "Magazine Upgrade", offset = {-200, -250}, atts = {"a_zsmagpistol1", "a_zsmagpistol2", "a_zsmagpistol3"}},
	   [7] = {header = "Perks", offset = {500, 650}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
       ["+reload"] = {header = "Ammo", offset = {-200, 250}, atts = {"am_magnum2", "am_matchgrade2", "am_duplex2", "am_ricochet2", "am_tracers2", "am_luckylast2", "am_rifdepleteduranium2"}}}
	
	
	elseif not CustomizableWeaponry_OP_Perks then

    SWEP.Attachments = {
       [1] = {header = "Sight", offset = {200, -700}, atts = {"md_pist_docter", "md_pist_rmr", "md_microt1"}},
       [2] = {header = "Muzzle", offset = {-600, -550}, atts = {"bg_pist_revolver_long_barrel", "bg_pist_revolver_short_barrel"}},
       [3] = {header = "Rail", offset = {-950, 110}, atts = {"md_insight_x2"}},
       [4] = {header = "Handling", offset = {800, 0}, atts = {"cw_one_hand"}},
	   [5] = {header = "Stock", offset = {600, 600}, atts = {"bg_pist_stock"}},
       ["+reload"] = {header = "Ammo", offset = {-300, 650}, atts = {}}}
	
end

SWEP.Animations = {fire = {"shoot1", "shoot2"},
    fire_dry = "shoot_empty",
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {[1] = {time = 0.25, sound = "CW_357_CYLINDEROPEN"},
	[2] = {time = 0.5, sound = "CW_357_Foley"},
	[3] = {time = 0.5, sound = "CW_357_ROUNDSOUT"},
	[4] = {time = 1.45, sound = "CW_357_ROUNDSIN"},
	[5] = {time = 1.96, sound = "CW_357_CYLINDERCLOSE"}}}

SWEP.SpeedDec = 10

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"double"}
SWEP.Base = "cw_base"
SWEP.Category = "[CW2.0] Yan's Guns"

SWEP.Author			= "Xxyan700xX"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_pist_357.mdl" 
SWEP.WorldModel		= "models/weapons/w_pist_357.mdl"
SWEP.ADSFireAnim    = true

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 72
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Pistol"

SWEP.FireDelay = 0.35
SWEP.FireSound = "CW_357_FIRE"
SWEP.Recoil = 2.65

SWEP.HipSpread = 0.036
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 1.35
SWEP.MaxSpreadInc = 0.075
SWEP.SpreadPerShot = 0.075
SWEP.SpreadCooldown = 0.11
SWEP.Shots = 1
SWEP.Damage = 235
SWEP.DeployTime = 0.4
SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.35
SWEP.ReloadHalt = 2.35

SWEP.ReloadTime_Empty = 2.35
SWEP.ReloadHalt_Empty = 2.35