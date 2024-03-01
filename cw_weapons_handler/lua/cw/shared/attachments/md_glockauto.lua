local att = {}
att.name = "md_glockauto"
att.displayName = "Auto"
att.displayNameShort = "Auto"




if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_ws_afg")
	att.description = {[1] = {t = "Allows usage of full auto.", c = CustomizableWeaponry.textColors.POSITIVE}}
	
end

function att:attachFunc()
	self.FireModes = {"auto", "semi","safe"}
	self:SelectFiremode("auto")
end

function att:detachFunc()
	self.FireModes = {"semi","safe"}
	self:SelectFiremode("semi")
end
att.price = 40


CustomizableWeaponry:registerAttachment(att)