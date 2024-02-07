local att = {}
att.name = "bg_mac11_stock"
att.displayName = "Unfolded stock"
att.displayNameShort = "Unfold"
att.isBG = true

-- att.statModifiers = {DrawSpeedMult = -0.1,
-- OverallMouseSensMult = -0.1,
-- RecoilMult = -0.15}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/mac11_unfolded_stock")
end

function att:attachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.unfolded)
end

function att:detachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.folded)
end

CustomizableWeaponry:registerAttachment(att)