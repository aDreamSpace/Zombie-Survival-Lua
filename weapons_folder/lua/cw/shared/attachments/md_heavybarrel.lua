local att = {}
att.name = "md_Heavybarrel"
att.displayName = "Heavy barrel"
att.displayNameShort = "Heavy Barrel"
att.isSuppressor = true


att.statModifiers = { 
	MaxSpreadIncMult = -0.4,
	AimSpreadMult = -0.2,
	VelocitySensitivityMult = 0.25}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/Arif")
	att.description = {[1] = {t = "Decrease spread and increase accuracy", c = CustomizableWeaponry.textColors.POSITIVE}
						}
end

att.price = 5
att.model = "models/items/battery.mdl"

CustomizableWeaponry:registerAttachment(att)



