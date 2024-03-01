local att = {}
att.name = "kry_hk33_fixed_stock"
att.displayName = "Solid fixed stock."
att.displayNameShort = "Fixed"
att.isBG = true
att.description = {[1] = {t = "Solid buttstock", c = CustomizableWeaponry.textColors.COSMETIC},
[2] = {t = "Decreases recoil by 25%.", c = CustomizableWeaponry.textColors.POSITIVE},
[3] = {t = "Decreases aiming spread by 31%", c = CustomizableWeaponry.textColors.POSITIVE},
[4] = {t = "Decreases reload speed by 12%", c = CustomizableWeaponry.textColors.NEGATIVE}
}
att.statModifiers = {OverallMouseSensMult = -0.02,
RecoilMult = -0.17, AimSpreadMult = -0.16, ReloadSpeedMult = -0.07 }

if CLIENT then
	att.displayIcon = surface.GetTextureID("models/weapons/v_models/kry_hk33/atts/kry_hk33_fix_stock")
end

function att:attachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.fixed)
end

function att:detachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.regular)
end

CustomizableWeaponry:registerAttachment(att)