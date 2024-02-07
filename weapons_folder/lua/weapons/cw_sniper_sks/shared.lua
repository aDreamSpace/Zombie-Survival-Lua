AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "arMag"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "SKS"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "w"
	killicon.Add( "khr_sks", "icons/killicons/khr_sks", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_sks")
	
	SWEP.MuzzleEffect = "muzzleflash_ak47"
	SWEP.PosBasedMuz = true
	SWEP.ShellScale = 0.3
	SWEP.FireMoveMod = 2
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 2.5}
	SWEP.SightWithRail = true
	SWEP.DisableSprintViewSimulation = false
	SWEP.SnapToIdlePostReload = true
	
	SWEP.EffectiveRange_Orig = 162.3 * 39.37
	SWEP.DamageFallOff_Orig = .34
	
	SWEP.BoltBone = "bolt_controller"
	SWEP.BoltBonePositionRecoverySpeed = 35
	SWEP.BoltShootOffset = Vector(-2.9, 0, 0)

	SWEP.IronsightPos = Vector(-2.556, -1.5, 1.5433)
	SWEP.IronsightAng = Vector(-0.28, 0.044, 0)
	
	SWEP.KobraPos = Vector( -2.435, -2, .875)
	SWEP.KobraAng = Vector( .2, .2, 0)
	
	SWEP.PUPos = Vector(-2.6145, 0, 1.026)
	SWEP.PUAng = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(0, .5, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.03
	SWEP.ViewModelMovementScale = 1
	
	SWEP.BackupSights = {["bg_skspuscope"] = {[1] = Vector(-2.556, -1.5, 1.5433), [2] = Vector(-0.28, 0.044, 0)}}
	
	SWEP.AttachmentModelsVM = {
	["md_kobra"] = { type = "Model", model = "models/cw2/attachments/kobra.mdl", bone = "SKS_Controller", rel = "", pos = Vector(0.3, 1.23, 0.449), angle = Angle(-90, 90, 0), size = Vector(0.449, 0.449, 0.449), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.PUAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 90}
	SWEP.SchmidtShortDotAxisAlign = {right = 1, up = 0, forward = 0}
end

SWEP.SightBGs = {main = 2, none = 0, scope = 1}
SWEP.MagBGs = {main = 1, none = 0, one = 1, two = 2}

SWEP.DrawTraditionalWorldModel = true
SWEP.WM = "models/khrcw2/w_khr_simsks.mdl"
SWEP.WMPos = Vector(1.2, -5, -10.5)
SWEP.WMAng = Vector(-9, 180, 180)

SWEP.MuzzleVelocity = 740 -- in meter/s
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true 
SWEP.CanRestOnObjects = true


SWEP.Attachments = {[1] = {header = "Sight", offset = {650, -400},  atts = {"md_kobra", "bg_skspuscope"}},
	 [2] = {header = "Perks", offset = {300, 300}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
	[3] = {header = "Bayonet", offset = {-250, -350}, atts = {"bg_sksbayonetfold","bg_sksbayonetunfold"}},
	[4] = {header = "Magazine Upgrade", offset = {-200, 250}, atts = {"a_zsmagssniper1", "a_zsmagssniper2", "a_zsmagssniper3"}},
["+reload"] = {header = "Ammo", offset = {600, 0}, atts = {"am_magnum2", "am_matchgrade2", "am_heavyhandload2", "am_grapeshot2", "am_rifdepleteduranium2", "am_ricochet2", "am_reducedpowderload2"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle1",
	draw = "draw"}
	
SWEP.Sounds = {	draw = {{time = 0, sound = "KSKS.Deploy"}},

	reload = {[1] = {time = 1.4, sound = "SIMSKS.Clipin"},
	[2] = {time = 2.4, sound = "SIMSKS.Insert2"},
	[3] = {time = 2.6, sound = "SIMSKS.Insert3"},
	[4] = {time = 2.85, sound = "SIMSKS.Insert1"},
	[5] = {time = 3.75, sound = "SIMSKS.Insert3"},
	[6] = {time = 4.5, sound = "SIMSKS.Boltback"},
	[7] = {time = 4.7, sound = "SIMSKS.Boltforward"},
	[8] = {time = 4.8, sound = "SIMSKS.Clipout"}}}

SWEP.HoldBoltWhileEmpty = true
SWEP.DontHoldWhenReloading = true
SWEP.Chamberable = false
SWEP.LuaVMRecoilAxisMod = {vert = .5, hor = .5, roll = .25, forward = 1.5, pitch = 1}

SWEP.SpeedDec = 40

SWEP.OverallMouseSens = .85
SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Khris"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 65
SWEP.AimViewModelFOV = 60
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khr_simsks.mdl"
SWEP.WorldModel		= "models/weapons/w_rif_ak47.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 10
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Gravity"

SWEP.FireDelay = 60/550
SWEP.FireSound = "SIMSKS.Fire"
SWEP.FireSoundSuppressed = "KSKS.SupFire"
SWEP.Recoil = 1.35

SWEP.HipSpread = 0.040
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = .5
SWEP.MaxSpreadInc = 0.015
SWEP.SpreadPerShot = 0.002
SWEP.SpreadCooldown = 60/200
SWEP.Shots = 1
SWEP.Damage = 103
SWEP.DeployTime = .45
SWEP.RecoilToSpread = 0

SWEP.ReloadSpeed = 1.25
SWEP.ReloadTime = 5.75
SWEP.ReloadTime_Empty = 5.75
SWEP.ReloadHalt = 5.75
SWEP.ReloadHalt_Empty = 5.75

function SWEP:Reload()
	if self:Clip1() > 0 then return end
	
	weapons.GetStored("cw_base").Reload(self)
end

function SWEP:IndividualThink()
	self.EffectiveRange = 162.3 * 39.37
	self.DamageFallOff = .34
	
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 10.785 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .054))
	end
end