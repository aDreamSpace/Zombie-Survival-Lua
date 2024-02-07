local att = {}
att.name = "cwc_altreload"
att.displayName = "Alternative Reload Method"
att.displayNameShort = "Alt. Reload"

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/altreload")
	att.description = {[1] = {t = "An alternative in reloading your weapon.", c = CustomizableWeaponry.textColors.NORMAL}}
end

function att:attachFunc()
end

function att:detachFunc()
end

CustomizableWeaponry:registerAttachment(att)