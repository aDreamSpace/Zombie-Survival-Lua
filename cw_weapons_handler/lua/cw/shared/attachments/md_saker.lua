local att = {}
att.name = "md_saker"
att.displayName = "Suppressor"
att.displayNameShort = "Suppressor"
att.isSuppressor = true

att.statModifiers = {OverallMouseSensMult = -0.1,
RecoilMult = -0.15,
DamageMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/saker")
	att.description = {[1] = {t = "Decreases firing noise.\nReduces aura range.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.dt.Suppressed = true
	self.AuraRange = 512
end

function att:detachFunc()
	self:resetSuppressorStatus()
end
att.price = 15
att.model = "models/items/battery.mdl"

CustomizableWeaponry:registerAttachment(att)

