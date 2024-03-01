local att = {}
att.name = "md_foldgrip_m27"
att.displayName = "Folding Grip"
att.displayNameShort = "F.Grip"

att.statModifiers = {DrawSpeedMult = 0.15,
ReloadSpeedMult = 0.10,
OverallMouseSensMult = -0.10,
RecoilMult = -0.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/foldgrip")
	att.description = {[1] = {t = "", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.ForegripOverride = true
	self.ForegripParent = "md_foldgripm416"
	self.ForeGripOffsetCycle_Reload = 0.8
	self.ForeGripOffsetCycle_Reload_Empty = 0.84
end

function att:detachFunc()
	self.ForegripOverride = false
	self.ForeGripOffsetCycle_Reload =  0.81
	self.ForeGripOffsetCycle_Reload_Empty = 0.54
end

att.price = 10
att.model = "models/items/battery.mdl"

CustomizableWeaponry:registerAttachment(att)


