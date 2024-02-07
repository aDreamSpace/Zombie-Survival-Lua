local att = {}
att.name = "md_m3auto"
att.displayName = "Semi-Auto"
att.displayNameShort = "Semi"
att.isBG = false

att.statModifiers = {RecoilMult = 0.05,
}

att.price = 20
if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_ws_afg")
	att.description = {[1] = {t = "Converts the weapon to semi automatic", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.FireModes = {"semi","safe"}
	self:SelectFiremode("semi")
end

function att:detachFunc()
	self.FireModes = {"pump","safe"}
	self:SelectFiremode("pump")
end

CustomizableWeaponry:registerAttachment(att)