AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "arMag"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "De Lisle Carbine"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "w"
	killicon.Add( "", "", Color(255, 80, 0, 150))
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/khrcw2/w_khri_delisle.mdl"
	SWEP.WMPos = Vector(-1, 1.5, 0)
	SWEP.WMAng = Vector(-5, 0, 180)
	
	SWEP.MuzzleEffect = "muzzleflash_suppressed"
	SWEP.PosBasedMuz = true
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.55
	SWEP.FireMoveMod = 2
	SWEP.ShellDelay = .5
	SWEP.SightWithRail = false
	SWEP.DisableSprintViewSimulation = false
	
	SWEP.EffectiveRange_Orig = 80.4 * 39.37
	SWEP.DamageFallOff_Orig = .3

	SWEP.IronsightPos = Vector(2.03, -2, 0.2)
	SWEP.IronsightAng = Vector(0.7, -0.05, 0)
	
	SWEP.SG1Pos = Vector(2.03, -2, 0.2)
	SWEP.SG1Ang = Vector(0.7, -0.05, 0)
	
	SWEP.CustomizePos = Vector(-3.8889, -1.6667, -1.6667)
	SWEP.CustomizeAng = Vector(18, -30, -10)
	
	SWEP.SprintPos = Vector(-1.6667, 1.6667, -0.5556)
	SWEP.SprintAng = Vector(-14, -26, 6)
	
	SWEP.AlternativePos = Vector(0.2, 0, -0.4)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.025
	SWEP.ViewModelMovementScale = 1
	
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 90}
	SWEP.SchmidtShortDotAxisAlign = {right = 1, up = 0, forward = 0}
end

SWEP.SightBGs = {main = 2, scope = 1, none = 0}

SWEP.MuzzleVelocity = 255 -- in meter/s
SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = true


SWEP.Attachments = {
	[1] = {header = "Perks", offset = {400, 300}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
	[2] = {header = "Magazine Upgrade", offset = {-200, 250}, atts = {"a_zsmagssniper1", "a_zsmagssniper2", "a_zsmagssniper3"}},
	["+reload"] = {header = "Ammo", offset = {-300, -200}, atts = {"am_magnum2", "am_matchgrade2", "am_heavyhandload2", "am_grapeshot2", "am_rifdepleteduranium2", "am_ricochet2"}}}

SWEP.Animations = {fire = {"shoot2"},
	reload = "reloadnon",
	reload_empty = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {	shoot2 = {{time = .2, sound = "DELISLE_BOLT"}},

    draw = {{time = 0, sound = "AEK.Draw"}},

	reload = {[1] = {time = 0, sound = "KSKS.Cloth"},
	[2] = {time = .6, sound = "DELISLE_MAGOUT"},
	[3] = {time = 2.2, sound = "DELISLE_MAGIN1"},
	[4] = {time = 2.5, sound = "DELISLE_MAGIN2"},
	[5] = {time = 3.5, sound = "DELISLE_BOLT"}},
	
	reloadnon = {[1] = {time = 0, sound = "KSKS.Cloth"},
	[2] = {time = .6, sound = "DELISLE_MAGOUT"},
	[3] = {time = 2.2, sound = "DELISLE_MAGIN1"},
	[4] = {time = 2.5, sound = "DELISLE_MAGIN2"}}}

SWEP.ADSFireAnim = true
SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = .5, roll = .25, forward = .75, pitch = 1.5}

SWEP.SpeedDec = 25

SWEP.OverallMouseSens = 1
SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Khris"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.AimViewModelFOV = 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/khrcw2/v_khri_delisle.mdl"
SWEP.WorldModel		= "models/khrcw2/w_khri_delisle.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 11
SWEP.Primary.DefaultClip	= 11
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "357"
SWEP.ForceBackToHipAfterAimedShot = true
SWEP.ForcedHipWaitTime = .9

SWEP.FireDelay = 1.1
SWEP.FireSound = "DELISLE_FIRE"
SWEP.Recoil = .5

SWEP.HipSpread = 0.047
SWEP.AimSpread = 0.0007
SWEP.VelocitySensitivity = .5
SWEP.MaxSpreadInc = 0.01
SWEP.SpreadPerShot = 0.001
SWEP.SpreadCooldown = 1
SWEP.Shots = 1
SWEP.Damage = 91
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1.1
SWEP.ReloadTime = 3.6
SWEP.ReloadTime_Empty = 4.6
SWEP.ReloadHalt = 3.6
SWEP.ReloadHalt_Empty = 4.6

function SWEP:IndividualThink()
	self.EffectiveRange = 80.4 * 39.37
	self.DamageFallOff = .3
	
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 12.06 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .045))
	end
end