AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M240 (MW2)"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.0
	SWEP.ViewbobIntensity = 1.0
	SWEP.FireMoveMod = 1.3
	
	SWEP.BoltBone = "mw2_m240_bolt"
	SWEP.BoltShootOffset = Vector(-3, 0, 0)
	SWEP.OffsetBoltOnBipodShoot = true
	
	SWEP.IconLetter = "w"
	killicon.AddFont("", "", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = true
	SWEP.MuzzlePosMod = {x = 0, y = 5, z = -1.2}
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.5
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/cw2/weapons/w_mach_m240rinic.mdl"
	SWEP.WMPos = Vector(4, 1, -0.5)
	SWEP.WMAng = Vector(-5, -90, 180)

	SWEP.IronsightPos = Vector(-3.72, -2.937, 1.047)

    	SWEP.IronsightAng = Vector(0.07, 0, 0)
	
	SWEP.AimpointPos = Vector(-3.735, -6.722, 0.503)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-3.713, -6.393, 0.239)
	SWEP.EoTechAng = Vector(0.279, 0, 0)
	
	SWEP.CoD4ReflexPos = Vector(-3.721, -6.091, 0.488)
	SWEP.CoD4ReflexAng = Vector(0, 0, 0)
	
	SWEP.KobraPos = Vector(-2.55, -3.224, -0.026)
	SWEP.KobraAng = Vector(0.717, -0.638, 0)
	
	SWEP.MicroT1Pos = Vector(-3.734, -4.898, 0.476)

	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.CSGOACOGPos = Vector(-3.712, -6.783, 0.328)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(5.592, -3.03, -1.729)
    	SWEP.SprintAng = Vector(-19.247, 44.048, -20.893)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-3.409, -6.31, -0.501), [2] = Vector(-0.84, 0.273, 0)}}
	
	SWEP.AlternativePos = Vector(-0.24, 0, -0.48)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.CSGOACOGAxisAlign = {right = 0, up = 0, forward = -40}
	
	SWEP.AttachmentModelsVM = {
	["md_aimpoint"] = { model = "models/wystan/attachments/aimpoint.mdl", bone = "mw2_m240_cover", rel = "", pos = Vector(3.278, 5.532, 5.67), angle = Angle(0, 180, 180), size = Vector(0.85, 0.85, 0.85)},
	["md_eotech"] = { model = "models/wystan/attachments/2otech557sight.mdl", bone = "mw2_m240_cover", rel = "", pos = Vector(2.775, -0.612, 11.572), angle = Angle(180, 90, 0), size = Vector(1, 1, 1)},
	["md_microt1"] = { model = "models/cw2/attachments/microt1.mdl", bone = "mw2_m240_cover", rel = "", pos = Vector(3.042, 11.064, 0.676), angle = Angle(180, 180, 0), size = Vector(0.4, 0.4, 0.4)},
	["md_anpeq15"] = { model = "models/cw2/attachments/anpeq15.mdl", bone = "body", rel = "", pos = Vector(11.972, -5.123, 0.398), angle = Angle(-0.322, 0.083, -90.555), size = Vector(0.5, 0.5, 0.5)},
	["md_csgo_acog"] = {model = "models/kali/weapons/csgo/eq_optic_acog.mdl", bone = "mw2_m240_cover", rel = "", pos = Vector(3, 4.798, 4.421), angle = Angle(0, -90, 180), size = Vector(0.8, 0.8, 0.8)},
	["md_csgo_silencer_rifle"] = {model = "models/kali/weapons/csgo/eq_suppressor_rifle.mdl", bone = "mw2_m240_frame", rel = "", pos = Vector(3.043, 36.451, 2.036), angle = Angle(0, -90, 0), size = Vector(0.699, 0.699, 0.699)},
	["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "cover", rel = "", pos = Vector(-0.184, -10.093, -3.815), angle = Angle(-91.204, 0.182, -88.82), size = Vector(0.754, 0.754, 0.754), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_cod4_reflex"] = {model = "models/v_cod4_reflex.mdl", bone = "mw2_m240_cover", rel = "", pos = Vector(3.052, 7.103, 3.451), angle = Angle(180, -90, 0), size = Vector(0.8, 0.8, 0.8)},
	["md_csgo_556"] = { type = "Model", model = "models/kali/weapons/csgo/eq_optic_sig.mdl", bone = "cover", rel = "", pos = Vector(-4.713, -0.533, -1.058), angle = Angle(0, 0, -89.885), size = Vector(0.736, 0.736, 0.736), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }

}
	
	SWEP.LaserPosAdjust = Vector(1, 5, 0)
	SWEP.LaserAngAdjust = Angle(2, 0, 0) 

end

SWEP.ReceiverBGs = {main = 3, regular = 0, m240_bipod = 1}
SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = false

SWEP.Attachments = {[1] = {header = "Sight", offset = {500, -500}, atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_csgo_acog"}},
	[2] = {header = "Barrel", offset = {-500, -300}, atts = {"md_csgo_silencer_rifle"}},
	[3] = {header = "Bullet Belts", offset = {-200, 0}, atts = {"a_zsmagslmg1", "a_zsmagslmg2", "a_zsmagslmg3"}},
	[4] = {header = "Perks", offset = {400, 300}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap"}},
	["+reload"] = {header = "Ammo", offset = {700, 0}, atts = {"am_magnum2", "am_matchgrade2", "am_duplex2", "am_ricochet2", "am_tracers2", "am_luckylast2", "am_rifdepleteduranium2"}}}



SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_MW2_M240_DRAW"}},

	reload = {[1] = {time = 0.15, sound = "CW_MW2_M240_bolt"},
	[2] = {time = 1.59, sound = "CW_MW2_M240_Coverup"},
	[3] = {time = 2.01, sound = "CW_MW2_M240_Boxout"},
	[4] = {time = 3.17, sound = "CW_MW2_M240_Boxin"},
	[5] = {time = 3.65, sound = "CW_MW2_M240_Chain"},
	[6] = {time = 4.45, sound = "CW_MW2_M240_Coverdown"},
	[7] = {time = 4.58, sound = "CW_MW2_M240_Coverup"}}}

SWEP.SpeedDec = 70

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 Rinic's Pack"
SWEP.Suppressable = false

SWEP.Author			= "Rinic"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/weapons/v_mach_m240rinic.mdl"
SWEP.WorldModel		= "models/cw2/weapons/w_mach_m240rinic.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 500
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Alyxgun"

SWEP.FireDelay = 0.0638297872340426
SWEP.FireSound = "CW_MW2_M240"
SWEP.FireSoundSuppressed = "CW_MW2_M240_SUPP"
SWEP.Recoil = 0.45

SWEP.ADSFireAnim = false
SWEP.BipodFireAnim = true

SWEP.HipSpread = 0.145
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.12
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 44
SWEP.DeployTime = 0.8

SWEP.ReloadSpeed = 0.8
SWEP.ReloadTime = 4.72
SWEP.ReloadTime_Empty = 4.72
SWEP.ReloadHalt = 4.92
SWEP.ReloadHalt_Empty = 4.92
SWEP.SnapToIdlePostReload = false
SWEP.Chamberable = false