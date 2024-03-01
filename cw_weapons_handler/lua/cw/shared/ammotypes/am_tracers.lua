local att = {}
att.name = "am_tracers2"
att.displayName = "Tracers"
att.displayNameShort = "Tracers"
att.price = 40

att.statModifiers = {FireDelayMult = .2 }

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/tracers")
	att.description = {{t = "Bullets contain white phosphorus powder", c = CustomizableWeaponry.textColors.POSITIVE},
		{t ="Deals damage to shades on impact", c = CustomizableWeaponry.textColors.POSITIVE}
		}
end

function att:attachFunc()
	self.bulType = 3
	self:unloadWeapon()
end

function att:detachFunc()
	self:unloadWeapon()
	self.bulType = 0
end

CustomizableWeaponry:registerAttachment(att)