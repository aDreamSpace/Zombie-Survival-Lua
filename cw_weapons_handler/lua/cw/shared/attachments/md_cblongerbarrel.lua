local att = {}
att.name = "md_cblongerbarrel"
att.displayName = "Longer Improved Barrel"
att.displayNameShort = "Longer"
att.isSuppressor = false

att.statModifiers = {OverallMouseSensMult = -.1,
ReloadSpeedMult = -0.1,
HipSpreadMult = -.80,
DamageMult = .50,
AimSpreadMult = -1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/saker")
end

CustomizableWeaponry:registerAttachment(att)