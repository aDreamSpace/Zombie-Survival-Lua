AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M27 IAR (Ghosts)"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "w"
	killicon.AddFont("cw_ar15", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.4
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9
	
	SWEP.M203OffsetCycle_Reload = 0.65
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/cw2/weapons/w_ghosts_m27iar.mdl"
	SWEP.WMPos = Vector(-0.3, 3, 0)
	SWEP.WMAng = Vector(-5, -2, 180)

	SWEP.IronsightPos = Vector(-2.602, -2.457, 0.4)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.FoldSightPos = Vector(-2.208, -4.3, 0.143)
	SWEP.FoldSightAng = Vector(0.605, 0, -0.217)
		
	SWEP.EoTechPos = Vector(-2.648, -3.739, 0.303)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.CoD4TascoPos = Vector(-2.612, -3.322, 0.815)
	SWEP.CoD4TascoAng = Vector(0, 0, 0)

	SWEP.BackupReflexPos = Vector(-1.165, -6.244, 1.21)
	SWEP.BackupReflexAng = Vector(0, 0, 45)
	
	SWEP.MicroT1Pos = Vector(-2.615, -2.853, 0.349)

	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.CoD4ReflexPos = Vector(-2.618, -2.853, 0.527)
	SWEP.CoD4ReflexAng = Vector(0, 0, 0)
	
	SWEP.CSGOACOGPos = Vector(-2.592, -3.128, 0.361)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)

	SWEP.SprintPos = Vector(1.465, 0, 1.531)
	SWEP.SprintAng = Vector(-22.983, 25.122, 0)

	SWEP.CustomizePos = Vector(4.168, 0, 0)
	SWEP.CustomizeAng = Vector(8.694, 28.868, 0.967)
	
	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.211, -4, -0.95), [2] = Vector(-2, 0, 0)}}

	SWEP.CSGOACOGAxisAlign = {right = -0.1, up = -0.1, forward = -40}
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_cod4_aimpoint_v2"] = {model = "models/v_cod4_aimpoint.mdl", bone = "body", rel = "", pos = Vector(-0.091, -0.676, 0.165), angle = Angle(0, -180, 90), size = Vector(0.85, 0.85, 0.85)},
		["md_cod4_reflex"] = {model = "models/v_cod4_reflex.mdl", bone = "body", rel = "", pos = Vector(-0.732, -0.857, 0.187), angle = Angle(-180, 0, -90), size = Vector(0.8, 0.8, 0.8)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "body", rel = "", pos = Vector(-8.256, 7.26, -0.046), angle = Angle(0, 0, -90), size = Vector(1, 1, 1)},
		["md_backup_reflex"] = {model = "models/c_docter.mdl", bone = "body", rel = "", pos = Vector(9.876, -3.139, -0.695), angle = Angle(0, 0, -135.943), size = Vector(0.8, 0.8, 0.8)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "smdimport001", rel = "", pos = Vector(-0.452, -2.556, -1.428), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "body", rel = "", pos = Vector(10.177, -2.48, -1.599), angle = Angle(0, 90, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "body", rel = "", pos = Vector(3.19, -3.721, 0.175), angle = Angle(90, -90, 0), size = Vector(0.449, 0.449, 0.449)},
		["md_csgo_acog"] = {model = "models/kali/weapons/csgo/eq_optic_acog.mdl", bone = "body", rel = "", pos = Vector(-3.047, 0.101, 0.128), angle = Angle(0, 0, -90), size = Vector(0.8, 0.8, 0.8)},
		["md_lasersight"] = {model = "models/rageattachments/anpeqbf.mdl", bone = "body", rel = "", pos = Vector(13.157, -3.71, -0.749), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_m203"] = {model = "models/cw2/attachments/m203.mdl", bone = "smdimport001", pos = Vector(2.299, -6.611, 4.138), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), animated = true}
	}
	
	SWEP.M203HoldPos = {
		["Bip01 L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-2.76, 2.651, 1.386), angle = Angle(0, 0, 0) }
	}

	SWEP.ForeGripHoldPos = {
		["Bip01 L Finger3"] = {pos = Vector(0, 0, 0), angle = Angle(0, 42.713, 0) },
		["Bip01 L Clavicle"] = {pos = Vector(-3.299, 1.235, -1.79), angle = Angle(-55.446, 11.843, 0) },
		["Bip01 L Forearm"] = {pos = Vector(0, 0, 0), angle = Angle(0, 0, 42.41) },
		["Bip01 L Finger02"] = {pos = Vector(0, 0, 0), angle = Angle(0, 71.308, 0) },
		["Bip01 L Finger11"] = {pos = Vector(0, 0, 0), angle = Angle(0, 25.795, 0) },
		["Bip01 L Finger4"] = {pos = Vector(0, 0, 0), angle = Angle(0, 26.148, 0) },
		["Bip01 L Finger1"] = {pos = Vector(0, 0, 0), angle = Angle(6.522, 83.597, 0) },
		["Bip01 L Finger0"] = {pos = Vector(0, 0, 0), angle = Angle(23.2, 16.545, 0) },
		["Bip01 L Finger42"] = {pos = Vector(0, 0, 0), angle = Angle(0, 31.427, 0) },
		["Bip01 L Finger32"] = {pos = Vector(0, 0, 0), angle = Angle(0, 29.565, 0) },
		["Bip01 L Hand"] = {pos = Vector(0, 0, 0), angle = Angle(9.491, 14.793, -15.926) },
		["Bip01 L Finger12"] = {pos = Vector(0, 0, 0), angle = Angle(0, -9.195, 0) },
		["Bip01 L Finger21"] = {pos = Vector(0, 0, 0), angle = Angle(0, 10.164, 0) },
		["Bip01 L Finger01"] = {pos = Vector(0, 0, 0), angle = Angle(0, 18.395, 0) },
		["Bip01 L Finger2"] = {pos = Vector(0, 0, 0), angle = Angle(2.411, 57.007, 0) }
	}
	
	SWEP.AttachmentPosDependency = {["md_anpeq15"] = {["bg_longris"] = Vector(-0.225, 13, 3.15)},
	["md_saker"] = {["bg_longbarrel"] = Vector(-0.042, 9, -0.1), ["bg_longris"] = Vector(-0.042, 9, -0.1)}}
	
	SWEP.LaserPosAdjust = Vector(0.3, 5, 1.9)
	SWEP.LaserAngAdjust = Angle(0, 0, 0) 
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = false

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -500}, atts = {"md_microt1", "md_eotech", "md_csgo_acog"}},
	[2] = {header = "Barrel", offset = {300, -500}, atts = {"md_saker"}},
	[3] = {header = "Bullet Belts", offset = {-200, 0}, atts = {"a_zsmagslmg1", "a_zsmagslmg2", "a_zsmagslmg3"}},
	[4] = {header = "Perks", offset = {400, 300}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap"}},
	["+reload"] = {header = "Ammo", offset = {700, 0}, atts = {"am_magnum2", "am_matchgrade2", "am_duplex2", "am_ricochet2", "am_tracers2", "am_luckylast2", "am_rifdepleteduranium2"}}}



SWEP.AttachmentDependencies = {["md_m203"] = {"bg_longris"}} -- this is on a PER ATTACHMENT basis, NOTE: the exclusions and dependencies in the Attachments table is PER CATEGORY

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	reload_empty = "reload_empty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {[1] = {time = 0, sound = "CW_FOLEY_MEDIUM"},
	[2] = {time = 0.25, sound = "CW_GHOSTS_M27IAR_BOLTBACK"},
	[3] = {time = 0.45, sound = "CW_GHOSTS_M27IAR_BOLTFORWARD"}},

	reload = {[1] = {time = 0.35, sound = "CW_GHOSTS_M27IAR_MAGOUT"},
	[2] = {time = 1.07, sound = "CW_FOLEY_LIGHT"},
	[3] = {time = 1.65, sound = "CW_GHOSTS_M27IAR_MAGIN"}},

	reload_empty = {[1] = {time = 0.35, sound = "CW_GHOSTS_M27IAR_MAGOUT"},
	[2] = {time = 1.07, sound = "CW_FOLEY_LIGHT"},
	[3] = {time = 1.65, sound = "CW_GHOSTS_M27IAR_MAGIN"},
	[4] = {time = 2.45, sound = "CW_GHOSTS_M27IAR_BOLTBACK"},
	[5] = {time = 2.65, sound = "CW_GHOSTS_M27IAR_BOLTFORWARD"}}}

SWEP.SpeedDec = 80

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "3burst", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 Rinic's Pack"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/weapons/v_ghosts_m27iar.mdl"
SWEP.WorldModel		= "models/cw2/weapons/w_ghosts_m27iar.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 300
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Alyxgun"

SWEP.FireDelay = 0.05
SWEP.FireSound = "CW_GHOSTS_M27IAR_FIRE"
SWEP.FireSoundSuppressed = "CW_GHOSTS_M27IAR_FIRE_SUPPRESSED"
SWEP.Recoil = 0.65

SWEP.HipSpread = 0.155
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.15
SWEP.SpreadPerShot = 0.009
SWEP.SpreadCooldown = 0.23
SWEP.Shots = 1
SWEP.Damage = 42
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 0.81
SWEP.ReloadTime = 1.69
SWEP.ReloadTime_Empty = 2.68
SWEP.ReloadHalt = 1.89
SWEP.ReloadHalt_Empty = 2.88

SWEP.BipodInstalled = true
SWEP.BipodFireAnim = true

function SWEP:IndividualThink()
	if self.FireMode == "3burst" then
		self.FireDelay = 0.03
	else 
		self.FireDelay = 0.05
	end
		self.Animations.draw = "draw_norm"
			if self.Animations.draw == "draw_norm" then
		self.DeployTime = 0.3
	end
end

function SWEP:CycleFiremodes()
	t = self.FireModes
	
	if not t.last then
		t.last = 2
	else
		if not t[t.last + 1] then
			t.last = 1
		else
			t.last = t.last + 1
		end
	end
	
	if self.dt.State == CW_AIMING or self:isBipodDeployed() then
		if self.FireModes[t.last] == "safe" then
			t.last = 1
		end
	end
	
	if self.FireMode != self.FireModes[t.last] and self.FireModes[t.last] then
		CT = CurTime()
		self:SelectFiremode(self.FireModes[t.last])
		self:SetNextPrimaryFire(CT + 0.25)
		self:SetNextSecondaryFire(CT + 0.25)
		self.ReloadWait = CT + 0.25
	end
	
	if self.FireMode == "3burst" then
		self.FireDelay = 0.03
	else 
		self.FireDelay = 0.05
	end
end