local att = {}
att.name = "kry_g3_claw_rail"
att.displayName = "Scope Rail(High)"
att.displayNameShort = "Rail system"
att.description = {[1] = {t = "Allows you to attach various equipment.", c = CustomizableWeaponry.textColors.COSMETIC}}
att.statModifiers = {DrawSpeedMult = -0.11}
att.isBG = false

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/kry_g3_claw_rail")
end

function att:attachFunc()
	
end

function att:detachFunc()
	
end

CustomizableWeaponry:registerAttachment(att)