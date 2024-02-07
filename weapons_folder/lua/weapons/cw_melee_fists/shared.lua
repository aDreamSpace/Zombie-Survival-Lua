AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.Base = "cw_base"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Fists"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.DrawTraditionalWorldModel = true
	
	SWEP.CustomizePos = Vector(0, 10, -1)
	SWEP.CustomizeAng = Vector(0, 0, 0)
end

SWEP.UseLegacyAnims = false

SWEP.Animations = {
	slash_primary = {"fists_left", "fists_right"},
	slash_secondary = "fists_uppercut",
	draw = "fists_draw"
}

SWEP.Sounds = {
	fists_left = {{time = 0.05, sound = "CW_FISTS_SWING"}},
	fists_right = {{time = 0.05, sound = "CW_FISTS_SWING"}},
	fists_uppercut = {{time = 0.05, sound = "CW_FISTS_SWING_HEAVY"}},
	fists_draw = {{time = 0.1, sound = "CW_FOLEY_LIGHT"}},
}

SWEP.PlayerHitSounds = {"CW_FISTS_HIT"}
SWEP.PlayerHitSoundsSecondary = {"CW_FISTS_HIT"}
SWEP.NPCHitSounds = {} -- key is npc class, value is table containing the sounds, if npc class key is not found within this table it will fall back to the sounds in PlayerHitSounds
SWEP.MiscHitSounds = {"CW_FISTS_HIT"}
SWEP.MiscHitSoundsSecondary = {"CW_FISTS_HIT"}

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
SWEP.ViewModel = "models/weapons/c_arms.mdl"
SWEP.WorldModel = ""
SWEP.UseHands = true
SWEP.CanCustomize = true

SWEP.Attachments = {[1] = {header = "Knuckles", offset = {-300, -50}, atts = {"md_m_brass"}}}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 0
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ""

SWEP.PrimaryAttackDelay = 1
SWEP.SecondaryAttackDelay = 2

SWEP.PrimaryAttackDamage = {15,25}--{30, 35}
SWEP.SecondaryAttackDamage = {30,45}--{65, 70}

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

function SWEP:IndividualThink()
	if CLIENT and IsFirstTimePredicted() then
		if self.CW_VM:GetCycle() == 1 then
			self:playAnim(nil, nil, nil, nil, "fists_idle_0"..math.random(2))
		end
	end
end