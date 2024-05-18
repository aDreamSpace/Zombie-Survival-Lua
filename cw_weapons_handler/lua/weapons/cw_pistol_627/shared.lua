AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

CustomizableWeaponry:registerAmmo(".38 SPECIAL", ".38 SPECIAL Rounds", 9, 29)

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "S&W 627"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.SelectIcon = surface.GetTextureID("weaponicons/mr96")
	killicon.Add("cw_mr96", "weaponicons/mr96", Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_OTS"
	SWEP.PosBasedMuz = true
	SWEP.MuzzlePosMod = {x = 0, y = 0, z = 0}
	SWEP.NoShells = true
	
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 1
	SWEP.ForeGripOffsetCycle_Reload_Empty = 1
	
	SWEP.ReticleInactivityPostFire = 0.75
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_pist_sw_628.mdl"
    SWEP.WMPos = Vector(0, -0.3, 0)
    SWEP.WMAng = Vector(180, 190, 0)
	
	SWEP.IronsightPos = Vector(2.7, 0, 1.536)
	SWEP.IronsightAng = Vector(-0.25, -0.03, 0)

--	SWEP.RMRPos = Vector(-2.06, 0, 0)
--	SWEP.RMRAng = Vector(1.4, -0.15, 0)

--	SWEP.MicroT1Pos = Vector(-1.971, 0, 0)
--	SWEP.MicroT1Ang = Vector(0.65, 0.23, 0)

	SWEP.DocterPos = Vector(2.705, 0, 1.041)
	SWEP.DocterAng = Vector(0.85, -0.021, 0)

--	SWEP.NXSPos = Vector(-2.05, -6.526, 0.119)
--	SWEP.NXSAng = Vector(-0.25, -0.181, 0)

	SWEP.AlternativePos = Vector(-0.281, 1.325, -0.52)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.CustomizePos = Vector(-1.696, 0.275, -1.665)
    SWEP.CustomizeAng = Vector(15.102, -15.136, 0)

	SWEP.SprintPos = Vector(-0.016, -2.162, -4.5)
	SWEP.SprintAng = Vector(43.928, 7.323, 2.046)

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
	  ["md_insight_x2"] = {model = "models/cw2/attachments/pistollaser.mdl", bone = "Body", rel = "", pos = Vector(0, -2.1, 0.25), angle = Angle(0, -90, 0), size = Vector(0.101, 0.082, 0.101)},
	--  ["md_pist_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "base", rel = "", pos = Vector(-0.267, -1.8, -2.62), angle = Angle(0, -90.001, 0), size = Vector(0.762, 0.762, 0.762)},
	--  ["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "base", rel = "", pos = Vector(-0, 2, 1.82), angle = Angle(0, -0, 0), size = Vector(0.331, 0.331, 0.331)},
	  ["md_pist_docter"] = {model = "models/attachments/2octorrds.mdl", bone = "Body", rel = "", pos = Vector(0.209, -1.195, 1.399), angle = Angle(0, -180, 0), size = Vector(0.88, 0.88, 0.88)}
	--  ["md_nightforce_nxs"] = {model = "models/cw2/attachments/l96_scope.mdl", bone = "base", rel = "", pos = Vector(-0.055, 4.034, 2.569), angle = Angle(0, -90, 0), size = Vector(0.811, 0.811, 0.811)}
	}
	
	SWEP.ForegripOverridePos = {
    ["One_Hand"] = {
	["R_Armdummy"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 0, 40) }}
	}
	
	SWEP.LaserPosAdjust = Vector(0.5, 0, -1.5)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
	SWEP.LaserAngAdjustAim = Angle(0, 180.2, 0)
	
end

SWEP.MuzzleVelocity = 600 -- in meter/s, assuming round is a 165 grain JHP <-------- I SAYS NO!

SWEP.BarrelBGs = {main = 5, regular = 0, long = 1, short = 0}
SWEP.CanRestOnObjects = true


 SWEP.Attachments = {
       [1] = {header = "Sight", offset = {200, -700}, atts = {"md_pist_docter"}},
       [2] = {header = "Rail", offset = {-950, 110}, atts = {"md_insight_x2"}},
       [3] = {header = "Handling", offset = {900, -100}, atts = {"cw_one_hand"}},
	   [5] = {header = "Magazine Upgrade", offset = {-500, 550}, atts = {"a_zsmagpistol1", "a_zsmagpistol2", "a_zsmagpistol3"}},
	   [6] = {header = "Perks", offset = {500, 750}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
       ["+reload"] = {header = "Ammo", offset = {-200, 150}, atts = {"am_magnum2", "am_matchgrade2", "am_duplex2", "am_ricochet2", "am_tracers2", "am_luckylast2", "am_rifdepleteduranium2"}}}
	
	


SWEP.Animations = {fire = {"shoot1", "shoot2"},
    fire_dry = "shoot_empty",
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {
    {time = 0, sound = "CW_FOLEY_LIGHT"},
	{time = 0.65, sound = "CW_628_CYLINDERCLOSE"}},

	reload = {
	[1] = {time = 0.35, sound = "CW_628_CYLINDEROPEN"},
	[2] = {time = 0.85, sound = "CW_628_ROUNDSOUT1"},
	[3] = {time = 0.95, sound = "CW_628_ROUNDSOUT2"},
	[4] = {time = 0.15, sound = "CW_628_ROUNDSOUT3"},
	[5] = {time = 1.6, sound = "CW_628_ROUNDSIN"},
	[6] = {time = 2.12, sound = "CW_628_CYLINDERCLOSE"}}}

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
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/v_pist_sw_628.mdl" 
SWEP.WorldModel		= "models/weapons/w_pist_sw_628.mdl"
SWEP.ADSFireAnim    = true

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 72
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Pistol"

SWEP.FireDelay = 0.3
SWEP.FireSound = "CW_628_FIRE"
SWEP.Recoil = 2

SWEP.HipSpread = 0.04
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.025
SWEP.SpreadCooldown = 0.15
SWEP.Shots = 1
SWEP.Damage = 300
SWEP.DeployTime = 0.8
SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.35
SWEP.ReloadHalt = 2.35

SWEP.ReloadTime_Empty = 2.35
SWEP.ReloadHalt_Empty = 2.35