local att = {}
att.name = "md_ncstar_frontsight"
att.displayName = "Front Aiming Sight"
att.displayNameShort = "Front"
att.isSight = false

if CLIENT then
	--att.displayIcon = surface.GetTextureID("cw20_extras/icons/upgr_frontsight")
	att.description = {[1] = {t = "Front ironsight.", c = CustomizableWeaponry.textColors.COSMETIC}}
end
att.price = 8
att.model = "models/items/battery.mdl"

CustomizableWeaponry:registerAttachment(att)

