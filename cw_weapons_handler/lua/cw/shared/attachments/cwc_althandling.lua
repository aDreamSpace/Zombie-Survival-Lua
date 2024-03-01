local att = {}
att.name = "cwc_althandling"
att.displayName = "Alternative handling"
att.displayNameShort = "Alt. Handle"

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/althandling")
	att.description = {[1] = {t = "An alternative in handling your weapon.", c = CustomizableWeaponry.textColors.NORMAL}}
end

function att:attachFunc()
	self.ForegripOverride = true
	self.ForegripParent = "Althand"
end

function att:detachFunc()
	self.ForegripOverride = true
	self.ForegripParent = "null"
end

CustomizableWeaponry:registerAttachment(att)