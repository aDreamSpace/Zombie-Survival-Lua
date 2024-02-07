local att = {}
att.name = "bg_tr09_mp9_stock"
att.displayName = "Folding Stock"
att.displayNameShort = "Stock"
att.isBG = true

att.statModifiers = {RecoilMult = -0.15,
DrawSpeedMult = -0.1,
OverallMouseSensMult = -0.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_tr09_mp9_stock")
end

function att:attachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.fold)
end

function att:detachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.regular)
end

CustomizableWeaponry:registerAttachment(att)