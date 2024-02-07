local att = {}
att.name = "bg_cbstock"
att.displayName = "Recoil-Absorbing Stock"
att.displayNameShort = "Stock"

att.statModifiers = {RecoilMult = -0.5,
OverallMouseSensMult = 0}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ar15heavystock")
end

CustomizableWeaponry:registerAttachment(att)