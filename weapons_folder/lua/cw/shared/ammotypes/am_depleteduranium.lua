local att = {}
att.name = "am_depleteduranium2"
att.displayName = "Depleted Uranium"
att.displayNameShort = "Dep. Uranium"

att.statModifiers = {EffectiveRangeMult = -4/5,
RecoilMult = .5}
att.price = 40

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/uranium")
	att.description = {{t = "Bullets can penetrate multiple zombies.", c = CustomizableWeaponry.textColors.POSITIVE},
	{t = "Damage is halved for every zombie that is penetrated.", c = CustomizableWeaponry.textColors.NEGATIVE}}
end

function att:attachFunc()
	self.bulType = BULTYPE_PEN
    self.dmgFalloff = 0.5
	self:unloadWeapon()
end

function att:detachFunc()
	self.bulType = BULTYPE_NONE
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)
