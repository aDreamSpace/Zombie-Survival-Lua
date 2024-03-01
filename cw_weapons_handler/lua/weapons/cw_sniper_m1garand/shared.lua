if CustomizableWeaponry then

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
game.AddParticles("particles/swb_muzzle.pcf")

PrecacheParticleSystem("swb_pistol_large")
PrecacheParticleSystem("swb_pistol_med")
PrecacheParticleSystem("swb_pistol_small")
PrecacheParticleSystem("swb_rifle_large")
PrecacheParticleSystem("swb_rifle_med")
PrecacheParticleSystem("swb_rifle_small")
PrecacheParticleSystem("swb_shotgun")
PrecacheParticleSystem("swb_silenced")
PrecacheParticleSystem("swb_silenced_small")
PrecacheParticleSystem("swb_sniper")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M1 Garand"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.25
	
	SWEP.IconLetter = "i"
	SWEP.SelectIcon = surface.GetTextureID("nikhud/nikgarkillhd")
	killicon.Add("nik_m1garandnew", "nikhud/nikgarkill", Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_SR25"
	SWEP.MuzzleEffectSupp = "swb_silenced"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.Shell = "mainshell"
	SWEP.ShellScale = 1
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 6.5, y = -2, z = 1.5}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 1
	SWEP.CustomizationMenuScale = 0.03
	SWEP.AimSwayIntensity = 0.8
	
	SWEP.DrawTraditionalWorldModel = false
	
	SWEP.CustomizePos = Vector(-3, -2, -1)
	SWEP.CustomizeAng = Vector(5, -22, 0)	
	
	SWEP.IronsightPos = Vector(3.1375, 0.65, 1.741)
	SWEP.IronsightAng = Vector(0.1, 0.515, 0)
	
	SWEP.EoTechPos = Vector(4.535, -2.801, 1.3)
	SWEP.EoTechAng = Vector(-0.68, -0.15, 0)
	
	SWEP.AimpointPos = Vector(-2.355, -2.83, 1.1)
	SWEP.AimpointAng = Vector(-1.4, 0, 0)
	
	SWEP.MicroT1Pos = Vector(3.2075, 7.65, 1.041)
	SWEP.MicroT1Ang = Vector(0.15, 0.53, 0)
	
	SWEP.ACOGPos = Vector(4.515, -2.801, 1.4)
	SWEP.ACOGAng = Vector(-1.5, -0.275, 0)
	
	SWEP.SG1Pos = Vector(-1.614, -0.861, -0.51)
	SWEP.SG1Ang = Vector(0, 0, 0)
	
	SWEP.CmorePos = Vector(-2.355, -3.83, 1)
	SWEP.CmoreAng = Vector(-0.78, 0.05, 0)
	
	SWEP.ReflexPos = Vector(-2.355, -3.83, 1.4)
	SWEP.ReflexAng = Vector(-1, -0.025, 0)
	
	SWEP.BallisticPos = Vector(-2.02, -4, 0.363)
	SWEP.BallisticAng = Vector(0, 0, 0)
	
	SWEP.ELCANPos = Vector(-2.355, -3, 1)
	SWEP.ELCANAng = Vector(-2.2, -0.1, 0)
	
	SWEP.ShortDotPos = Vector(3.1375, 0.65, 0.741)
	SWEP.ShortDotAng = Vector(2.8, 0.565, 0)
	
	SWEP.NXSPos = Vector(3.1375, 1.65, 0.741)
	SWEP.NXSAng = Vector(2.2, 0.295, 0)
	
	SWEP.TrijiconPos = Vector(-2.355, -3.83, 0.85)
	SWEP.TrijiconAng = Vector(-0.35, -0.085, 0)
	
	SWEP.CSGOACOGPos = Vector(2.575, -5.401, -0.12)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.CSGOSSGPos = Vector(-2.02, -3.217, 0.34)
	SWEP.CSGOSSGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(-7.1519, -6, 0.81)
	SWEP.SprintAng = Vector(-18.4897, -66.1888, 0)
	
	SWEP.BackupSights = {
	["md_elcan"] = {[1] = Vector(-2.335, -10, -0.6), [2] = Vector(0, -0.1, 0)},
	["md_acog_fixed"] = {[1] = Vector(4.49, -2.801, 0.3), [2] = Vector(0.1, -0.475, 0)}
	}

	SWEP.SightWithRail = true
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.CSGOACOGAxisAlign = {right = 0, up = 0, forward = -40}
	SWEP.CSGOSSGAxisAlign = {right = 0, up = 0, forward = 145}
	SWEP.NXSAlign = {right = -3.2, up = -0.24, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = -3.9, up = 0, forward = 0}
	
	SWEP.AlternativePos = Vector(0.2, 0, -1)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}

	SWEP.BaseArm = "Right_U_Arm"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_rail"] = { type = "Model", model = "models/wystan/attachments/akrailmount.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(0.27, 3.79, 2.55), angle = Angle(180, 0, 90), size = Vector(1.1, 0.4, 0.5)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "v_weapon.AK47_Parent", pos = Vector(0.315, 0.16, -1.221), angle = Angle(90, -270, 0), size = Vector(0.6, 0.8, 0.8)},
		["md_bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(0.057, -8.466, -1.925), angle = Angle(0, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} },
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.15, -3.889, -4.4), angle = Angle(0, 0, 0), size = Vector(1.25, 1.25, 1.25), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--		["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.601, -8.801, 0), angle = Angle(0, -90, 90), size = Vector(0.5, 0.5, 0.5)},
		["md_foregrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.401, -17.066, -3.633), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(0.035, 4.84, 2.579), angle = Angle(180, 0, 90), size = Vector(0.35, 0.35, 0.35)},
		["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(0.18, 3, 0.1), angle = Angle(0, 0, 0), size = Vector(0.5, 0.95, 0.5)},
		["md_m203"] = { type = "Model", model = "models/cw2/attachments/m203.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-2.34, 10.659, 2.4), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), animated = true},
		["md_acog_fixed"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-4.75, 0.185, -1.985), angle = Angle(0, 89.5, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.198, -2.5, -3.7), angle = Angle(0, 0, 0), size = Vector(1.1, 1.1, 1.1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_trijicon"] = { type = "Model", model = "models/att_trijicon.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(0.2, 6.59, -1), angle = Angle(0, 0, 0), size = Vector(3, 3, 3)},
		["md_csgo_acog"] = { type = "Model", model = "models/kali/weapons/csgo/eq_optic_acog.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.04, 6.199, -0.51), angle = Angle(0, 90, 0), size = Vector(0.699, 0.699, 0.699)},
		["md_nightforce_nxs"] = {model = "models/cw2/attachments/l96_scope.mdl", bone = "v_weapon.AK47_Parent", pos = Vector(0.125, 5.76, 2.221), angle = Angle(90, -270, 0), size = Vector(0.6, 1, 1)},
		["md_csgo_silencer_rifle"] = { type = "Model", model = "models/kali/weapons/csgo/eq_suppressor_rifle.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(0.05, 1.85, 42), angle = Angle(90, 90, 0), size = Vector(2.1, 1.2, 1.2)},
	}

	SWEP.ForeGripHoldPos = {
		["Right_U_Arm"] = {vector = Vector(0, 0, 0), angle = Angle(-8.5, 14.8, -82.5)},
		["Bone24"] = {vector = Vector(0, 0, 0), angle = Angle(57.558, 0, 0)},
		["Bone23"] = {vector = Vector(0, 0, 0), angle = Angle(29.489, 0, 0)},
		["Bone12"] = {vector = Vector(0, 0, 0), angle = Angle(47.895, 0, 0)},
		["Bone22"] = {vector = Vector(0, 0, 0), angle = Angle(7.638, 26.665, 0)},
		["Bone18"] = {vector = Vector(0, 0, 0), angle = Angle(-8.7, 0, 0)},
		["Bone06"] = {vector = Vector(0, 0, 0), angle = Angle(51.199, 23.795, 7.397)},
		["Bone16"] = {vector = Vector(0, 0, 0), angle = Angle(51.741, 0, 0)},
		["Bone11"] = {vector = Vector(0, 0, 0), angle = Angle(28.035, 7.127, -1.678)},
		["Bone08"] = {vector = Vector(0, 0, 0), angle = Angle(11.036, 0, 0)},
		["Bone14"] = {vector = Vector(0, 0, 0), angle = Angle(7.001, 4.373, 0)},
		["Right_L_Arm"] = {vector = Vector(0, 0, 0), angle = Angle(0, -22.463, 0)},
		["Bone20"] = {vector = Vector(0, 0, 0), angle = Angle(58.548, 0, 0)}
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	
	SWEP.BoltBone = "v_weapon.AK47_Bolt"
	SWEP.BoltShootOffset = Vector(0, 0, -3.5)
	SWEP.BoltBonePositionRecoverySpeed = 50
	
	SWEP.LaserPosAdjust = Vector(0.5, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
	SWEP.MagBoneName = "v_weapon.AK47_Clip"
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {400, -600},  atts = {"md_microt1", "md_schmidt_shortdot", "md_nightforce_nxs"}},
	 [2] = {header = "Perks", offset = {100, 300}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
	[3] = {header = "Barrel extension", offset = {-300, -300},  atts = {"md_csgo_silencer_rifle"}},
	[4] = {header = "Magazine Upgrade", offset = {-500, 250}, atts = {"a_zsmagssniper1", "a_zsmagssniper2", "a_zsmagssniper3"}},
["+reload"] = {header = "Ammo", offset = {600, 0}, atts = {"am_magnum2", "am_matchgrade2", "am_heavyhandload2", "am_grapeshot2", "am_rifdepleteduranium2", "am_ricochet2"}}}

SWEP.Animations = {fire = {"ak47_fire1"},
	reload = "ak47_reload",
	idle = "ak47_idle",
	draw = "ak47_draw"}
	
SWEP.Sounds = {ak47_draw = {{time = 0, sound = "CW_NIK_DRAWDEFAULT"}}, 
	ak47_reload = {{time = 0.1, sound = "CW_NIK_M1GARAND_CLIPOUT"},
	{time = 0.8, sound = "CW_NIK_M1GARAND_CLIPIN"},
	{time = 1.4, sound = "CW_NIK_M1GARAND_BREECHCLOSE"},
	{time = 1.65, sound = "CW_FOLEY_LIGHT"}}}

SWEP.SpeedDec = 20

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "Nikolai's CW Arsenal"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 95
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/v_nik_m1garnew.mdl"
SWEP.WorldModel		= "models/weapons/w_nik_m1garnew.mdl"
SWEP.WM = "models/weapons/w_nik_m1garnew.mdl"
SWEP.WMPos = Vector(0, 0, 1)
SWEP.WMAng = Vector(-9, 0, 180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 16
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Gravity"

SWEP.FireDelay = 0.25
SWEP.FireSound = "CW_NIK_M1GARAND_FIRE"
SWEP.FireSoundSuppressed = "CW_NIK_M1GARAND_FIRE_SUPPRESSED"
SWEP.Recoil = 4.95

SWEP.HipSpread = 0.085
SWEP.AimSpread = 0.001
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.15
SWEP.ReloadViewBobEnabled = true
SWEP.Shots = 1
SWEP.Damage = 195
SWEP.DeployTime = 0.5

SWEP.ReloadSpeed = 1.0
SWEP.ReloadTime = 2
SWEP.ReloadTime_Empty = 2
SWEP.ReloadHalt = 2
SWEP.ReloadHalt_Empty = 2

SWEP.SnapToIdlePostReload = false

end