local att = {}
att.name = "bg_ar1560rndmag"
att.displayName = "Quad-stack mag"
att.displayNameShort = "Quad"
att.isBG = true

att.statModifiers = {ReloadSpeedMult = -0.15,
MagMult = 1,
OverallMouseSensMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ar1560rndmag")
	att.description = {[1] = {t = "Increases mag size to 60 rounds.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.round60)
	self:unloadWeapon()
	
end

function att:detachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.regular)
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end
att.price = 85
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)


