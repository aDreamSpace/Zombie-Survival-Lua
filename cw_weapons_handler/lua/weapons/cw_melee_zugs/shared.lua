AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
SWEP.Base = "cw_base"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Executioner's Ultra Greatsword"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.DrawTraditionalWorldModel = false
	
	SWEP.CustomizePos = Vector(0, 0, 0)
	SWEP.CustomizeAng = Vector(0, 0, 0)

end

SWEP.Animations = {
	slash_primary = "powerattack1",
	slash_secondary = "powerattack2",
	draw = "draw",
	idle = "idle",
	parry = "block"
}

SWEP.SpecialCAnimation = true
SWEP.CustomizationAnims = {to = {"toinspect", 1.4}, from = {"frominspect", 1.4}}


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


SWEP.PlayerHitSounds = {"CW_UGS_CLANG"}
SWEP.NPCHitSounds = {} -- key is npc class, value is table containing the sounds, if npc class key is not found within this table it will fall back to the sounds in PlayerHitSounds
SWEP.MiscHitSounds = {"CW_UGS_CLANG"}

SWEP.PlayerHitSoundsSecondary = {"CW_UGS_CLANG"}
SWEP.MiscHitSoundsSecondary = {"CW_UGS_CLANG"}
SWEP.Slot = 0
SWEP.SlotPos = 0
SWEP.Category = "CW 2.0"

SWEP.CW20Melee 		= true
SWEP.ZMelee = true


SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 82
SWEP.ViewModelFlip	= false
SWEP.ViewModel = "models/cw2/melee/greatsword/c_melee_greatsword.mdl"
SWEP.WorldModel = "models/demonssouls/weapons/great sword.mdl"
SWEP.WM = "models/demonssouls/weapons/great sword.mdl"
SWEP.WMPos = Vector(-3, 3, 1)
SWEP.WMAng = Vector(-100, -5, 90)

SWEP.NormalHoldType = "melee2"
SWEP.RunHoldType = "melee2"

SWEP.UseHands = true
SWEP.CanCustomize = false

SWEP.ViewModelMovementScale = 1.2
SWEP.Attachments = {
	--[1] = {header = "Blade", offset = {-500, -50}, atts = {"md_m_pointedblade", "md_m_sharpenedblade", "md_m_refinedblade"}}
	["+reload"] = {header = "Infusion", offset = {-300, -200}, atts = {"md_m_inf_sharp", "md_m_inf_heavy", "md_m_inf_raw"}}

}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 0
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ""

SWEP.PrimaryAttackDelay = 1.5
SWEP.SecondaryAttackDelay = 2.25

SWEP.FireAnimSpeed = 2
SWEP.FireAnimSpeedSecondary = 1.9

SWEP.PrimaryAttackDamage = {50, 100}
SWEP.SecondaryAttackDamage = {1000, 1000}
SWEP.PropDamage = 5

SWEP.PrimaryAttackRange = 75
SWEP.SecondaryAttackRange = 85

SWEP.HolsterTime = 0.4
SWEP.DeployTime = 0.6

SWEP.SpeedDec = 0

SWEP.PrimaryAttackImpactTime = 0.8
SWEP.PrimaryAttackDamageWindow = 0.2

SWEP.SecondaryAttackImpactTime = 0.8
SWEP.SecondaryAttackDamageWindow = 0.15

SWEP.PrimaryHitAABB = {
	Vector(-1, -1, -10),
	Vector(1, 1, 10)
}

SWEP.SecondaryHitAABB = {
	Vector(-1, -1, -1),
	Vector(1, 1, 1)
}

function SWEP:IndividualInitialize()
	self:setBodygroup(0, 2)
end