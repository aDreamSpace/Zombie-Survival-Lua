local att = {}
att.name = "kry_sw_m500_likeaboss"
att.displayName = "One hand operation"
att.displayNameShort = "LIKE A BOSS"
att.Description = {[1] = {t = "Allows you to shoot from the ladder.", c = CustomizableWeaponry.textColors.POSITIVE}}

att.statModifiers = {DrawSpeedMult = 0.21,
RecoilMult = 0.45, AimSpreadMult = 0.26, HipSpreadMult = 0.42 }


if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/cw_m500_boss")
end

function att:attachFunc()
	self.ForegripOverride = true
	self.ForegripParent = att.name
	
	self.ForeGripOffsetCycle_Reload = 0.72
	self.ForeGripOffsetCycle_Reload_Empty = 0.8
	self.NormalHoldType = "pistol"
	self.HolsterOnLadder = false
end

function att:detachFunc()
	self.ForegripOverride = false
	self.HolsterOnLadder = true
	self.NormalHoldType = "revolver"
	end

CustomizableWeaponry:registerAttachment(att)