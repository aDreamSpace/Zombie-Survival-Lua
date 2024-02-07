local att = {}
att.name = "bg_wsjng_paint1"
att.displayName = "Turkish Paint"
att.displayNameShort = "Turkish"
att.isBG = false

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/bg_wsjng_paint1")
	att.description = {[1] = {t = "Turkish finish for a true patriot.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
end

function att:detachFunc()
	
end

CustomizableWeaponry:registerAttachment(att)