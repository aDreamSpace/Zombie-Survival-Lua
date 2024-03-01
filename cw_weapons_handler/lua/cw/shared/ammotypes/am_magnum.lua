local att = {}
att.name = "am_magnum2"
att.displayName = "Steel Core"
att.displayNameShort = "SCRNDs"

att.statModifiers = {DamageMult = 0.2,
	RecoilMult = 0.25,
	EffectiveRangeMult = -.5}
att.price = 30
if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/magnum")
	att.description = {}
end

function att:attachFunc()
	self:unloadWeapon()
end

function att:detachFunc()
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)
