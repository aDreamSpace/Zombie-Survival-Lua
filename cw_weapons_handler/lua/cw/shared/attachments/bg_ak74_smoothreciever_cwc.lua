local att = {}
att.name = "bg_ak74_smoothreciever_cwc"
att.displayName = "Smooth Reciever"
att.displayNameShort = "Smooth"
att.isBG = true

att.statModifiers = {DamageMult = 0.025,
SpreadPerShotMult = 0.3,
RecoilMult = -0.15,
SpreadCooldownMult = -0.1,
MaxSpreadIncMult = 0.2}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ak74_smoothreciever")
end

function att:attachFunc()
	self:setBodygroup(self.ReceiverBGs.main, self.ReceiverBGs.rpk)
	self.BipodInstalled = true
end

function att:detachFunc()
	self:setBodygroup(self.ReceiverBGs.main, self.ReceiverBGs.regular)
	self.BipodInstalled = false

end

CustomizableWeaponry:registerAttachment(att)