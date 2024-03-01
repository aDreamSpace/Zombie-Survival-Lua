local att = {}
att.name = "md_Assaultstock_m27"
att.displayName = "Assault Stock"
att.displayNameShort = "Assault"
att.isBG = true

att.statModifiers = {
	OverallMouseSensMult = 0.08,
	DrawSpeedMult = 0.07,
	AimSpreadMult = 0.35
}
	

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/AssaultStock")
		att.description = {}
							
						
end

function att:attachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.Ass)
end

function att:detachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.regular)
end


att.price = 8
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)
