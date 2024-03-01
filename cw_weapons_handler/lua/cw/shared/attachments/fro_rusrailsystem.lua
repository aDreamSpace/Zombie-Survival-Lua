local att = {}
att.name = "md_fro_rusrailsystem"
att.displayName = "Russian Side Mount"
att.displayNameShort = "Rail system"
att.statModifiers = {DrawSpeedMult = -0.1}
att.isBG = false

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/akrailmount")
end

function att:attachFunc()
	
end

function att:detachFunc()
	
end

CustomizableWeaponry:registerAttachment(att)