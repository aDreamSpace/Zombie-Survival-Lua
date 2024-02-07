local att = {}
att.name = "md_foregripthomas"
att.displayName = "Wooden Foregrip"
att.displayNameShort = "Grip"

att.statModifiers = {VelocitySensitivityMult = -0.4,
DrawSpeedMult = -0.3,
RecoilMult = -0.4}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/m1928grip")
end

function att:attachFunc()
	self.ForegripOverride = true
	self.ForegripParent = "thompfore"
	self:setBodygroup(self.GripBGs.main, self.GripBGs.on)
end

function att:detachFunc()
	self.ForegripOverride = false
	self.ForegripParent = null
	self:setBodygroup(self.GripBGs.main, self.GripBGs.off)
end

CustomizableWeaponry:registerAttachment(att)