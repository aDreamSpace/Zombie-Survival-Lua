local att = {}
att.name = "am_ricochet2"
att.displayName = "Ricochet rounds"
att.displayNameShort = "Ricochet"

att.statModifiers = {DamageMult = 0.45,
	RecoilMult = 0.25}
att.price = 30
if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/richocet")
	att.description = {}
end

function att:attachFunc()
	self.CanRicochet = true
	self:unloadWeapon()
end

function att:detachFunc()
	self.CanRicochet = false
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)
