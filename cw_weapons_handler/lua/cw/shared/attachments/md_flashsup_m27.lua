local att = {}
att.name = "md_flashsup_m27"
att.displayName = "KX3 Flash suppressor"
att.displayNameShort = "KX3"
att.isSuppressor = true

att.statModifiers = {
	HipSpreadMult = 0.1
	}
	

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/Flsup")
		att.description = {[1] = {t = "Reduces muzzle signature.", c = CustomizableWeaponry.textColors.POSITIVE}
						}
end

function att:attachFunc()
	self.MuzzleEffect  = "muzzleflash_suppressed"
end

function att:detachFunc()
	self.MuzzleEffect  = "muzzleflash_OTS"
end

att.price = 15
att.model = "models/items/battery.mdl"

CustomizableWeaponry:registerAttachment(att)


