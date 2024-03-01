local att = {}
att.name = "bg_apsstock"
att.displayName = "Stock"
att.displayNameShort = "Stock"
att.isBG = true

att.statModifiers = {RecoilMult = -0.05,
OverallMouseSensMult = -0.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ar15sturdystock")
end

function att:attachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.stock)
end

function att:detachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.none)
end

CustomizableWeaponry:registerAttachment(att)