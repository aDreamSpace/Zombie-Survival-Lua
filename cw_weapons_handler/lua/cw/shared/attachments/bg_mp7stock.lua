local att = {}
att.name = "bg_mp7stock"
att.displayName = "Retractable Stock"
att.displayNameShort = "R. Stock"
att.isBG = true
--att.isSight = false
--att.aimPos = {"FoldedPos", "FoldedAng"}

att.statModifiers = {RecoilMult = 0.2,
ReloadSpeedMult = 0.1,
OverallMouseSensMult = 0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/mp7_stock")
	att.description = {[1] = {t = "Makes You Shoot Worse", c = CustomizableWeaponry.textColors.COSMETIC}}
end

function att:attachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.folded)
end

function att:detachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.unfolded)
end

CustomizableWeaponry:registerAttachment(att)