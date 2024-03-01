local att = {}
att.name = "md_cblongbarrel"
att.displayName = "Long Barrel"
att.displayNameShort = "Long"
att.isSuppressor = false

att.statModifiers = {OverallMouseSensMult = -.05,
ReloadSpeedMult = -0.05,
HipSpreadMult = -.65,
DamageMult = .25,
AimSpreadMult = -.50}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/saker")
end

CustomizableWeaponry:registerAttachment(att)