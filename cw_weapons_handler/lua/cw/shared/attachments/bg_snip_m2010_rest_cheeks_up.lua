local att = {}
att.name = "bg_snip_m2010_rest_cheeks_up"
att.displayName = "Rest Cheeks"
att.displayNameShort = "Rest C"
att.isBG = true
-- att.SpeedDec = -10

att.statModifiers = {
AimSpreadMult = -0.05,
RecoilMult = -0.08}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/rest_cheeks")
end

function att:attachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.up)
end

function att:detachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.regular)
end

CustomizableWeaponry:registerAttachment(att)