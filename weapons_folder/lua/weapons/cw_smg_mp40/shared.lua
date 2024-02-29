AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "smgMag"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "MP-40"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "w"
	killicon.Add( "khr_mp40", "icons/killicons/khr_mp40", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_mp40")
	
	SWEP.EffectiveRange_Orig = 76 * 39.37
	SWEP.DamageFallOff_Orig = .41
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = true
	SWEP.Shell = "smallshell"
	SWEP.ShellDelay = 0.04
	SWEP.ShellScale = 0.5
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -2}
	SWEP.SightWithRail = true
	SWEP.DisableSprintViewSimulation = false
	
	SWEP.BoltBone = "Bolt"
	SWEP.BoltBonePositionRecoverySpeed = 50
	SWEP.BoltShootOffset = Vector(2, 0, 0)
	
	SWEP.IronsightPos = Vector(-1.872, 0, 0.939)
	SWEP.IronsightAng = Vector(-.12, 0, 0)
	
	SWEP.KR_CMOREPos =  Vector(-1.855, -1, 0.57)
	SWEP.KR_CMOREAng =  Vector(-1, 0, 0)
	
	SWEP.SprintPos = Vector(1.169, -0.866, -2.87)
	SWEP.SprintAng = Vector(1.85, 7.629, -6.34)
	
	SWEP.AlternativePos = Vector(.5, .5, -0.202)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_saker222"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "body", rel = "", pos = Vector(0, 4.239, -0.401), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_rail"] = { type = "Model", model = "models/wystan/attachments/rail.mdl", bone = "body", rel = "", pos = Vector(0.119, -1.5, 0.535), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["odec3d_cmore_kry"] = { type = "Model", model = "models/weapons/krycek/sights/odec3d_cmore_reddot.mdl", bone = "body", rel = "", pos = Vector(-0.02, -2, 1.5), angle = Angle(0, -90, 0), size = Vector(0.15, 0.15, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.CustomizationMenuScale = 0.015
	SWEP.ViewModelMovementScale = 1
	
end

SWEP.MuzzleVelocity = 400 -- in meter/s

SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = .25, forward = 1.5, pitch = 1.5}

SWEP.LuaViewmodelRecoil = true


SWEP.Attachments = {[1] = {header = "Barrel", offset = {150, -380},  atts = {"md_saker222"}},
	[2] = {header = "Sight", offset = {750, -50},  atts = {"odec3d_cmore_kry"}},
	[3] = {header = "Magazine Upgrade", offset = {-500, 300}, atts = {"a_zsmagsmg1", "a_zsmagsmg2", "a_zsmagsmg3"}},
	   [4] = {header = "Perks", offset = {100, 300}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
	["+reload"] = {header = "Ammo", offset = {-500, -50}, atts = {"am_magnum2", "am_matchgrade2", "am_duplex2", "am_ricochet2", "am_tracers2", "am_luckylast2", "am_rifdepleteduranium2"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3", "shoot4", "shoot5", "shoot6", "shoot7", "shoot8", "shoot9", "shoot10"},
	reload = "reload_3",
	reload_empty = "reload_2",
	idle = "idle",
	draw = "draw_1"}
	
SWEP.Sounds = {	draw = {{time = 0, sound = "MP40_CLOTH"}},

	reload_3 = {[1] = {time = .8, sound = "MP40_MAGOUT"},
	[2] = {time = 2.1, sound = "MP40_MAGIN"},
	[3] = {time = 2.6, sound = "MP40_GRIP"}},
	
	reload_2 = {[1] = {time = .8, sound = "MP40_MAGOUT"},
	[2] = {time = 1.5, sound = "MP40_MAGIN"},
	[3] = {time = 2.3, sound = "MP40_BOLT"},
	[4] = {time = 2.9, sound = "MP40_GRIP"}}}

SWEP.HoldBoltWhileEmpty = true
SWEP.DontHoldWhenReloading = false
SWEP.Chamberable = false

SWEP.SpeedDec = 25

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "smg"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Khris"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.OverallMouseSens = 1
SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khr_mp4.mdl"
SWEP.WorldModel		= "models/weapons/w_smg_ump45.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 32
SWEP.Primary.DefaultClip	= 32
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SMG1"

SWEP.FireDelay = 60/550
SWEP.FireSound = "MP40_FIRE"
SWEP.FireSoundSuppressed = "KRISS_Firesup"
SWEP.Recoil = 1

SWEP.HipSpread = 0.038
SWEP.AimSpread = 0.0081
SWEP.VelocitySensitivity = .45
SWEP.MaxSpreadInc = 0.009
SWEP.SpreadPerShot = 0.0015
SWEP.SpreadCooldown = 60/300
SWEP.Shots = 1
SWEP.Damage = 55
SWEP.DeployTime = 0.5
SWEP.RecoilToSpread = 0

SWEP.ReloadSpeed = 1.2
SWEP.ReloadTime = 3
SWEP.ReloadTime_Empty = 3.2
SWEP.ReloadHalt = 3
SWEP.ReloadHalt_Empty = 3.2

function SWEP:IndividualThink()
	self.EffectiveRange = 76 * 39.37
	self.DamageFallOff = .41
	
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 11.4 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .0615))
	end
	if self.ActiveAttachments.md_saker222 then
	self.EffectiveRange = ((self.EffectiveRange - 15.2 * 39.37))
	end
end