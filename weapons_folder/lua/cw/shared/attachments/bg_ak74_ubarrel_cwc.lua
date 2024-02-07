local att = {}
att.name = "bg_ak74_ubarrel_cwc"
att.displayName = "U Variant"
att.displayNameShort = "U"
att.isBG = true
att.categoryFactors = {cqc = 3}
att.SpeedDec = -3

att.statModifiers = {RecoilMult = -0.1,
AimSpreadMult = 1,
DrawSpeedMult = 0.15,
ReloadSpeedMult = 0.5,
FireDelayMult = -0.0714285}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ak74_ubarrel")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.short)
	self:setupCurrentIronsights(self.ShortenedPos, self.ShortenedAng)
	self:updateSoundTo("CWC_AK74_U_FIRE", CustomizableWeaponry.sounds.UNSUPPRESSED)
	self:updateSoundTo("CWC_AK74_U_FIRE_SUPPRESSED", CustomizableWeaponry.sounds.SUPPRESSED)
	self:unloadWeapon()
	self.Primary.Ammo = "smg1"
	self.Primary.Ammo_orig = "ar2"
	
	if not self:isAttachmentActive("sights") then
		self:updateIronsights("Shortened")
	end
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
	self:setBodygroup(self.ReceiverBGs.main, self.ReceiverBGs.regular)
	self.BipodInstalled = false
	self.Primary.Ammo = self.Primary.Ammo_orig
	self.Primary.Ammo_orig = self.Primary.Ammo_orig
	self:restoreSound()
end

CustomizableWeaponry:registerAttachment(att)