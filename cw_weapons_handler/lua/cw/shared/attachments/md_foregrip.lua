local att = {}
att.name = "md_foregrip"
att.displayName = "Foregrip"
att.displayNameShort = "Grip"

att.statModifiers = {VelocitySensitivityMult = -0.3,
DrawSpeedMult = -0.1,
RecoilMult = -0.2}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/foregrip")
end
att.price = 5
att.model = "models/items/battery.mdl"

CustomizableWeaponry:registerAttachment(att)

