local att = {}
att.name = "pk_stoppingpower"
att.displayName = "Stopping Power"
att.displayNameShort = "SP"

att.statModifiers = {DamageMult = 0.35
}

att.price = 250

if CLIENT then
--Placeholder image--
	att.displayIcon = surface.GetTextureID("extras/icons/stoppingpower")
	att.description = {[1] = {t = "Increases your damage passively.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

CustomizableWeaponry:registerAttachment(att)