local att = {}
att.name = "bg_ak74_rpkbarrel"
att.displayName = "RPK variant"
att.displayNameShort = "RPK"
att.isBG = true
att.categoryFactors = {cqc = -1, lmg = 3}
att.SpeedDec = 3

att.statModifiers = {DamageMult = 0.1,
RecoilMult = 0.1,
AimSpreadMult = -0.2,
FireDelayMult = -0.0714285
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ak74_rpkbarrel")
	att.description = {[1] = {t = "Allows the use of a bipod. Changes ammo to LMG.", c = CustomizableWeaponry.textColors.POSITIVE}}
end


function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.rpk)
	self:setBodygroup(self.ReceiverBGs.main, self.ReceiverBGs.rpk)
	self:updateSoundTo("CW_AK74_RPK_FIRE", CustomizableWeaponry.sounds.UNSUPPRESSED)
	self:updateSoundTo("CW_AK74_RPK_FIRE_SUPPRESSED", CustomizableWeaponry.sounds.SUPPRESSED)
	self:setupCurrentIronsights(self.RPKPos, self.RPKAng)
	self.BipodInstalled = true
	self:unloadWeapon()
	self.Primary.Ammo = "alyxgun"
	self.Primary.Ammo_orig = "ar2"
	
	if not self:isAttachmentActive("sights") then
		self:updateIronsights("RPK")
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
att.price = 100
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)


