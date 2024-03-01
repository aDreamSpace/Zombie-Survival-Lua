local att = {}
att.name = "md_Pbsilencer_m27"
att.displayName = "PBS Silencer"
att.displayNameShort = "PBS"
att.isSuppressor = true

att.statModifiers = {
	}
	

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/pbs1")
		att.description = {[1] = {t = "Decreases firing noise and muzzle signature.", c = CustomizableWeaponry.textColors.POSITIVE},
						[2] = {t = "Reduces weapon penetration by 50%.", c = CustomizableWeaponry.textColors.NEGATIVE}}
end

function att:attachFunc()
	self.dt.Suppressed = true
	self.PenMod = 1
end

function att:detachFunc()
	self.dt.Suppressed = false
	self.PenMod = 2
end

att.price = 15
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)



