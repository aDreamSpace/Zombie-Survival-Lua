local att = {}
att.name = "nm_heavybarrel"
att.displayName = "Heavy Barrel"
att.displayNameShort = "Heavy"

att.statModifiers = {RecoilMult = -0.2,
	VelocitySensitivityMult = -0.3,}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/nm_heavybarrel")
	att.description = {}
end

CustomizableWeaponry:registerAttachment(att)