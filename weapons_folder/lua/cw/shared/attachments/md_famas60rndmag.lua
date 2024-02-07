local att = {}
att.name = "bg_famas60rndmag"
att.displayName = "Quad-stack mag"
att.displayNameShort = "Quad"
att.isBG = false

att.statModifiers = {ReloadSpeedMult = -0.15,
MagMult = 1
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ar1560rndmag")
	att.description = {[1] = {t = "Increases mag size to 60 rounds.", c = CustomizableWeaponry.textColors.POSITIVE}}
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


