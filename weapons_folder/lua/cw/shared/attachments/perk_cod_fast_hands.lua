local att = {}
att.name = "Cod_Fast_Hands"
att.displayName = "Cogni Juice"
att.displayNameShort = "CJ"
att.price = 45 

att.statModifiers = {
DrawSpeedMult = 0.4,
ReloadSpeedMult =0.4}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/Perk_Cod_Fast_hands")
end

CustomizableWeaponry:registerAttachment(att)