local att = {}
att.name = "md_railcover_m27"
att.displayName = "Rail cover"
att.displayNameShort = "R.Cover"

att.statModifiers = {VelocitySensitivityMult = -0.80,
HipSpreadMult = - 0.15,
OverallMouseSensMult = -0.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/bg_hk416_railcover")
	att.description = {[1] = {t = "Improves accuracy while moving.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.ForegripOverride = true
	self.ForeGripOffsetCycle_Reload = 0.80
	self.ForeGripOffsetCycle_Reload_Empty = 0.80
	self.ForegripParent = "md_railcoverm27"
end

function att:detachFunc()
	self.ForegripOverride = false
	self.ForeGripOffsetCycle_Reload = 0.6
	self.ForeGripOffsetCycle_Reload_Empty = 0.6
end
att.price = 5
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)


