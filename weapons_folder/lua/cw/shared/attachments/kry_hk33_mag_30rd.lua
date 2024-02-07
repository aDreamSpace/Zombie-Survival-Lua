local att = {}
att.name = "kry_hk33_mag_30rd"
att.displayName = "Extended magazine."
att.displayNameShort = "30rds mag"
att.isBG = true
att.description = {[1] = {t = "Increases weapon clip size to 30.", c = CustomizableWeaponry.textColors.POSITIVE}
}
att.statModifiers = {DrawSpeedMult = -0.03,
ReloadSpeedMult = -0.05 }

if CLIENT then
	att.displayIcon = surface.GetTextureID("models/weapons/v_models/kry_hk33/atts/kry_hk33_30rd")
end

function att:attachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.r30)
	self:unloadWeapon()
	self.Primary.ClipSize = 30
	self.Primary.ClipSize_Orig = 30
end

function att:detachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.r25)
	self:unloadWeapon()
	self.Primary.ClipSize = 25
	self.Primary.ClipSize_Orig = 25
end

CustomizableWeaponry:registerAttachment(att)