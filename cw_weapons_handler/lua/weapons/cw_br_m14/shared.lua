AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M14 (Ichi-Yon)"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	killicon.AddFont("cw_g3a3", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_m14"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/cw2/weapons/w_ichi_yon.mdl"
	SWEP.WMPos = Vector(-0.5, -0.5, 0.5)
	SWEP.WMAng = Vector(-1, 0, 180)
	
	SWEP.IronsightPos = Vector(-2.233, -2.04, 1.233)
	SWEP.IronsightAng = Vector(-0.376, 0.003, 0)
	
	SWEP.EoTechPos = Vector(-2.256, -3.516, -0.031)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.LeupoldPos = Vector(-2.26, -2.769, -0.094)
	SWEP.LeupoldAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-2.258, -3.517, 0.032)

	SWEP.AimpointAng = Vector(0, -0.008, 0)
	
	SWEP.MicroT1Pos = Vector(-2.264, -3.241, 0.048)
	SWEP.MicroT1Ang = Vector(-0.08, 0.003, 0)

	SWEP.M98BPos = Vector(-2.248, -2.303, 0.209)

	SWEP.M98BAng = Vector(0, 0, 0)
	
	SWEP.CoD4ReflexPos = Vector(-2.237, -3.836, 0.246)
	SWEP.CoD4ReflexAng = Vector(0, 0, 0)
	
	SWEP.CSGOACOGPos = Vector(-2.254, -3.517, -0.026)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.929, 0, 0.833)
	SWEP.SprintAng = Vector(-20.518, 24.666, -9.66)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.221, -4.617, -1.234), [2] = Vector(0, -0.008, 0)}}

	SWEP.SightWithRail = true
	SWEP.CSGOACOGAxisAlign = {right = -0.1, up = -0.1, forward = -40}
	SWEP.M98BAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.LeupoldAxisAlign = {right = 1, up = 0, forward = 0}
	
	SWEP.AlternativePos = Vector(-0.319, 1.325, -1.04)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.M203OffsetCycle_Reload = 0.81
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0
	
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.BoltBone = "M14_Bolt"
	SWEP.BoltShootOffset = Vector(-3, 0, 0)
	
	SWEP.M203HoldPos = {
		["Bip01 L Clavicle"] = {pos = Vector(4.461, 0.308, -2.166), angle = Angle(0, 0, 0)}
	}
	
	SWEP.AttachmentModelsVM = {
		["md_rail"] = {model = "models/atts/m14railmount.mdl", bone = "M14_Body", rel = "", pos = Vector(-0.138, 0.05, 0.579), angle = Angle(0, -90, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "M14_Body", rel = "", pos = Vector(-0.269, -6.553, -4.235), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "M14_Body", rel = "", pos = Vector(0.25, -11.391, -9.294), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_cod4_reflex"] = {model = "models/v_cod4_reflex.mdl", bone = "M14_Body", rel = "", pos = Vector(0, -4.106, -1.229), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_fas2_leupold"] = {model = "models/v_fas2_leupold.mdl", bone = "M14_Body", rel = "", pos = Vector(-0.033, -1.782, 2.628), angle = Angle(0, -90, 0), size = Vector(1.7, 1.7, 1.7)},
		["md_fas2_leupold_mount"] = {model = "models/v_fas2_leupold_mounts.mdl", bone = "M14_Body", rel = "", pos = Vector(-0.033, -1.782, 2.628), angle = Angle(0, -90, 0), size = Vector(1.7, 1.7, 1.7)},
		["md_m98b_scope"] = {model = "models/attachments/98b_scope.mdl", bone = "M14_Body", rel = "", pos = Vector(-0.049, -0.627, 2.637), angle = Angle(0, -90, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_hk416_bipod"] = {model = "models/c_bipod.mdl", bone = "M14_Body", rel = "", pos = Vector(0, 10.876, -0.82), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "M14_Body", rel = "", pos = Vector(-0.009, -0.459, 1.652), angle = Angle(0, 180, 0), size = Vector(0.449, 0.449, 0.449)},
		["md_csgo_silencer_rifle"] = {model = "models/kali/weapons/csgo/eq_suppressor_rifle.mdl", bone = "M14_Body", rel = "", pos = Vector(-0.015, 22.25, -0.232), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "M14_Body", pos = Vector(-0.173, 6.684, 1.22), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_csgo_acog"] = {model = "models/kali/weapons/csgo/eq_optic_acog.mdl", bone = "M14_Body", rel = "", pos = Vector(0.024, -6.673, -2.083), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "M14_Body", pos = Vector(-0.419, -5.74, -3.297), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)}
	}
	
	SWEP.AttachmentPosDependency = {["md_anpeq15"] = {["bg_longris"] = Vector(-0.225, 13, 3.15)},
	["md_saker"] = {["bg_longbarrel"] = Vector(-0.042, 9, -0.1), ["bg_longris"] = Vector(-0.042, 9, -0.1)}}

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	
	SWEP.LaserPosAdjust = Vector(0.5, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_csgo_acog", "md_m98b_scope"}},
	[2] = {header = "Barrel", offset = {-450, -300},  atts = {"md_csgo_silencer_rifle"}},
	[3] = {header = "Bipod", offset = {800, 100}, atts = {}},
	["+attack2"] = {header = "Perks", offset = {100, -300}, atts = {"pk_sleightofhand", "pk_light"}},
	["+reload"] = {header = "Ammo", offset = {-450, 100}, atts = {"am_magnum", "am_matchgrade"}}}

if CustomizableWeaponry_KK_HK416 then
		table.insert(SWEP.Attachments[1].atts, 2, "md_cod4_reflex")
		table.insert(SWEP.Attachments[1].atts, 6, "md_fas2_leupold")
		table.insert(SWEP.Attachments[3].atts, 1, "md_hk416_bipod")		
end

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "M14_Reload",
	idle = "idle",
	draw = "M14_Deploy"}
	
SWEP.Sounds = {M14_Reload = {{time = 0.6, sound = "CW_FOLEY_LIGHT"},
	{time = 0.8, sound = "CW_ICHI_YON_MAGOUT"},
	{time = 1.4, sound = "CW_FOLEY_LIGHT"},
	{time = 2, sound = "CW_ICHI_YON_MAGIN"},
	{time = 2.7, sound = "CW_FOLEY_LIGHT"},
	{time = 3.15, sound = "CW_ICHI_YON_BOLTBACK"},
	{time = 3.4, sound = "CW_ICHI_YON_BOLTRELEASE"}},
	
	M14_Deploy = {{time = 0, sound = "CW_FOLEY_MEDIUM"},
	{time = 0.7, sound = "CW_ICHI_YON_BOLTBACK"},
	{time = 0.9, sound = "CW_ICHI_YON_BOLTRELEASE"}}}

SWEP.SpeedDec = 40

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi", "auto"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 Rinic's Pack"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/weapons/v_ichi_yon.mdl"
SWEP.WorldModel		= "models/cw2/weapons/w_ichi_yon.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 80
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x51MM"

SWEP.FireDelay = 0.096
SWEP.FireSound = "CW_ICHI_YON_FIRE"
SWEP.FireSoundSuppressed = "CW_ICHI_YON_FIRE_SUPPRESSED"
SWEP.Recoil = 1.5

SWEP.HipSpread = 0.175
SWEP.AimSpread = 0.001
SWEP.VelocitySensitivity = 2.1
SWEP.MaxSpreadInc = 0.15
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.12
SWEP.Shots = 1
SWEP.Damage = 50
SWEP.DeployTime = 0.7

SWEP.RecoilToSpread = 1.3 -- the M14 in particular will have 30% more recoil from continuous fire to give a feeling of "oh fuck I should stop firing 7.62x51MM in full auto at 750 RPM"

SWEP.ReloadSpeed = 1.15
SWEP.ReloadTime = 2.5
SWEP.ReloadTime_Empty = 3.3
SWEP.ReloadHalt = 2.7
SWEP.ReloadHalt_Empty = 3.5

SWEP.SnapToIdlePostReload = true

function SWEP:IndividualThink()
		self.Animations.draw = "draw_norm"
			if self.Animations.draw == "draw_norm" then
		self.DeployTime = 0.3
	end
end