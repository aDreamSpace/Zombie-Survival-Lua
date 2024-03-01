local att = {}
att.name = "md_saigadrum"
att.displayName = "Drum Mag"
att.displayNameShort = "Drum"
att.isBG = false

att.statModifiers = {ReloadSpeedMult = -0.15,
MagMult = .5
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ar1560rndmag")
	att.description = {[1] = {t = "Increases mag size to 12 rounds.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:unloadWeapon()

end

function att:detachFunc()
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end
att.price = 30
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)


