local att = {}
att.name = "bg_m249_bipod"
att.displayName = "M249 Bipod"
att.displayNameShort = "M249 SAW"
att.isBG = true

att.statModifiers = {RecoilMult = -0.2,
AimSpreadMult = -0.25,
OverallMouseSensMult = -0.15}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/icons/m240_bipod")
	att.description = {[1] = {t = "Allows the use of a bipod.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.ReceiverBGs.main, self.ReceiverBGs.m249_bipod)
	self.BipodInstalled = true
end

function att:detachFunc()
	self:setBodygroup(self.ReceiverBGs.main, self.ReceiverBGs.regular)
	self.BipodInstalled = false
end
att.price = 5
att.model = "models/items/battery.mdl"

CustomizableWeaponry:registerAttachment(att)

