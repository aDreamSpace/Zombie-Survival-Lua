local att = {}
att.name = "pk_stoppingpowerpro"
att.displayName = "Charged Pulse"
att.displayNameShort = "ECP"

att.statModifiers = {DamageMult = 0.80
}

att.price = 300

if CLIENT then
--Placeholder image--
	att.displayIcon = surface.GetTextureID("extras/icons/stoppingpowerpro")
	att.description = {[1] = {t = "Deal extra damage.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

CustomizableWeaponry:registerAttachment(att)