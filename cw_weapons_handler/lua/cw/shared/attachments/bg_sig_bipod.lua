local att = {}
att.name = "bg_sig_bipod"
att.displayName = "550 Bipod"
att.displayNameShort = "Bipod"
att.isBG = true

att.statModifiers = {OverallMouseSensMult = -0.1,
DrawSpeedMult = -0.15}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bipod")
	att.description = {[1] = {t = "When deployed:", c = CustomizableWeaponry.textColors.REGULAR},
	[2] = {t = "Decreases recoil by 70%", c = CustomizableWeaponry.textColors.POSITIVE},
	[3] = {t = "Greatly increases hip fire accuracy to destroy Sako's", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.BipodBGs.main, self.BipodBGs.on)
	self.BipodInstalled = true
end

function att:detachFunc()
	self:setBodygroup(self.BipodBGs.main, self.BipodBGs.off)
	self.BipodInstalled = false
end
att.price = 5
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)


