local att = {}
att.name = "am_smghqb"
att.displayName = "High Quality Brass"
att.displayNameShort = "HQB"

att.statModifiers = {FireDelayMult = -.45,
RecoilMult = 0.4
}
att.price = 25
if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/hqb")
	att.description = {}
end

function att:attachFunc()
	self:unloadWeapon()
end

function att:detachFunc()
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)