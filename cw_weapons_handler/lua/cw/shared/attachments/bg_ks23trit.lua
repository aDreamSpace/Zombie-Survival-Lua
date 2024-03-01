local att = {}
att.name = "bg_tritium"
att.displayName = "Tritium"
att.displayNameShort = "Tritium"
att.isBG = true

att.statModifiers = {AimSpreadMult = -.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ar1560rndmag")
	att.description = {[1] = {t = "Improved Night Optics.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.SightBGs.main, self.SightBGs.tritium)
	self:unloadWeapon()
	
end

function att:detachFunc()
	self:setBodygroup(self.SightBGs.main, self.SightBGs.tritium)
	self:unloadWeapon()
	
end
att.price = 50
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)


