local att = {}
att.name = "md_Heavystock_m27"
att.displayName = "Heavy Stock"
att.displayNameShort = "Heavy"
att.isBG = true

att.statModifiers = {
	OverallMouseSensMult = -0.1,
	HipSpreadMult = 0.3,
	
}
	

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ar15heavystock")
		att.description = {[1] = {t = "Reduces the recoil of the first few shots.", c = CustomizableWeaponry.textColors.POSITIVE},
						[2] = {t = "Following recoil is amplified.", c = CustomizableWeaponry.textColors.NEGATIVE},
						[3] = {t = "Increase burst fire's recoil.", c = CustomizableWeaponry.textColors.NEGATIVE}}
							
						
end

function att:attachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.Heavy)
	self.SpreadCooldown = 0.08
	self.BurstRecoilMul = 1
end

function att:detachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.regular)
	self.SpreadCooldown = 0.1
	BurstRecoilMul = 0.75
end


att.price = 5
att.model = "models/items/battery.mdl"

CustomizableWeaponry:registerAttachment(att)


