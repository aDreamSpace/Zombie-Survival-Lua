local att = {}
att.name = "am_slugrounds2"
att.displayName = "Slug rounds"
att.displayNameShort = "Slug"

att.statModifiers = {DamageMult = 7.5,
	HipSpreadMult = 100,
	ShotsMult = -.875,
	EffectiveRangeMult = 5}
att.price = 20
att.worth = 10
if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/slugs")
	att.description = {{t = "Greatly increases accuracy.", c = CustomizableWeaponry.textColors.POSITIVE},
	{t = "Fires out only 1 pellet.", c = CustomizableWeaponry.textColors.NEGATIVE}}
end

function att:attachFunc()
	self.ClumpSpread = nil
	self.bulType = BULTYPE_PEN
	self.CrosshairParts = {left = true, right = true, upper = true, lower = true}
	self.dmgFalloff = 1/4
	self:unloadWeapon()
end

function att:detachFunc()
	self.ClumpSpread = self.ClumpSpread_Orig
	self.CrosshairParts = {left = false, right = false, upper = false, lower = false}
	self.bulType = BULTYPE_NONE
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)