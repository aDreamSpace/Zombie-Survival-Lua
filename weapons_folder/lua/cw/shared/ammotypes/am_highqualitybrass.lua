local att = {}
att.name = "am_hqb2"
att.displayName = "High Quality Brass"
att.displayNameShort = "HQB"

att.statModifiers = {FireDelayMult = -.35,
RecoilMult = 0.4
}
att.price = 30

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/hqb")
	att.description = {}
end

function att:attachFunc()
	self:unloadWeapon()
end

function att:detachFunc()
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)