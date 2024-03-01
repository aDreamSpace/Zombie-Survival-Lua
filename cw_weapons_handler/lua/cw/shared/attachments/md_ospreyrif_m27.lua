local att = {}
att.name = "md_Ospreyrif_m27"
att.displayName = "SilencerCo Osprey"
att.displayNameShort = "Osprey"
att.isSuppressor = true

att.statModifiers = {

	MaxSpreadIncMult = 0.35}
	

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/Osprey")
	att.description = {[1] = {t = "Decreases firing noise and muzzle signature.", c = CustomizableWeaponry.textColors.POSITIVE},
						[2] = {t = "Reduceds range effectiveness.", c = CustomizableWeaponry.textColors.NEGATIVE}}
end

function att:attachFunc()
	self.dt.Suppressed = true
end

function att:detachFunc()
	self.dt.Suppressed = false
end

att.price = 8
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)



