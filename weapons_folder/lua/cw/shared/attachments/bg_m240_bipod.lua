local att = {}
att.name = "bg_m240_bipod"
att.displayName = "M240 Bipod"
att.displayNameShort = "M240"
att.isBG = true

att.statModifiers = {RecoilMult = -0.1,
AimSpreadMult = -0.2,
OverallMouseSensMult = -0.15}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/icons/m240_bipod")
	att.description = {[1] = {t = "Allows the use of a bipod.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.ReceiverBGs.main, self.ReceiverBGs.m240_bipod)
	self.BipodInstalled = true
end

function att:detachFunc()
	self:setBodygroup(self.ReceiverBGs.main, self.ReceiverBGs.regular)
	self.BipodInstalled = false
end

CustomizableWeaponry:registerAttachment(att)