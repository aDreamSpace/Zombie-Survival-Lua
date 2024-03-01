local att = {}
att.name = "md_orange_chan"
att.displayName = "Orange Slice"
att.displayNameShort = "16"
att.isBG = false

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/icons/oj_icon")
	att.description = {[1] = {t = "An Orange slice clip accessory", c = CustomizableWeaponry.textColors.REGULAR},
	[2] = {t = "Increase in bitchness by 100%", c = CustomizableWeaponry.textColors.NEGATIVE}}
end

CustomizableWeaponry:registerAttachment(att)