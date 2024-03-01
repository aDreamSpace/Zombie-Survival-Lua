local att = {}
att.name = "bg_m24_short_barrel"
att.displayName = "Shortened barrel"
att.displayNameShort = "Short"
att.isBG = true
att.categoryFactors = {cqc = 3}
att.SpeedDec = -5

att.statModifiers = {
RecoilMult = -0.35,
OverallMouseSensMult = 0.1,
VelocitySensitivityMult = -0.15,
DrawSpeedMult = 0.1,
AimSpreadMult = 0.3,
DamageMult = -0.1,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/m24_short_barrel")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.short)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
	self:restoreSound()
end

CustomizableWeaponry:registerAttachment(att)