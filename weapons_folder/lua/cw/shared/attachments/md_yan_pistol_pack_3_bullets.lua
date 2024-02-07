local att = {}
att.name = "bg_extended_3_bullets"
att.displayName = "extended mag"
att.displayNameShort = "3 Mag"
att.isBG = true

att.statModifiers = {
ReloadSpeedMult = -0.02,
OverallMouseSensMult = -0.02}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/+3")
	att.description = {[1] = {t = "Increases mag size to 18 rounds.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.extended)
	self:unloadWeapon()
	self.Primary.ClipSize = 18
	self.Primary.ClipSize_Orig = 18
end

function att:detachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.regular)
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end

CustomizableWeaponry:registerAttachment(att)

local att = {}
att.name = "bg_extended_3_bullets_cz_75"
att.displayName = "extended mag"
att.displayNameShort = "3 Mag"
att.isBG = true

att.statModifiers = {
ReloadSpeedMult = -0.02,
OverallMouseSensMult = -0.02}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/+3")
	att.description = {[1] = {t = "Increases mag size to 20 rounds.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.extended)
	self:unloadWeapon()
	self.Primary.ClipSize = 20
	self.Primary.ClipSize_Orig = 20
end

function att:detachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.regular)
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end

CustomizableWeaponry:registerAttachment(att)