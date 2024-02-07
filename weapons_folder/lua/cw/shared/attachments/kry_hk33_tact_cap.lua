local att = {}
att.name = "kry_hk33_tact_cap"
att.displayName = "Tactical end cap"
att.displayNameShort = "No stock"
att.isBG = true
att.description = {[1] = {t = "Tactical cap.", c = CustomizableWeaponry.textColors.COSMETIC}}
att.statModifiers = {DrawSpeedMult = 0.13,
RecoilMult = 0.4, AimSpreadMult = 0.43, HipSpreadMult = 0.42, ReloadSpeedMult = 0.17 }

if CLIENT then
	att.displayIcon = surface.GetTextureID("models/weapons/v_models/kry_hk33/atts/kry_hk33_cap")
end

function att:attachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.cap)
end

function att:detachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.regular)
end

CustomizableWeaponry:registerAttachment(att)