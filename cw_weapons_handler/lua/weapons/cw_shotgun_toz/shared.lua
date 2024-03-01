AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "TOZ BM-16"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.SelectIcon = surface.GetTextureID("weaponicons/mr96")
	killicon.Add("cw_mr96", "weaponicons/mr96", Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.NoShells = true
		
	SWEP.IronsightPos = Vector(-2.523, -1.316, 1.098)
	SWEP.IronsightAng = Vector(1.115, -0.151, 0)
	
	
	
	SWEP.SprintPos = Vector(0.256, 0.01, 1.2)
	SWEP.SprintAng = Vector(-17.778, 0, 0)
	
	SWEP.AlternativePos = Vector(-0.281, 1.325, -0.52)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.ViewModelMovementScale = 0.8
	SWEP.HUD_MagText = "CYLINDER: "

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1.5, roll = 3, forward = 1, pitch = 4}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.DisableSprintViewSimulation = true
end

SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = false
SWEP.ADSFireAnim = true

SWEP.EoTechPos = Vector(-2.49, -12, .35)
SWEP.EoTechAng = Vector(0, 0, 0)

SWEP.MicroT1Pos = Vector(-2.618, 0, 0.25)
SWEP.MicroT1Ang = Vector(0, 0, 0)

SWEP.AimpointPos = Vector(-2.613, -4.803, 0.064)
SWEP.AimpointAng = Vector(0, 0, 0)

SWEP.ACOGPos = Vector(-2.599, -4.803, -0.109)
SWEP.ACOGAng = Vector(0, 0, 0)

SWEP.AttachmentModelsVM = {
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "barrel", pos = Vector(3.57, 10, 8), angle = Angle(90, -90, 0), size = Vector(1, 1, 1)},
		["md_rail"] = {model = "models/wystan/attachments/rail.mdl", bone = "barrel", pos = Vector(0, 0, 0), angle = Angle(0, -90, 180), size = Vector(0.6, 1.1, 1)},
	}


SWEP.Attachments = {
	[1] = {header = "Sight", offset = {800, -400}, atts = { "md_eotech" }},
	[2] = {header = "Drum Magazines", offset = {-500, -250}, atts = {"a_zsmagshotgun1", "a_zsmagshotgun2", "a_zsmagshotgun3"}},
		[3] = {header = "Perks", offset = {100, -100}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
	["+reload"] = {header = "Ammo", offset = {-200, 300}, atts = {"am_flechetterounds2", "am_slugrounds2", "am_shrapnel2", "am_minishells2", "am_sabots2", "am_dragonsbreath2", "am_explosive2", "am_kristallnacht2"}}
	}
		
	
SWEP.Animations = {fire = {"fire1", "firelast"},
	reload = "reload",
	reload_empty = "reloadempty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {[1] = {time = 0.2, sound = "CW_TOZ_OPEN"},
	[2] = {time = 1.3, sound = "CW_TOZ_SHELL1"},
	[3] = {time = 2, sound = "CW_TOZ_HAMMER"},
	[4] = {time = 2.8, sound = "CW_TOZ_CLOSE"}},
	
	reloadempty = {[1] = {time = 0.2, sound = "CW_TOZ_OPEN"},
	[2] = {time = 1.3, sound = "CW_TOZ_SHELL1"},
	[2] = {time = 1.5, sound = "CW_TOZ_SHELL1"},
	[3] = {time = 2, sound = "CW_TOZ_HAMMER"},
	[4] = {time = 2.8, sound = "CW_TOZ_CLOSE"}}}

SWEP.SpeedDec = 10

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "shotgun"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"break"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 60
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/tayley/v_bm16.mdl"
SWEP.WorldModel		= "models/weapons/w_357.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 2
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Buckshot"

SWEP.FireDelay = 0.2
SWEP.FireSound = "CW_TOZ_FIRE"
SWEP.Recoil = 2.6

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.06
SWEP.ClumpSpread = 0.013
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.25
SWEP.Shots = 22
SWEP.Damage = 100
SWEP.DeployTime = 1
SWEP.Chamberable = false


SWEP.ReloadSpeed = 1.2
SWEP.ReloadTime = 3.2
SWEP.ReloadTime_Empty = 3.2
SWEP.ReloadHalt = 3.5
SWEP.ReloadHalt_Empty = 3.5