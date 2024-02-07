local att = {}
att.name = "md_ws_grippod"
att.displayName = "Grip Pod System"
att.displayNameShort = "Grip Pod"

att.statModifiers = {
VelocitySensitivityMult = -0.3,
OverallMouseSensMult = -0.15,
HipSpreadMult = -0.15,
DrawSpeedMult = -0.15,
RecoilMult = -0.2
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_ws_grippod")
end

function att:attachFunc()
	self.BipodInstalled = true
	self.ForegripOverride = true
	self.ForegripParent = "md_ws_grippod"
end

function att:detachFunc()
	self.BipodInstalled = false
	self.ForegripOverride = false
end

CustomizableWeaponry:registerAttachment(att)