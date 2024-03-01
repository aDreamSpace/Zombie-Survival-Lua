local att = {}
att.name = "md_magpulpmag_m27"
att.displayName = "PMAG"
att.displayNameShort = "PMAG"
att.isBG = true

att.statModifiers = {
	ReloadSpeedMult = -0.05,
}

	

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/Pmag")
		att.description = {[1] = {t = "36 rounds magazine.", c = CustomizableWeaponry.textColors.POSITIVE}}
						
end

function att:attachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.Pmag)
	self:unloadWeapon()
	self.Primary.ClipSize = 36
	self.Primary.ClipSize_Orig = 36
end

function att:detachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.regular)
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end

att.price = 15
att.model = "models/items/battery.mdl"

CustomizableWeaponry:registerAttachment(att)

