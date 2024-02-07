local att = {}
att.name = "md_uzi_50rndmag"
att.displayName = "50 round magazine"
att.displayNameShort = "50 RND"
att.isBG = false

att.statModifiers = {ReloadSpeedMult = -0.15,
MagMult = .5625
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/mp530rnd")
	att.description = {[1] = {t = "Increases mag size to 50 rounds.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:unloadWeapon()
end

function att:detachFunc()
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end
att.price = 35
att.model = "models/items/battery.mdl"

CustomizableWeaponry:registerAttachment(att)

