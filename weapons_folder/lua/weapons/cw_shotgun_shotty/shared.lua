AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Serbu Super Shorty"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "q"
	killicon.AddFont("cw_short", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("vgui/hud/short")
	
	SWEP.MuzzleEffect = "muzzleflash_m3"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.Shell = "shotshell"
	SWEP.ShellDelay = 0.7
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_supershort.mdl"
	SWEP.WMPos = Vector(-1, 1.5, 0)
	SWEP.WMAng = Vector(-4, 0, 180)
	
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 1
	
	SWEP.ReticleInactivityPostFire = 1.0
	
	SWEP.SightWithRail = true
		
	SWEP.IronsightPos = Vector(4.3, 0, 2.279)
	SWEP.IronsightAng = Vector(0, 0, -0.561)
	
	SWEP.FrontRearPos = Vector(-4.841, -6.052, 1.159)
    SWEP.FrontRearAng = Vector(0, 0.101, 0)
	
	SWEP.MicroT1Pos = Vector(-4.801, -5.904, 1.24)
    SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-4.83, -4.501, 1.559)
    SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.CSGO556Pos = Vector(-4.856, -6.165, 1.319)
    SWEP.CSGO556Ang = Vector(0, 0, 0)
	
	SWEP.ReflexPos = Vector(-4.815, -4.068, 1.437)
    SWEP.ReflexAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-4.85, -7.239, 1.041)
    SWEP.AimpointAng = Vector(0.515, 0, 0)
			
	SWEP.ACOGPos = Vector(-4.864, -7.505, 0.839)
    SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.SprintPos = Vector(-2.152, 0, 1.504)
    SWEP.SprintAng = Vector(-12.664, -22.514, 0)
		
	SWEP.CustomizePos = Vector(-2.211, -0.603, 2.21)
	SWEP.CustomizeAng = Vector(11.255, -7.739, -23.216)
		
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-4.861, -7.505, -0.584), [2] = Vector(0, 0, 0)}}

	SWEP.SightWithRail = true
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 50.5}
	SWEP.CSGO556AxisAlign = {right = 0, up = 0, forward = 50.5}
	
	SWEP.AlternativePos = Vector(-0.64, 0.294, -0.978)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.CustomizationMenuScale = 0.016
	SWEP.ReticleInactivityPostFire = 0.6

	SWEP.AttachmentModelsVM = { ["md_saker"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "shawtgun", rel = "", pos = Vector(0.289, -1.433, 9.807), angle = Angle(-180, 21.562, -90), size = Vector(0.628, 0.628, 0.628), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }

}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	
	SWEP.LaserPosAdjust = Vector(0.8, 0, 0.3)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.ADSFireAnim = true

SWEP.Attachments = { -- [1] = {header = "Barrel", offset = {100, -500}, atts = {"md_saker"}},
	[1] = {header = "Drum Magazines", offset = {-800, -250}, atts = {"a_zsmagshotgun1", "a_zsmagshotgun2", "a_zsmagshotgun3"}},
	[2] = {header = "Perks", offset = {-100, -200}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
	["+reload"] = {header = "Ammo", offset = {-200, 100}, atts = {"am_flechetterounds2", "am_slugrounds2", "am_shrapnel2", "am_minishells2", "am_sabots2", "am_dragonsbreath2", "am_explosive2", "am_kristallnacht2"}}
}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload_start = "start_reload",
	insert = "insert",
	reload_end = "end_reload",
	idle = "idle",
	draw = "draw2"}
	
SWEP.Sounds = { insert = {{time = 0.1, sound = "CW_SERBU_INSERT"}},
	
	--draw2 = {{time = 0.2, sound = "CW_SERBU_PUMP"}},
	end_reload = {{time = 0.4, sound = "CW_SERBU_PUMP"}},
	shoot1 = {{time = 0.4, sound = "CW_SERBU_PUMP"}},
	shoot2 = {{time = 0.4, sound = "CW_SERBU_PUMP2"}}}

SWEP.SpeedDec = 15

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "shotgun"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"pump"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 Shotgun Pack"

SWEP.Author			= "Shot"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/shotgun/v_supershort.mdl"
SWEP.WorldModel		= "models/weapons/w_supershort.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 4
SWEP.Primary.DefaultClip	= 12
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Buckshot"

SWEP.FireDelay = 0.9
SWEP.FireSound = "CW_SERBU_FIRE"
SWEP.FireSoundSuppressed = "CW_SHOTGUN_FIRESIL"
SWEP.Recoil = 4

SWEP.HipSpread = 0.2
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.9
SWEP.MaxSpreadInc = 0.06
SWEP.ClumpSpread = 0.04
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.8
SWEP.Shots = 12
SWEP.Damage = 12
SWEP.DeployTime = 1

SWEP.ReloadStartTime = 0.5
SWEP.InsertShellTime = 0.5
SWEP.ReloadFinishWait = 1.3
SWEP.ShotgunReload = true

SWEP.Chamberable = false