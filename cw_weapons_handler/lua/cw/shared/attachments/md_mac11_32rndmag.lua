local att = {}
att.name = "md_mac11_32rndmag"
att.displayName = "32 round magazine"
att.displayNameShort = "32 RND"
att.isBG = false

att.statModifiers = {ReloadSpeedMult = -0.1,
MagMult = .28}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/mp530rnd")
	att.description = {[1] = {t = "Increases mag size to 32 rounds.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:unloadWeapon()
	
end

function att:detachFunc()
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end
att.price = 15
att.model = "models/items/battery.mdl"

CustomizableWeaponry:registerAttachment(att)

