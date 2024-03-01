local att = {}
att.name = "md_ber_grooved"
att.displayName = "Grooved Suppressor"
att.displayNameShort = "Grooved"
att.isSuppressor = true

att.statModifiers = {OverallMouseSensMult = -0.1,
RecoilMult = -0.15,
DamageMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/grooved")
	att.description = {[1] = {t = "Decreases firing noise.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.dt.Suppressed = true
end

function att:detachFunc()
	self.dt.Suppressed = false
end
att.price = 5
att.model = "models/items/battery.mdl"

CustomizableWeaponry:registerAttachment(att)

