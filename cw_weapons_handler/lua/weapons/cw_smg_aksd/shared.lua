AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "AK-SD"
	SWEP.CSMuzzleFlashes = true

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "Models/cw2/Weapons/w_rif_aksd.mdl"
	SWEP.WMPos = Vector(-0.7, 2.7, 0)
	SWEP.WMAng = Vector(-3, 0, 180)
	
	SWEP.IronsightPos = Vector(-1.749, -2.477, 0.09)

	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-1.747, -1.714, -0.315)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-1.747, -1.535, -0.650)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.KobraPos = Vector(-1.673, -2.302, -0.193)
	SWEP.KobraAng = Vector(1.138, 0, 0)
	



	
	SWEP.CSGOACOGPos = Vector(-1.739, -1.591, -0.408)

	SWEP.CSGOACOGAng = Vector(0, 0, 0)

	SWEP.SprintPos = Vector(1.822, 0, -0.427)

	SWEP.SprintAng = Vector(-16.42, 22.235, -2.984)

	SWEP.CustomizePos = Vector(3.667, 0, -0.821)
	SWEP.CustomizeAng = Vector(10.213, 29.43, -3.471)
	
	SWEP.AlternativePos = Vector(-0.24, 0, -0.48)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.M203Pos = Vector(1.368, -1.481, 0)
	SWEP.M203Ang = Vector(11.897, 0, 0)

	SWEP.M203OffsetCycle_Reload = 0.81
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0
	
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}

	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)

	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "b"
	killicon.AddFont("cw_ak74", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.PosBasedMuz = false
	SWEP.ShellScale = 0.5
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.SightWithRail = true
	SWEP.ForeGripOffsetCycle_Draw = 0.7
	SWEP.ForeGripOffsetCycle_Reload = 0.75
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9
	
	SWEP.BoltBone = "AKSD_Bolt"
	SWEP.BoltShootOffset = Vector(-3.6, 0, 0)
	SWEP.OffsetBoltOnBipodShoot = true

	SWEP.M203HoldPos = {
		["Bip01 L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(2.076, 0.145, -2.27), angle = Angle(0, 0, 0)}
	}
	
	SWEP.AttachmentModelsVM = {
		["md_rail"] = {model = "models/wystan/attachments/akrailmount.mdl", bone = "AKSD_Body", rel = "", pos = Vector(-2.159, -7.559, 2.466), angle = Angle(180, 180, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "AKSD_Body", rel = "", pos = Vector(-1.724, 2.273, 10.666), angle = Angle(180, -90, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_lasersight"] = {model = "models/rageattachments/anpeqbf.mdl", bone = "AKSD_Body", rel = "", pos = Vector(-0.828, -21.73, 1.565), angle = Angle(180, -90, 90), size = Vector(1, 1, 1)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "AKSD_Body", rel = "", pos = Vector(-2.133, -3.211, 4.702), angle = Angle(180, 180, 0), size = Vector(0.649, 0.649, 0.649)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "AKSD_Body", rel = "", pos = Vector(-1.586, -29.014, 6.105), angle = Angle(180, 0, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_pbs1"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "ak74_body", pos = Vector(-19.57, 0, -0.816), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_kobra"] = {model = "models/cw2/attachments/kobra.mdl", bone = "AKSD_Body", rel = "", pos = Vector(-1.512, -8.754, 4.328), angle = Angle(180, 0, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_csgo_acog"] = {model = "models/kali/weapons/csgo/eq_optic_acog.mdl", bone = "AKSD_Body", rel = "", pos = Vector(-1.922, -2.738, 3.713), angle = Angle(180, -90, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_m203"] = {model = "models/cw2/attachments/m203.mdl", bone = "AKSD_Body", rel = "", pos = Vector(0.342, -0.698, 0.381), angle = Angle(180, -90, 0), size = Vector(1, 1, 1), animated = true}
	}

	SWEP.ForeGripHoldPos = {
		["Bip01 L Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-23.574, 72.832, 20.068) },
	
		["Bip01 L Finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 15.826, 0) },
	
		["Bip01 L Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-14.11, 112.958, 36.361) },
	
		["Bip01 L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0.908, -4.146, 1.019), angle = Angle(-49.626, 26.582, -4.829) },
	
		["Bip01 L Finger22"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 27.402, 0) },
	
		["Bip01 L Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 27.27, 7.199) },
	
		["Bip01 L Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(18.062, 44.591, 0) },
	
		["Bip01 L Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(7.922, 43.791, 0) },
	
		["Bip01 L Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-21.83, 51.882, 14.961) },
	
		["Bip01 L Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-21.039, 119.319, 49.769) },
	
		["Bip01 L ForeTwist1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0.331) },
	
		["Bip01 L Finger42"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 20.334, 0) },
	
		["Bip01 L Finger32"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 21.486, 0) },
	
		["Bip01 L Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 24.924, 11.786) },
	
		["Bip01 L Finger12"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0.691, 11.795, 0) },
	
		["Bip01 L Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 17.775, 0) },
	
		["Bip01 L Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(26.69, 62.341, 0.823) },
	
		["Bip01 L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(28.381, -3.859, 52.625) }}
		
	SWEP.LaserPosAdjust = Vector(0.5, 0, 2.3)
	SWEP.LaserAngAdjust = Angle(-0.5, 0, 0)

	SWEP.CSGOACOGAxisAlign = {right = -0.1, up = -0.1, forward = -40}
	SWEP.AttachmentPosDependency = {["md_pbs1"] = {["bg_ak74_rpkbarrel"] = Vector(-28, 0, -0.816), ["bg_ak74_ubarrel"] = Vector(-14, 0, -0.88)}}
end

SWEP.LuaViewmodelRecoil = true
SWEP.SightBGs = {main = 2, none = 1}

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -500},  atts = {"md_kobra", "md_eotech", "md_aimpoint", "md_csgo_acog"}},
	 [2] = {header = "Perks", offset = {200, 400}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
	[3] = {header = "Underbarrel", offset = {-500, 200},  atts = {"md_foregrip", "md_m203"}},
	[4] = {header = "Magazine Upgrade", offset = {-100, -250}, atts = {"a_zsmagsmg1", "a_zsmagsmg2", "a_zsmagsmg3"}},
	["+reload"] = {header = "Ammo", offset = {800, 0}, atts = {"am_magnum2", "am_matchgrade2", "am_hqb2", "am_duplex2", "am_highcaliberrounds2", "am_luckylast2"}}}


SWEP.Animations = {fire = {"fire1", "fire2", "fire3"},
	reload = "reload",
	reload_empty = "reload_empty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {	draw = {[1] = {time = 0, sound = "CW_FOLEY_MEDIUM"},
	[2] = {time = 0.6, sound = "CW_AKSD_BOLTPULL"}},

	reload = {[1] = {time = 0.86, sound = "CW_AKSD_MAGOUT"},
	[2] = {time = 1.15, sound = "CW_AKSD_MAGIN"}},

	reload_empty = {[1] = {time = 0.86, sound = "CW_AKSD_MAGOUT"},
	[2] = {time = 1.15, sound = "CW_AKSD_MAGIN"},
	[3] = {time = 2.14, sound = "CW_AKSD_BOLTPULL"}}}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 Rinic's Pack"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "Models/cw2/Weapons/v_rif_aksd.mdl"
SWEP.WorldModel		= "Models/cw2/Weapons/w_rif_aksd.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 150
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SMG1"

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_AKSD_FIRE"
SWEP.FireSoundSuppressed = "CW_AKSD_FIRE_SUPPRESSED"
SWEP.Recoil = 0.6

SWEP.HipSpread = 0.075
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.6
SWEP.MaxSpreadInc = 0.09
SWEP.SpreadPerShot = 0.07
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 34
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 1.15
SWEP.ReloadTime = 1.3
SWEP.ReloadTime_Empty = 2.5
SWEP.ReloadHalt = 1.5
SWEP.ReloadHalt_Empty = 2.7
SWEP.SnapToIdlePostReload = false

SWEP.SuppressedOnEquip = true

function SWEP:IndividualThink()
		self.Animations.draw = "draw_norm"
			if self.Animations.draw == "draw_norm" then
		self.DeployTime = 0.21
	end
end