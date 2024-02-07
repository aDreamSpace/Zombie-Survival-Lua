local att = {}
att.name = "cwc_compensator"
att.displayName = "Compensator"
att.displayNameShort = "Comp."
att.isSuppressor = false

att.statModifiers = {RecoilMult = -0.25,
AimSpreadMult = 0.5,
HipSpreadMult = 0.35}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/compensator")
end

CustomizableWeaponry:registerAttachment(att)