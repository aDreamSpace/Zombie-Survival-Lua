local att = {}
att.name = "cw_one_hand"
att.displayName = "One Handed"
att.displayNameShort = "Hand"
att.isBG = true
att.SpeedDec = -20

att.statModifiers = {
OverallMouseSensMult = 0.5,
VelocitySensitivityMult = -0.5,
DrawSpeedMult = 0.5,
RecoilMult = 0.25,
HipSpreadMult = 0.3,
AimSpreadMult = 0.2,
SpreadPerShotMult = 0.05
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/one_hand")
	att.description = {[1] = {t = "One hand like a Pro", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.HolsterOnLadder = false
	self.SprintingEnabled = false
	self.ForegripOverride = true
	self.ForegripParent = "One_Hand"
end

function att:detachFunc()
	self.HolsterOnLadder = true
	self.SprintingEnabled = true
	self.ForegripOverride = true
	self.ForegripParent = "null"
end

CustomizableWeaponry:registerAttachment(att)

local att = {}
att.name = "cw_one_hand_cz_75"
att.displayName = "One Handed"
att.displayNameShort = "Hand"
att.isBG = true
att.SpeedDec = -20

att.statModifiers = {
OverallMouseSensMult = 0.5,
VelocitySensitivityMult = -0.5,
DrawSpeedMult = 0.5,
RecoilMult = 0.25,
HipSpreadMult = 0.3,
AimSpreadMult = 0.2,
SpreadPerShotMult = 0.05
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/one_hand")
	att.description = {[1] = {t = "One hand like a Pro", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.HolsterOnLadder = false
	self.SprintingEnabled = false
	self.ForegripOverride = true
	self.ForegripParent = "One_Hand"
end

function att:detachFunc()
	self.HolsterOnLadder = true
	self.SprintingEnabled = true
	self.ForegripOverride = true
	self.ForegripParent = "null"
end

CustomizableWeaponry:registerAttachment(att)

local att = {}
att.name = "cw_one_hand_cz_75_sp01"
att.displayName = "One Handed"
att.displayNameShort = "Hand"
att.isBG = true
att.SpeedDec = -20

att.statModifiers = {
OverallMouseSensMult = 0.5,
VelocitySensitivityMult = -0.5,
DrawSpeedMult = 0.5,
RecoilMult = 0.25,
HipSpreadMult = 0.3,
AimSpreadMult = 0.2,
SpreadPerShotMult = 0.05
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/one_hand")
	att.description = {[1] = {t = "One hand like a Pro", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
    self.Animations = {reload = "reload",
	    reload_empty = "reloadempty",
	    fire = {"fire", "fire2", "fire3"},
	    fire_dry = "firelast",
	    idle = "idle",
	    draw = "draw"}
--  self:sendWeaponAnim("idle")
	self.HolsterOnLadder = false
	self.SprintingEnabled = false
	self.ForegripOverride = true
	self.ForegripParent = "One_Hand"
end

function att:detachFunc()
    self.Animations = {reload = "reload",
	    reload_empty = "reloadempty",
	    fire = {"fire", "fire2", "fire3"},
	    fire_dry = "firelast",
	    idle = "idle",
	    draw = "ready"}
--	self:sendWeaponAnim("idle")
	self.HolsterOnLadder = true
	self.SprintingEnabled = true
	self.ForegripOverride = true
	self.ForegripParent = "null"
end

CustomizableWeaponry:registerAttachment(att)