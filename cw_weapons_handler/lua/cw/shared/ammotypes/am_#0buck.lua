local att = {}
att.name = "am_singleaught"
att.displayName = "Single-Aught Buck"
att.displayNameShort = "#0 Buck"

att.statModifiers = {ClumpSpreadMult = -0.4,
	ShotsMult = .125,
	EffectiveRangeMult = 3}
att.price = 30
if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/0buck")
	att.description = {{t = "A round intended for increasing effective range.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:unloadWeapon()
end

function att:detachFunc()
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)