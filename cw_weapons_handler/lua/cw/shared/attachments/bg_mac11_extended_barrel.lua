AddCSLuaFile()

local att = {}
att.name = "bg_mac11_extended_barrel"
att.displayName = "Extended barrel"
att.displayNameShort = "Ext"
att.isBG = true

att.statModifiers = {OverallMouseSensMult = -0.1,
	AimSpreadMult = -0.15,
	DamageMult = 0.1,
	RecoilMult = 0.15}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/mac11_ext_barrel")
	att.description = {[1] = {t = "An extended barrel.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.extended)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
end

CustomizableWeaponry:registerAttachment(att)