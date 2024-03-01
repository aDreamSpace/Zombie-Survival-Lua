local att = {}
att.name = "bg_am180_grip"
att.displayName = "Vertical Grip"
att.displayNameShort = "VGrip"
att.isBG = true
att.statModifiers = {VelocitySensitivityMult = -0.3,
DrawSpeedMult = -0.1,
RecoilMult = -0.2}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/foregrip")
end

function att:attachFunc()
	self:setBodygroup(self.GripBGs.main, self.GripBGs.vgrip)
	self.ForegripOverride = true
end

function att:detachFunc()
	self:setBodygroup(self.GripBGs.main, self.GripBGs.none)
	self.ForegripOverride = false
end
att.price = 5
att.worth = 5
att.model = "models/items/battery.mdl"

CustomizableWeaponry:registerAttachment(att)

