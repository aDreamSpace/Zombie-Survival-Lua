local att = {}
att.name = "bg_snip_m2010_short_barrel"
att.displayName = "Shortened barrel"
att.displayNameShort = "Short"
att.isBG = true
att.categoryFactors = {cqc = 3}
att.SpeedDec = -5

att.statModifiers = {
RecoilMult = -0.25,
OverallMouseSensMult = 0.12,
VelocitySensitivityMult = -0.15,
DrawSpeedMult = 0.15,
AimSpreadMult = 0.15,
DamageMult = -0.15,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/m2010_barrel")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.short)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
	self:restoreSound()
end

CustomizableWeaponry:registerAttachment(att)