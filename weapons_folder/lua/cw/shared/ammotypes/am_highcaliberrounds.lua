local att = {}
att.name = "am_highcaliberrounds2"
att.displayName = "High Caliber Rounds"
att.displayNameShort = "HCR"

att.statModifiers = {DamageMult = 0.15,
    EffectiveRangeMult = 1/5,
	RecoilMult = .15,
	DrawSpeedMult = -0.15,
	ReloadSpeedMult = -0.30}
	
att.price = 75

--Their added mass slows handling and reload speed.--

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/hcr")
	
	att.description = {[1] = {t = "These huge rounds over-penetrate targets.", c = CustomizableWeaponry.textColors.POSITIVE},
	{t = "Damage is halved for every zombie that is penetrated.", c = CustomizableWeaponry.textColors.NEGATIVE},
	{t = "Their heavier mass makes it harder to reload.", c = CustomizableWeaponry.textColors.NEGATIVE}}
end

function att:attachFunc()
	self.bulType = BULTYPE_PEN
	self:unloadWeapon()
end

function att:detachFunc()
	self.bulType = BULTYPE_NONE
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)
