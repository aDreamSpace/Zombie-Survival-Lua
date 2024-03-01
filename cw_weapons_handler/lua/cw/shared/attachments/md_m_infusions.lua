--
--Fire infusion
--
local att = {}
att.name = "md_m_inf_fire"
att.displayName = "Fire Infusion"
att.displayNameShort = "Fire"

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/fire")
	att.description = {[1] = {t = "Fire infusion inflicts 10% of the weapons base damage as fire.", c = CustomizableWeaponry.textColors.POSITIVE}}
	
end
att.price = 55
att.model = "models/items/battery.mdl"

--I COULD do some funny stuff with OnMeleeHit overriding but i won't since that'll get janky real quick
--Instead, I am simply going to define a variable and just handle it in the base in a modular way
--You know, this is actually how the CW ammo callbacks work!

function att:attachFunc()
	self.InfusionType = INFUSION_FIRE
	self.InfusionDmg = 0.1
	self.InfusionMult = true --if true then infusion dmg acts as a multiplier for base damage, else it applies the dmg as a flat upgrade

	self:SetPrimaryDamageMult(0.5, 0.5)
end

function att:detachFunc()
	self.InfusionType = INFUSION_NONE
	self.InfusionMult = false --ALWAYS reset this variable on detach

	self:ResetPrimaryDamage()
end

CustomizableWeaponry:registerAttachment(att)

--
--Blood infusion
--

local att = {}
att.name = "md_m_inf_blood"
att.displayName = "Blood Infusion"
att.displayNameShort = "Blood"

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/blood")
	att.description = {[1] = {t = "Blood infusion inflicts additional damage as bleed.", c = CustomizableWeaponry.textColors.POSITIVE}}
end
att.price = 40
att.model = "models/items/battery.mdl"

function att:attachFunc()
	self.InfusionType = INFUSION_BLOOD
	self.InfusionDmg = 0.2
	self.InfusionMult = true --if true then infusion dmg acts as a multiplier for base damage, else it applies the dmg as a flat upgrade
end

function att:detachFunc()
	self.InfusionType = INFUSION_NONE
	self.InfusionMult = false --ALWAYS reset this variable on detach
end

CustomizableWeaponry:registerAttachment(att)

--
--Poison Infusion (NEEDS TESTING)
--

local att = {}
att.name = "md_m_inf_poison"
att.displayName = "Poison Infusion"
att.displayNameShort = "Poison"

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/poison")
	att.description = {[1] = {t = "Poison infusion inflicts 150 damage as poison.", c = CustomizableWeaponry.textColors.POSITIVE}}
end
att.price = 70
att.model = "models/items/battery.mdl"

function att:attachFunc()
	self.InfusionType = INFUSION_POISON
	self.InfusionDmg = 150
	self.InfusionMult = false --if true then infusion dmg acts as a multiplier for base damage, else it applies the dmg as a flat upgrade
end

function att:detachFunc()
	self.InfusionType = INFUSION_NONE
	self.InfusionMult = false --ALWAYS reset this variable on detach
end

CustomizableWeaponry:registerAttachment(att)

--
--Sharp Infusion
--

local att = {}
att.name = "md_m_inf_sharp"
att.displayName = "Sharp Infusion"
att.displayNameShort = "Sharp"

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/sharpened")
	att.description = {[1] = {t = "Sharp infusion allows cutting through multiple zombies.", c = CustomizableWeaponry.textColors.POSITIVE}}
end
att.price = 90
att.model = "models/items/battery.mdl"

function att:attachFunc()
	self.InfusionType = INFUSION_SHARP
	self.InfusionDmg = 1
	self.InfusionMult = true
end

function att:detachFunc()
	self.InfusionType = INFUSION_NONE
	self.InfusionMult = false --ALWAYS reset this variable on detach
end

CustomizableWeaponry:registerAttachment(att)

--
--Heavy Infusion
--

local att = {}
att.name = "md_m_inf_heavy"
att.displayName = "Heavy Infusion"
att.displayNameShort = "Heavy"

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/heavy")
	att.description = {[1] = {t = "Heavy infusion inflicts knockback onto zombies.", c = CustomizableWeaponry.textColors.POSITIVE}}
end
att.price = 30
att.model = "models/items/battery.mdl"

function att:attachFunc()
	self.InfusionType = INFUSION_HEAVY
	self.InfusionDmg = 1
	self.InfusionMult = true
end

function att:detachFunc()
	self.InfusionType = INFUSION_NONE
	self.InfusionMult = false --ALWAYS reset this variable on detach
end

CustomizableWeaponry:registerAttachment(att)

--
--Raw Infusion
--

local att = {}
att.name = "md_m_inf_raw"
att.displayName = "Raw Infusion"
att.displayNameShort = "Raw"

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/raw")
	att.description = {[1] = {t = "Raw infusion removes the damage range and only applies an average, flat, damage.", c = CustomizableWeaponry.textColors.POSITIVE}}
end
att.price = 20
att.model = "models/items/battery.mdl"

function att:attachFunc()
	self.InfusionType = INFUSION_RAW
	self:SetupAverageDamage(true)
	self:SetupAverageDamage()
end

function att:detachFunc()
	self.InfusionType = INFUSION_NONE
	self.InfusionMult = false --ALWAYS reset this variable on detach
	self:ResetPrimaryDamage()
	self:ResetSecondaryDamage()
end

CustomizableWeaponry:registerAttachment(att)

--
--Chaos Infusion
--

local att = {}
att.name = "md_m_inf_chaos"
att.displayName = "Chaos Infusion"
att.displayNameShort = "Chaos"

att.statModifiers = {}

if CLIENT then
    att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/chaos")
	att.description = {[1] = {t = "Chaos infusion increased damage depending on current spendable points.", c = CustomizableWeaponry.textColors.POSITIVE}}
end
att.price = 80
att.model = "models/items/battery.mdl"

function att:attachFunc()
	self.InfusionType = INFUSION_CHAOS
	self.InfusionDmg = 1 --these aren't used
	self.InfusionMult = true
end

function att:detachFunc()
	self.InfusionType = INFUSION_NONE
	self.InfusionMult = false --ALWAYS reset this variable on detach
end

CustomizableWeaponry:registerAttachment(att)


--
--Boom Infusion
--

local att = {}
att.name = "md_m_inf_explosive"
att.displayName = "Explosive Infusion"
att.displayNameShort = "Explosive"

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/explosion")
	att.description = {[1] = {t = "Weapon is charged with explosive energy, inflicting AOE damage on hit.", c = CustomizableWeaponry.textColors.POSITIVE}}
end
att.price = 100
att.model = "models/items/battery.mdl"

function att:attachFunc()
	self.InfusionType = INFUSION_BOOM
	self.InfusionDmg = 0.5
	self.InfusionMult = true
end

function att:detachFunc()
	self.InfusionType = INFUSION_NONE
	self.InfusionMult = false --ALWAYS reset this variable on detach
end

CustomizableWeaponry:registerAttachment(att)





