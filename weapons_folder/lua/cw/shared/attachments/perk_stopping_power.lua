local att = {}
att.name = "Perk_Stopping_Power"
att.displayName = "Pulse Rifle Rounds"
att.displayNameShort = "PR"
att.description = {[1] = {t = "Makes your bullets shoot pulse rounds.", c = CustomizableWeaponry.textColors.VPOSITIVE}}
att.isBG = true
att.price = 400

att.statModifiers = {
DamageMult = 0.4}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/Perk_Stopping_Power")
end

CustomizableWeaponry:registerAttachment(att)