AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M16A4 (Ichi-Roku)"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "w"
	killicon.AddFont("cw_ar15", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.5
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0.6
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.73
	
	SWEP.M203OffsetCycle_Reload = 0.65
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0.6

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/cw2/weapons/w_ichi_roku.mdl"
	SWEP.WMPos = Vector(-0.5, -0.5, 0.2)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.IronsightPos = Vector(-1.871, -3.412, 0.087)
	SWEP.IronsightAng = Vector(0, 0, 0)
		
	SWEP.EoTechPos = Vector(-1.882, -3.276, -0.002)
	SWEP.EoTechAng = Vector(0.004, 0, 0)
	
	SWEP.AimpointPos = Vector(-1.879, -3.277, 0.215)
	SWEP.AimpointAng = Vector(0.004, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-1.88, -2.324, 0.214)

	SWEP.MicroT1Ang = Vector(-0.058, 0, 0)
	

	SWEP.CSGOACOGPos = Vector(-1.882, -2.145, 0.148)



	SWEP.CSGOACOGAng = Vector(0.004, 0, 0)
	
	SWEP.M203Pos = Vector(1.368, -1.481, 0)
	SWEP.M203Ang = Vector(11.897, 0, 0)
	
	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.211, -4, -0.95), [2] = Vector(-2, 0, 0)}}

	SWEP.CSGOACOGAxisAlign = {right = 0, up = 0, forward = -40}
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "M16_Body", rel = "", pos = Vector(-0.213, -6.119, -2.382), angle = Angle(0, 0, 0), size = Vector(0.85, 0.85, 0.85)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "M16_Body", rel = "", pos = Vector(0.273, -11.98, -8.299), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "M16_Body", rel = "", pos = Vector(-0.461, -6.486, -1.798), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_csgo_silencer_rifle"] = {model = "models/kali/weapons/csgo/eq_suppressor_rifle.mdl", bone = "M16_Body", rel = "", pos = Vector(0, 16.656, 0.791), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_cod4_reflex"] = {model = "models/v_cod4_reflex.mdl", bone = "M16_Body", rel = "", pos = Vector(0, -4.171, -0.231), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_orange_chan"] = {model = "models/fruit/slice.mdl", bone = "M16_Body", rel = "", pos = Vector(0.774, 1.95, 2.335), angle = Angle(-54.552, 0, -37.93), size = Vector(1.542, 1.542, 1.542)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "M16_Body", rel = "", pos = Vector(0.021, -0.944, 2.604), angle = Angle(0, 180, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_csgo_acog"] = {model = "models/kali/weapons/csgo/eq_optic_acog.mdl", bone = "M16_Body", rel = "", pos = Vector(0.041, -7.136, -0.94), angle = Angle(0, -90, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_lasersight"] = {model = "models/rageattachments/anpeqbf.mdl", bone = "M16_Body", rel = "", pos = Vector(0.97, 11.119, 2.619), angle = Angle(0, -90, 90), size = Vector(0.8, 0.8, 0.8)},
		["md_m203"] = {model = "models/cw2/attachments/m203.mdl", bone = "M16_Body", rel = "", pos = Vector(2.385, -10.396, 3.937), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), animated = true}
	}
	
	SWEP.M203HoldPos = {
		["Bip01 L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(1.485, 0.15, -2.212), angle = Angle(0, 0, 0) }
	}

	SWEP.ForeGripHoldPos = {
		["Bip01 L Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-20.753, 56.662, 31.134) },
	
		["Bip01 L Finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 15.477, 0) },
	
		["Bip01 L Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-34.694, 61.298, 14.765) },
	
		["Bip01 L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0.897, -5.789, 4.459), angle = Angle(-35.992, 20.711, 20.013) },
	
		["Bip01 L Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -8.648, 0) },
	
		["Bip01 L Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 89.114, 0) },
	
		["Bip01 L Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-44.939, 45.175, 0) },
	
		["Bip01 L Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-15.289, 0, 18.006) },
	
		["Bip01 L Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-20.906, 79.323, 0) },
	
		["Bip01 L Finger42"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 22.055, 0) },
	
		["Bip01 L Finger32"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 17.156, 0) },
	
		["Bip01 L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(15.248, -2.708, -4.256) },
	
		["Bip01 L ForeTwist1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 11.131) },
	
		["Bip01 L Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 22.1, 30.315) },
	
		["Bip01 L Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-7.49, 45.561, 34.914) },
	
		["Bip01 L Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(4.507, 36.146, -20.055) }
	}
	
	SWEP.AttachmentPosDependency = {["md_anpeq15"] = {["bg_longris"] = Vector(-0.225, 13, 3.15)},
	["md_saker"] = {["bg_longbarrel"] = Vector(-0.042, 9, -0.1), ["bg_longris"] = Vector(-0.042, 9, -0.1)}}
	
	SWEP.LaserPosAdjust = Vector(1, 50, 3)
	SWEP.LaserAngAdjust = Angle(0, 0, 0) 
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -500}, atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_csgo_acog"}},
	[2] = {header = "Barrel", offset = {300, -500}, atts = {"md_csgo_silencer_rifle"}},
	[3] = {header = "Handguard", offset = {-400, 0}, atts = {"md_foregrip", "md_m203"}},
	[4] = {header = "Upotte!!", offset = {800, 400}, atts = {"md_orange_chan"}},
	[5] = {header = "Magazine Upgrade", offset = {200, 300}, atts = {"a_zsmagar1", "a_zsmagar2", "a_zsmagar3"}},
	[6] = {header = "Perks", offset = {-100, -200}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
	["+reload"] = {header = "Ammo", offset = {800, 0},  atts = {"am_highcaliberrounds2", "am_hqb2", "am_magnum2", "am_matchgrade2", "am_luckylast2", "am_duplex2", "am_depleteduranium2"}}}



SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	reload_empty = "reload_empty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {[1] = {time = 0, sound = "CW_FOLEY_MEDIUM"},
	[2] = {time = 0.65, sound = "CW_ICHI_ROKU_BOLT"}},

	reload = {[1] = {time = 0.35, sound = "CW_ICHI_ROKU_MAGOUT"},
	[2] = {time = 1.05, sound = "CW_ICHI_ROKU_MAGIN"}},

	reload_empty = {[1] = {time = 0.35, sound = "CW_ICHI_ROKU_MAGOUT"},
	[2] = {time = 1.05, sound = "CW_ICHI_ROKU_MAGIN"},
	[3] = {time = 1.8, sound = "CW_ICHI_ROKU_BOLTBACK"},
	[4] = {time = 2, sound = "CW_ICHI_ROKU_BOLTFORWARD"}}}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"3burst", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 Rinic's Pack"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/weapons/v_ichi_roku.mdl"
SWEP.WorldModel		= "models/cw2/weapons/w_ichi_roku.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 150
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "AR2"

SWEP.FireDelay = 0.054034151547492
SWEP.FireSound = "CW_ICHI_ROKU_FIRE"
SWEP.FireSoundSuppressed = "CW_ICHI_ROKU_FIRE_SUPPRESSED"
SWEP.Recoil = 0.3

SWEP.HipSpread = 0.025
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.15
SWEP.SpreadPerShot = 0.015
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 250
SWEP.DeployTime = 0.3

SWEP.ReloadSpeed = 1.15
SWEP.ReloadTime = 1.4
SWEP.ReloadTime_Empty = 1.95
SWEP.ReloadHalt = 1.45
SWEP.ReloadHalt_Empty = 2.15

function SWEP:IndividualThink()
		self.Animations.draw = "draw_norm"
			if self.Animations.draw == "draw_norm" then
		self.DeployTime = 0.3
	end
end