AddCSLuaFile()

-- uhhhh what do i put here help

------------------ SHORT BARREL

local att = {}
att.name = "bg_m79_shortbarrel"
att.displayName = "Short barrel"
att.displayNameShort = "Short"
att.isBG = true
att.SpeedDec = -5

att.statModifiers = {OverallMouseSensMult = 0.25,
ReloadSpeedMult = 0.25,
HipSpreadMult = 1,
AimSpreadMult = 4}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/m79_shortbarrel")
end

function att:attachFunc()
	self:setupCurrentIronsights(self.ShortenedPos, self.ShortenedAng)
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.short)
	self:setBodygroup(self.SightBGs.main, self.SightBGs.none)
	
	self:updateIronsights("Shortened")
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.normal)
	self:setBodygroup(self.SightBGs.main, self.SightBGs.up)
	
	self:revertToOriginalIronsights()
end

CustomizableWeaponry:registerAttachment(att)

------------------ SHORT STOCK

local att = {}
att.name = "bg_m79_shortstock"
att.displayName = "Short stock"
att.displayNameShort = "Short"
att.isBG = true
att.SpeedDec = -5

att.statModifiers = {OverallMouseSensMult = 0.25,
DrawSpeedMult = 0.25,
RecoilMult = 0.25,
VelocitySensitivityMult = 0.2}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/m79_shortstock")
end

function att:attachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.short)
end

function att:detachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.normal)
end

CustomizableWeaponry:registerAttachment(att)