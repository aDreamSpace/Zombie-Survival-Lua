AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
SWEP.Base = "cw_base"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Stiletto"
	SWEP.CSMuzzleFlashes = true
	SWEP.DisableSprintViewSimulation = true
	SWEP.IronsightPos = Vector(0, 0, 0)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(0, 0, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.CustomizePos = Vector(0, 0, 0)
	SWEP.CustomizeAng = Vector(0, 0, 0)
	
	SWEP.CustomizationMenuScale = 0.02
end

SWEP.ViewModelMovementScale = 1
SWEP.Attachments = {
	["+reload"] = {header = "Infusion", offset = {-50, -100}, atts = {"md_m_inf_blood", "md_m_inf_raw"}} --"md_m_inf_poison"
}

SWEP.UseLRAnimsPrimary = true
SWEP.NoWindup = true
SWEP.UseLRAnimsSecondary = false
SWEP.Animations = {
	--anim definitions for LR support
	miss_primaryR = "attack1",
	miss_primaryL = "attack2",
	hit_primaryR = "attack1",
	hit_primaryL = "attack2",

	slash_primary = {"attack1", "attack2"},
	slash_secondary = "powerattack",
	draw = "draw",
	idle = "idle"
}

SWEP.PlayerHitSounds = {"CW_SWORD_SLASH_FLESH"}
SWEP.PlayerHitSoundsSecondary = {"CW_SWORD_STAB_FLESH"}
SWEP.NPCHitSounds = {} -- key is npc class, value is table containing the sounds, if npc class key is not found within this table it will fall back to the sounds in PlayerHitSounds
SWEP.MiscHitSounds = {"CW_SWORD_SLASH_WALL"}
SWEP.MiscHitSoundsSecondary = {"CW_SWORD_STAB_OUT"}

SWEP.Sounds = {
	["attack1"] = {{time = 0.2, sound = "CW_FOLEY_MEDIUM"}, {time = 0.15, sound = "CW_SWORD_SLASH_QUICK"}},
	["attack2"] = {{time = 0.2, sound = "CW_FOLEY_MEDIUM"}, {time = 0.15, sound = "CW_SWORD_SLASH_QUICK"}},
	["draw"] = {{time = 0.1, sound = "CW_KNIFE_DRAW"}, {time = 0.6, sound = "CW_FOLEY_HEAVY"}},
	["powerattack"] = {{time = 0.2, sound = "CW_FOLEY_HEAVY"},{time = 1, sound = "CW_KNIFE_SLASH"}, {time = 1.3, sound = "CW_FOLEY_LIGHT"}},

	["toinspect"] = {{time = 0.3, sound = "CW_FOLEY_HEAVY"}, {time = 1.4, sound = "CW_FOLEY_LIGHT"}},
	["frominspect"] = {{time = 0, sound = "CW_FOLEY_HEAVY"}, {time = 0.6, sound = "CW_FOLEY_MEDIUM"}, {time = 1.1, sound = "CW_FOLEY_LIGHT"}},
}

SWEP.Slot = 0
SWEP.SlotPos = 0
SWEP.Category = "CW 2.0"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.SpeedDec = -10

SWEP.ViewModelFOV	= 90
SWEP.ViewModelFlip	= false
SWEP.NormalHoldType = "knife" 
SWEP.ViewModel = "models/cw2/melee/dagger/c_melee_dagger.mdl"
SWEP.WorldModel = "models/demonssouls/weapons/geri's geristiletto.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/demonssouls/weapons/geri's geristiletto.mdl"
SWEP.WMPos = Vector(-3, 1, 2)
SWEP.WMAng = Vector(-90, 0, 90)

SWEP.UseHands = true
SWEP.CanCustomize = true
SWEP.SpecialCAnimation = true
SWEP.CustomizationAnims = {to = {"toinspect", 0.75}, from = {"frominspect", 0.75}}

SWEP.CW20Melee = true

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 0
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ""

SWEP.FireAnimSpeed = 1.3
SWEP.FireAnimSpeedSecondary = 0.75
SWEP.PrimaryAttackDelay = 0.6
SWEP.SecondaryAttackDelay = 2.25

SWEP.PrimaryAttackDamage = {259, 260}
SWEP.SecondaryAttackDamage = {299, 300}

SWEP.CanBackstab = true
SWEP.BackstabDamageMultiplier = 1.5

SWEP.PrimaryAttackRange = 45
SWEP.SecondaryAttackRange = 40

SWEP.HolsterTime = 0.3
SWEP.DeployTime = 0.3

SWEP.PrimaryAttackImpactTime = 0.2
SWEP.PrimaryAttackDamageWindow = 0.1

SWEP.SecondaryAttackImpactTime = 1.3
SWEP.SecondaryAttackDamageWindow = 0.2

SWEP.PrimaryHitAABB = {
	Vector(-10, -10, -5),
	Vector(10, 10, 5)
}
SWEP.SecondaryHitAABB = {
	Vector(-5, -5, -10),
	Vector(5, 5, 10)
}

function SWEP:IndividualInitialize()
	self:setBodygroup(0, 6)
end

function SWEP:IndividualThink()
	if self.CustomizationAnimation and not self:canCustomize() then
		self:playAnim(nil, nil, nil, nil, self.CustomizationAnims.from[1])
		self.CustomizationAnimation = false --idk why the fuck this variable is needed but getting the sequence causes CW_IDLE and CW_CUSTOMIZE to fuck up
	end
end