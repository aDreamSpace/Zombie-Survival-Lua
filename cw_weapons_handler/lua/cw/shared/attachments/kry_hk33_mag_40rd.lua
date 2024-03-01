local att = {}
att.name = "kry_hk33_mag_40rd"
att.displayName = "Extended magazine."
att.displayNameShort = "40rds mag"
att.isBG = true
att.description = {[1] = {t = "Increases weapon clip size to 40.", c = CustomizableWeaponry.textColors.POSITIVE}
}
att.statModifiers = {DrawSpeedMult = -0.05,
ReloadSpeedMult = -0.09 }

if CLIENT then
	att.displayIcon = surface.GetTextureID("models/weapons/v_models/kry_hk33/atts/kry_hk33_30rd")
end

function att:attachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.r40)
	self:unloadWeapon()
	self.Primary.ClipSize = 40
	self.Primary.ClipSize_Orig = 40
end

function att:detachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.r25)
	self:unloadWeapon()
	self.Primary.ClipSize = 25
	self.Primary.ClipSize_Orig = 25
end

CustomizableWeaponry:registerAttachment(att)