local att = {}
att.name = "cwc_singlehanded"
att.displayName = "Single Handed"
att.displayNameShort = "Woostyle"
att.isBG = true
att.SpeedDec = -15
att.aimPos = {"WooPos", "WooAng"}

att.statModifiers = {RecoilMult = 0.15,
OverallMouseSensMult = 0.2,
MaxSpreadIncMult = 0.4,
DrawSpeedMult = .7}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/singlehand")
	att.description = {[1] = {t = "You're free to fire whilst sprinting or climbing.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.ForegripOverride = true
	self.ForegripParent = "Singhand"
	self.HolsterOnLadder = false
	self.SprintingEnabled = false
end

function att:detachFunc()
	self.ForegripOverride = true
	self.ForegripParent = "null"
	self.HolsterOnLadder = true
	self.SprintingEnabled = true
end

CustomizableWeaponry:registerAttachment(att)