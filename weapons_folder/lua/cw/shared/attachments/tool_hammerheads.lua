local att = {}
att.name = "md_m_steelhammer2"
att.displayName = "Solid Steel"
att.displayNameShort = "Steel"

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/steelh")
	att.description = {[1] = {t = "Steel hammerhead increases repair strength by 100%", c = CustomizableWeaponry.textColors.POSITIVE}}
	
end
att.price = 16
att.model = "models/items/battery.mdl"


function att:attachFunc()
	self.HealStrength_Orig = self.HealStrength_Orig or self.HealStrength or 1
	self.HealStrength = self.HealStrength_Orig * 2
end

function att:detachFunc()
	self.HealStrength = self.HealStrength_Orig
end

CustomizableWeaponry:registerAttachment(att)

local att = {}
att.name = "md_m_electrumhammer2"
att.displayName = "Conductive Electrum"
att.displayNameShort = "Electrum"

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/electrum")
	att.description = {[1] = {t = "Electrum hammerhead increases repair strength by 250%", c = CustomizableWeaponry.textColors.POSITIVE}}
	
end
att.price = 100
att.model = "models/items/battery.mdl"


function att:attachFunc()
	self.HealStrength_Orig = self.HealStrength_Orig or self.HealStrength or 1
	self.HealStrength = self.HealStrength_Orig * 3.5
end

function att:detachFunc()
	self.HealStrength = self.HealStrength_Orig
end

CustomizableWeaponry:registerAttachment(att)

local att = {}
att.name = "md_m_alloyhammer2"
att.displayName = "Titanium Alloy"
att.displayNameShort = "Titanium"

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/titanium")
	att.description = {[1] = {t = "Titanium hammerhead increases repair strength by 175%", c = CustomizableWeaponry.textColors.POSITIVE}}
	
end
att.price = 50
att.model = "models/items/battery.mdl"


function att:attachFunc()
	self.HealStrength_Orig = self.HealStrength_Orig or self.HealStrength or 1
	self.HealStrength = self.HealStrength_Orig * 2.75
end



function att:detachFunc()
	self.HealStrength = self.HealStrength_Orig
end

CustomizableWeaponry:registerAttachment(att)
