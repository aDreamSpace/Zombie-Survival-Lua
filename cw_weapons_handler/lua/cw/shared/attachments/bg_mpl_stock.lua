local att = {}
att.name = "bg_mpl_stock"
att.displayName = "MPL stock"
att.displayNameShort = "MPL"
att.isBG = true

att.statModifiers = {RecoilMult = -0.25,
OverallMouseSensMult = -0.25}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/icons/mpl_stock")
end

function att:attachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.mpl_stock)
end

function att:detachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.regular)
end

CustomizableWeaponry:registerAttachment(att)