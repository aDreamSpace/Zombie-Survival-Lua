local att = {}
att.name = "bg_bigmag"
att.displayName = "Extended Magazine"
att.displayNameShort = "Extended Magazine"
att.price = 25

att.statModifiers = {ReloadSpeedMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/rpkmag")
	att.description = {{t = "Increases ammo capacity by 200%.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	local ammo = self.Primary.ClipSize * 2
    self.Primary.ClipSize = ammo
	self.Primary.ClipSize_Orig = ammo
	self:unloadWeapon()
end

function att:detachFunc()
    self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)