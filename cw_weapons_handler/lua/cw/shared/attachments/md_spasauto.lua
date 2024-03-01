local att = {}
att.name = "md_spaspump"
att.displayName = "Pump"
att.displayNameShort = "Pump"
att.isBG = false

att.statModifiers = {RecoilMult = -0.05,
DamageMult = .05}

att.price = 20
if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_ws_afg")
	att.description = {[1] = {t = "Allows use of different ammos", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.FireModes = {"pump","safe"}
	self:SelectFiremode("pump")
end

function att:detachFunc()
	self.FireModes = {"semi","safe"}
	self:SelectFiremode("semi")
end

CustomizableWeaponry:registerAttachment(att)