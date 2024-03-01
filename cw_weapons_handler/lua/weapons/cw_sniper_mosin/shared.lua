AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Mosin-Nagant"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "w"
	killicon.Add( "khr_mosin", "icons/killicons/khr_mosin", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_mosin")
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/khrcw2/w_khri_mosinm91.mdl"
	SWEP.WMPos = Vector(-1, 5, 0)
	SWEP.WMAng = Vector(-13, 0, 180)
	
	SWEP.EffectiveRange_Orig = 245.8 * 39.37
	SWEP.DamageFallOff_Orig = .28
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = true
	SWEP.SightWithRail = true
	SWEP.NoDistance = false
	SWEP.SnapToIdlePostReload = false
	SWEP.CrosshairEnabled = true
	SWEP.FOVPerShot = 0.25
	SWEP.ShellScale = 0.28
	SWEP.ShellDelay = .75
	SWEP.NoShells = false
	SWEP.ShellOffsetMul = 0
	SWEP.ShellPosOffset = {x = 6, y = -.25, z = .5}
	SWEP.FireMoveMod = 0.6
	SWEP.CustomizationMenuScale = 0.03
	
	SWEP.IronsightPos = Vector(-2.8155, -1.6667, 1.455)
	SWEP.IronsightAng = Vector(0, 0.03, 0)

	SWEP.PUPos = Vector(-2.819, 0, 0.723)
	SWEP.PUAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.786, -1, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
	
	SWEP.AlternativePos = Vector(-0.5, 0, -0.25)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.ACOGPos = Vector(-2.821, -9, -0.2144)
	SWEP.ACOGAng = Vector(-1, 0, 0)

	SWEP.NXSPos = Vector(-3.648, -4, 1.157)
	SWEP.NXSAng = Vector(0, 0, 0)

	SWEP.ShortDotPos = Vector(-3.626, -5, 1.28)
	SWEP.ShortDotAng = Vector(0, 0, 0)

	SWEP.AttachmentModelsVM = {
	["md_rail"] = { type = "Model", model = "models/khrcw2/attachments/a_modkit_mosin.mdl", bone = "Weapon", rel = "", pos = Vector(0, 4.199, 0.518), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_khr_ins2ws_acog"] = { type = "Model", model = "models/khrcw2/attachments/khr_ins2_cstm_acog.mdl", bone = "Weapon", rel = "", pos = Vector(0, 0.555, 2.198), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_ins2_suppressor_ins"] = { type = "Model", model = "models/weapons/upgrades/a_suppressor_ins.mdl", bone = "Weapon", rel = "", pos = Vector(0, 26.899, 0.8), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	}
	
	SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
	SWEP.ACOGAxisAlign = {right = 1.1, up = 0, forward = 0}
	SWEP.PUAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = 180, up = 180, forward = 180}
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 1, forward = 0, pitch = 1}
end

SWEP.MuzzleVelocity = 865 -- in meter/s

SWEP.BackupSights = {["bg_skspuscope"] = {[1] = Vector(-2.8155, -1.6667, 1.455), [2] = Vector(0, 0, 0)}}

SWEP.AttachmentDependencies = { 
	["bg_skspuscope"] = {"bg_bentbolt"}
}

SWEP.BoltBGs = {main = 1, bent = 1, straight = 0}
SWEP.SightBGs = {main = 2, scope = 1, none = 0}
SWEP.StockBGs = {main = 0, full = 0, custom = 1, carbine = 2, obrez = 3}

SWEP.Attachments = {[1] = {header = "Sight", offset = {600, -350},  atts = {"bg_skspuscope","md_khr_ins2ws_acog"}},
[2] = {header = "Bolt", offset = {1100, 100},  atts = {"bg_bentbolt"}},
[3] = {header = "Finish", offset = {50, -350},  atts = {"md_mnbrandnew1", "md_mnbrandnew2", "md_mnolddark"}},
 [4] = {header = "Perks", offset = {100, 300}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
[5] = {header = "Style", offset = {-500, -50},  atts = {"bg_mncustombody", "bg_mncarbinebody", "bg_mnobrezbody"}},
[6] = {header = "Magazine Upgrade", offset = {-200, 250}, atts = {"a_zsmagssniper1", "a_zsmagssniper2", "a_zsmagssniper3"}},
["+reload"] = {header = "Ammo", offset = {600, 600}, atts = {"am_magnum2", "am_matchgrade2", "am_heavyhandload2", "am_grapeshot2", "am_rifdepleteduranium2", "am_ricochet2"}}}

SWEP.Animations = {fire = "base_fire_start",
	reload_start = "reload_start",
	insert = "reload_insert",
	reload_end = "reload_end",
	idle = "reload_end",
	draw = "base_draw"}
	
SWEP.Sounds = {	bent_reload_start = {
		{time = 4/30, sound = "KHRMOSIN_BOLTRELEASE"},
		{time = 10/30, sound = "KHRMOSIN_BOLTBACK"},
	},
	
	reload_start = {
		{time = 4/30, sound = "KHRMOSIN_BOLTRELEASE"},
		{time = 10/30, sound = "KHRMOSIN_BOLTBACK"},
	},

		reload_insert = {
		{time = 8/30, sound = "KHRMOSIN_BULLETIN"},
	},
	
		reload_end = {
		{time = 7/30, sound = "KHRMOSIN_BOLTFORWARD"},
		{time = 11/30, sound = "KHRMOSIN_BOLTLATCH"},
	},
	
		bent_reload_end = {
		{time = 7/30, sound = "KHRMOSIN_BOLTFORWARD"},
		{time = 11/30, sound = "KHRMOSIN_BOLTLATCH"},
	},
	
		bent_fire_start = {
		{time = 15/30, sound = "KHRMOSIN_BOLTRELEASE"},
		{time = 19/30, sound = "KHRMOSIN_BOLTBACK"},
		{time = 28/30, sound = "KHRMOSIN_BOLTFORWARD"},
		{time = 35/30, sound = "KHRMOSIN_BOLTLATCH"},
		
	},
		
		base_fire_start = {
		{time = 15/30, sound = "KHRMOSIN_BOLTRELEASE"},
		{time = 19/30, sound = "KHRMOSIN_BOLTBACK"},
		{time = 28/30, sound = "KHRMOSIN_BOLTFORWARD"},
		{time = 35/30, sound = "KHRMOSIN_BOLTLATCH"}
	}}

SWEP.SpeedDec = 45

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Khris"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.AimViewModelFOV = 60
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khri_mosinm91.mdl"
SWEP.WorldModel		= "models/khrcw2/w_khri_mosinm91.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.ADSFireAnim = true
SWEP.Chamberable = false

SWEP.LuaViewmodelRecoil = false
SWEP.ForcedHipWaitTime = 1.4

SWEP.OverallMouseSens = .8
SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "357"
SWEP.FireDelay = 60/36
SWEP.FireSound = "KHRMOSIN_FIRE"
SWEP.Recoil = 2.5

SWEP.HipSpread = 0.07
SWEP.AimSpread = 0.0027
SWEP.VelocitySensitivity = .4
SWEP.MaxSpreadInc = 0.03
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 60/35
SWEP.Shots = 1
SWEP.Damage = 130
SWEP.DeployTime = .6

SWEP.ReloadSpeed = 1
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = .8
SWEP.ReloadFinishWait = 1
SWEP.ShotgunReload = true

function SWEP:IndividualThink()
	self.EffectiveRange = 245.8 * 39.37
	self.DamageFallOff = .28
	
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 36.87 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .033))
	end
	if self.ActiveAttachments.bg_mncarbinebody then
	self.EffectiveRange = ((self.EffectiveRange - 24.58 * 39.37))
	end
	if self.ActiveAttachments.bg_mnobrezbody then
	self.EffectiveRange = ((self.EffectiveRange - 98.32 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .055))
	end
end