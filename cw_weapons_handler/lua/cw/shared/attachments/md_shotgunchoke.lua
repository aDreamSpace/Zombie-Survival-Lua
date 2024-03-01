local att = {}
att.name = "md_choke"
att.displayName = "Choke"
att.displayNameShort = "Choke"

att.statModifiers = {ClumpSpreadMult = -0.15,
	EffectiveRangeMult = -.1}
att.price = 20
if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/flashhider")
	att.description = {{t = "A barrel modification that reduces spread.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
end

function att:detachFunc()
end

CustomizableWeaponry:registerAttachment(att)