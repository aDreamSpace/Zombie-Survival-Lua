local att = {}
att.name = "md_tachandgrip_m27"
att.displayName = "Tactical grip"
att.displayNameShort = "T.grip"

att.statModifiers = {
OverallMouseSensMult = -0.15,
RecoilMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/Tacticalgrip")
	att.description = {[1] = {t = "Reduces recoil at the cost of handling.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.ForegripOverride = true
	self.ForeGripOffsetCycle_Reload = 0.80
	self.ForeGripOffsetCycle_Reload_Empty = 0.80
	self.ForegripParent = "md_tachandgrip"
end

function att:detachFunc()
	self.ForegripOverride = false
	self.ForeGripOffsetCycle_Reload = 0.6
	self.ForeGripOffsetCycle_Reload_Empty = 0.6
end
att.price = 8
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)


