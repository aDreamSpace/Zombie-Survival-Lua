local att = {}
att.name = "am_duplex2"
att.displayName = "Duplex Rounds"
att.displayNameShort = "Duplex"

att.statModifiers = {ClumpSpreadMult = -0.7,
	DamageMult = -0.5,
	ShotsMult = 1.5,
	EffectiveRangeMult = -.75}
att.price = 210
if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/duplex")
	att.description = {{t = "Increases amount of pellets per shot x1.2", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:unloadWeapon()
end

function att:detachFunc()
	self.Shots = self.Shots_Orig
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)