local att = {}
att.name = "am_explosive2"
att.displayName = "Explosive Shot"
att.displayNameShort = "Explosive"

att.statModifiers = {DamageMult = 8.5,
	HipSpreadMult = 0,
	ShotsMult = -.875,
}
att.price = 110

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/explosive")
	att.description = {{t = "Greatly increases accuracy.", c = CustomizableWeaponry.textColors.POSITIVE},
	{t = "Fires out only 1 projectile.", c = CustomizableWeaponry.textColors.NEGATIVE}}
end

function att:attachFunc()
	self.ClumpSpread = nil
	self.bulType = 2
	self.CrosshairParts = {left = true, right = true, upper = true, lower = true}
	self:unloadWeapon()
end

function att:detachFunc()
	self.Shots = self.Shots_Orig
	self.ClumpSpread = self.ClumpSpread_Orig
	self.CrosshairParts = {left = false, right = false, upper = false, lower = false}
	self.bulType = 0
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)
