local att = {}
att.name = "bg_ak74rpkmag"
att.displayName = "RPK Magazine"
att.displayNameShort = "RPK Mag"
att.isBG = true

att.statModifiers = {ReloadSpeedMult = -0.1,
MagMult = 1.5}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/rpkmag")
	att.description = {[1] = {t = "Increases mag size to 75 rounds.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.rpk)
	self:unloadWeapon()
end

function att:detachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.regular)
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end
att.price = 60
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)


