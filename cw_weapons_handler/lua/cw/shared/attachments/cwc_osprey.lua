local att = {}
att.name = "cwc_osprey"
att.displayName = "Osprey Suppressor"
att.displayNameShort = "Osprey"
att.isSuppressor = true

att.statModifiers = {RecoilMult = -0.15,
AimSpreadMult = -0.15,
HipSpreadMult = -0.20,
OverallMouseSensMult = -0.15,
DrawSpeedMult = -0.15}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/osprey")
	att.description = {[1] = {t = "Decreases firing noise.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.dt.Suppressed = true
end

function att:detachFunc()
	self:resetSuppressorStatus()
end



CustomizableWeaponry:registerAttachment(att)