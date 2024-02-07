AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.Base = "cw_base"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Crowbar"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.DrawTraditionalWorldModel = true
	
	SWEP.CustomizePos = Vector(2.937, -6.658, -3.754)
	SWEP.CustomizeAng = Vector(42.687, 4.889, 16.902)
end

SWEP.MuzzleAttachment = -1

SWEP.UseLegacyAnims = true

SWEP.Animations = {

	hit_primary = {"hitcenter1", "hitcenter2", "hitcenter3"},
	miss_primary = {"misscenter1", "misscenter2"},
	hit_secondary = {"misscenter1"},
	miss_secondary = {"misscenter1"},
	draw = "draw"
}

SWEP.Sounds = {
	misscenter1 = {{time = 0, sound = "CW_CROWBAR_SWING"}}, 
	misscenter2 = {{time = 0, sound = "CW_CROWBAR_SWING"}}, 
	draw = {{time = 0.1, sound = "CW_FOLEY_MEDIUM"}},
}

SWEP.PlayerHitSounds = {"CW_SWORD_SLASH_FLESH"}
SWEP.PlayerHitSoundsSecondary = {"CW_SWORD_STAB_FLESH"}
SWEP.NPCHitSounds = {} -- key is npc class, value is table containing the sounds, if npc class key is not found within this table it will fall back to the sounds in PlayerHitSounds
SWEP.MiscHitSounds = {"CW_SWORD_SLASH_WALL"}
SWEP.MiscHitSoundsSecondary = {"CW_SWORD_STAB_OUT"}

SWEP.Slot = 0
SWEP.SlotPos = 0
SWEP.Category = "CW 2.0"

SWEP.CW20Melee 		= true


SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 54
SWEP.ViewModelFlip	= false
SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
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
SWEP.SecondaryAttackDelay = 1

SWEP.FireAnimSpeed = 1.2
SWEP.FireAnimSpeedSecondary = 0.7

SWEP.PrimaryAttackDamage = {84, 85}
SWEP.SecondaryAttackDamage = {109, 110}

SWEP.PrimaryAttackRange = 50
SWEP.SecondaryAttackRange = 40

SWEP.HolsterTime = 0.4
SWEP.DeployTime = 0.6

SWEP.SpeedDec = 0

SWEP.PrimaryAttackImpactTime = 0.2
SWEP.PrimaryAttackDamageWindow = 0.15

SWEP.SecondaryAttackImpactTime = 0.2
SWEP.SecondaryAttackDamageWindow = 0.15

SWEP.PrimaryHitAABB = {
	Vector(-10, -5, -5),
	Vector(10, 5, 5)
}