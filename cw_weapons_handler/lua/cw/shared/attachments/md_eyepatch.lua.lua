local att = {}
att.name = "md_eyepatch"
att.displayName = "Fujiko's Eyepatch!"
att.displayNameShort = "Senpai!"
att.isBG = false

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/icons/patch_icon")
	att.description = {[1] = {t = "An Eyepatch accessory", c = CustomizableWeaponry.textColors.REGULAR},
	[2] = {t = "Increases Strictness by 100%", c = CustomizableWeaponry.textColors.NEGATIVE}}
end

att.price = 1000000000
att.model = "models/items/battery.mdl"

CustomizableWeaponry:registerAttachment(att)
