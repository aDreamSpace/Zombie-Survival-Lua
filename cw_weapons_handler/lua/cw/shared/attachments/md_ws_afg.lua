local att = {}
att.name = "md_ws_afg"
att.displayName = "AFG Angled Foregrip"
att.displayNameShort = "AFG"

att.statModifiers = {
VelocitySensitivityMult = -0.3,
OverallMouseSensMult = -0.15,
HipSpreadMult = -0.15,
RecoilMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_ws_afg")
end

function att:attachFunc()
	self.ForegripOverride = true
	self.ForegripParent = "md_ws_afg"
end

function att:detachFunc()
	self.ForegripOverride = false
end

CustomizableWeaponry:registerAttachment(att)