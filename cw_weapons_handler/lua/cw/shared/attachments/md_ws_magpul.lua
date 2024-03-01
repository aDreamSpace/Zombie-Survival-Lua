local att = {}
att.name = "md_ws_magpul"
att.displayName = "Magpul"
att.displayNameShort = "Magpul"
att.statModifiers = {ReloadSpeedMult = 0.3}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_ws_magpul")
	att.description = {[1] = {t = "Allows for faster reload", c = CustomizableWeaponry.textColors.POSITIVE}}
end

CustomizableWeaponry:registerAttachment(att)