AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M29 Satan"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.SelectIcon = surface.GetTextureID("weaponicons/mr96")
	killicon.Add("cw_mr96", "weaponicons/mr96", Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_SR25"
	SWEP.NoShells = true
	
	SWEP.PosBasedMuz = true
	SWEP.MuzzlePosMod = {x = 6, y = 40, z = 5}

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_pist_m29.mdl"
    SWEP.WMPos = Vector(0, 0.2, 0)
    SWEP.WMAng = Vector(180, 190, 0)
		
	SWEP.IronsightPos = Vector(2.257, 2, 1.12)
	SWEP.IronsightAng = Vector(0.3, -0.04, 0)
	
	SWEP.RMRPos = Vector(2.23, 0, 0.56)
	SWEP.RMRAng = Vector(1.399, -0.201, 0)

	SWEP.MicroT1Pos = Vector(-1.971, 0, 0)
	SWEP.MicroT1Ang = Vector(0.65, 0.23, 0)

	SWEP.DocterPos = Vector(2.253, 0, 0.564)
	SWEP.DocterAng = Vector(1.58, -0.092, 0)

--	SWEP.NXSPos = Vector(2.295, 0, 0.519)
--	SWEP.NXSAng = Vector(0, 0.064, 0)

	SWEP.AlternativePos = Vector(-0.281, 0.005, -0.52)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(-3.632, 0, 0.572)
	SWEP.SprintAng = Vector(-11.304, -29.709, 0)

	SWEP.CustomizePos = Vector(-1.668, -0.47, -1.829)
	SWEP.CustomizeAng = Vector(17.322, -16.981, 0)

	SWEP.PronePos = Vector(-1.872, 0.978, -1.499)
	SWEP.ProneAng = Vector(-3.026, -9.395, 10.586)
	
	SWEP.AttachmentModelsVM = {
	  ["md_insight_x2"] = {model = "models/cw2/attachments/pistollaser.mdl", bone = "Body", rel = "", pos = Vector(-0, 0.419, -1.77), angle = Angle(90, 0, 90), size = Vector(0.092, 0.092, 0.092)},
	  ["md_pist_rmr"] = {model = "models/cw2/attachments/pistolholo.mdl", bone = "Body", rel = "", pos = Vector(-0.235, -2.06, 1.6), angle = Angle(-90, 0, 90), size = Vector(0.64, 0.64, 0.64)},
--	  ["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "base", rel = "", pos = Vector(-0, 2, 1.82), angle = Angle(0, -0, 0), size = Vector(0.331, 0.331, 0.331)},
	  ["md_pist_docter"] = {model = "models/attachments/2octorrds.mdl", bone = "Body", rel = "", pos = Vector(-0.195, 1.559, -1.484), angle = Angle(0, 0, 90), size = Vector(0.819, 0.819, 0.819)}
--    ["md_nightforce_nxs"] = {model = "models/cw2/attachments/l96_scope.mdl", bone = "Body", rel = "", pos = Vector(-0.076, 2.38, -3.712), angle = Angle(-90, 0, 90), size = Vector(0.722, 0.722, 0.722)}
	}
	
	SWEP.MoveType = 1
	SWEP.CustomizationMenuScale = 0.0055
	SWEP.ReticleInactivityPostFire = 0.54
	
	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = true
	SWEP.HUD_MagText = "CYLINDER: "

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 0, forward = 1, pitch = 2}
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.LuaViewmodelRecoil = false
    SWEP.LuaViewmodelRecoilOverride = false
    SWEP.FullAimViewmodelRecoil = false
	
	SWEP.LaserPosAdjust = Vector(0.5, 0, -1.5)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
--	SWEP.NXSAlign = {right = -1.19, up = -0.27, forward = 0}
	
end

SWEP.MuzzleVelocity = 555 -- in meter/s, assuming round is a 165 grain JHP <--- NO!

SWEP.BarrelBGs = {main = 1, regular = 1, long = 2, short = 0}
SWEP.CanRestOnObjects = true



    SWEP.Attachments = {
       [1] = {header = "Sight", offset = {50, -700}, atts = {"md_pist_docter", "md_pist_rmr"}},
       [2] = {header = "Rail", offset = {-950, 100}, atts = {"md_insight_x2"}},
	   [3] = {header = "Magazine Upgrade", offset = {-200, 50}, atts = {"a_zsmagpistol1", "a_zsmagpistol2", "a_zsmagpistol3"}},
	   [4] = {header = "Perks", offset = {900, 170}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
       ["+reload"] = {header = "Ammo", offset = {-200, 650}, atts = {"am_magnum2", "am_matchgrade2", "am_duplex2", "am_ricochet2", "am_tracers2", "am_luckylast2", "am_rifdepleteduranium2"}}}



SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle1",
	draw = "draw"}
	
SWEP.Sounds = {
    draw = {{time = 0, sound = "DRAW1"},
	{time = 0, sound = "DRAW2"}},
	
	reload = {
	[1] = {time = 0, sound = "BLICK"},
	[2] = {time = 0.34, sound = "OUT"},
	[3] = {time = 1.5, sound = "IN"},
	[4] = {time = 1.8, sound = "CLOSE"},
	[5] = {time = 2, sound = "SPIN"}}}
	
SWEP.SpeedDec = 20

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
SWEP.ViewModel		= "models/weapons/v_pist_m29.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_m29.mdl"
SWEP.ADSFireAnim    = true
SWEP.SprintingEnabled = false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 72
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Pistol"

SWEP.FireDelay = 0.55
SWEP.FireSound = "CW_M29_SATAN_FIRE"
SWEP.Recoil = 3

SWEP.HipSpread = 0.015
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.85
SWEP.MaxSpreadInc = 0.15
SWEP.SpreadPerShot = 0.15
SWEP.SpreadCooldown = 0.20
SWEP.Shots = 1
SWEP.Damage = 500
SWEP.DeployTime = 0.75
SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.7
SWEP.ReloadHalt = 2.7

SWEP.ReloadTime_Empty = 2.7
SWEP.ReloadHalt_Empty = 2.7