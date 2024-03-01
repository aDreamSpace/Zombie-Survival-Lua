AddCSLuaFile()

SWEP.Base = "cw_base"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Knife"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.DrawTraditionalWorldModel = true
	
	SWEP.CustomizePos = Vector(2.937, -6.658, -3.754)
	SWEP.CustomizeAng = Vector(42.687, 4.889, 44.902)
end

SWEP.Animations = {
	slash_primary = {"midslash1", "midslash2"},
	slash_secondary = "stab",
	draw = "draw"
}

SWEP.Sounds = {
	midslash1 = {{time = 0.05, sound = "CW_KNIFE_SLASH"}},
	midslash2 = {{time = 0.05, sound = "CW_KNIFE_SLASH"}},
	stab = {{time = 0.1, sound = "CW_KNIFE_SLASH"}},
	draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}, {time = 0.1, sound = "CW_KNIFE_DRAW"}},
}

 
SWEP.MiscHitSoundsSecondary = SWEP.MiscHitSounds

SWEP.Slot = 0
SWEP.SlotPos = 0
SWEP.Category = "CW 2.0"

SWEP.CW20Melee 		= true


SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.SpeedDec = -10

SWEP.ViewModelFOV	= 54
SWEP.ViewModelFlip	= false
SWEP.ViewModel = "models/weapons/cstrike/c_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"
SWEP.UseHands = true
SWEP.CanCustomize = false

SWEP.Attachments = {[3] = {header = "Magazine", offset = {-300, -50}, atts = {"bg_ar1560rndmag"}}}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 0
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ""

SWEP.PrimaryAttackDelay = 0.5
SWEP.SecondaryAttackDelay = 1.2

SWEP.PrimaryAttackDamage = {74, 75}
SWEP.SecondaryAttackDamage = {89, 90}

SWEP.PrimaryAttackRange = 50
SWEP.SecondaryAttackRange = 40

SWEP.HolsterTime = 0.4
SWEP.DeployTime = 0.6

SWEP.SpeedDec = -10

SWEP.PrimaryAttackImpactTime = 0.2
SWEP.PrimaryAttackDamageWindow = 0.15

SWEP.SecondaryAttackImpactTime = 0.2
SWEP.SecondaryAttackDamageWindow = 0.15

SWEP.PrimaryHitAABB = {
	Vector(-10, -5, -5),
	Vector(10, 5, 5)
}