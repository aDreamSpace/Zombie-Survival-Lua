AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
SWEP.Base = "cw_base"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Dragonslayer Ultra-Greatsword"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.DisableSprintViewSimulation = true
	
	SWEP.DrawTraditionalWorldModel = false
	
	SWEP.CustomizePos = Vector(0, 0, 0)
	SWEP.CustomizeAng = Vector(0, 0, 0)

end

SWEP.CanBlock = true
SWEP.BlockFactor = 0.2
SWEP.Animations = {
	slash_primary = {"attack1", "attack2"},
	slash_secondary = {"powerattack1", "powerattack2"},
	draw = "draw",
	idle = "idle",
	parry = "block",
	block_start = "to_block",
	block_end = "from_block"
}

SWEP.SpecialCAnimation = true
SWEP.CustomizationAnims = {to = {"toinspect", 1.4}, from = {"frominspect", 1.4}}


SWEP.Sounds = {
	attack1 = {{time = 0.05, sound = "CW_FOLEY_MEDIUM"}, {time = 1.2, sound = "CW_UGS_SWING"}},
	attack2 = {{time = 0.05, sound = "CW_FOLEY_MEDIUM"}, {time = 1.2, sound = "CW_UGS_SWING"}},
	powerattack1 = {{time = 0.05, sound = "CW_FOLEY_MEDIUM"}, {time = 1.6, sound = "CW_FOLEY_HEAVY"}, {time = 1.5, sound = "CW_UGS_SWING"}},
	powerattack2 = {{time = 0.05, sound = "CW_FOLEY_MEDIUM"}, {time = 1.5, sound = "CW_FOLEY_HEAVY"}, {time = 1.5, sound = "CW_UGS_SWING"}},
	stab = {{time = 0.1, sound = "CW_KNIFE_SLASH"}},
	draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}, {time = 0.8, sound = "CW_FOLEY_HEAVY"}, {time = 1.65, sound = "CW_FOLEY_MEDIUM"}},
	toinspect = {{time = 0.1, sound = "CW_FOLEY_LIGHT"}},
	frominspect = {{time = 0.4, sound = "CW_FOLEY_LIGHT"}},
}

SWEP.PlayerHitSounds = {"CW_UGS_CLANG"}
SWEP.NPCHitSounds = {} -- key is npc class, value is table containing the sounds, if npc class key is not found within this table it will fall back to the sounds in PlayerHitSounds
SWEP.MiscHitSounds = {"CW_UGS_CLANG"}

SWEP.PlayerHitSoundsSecondary = {"CW_UGS_STAB_FLESH"}
SWEP.MiscHitSoundsSecondary = {"CW_UGS_STAB"}


SWEP.Slot = 0
SWEP.SlotPos = 0
SWEP.Category = "CW 2.0"

SWEP.CW20Melee 		= true

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 82
SWEP.ViewModelFlip	= false
SWEP.ViewModel = "models/cw2/melee/greatsword/c_melee_greatsword.mdl"
SWEP.WorldModel = "models/berserk/dragonslayer/dragonslayer.mdl"
SWEP.WM = "models/berserk/dragonslayer/dragonslayer.mdl"
SWEP.WMPos = Vector(2, -13.5, -18)
SWEP.WMAng = Vector(180, -5, 0)

SWEP.NormalHoldType = "melee2"
SWEP.RunHoldType = "melee2"

SWEP.UseHands = true
SWEP.UsePropModel = true
SWEP.PropModel = {bone = "main_control", name = "models/berserk/dragonslayer/dragonslayer.mdl", pos = Vector(-10.5, -14, -1), ang = Angle(0, 0, 90)}

SWEP.CanCustomize = true

SWEP.ViewModelMovementScale = 1.2
SWEP.Attachments = {
	--[1] = {header = "Blade", offset = {-500, -50}, atts = {"md_m_pointedblade", "md_m_sharpenedblade", "md_m_refinedblade"}}
	["+reload"] = {header = "Infusion", offset = {-300, -200}, atts = {"md_m_inf_heavy", "md_m_inf_raw"}}

}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 0
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ""

SWEP.PrimaryAttackDelay = 2.3
SWEP.SecondaryAttackDelay = 3.2

SWEP.FireAnimSpeed = 1.75
SWEP.FireAnimSpeedSecondary = 1.5

SWEP.PrimaryAttackDamage = {1399, 1400}
SWEP.SecondaryAttackDamage = {1799, 1800}

SWEP.PrimaryAttackRange = 80
SWEP.SecondaryAttackRange = 100

SWEP.HolsterTime = 0.4
SWEP.DeployTime = 0.6

SWEP.SpeedDec = 60

SWEP.PrimaryAttackImpactTime = 1
SWEP.PrimaryAttackDamageWindow = 0.2

SWEP.SecondaryAttackImpactTime = 1.3
SWEP.SecondaryAttackDamageWindow = 0.3

SWEP.PrimaryHitAABB = {
	Vector(-10, -10, -10),
	Vector(10, 10, 10)
}

SWEP.SecondaryHitAABB = {
	Vector(-8, 8, -10),
	Vector(8, 8, 10)
}

function SWEP:IndividualInitialize()
	self:setBodygroup(0, 0)
end

function SWEP:IndividualThink()
	--to animation plays at: cl_playerbindpress
	if self.CustomizationAnimation and not self:canCustomize() and not self.IsBlocking then
		self:playAnim(nil, nil, nil, nil, self.CustomizationAnims.from[1])
		self.CustomizationAnimation = false --idk why the fuck this variable is needed but getting the sequence causes CW_IDLE and CW_CUSTOMIZE to fuck up
	end
end
--[[
function SWEP:Reload()
	local flCT = CurTime()
	if self.GlobalDelay < flCT and IsFirstTimePredicted() then
		self:playAnim(nil, nil, nil, nil, "block")

		self.GlobalDelay = flCT + 2
	end
end
--]]