local att = {}
att.name = "am_flechetterounds2"
att.displayName = "Flechette rounds"
att.displayNameShort = "Flechette"

att.statModifiers = {ClumpSpreadMult = -0.4,
	DamageMult = -0.45,
	ShotsMult = 1.5,
	EffectiveRangeMult = -.5}
att.price = 45
if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/chette")
	att.description = {{t = "Increases amount of pellets per shot to 20.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:unloadWeapon()
end

function att:detachFunc()
	self.Shots = self.Shots_Orig
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)