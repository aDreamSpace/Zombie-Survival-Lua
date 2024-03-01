AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
SWEP.Base = "cw_base"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Scraping Spear"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.DrawTraditionalWorldModel = false
	
	SWEP.CustomizePos = Vector(0, 0, 0)
	SWEP.CustomizeAng = Vector(0, 0, 0)
end

SWEP.Animations = {
	slash_primary = {"attack1", "attack2"},
	slash_secondary = {"powerattack1", "powerattack2"},
	draw = "draw",
	idle = "idle"
}

SWEP.SpecialCAnimation = true
SWEP.CustomizationAnims = {to = {"toinspect", 2}, from = {"frominspect", 2}}

SWEP.Sounds = {
	attack1 = {{time = 0.05, sound = "CW_FOLEY_MEDIUM"}, {time = 0.8, sound = "CW_SPEAR_SWING"}},
	attack2 = {{time = 0.05, sound = "CW_FOLEY_MEDIUM"}, {time = 0.8, sound = "CW_SPEAR_SWING"}},
	powerattack1 = {{time = 0.05, sound = "CW_FOLEY_MEDIUM"}, {time = 1.6, sound = "CW_FOLEY_HEAVY"}, {time = 1.5, sound = "CW_SPEAR_SWING_HEAVY"}},
	powerattack2 = {{time = 0.05, sound = "CW_FOLEY_MEDIUM"}, {time = 1.5, sound = "CW_FOLEY_HEAVY"}, {time = 1.5, sound = "CW_SPEAR_SWING_HEAVY"}},
	stab = {{time = 0.1, sound = "CW_KNIFE_SLASH"}},
	draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}, {time = 0.8, sound = "CW_FOLEY_HEAVY"}, {time = 1.65, sound = "CW_FOLEY_MEDIUM"}},
	toinspect = {{time = 0.1, sound = "CW_FOLEY_LIGHT"}},
	frominspect = {{time = 0.4, sound = "CW_FOLEY_LIGHT"}},
}


SWEP.MiscHitSoundsSecondary = SWEP.MiscHitSounds
SWEP.MiscHitSounds = {"CW_SWORD_SLASH_WALL"}
SWEP.Slot = 0
SWEP.SlotPos = 0
SWEP.Category = "CW 2.0"

SWEP.CW20Melee 		= true


SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 90
SWEP.ViewModelFlip	= false
SWEP.ViewModel = "models/cw2/melee/polearms/c_melee_polearm.mdl"
SWEP.WorldModel = "models/demonssouls/weapons/scraping spear.mdl"
SWEP.WM = "models/demonssouls/weapons/scraping spear.mdl"
SWEP.WMPos = Vector(2, 1, 3)
SWEP.WMAng = Vector(-90, 0, 0)
SWEP.UseHands = true
SWEP.CanCustomize = true

SWEP.ViewModelMovementScale = 6
SWEP.Attachments = {
	["+reload"] = {header = "Infusion", offset = {-300, -200}, atts = {"md_m_inf_sharp", "md_m_inf_heavy", "md_m_inf_raw"}}
}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 0
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ""

SWEP.PrimaryAttackDelay = 1
SWEP.SecondaryAttackDelay = 3

SWEP.FireAnimSpeed = 1.3
SWEP.FireAnimSpeedSecondary = 1

SWEP.PrimaryAttackDamage = {349, 350}
SWEP.SecondaryAttackDamage = {399, 400} 

SWEP.PrimaryAttackRange = 110
SWEP.SecondaryAttackRange = 125

SWEP.HolsterTime = 0.4
SWEP.DeployTime = 0.6

SWEP.SpeedDec = 50

SWEP.PrimaryAttackImpactTime = 0.8
SWEP.PrimaryAttackDamageWindow = 0.2

SWEP.SecondaryAttackImpactTime = 1.5
SWEP.SecondaryAttackDamageWindow = 0.3

SWEP.PrimaryHitAABB = {
	Vector(-2, -2, -2),
	Vector(2, 2, 2)
}

SWEP.SecondaryHitAABB = {
	Vector(-8, 8, -10),
	Vector(8, 8, 10)
}

function SWEP:IndividualInitialize()
	self:setBodygroup(0, 5)
end

function SWEP:IndividualThink()
	if self.CustomizationAnimation and not self:canCustomize() then
		self:playAnim(nil, nil, nil, nil, self.CustomizationAnims.from[1])
		self.CustomizationAnimation = false --idk why the fuck this variable is needed but getting the sequence causes CW_IDLE and CW_CUSTOMIZE to fuck up
	end
end