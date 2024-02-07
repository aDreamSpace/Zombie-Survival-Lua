local att = {}
att.name = "am_sabots2"
att.displayName = "Sabot"
att.displayNameShort = "Sabot"

att.statModifiers = {
DamageMult = 7,
HipSpreadMult = 100,
ShotsMult = -.875,
EffectiveRangeMult = 10
}

att.price = 60

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/sabot")
	att.description = {{t = "Bullets can penetrate multiple zombies.", c = CustomizableWeaponry.textColors.POSITIVE},
	{t = "Damage is halved for every zombie that is penetrated.", c = CustomizableWeaponry.textColors.NEGATIVE}}
end

function att:attachFunc()
	self.bulType = BULTYPE_PEN
    self.dmgFalloff = 3/4
	self:unloadWeapon()
end

function att:detachFunc()
	self.bulType = BULTYPE_NONE
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)
