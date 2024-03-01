local att = {}
att.name = "kry_hk33_sniper_stock"
att.displayName = "Enchanced stock."
att.displayNameShort = "Sniper"
att.isBG = true
att.description = {[1] = {t = "Solid buttstock with cheekrest.", c = CustomizableWeaponry.textColors.COSMETIC},
[2] = {t = "Decreases recoil by 25%.", c = CustomizableWeaponry.textColors.POSITIVE},
[3] = {t = "Decreases aiming spread by 31%", c = CustomizableWeaponry.textColors.POSITIVE},
[4] = {t = "Decreases reload speed by 12%", c = CustomizableWeaponry.textColors.NEGATIVE}
}
att.statModifiers = {OverallMouseSensMult = -0.04,
RecoilMult = -0.25, AimSpreadMult = -0.31, ReloadSpeedMult = -0.12 }

if CLIENT then
	att.displayIcon = surface.GetTextureID("models/weapons/v_models/kry_hk33/atts/kry_hk33_sg_stock")
end

function att:attachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.prec)
end

function att:detachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.regular)
end

CustomizableWeaponry:registerAttachment(att)