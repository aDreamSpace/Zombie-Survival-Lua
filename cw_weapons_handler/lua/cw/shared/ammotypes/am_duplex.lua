local att = {}
att.name = "am_duplex2"
att.displayName = "Duplex Rounds"
att.displayNameShort = "Duplex"

att.statModifiers = {ClumpSpreadMult = -0.7,
	DamageMult = -0.25,
	ShotsMult = 3,
	EffectiveRangeMult = -.75}
att.price = 250
if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/duplex")
	att.description = {{t = "Increases amount of bullets per shot x3", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:unloadWeapon()
end

function att:detachFunc()
	self.Shots = self.Shots_Orig
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)