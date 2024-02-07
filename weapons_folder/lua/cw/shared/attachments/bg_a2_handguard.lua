local att = {}
att.name = "bg_a2_handguard"
att.displayName = "L85A2 Handguard"
att.displayNameShort = "L85A2"
att.isBG = true

att.statModifiers = {AimSpreadMult = -0.15,
RecoilMult = 0.2,
OverallMouseSensMult = 0.15}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/icons/a2_rail")
	att.description = {[1] = {t = "The A2 variant handguard", c = CustomizableWeaponry.textColors.REGULAR},
	[2] = {t = "Now she can hold a bunch of tactical equipment!", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.l85_a2)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
end

att.price = 8
att.model = "models/items/battery.mdl"

CustomizableWeaponry:registerAttachment(att)

