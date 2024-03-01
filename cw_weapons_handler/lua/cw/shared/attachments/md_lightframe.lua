local att = {}
att.name = "md_lightframe"
att.displayName = "Light Frame"
att.displayNameShort = "Light"
att.isBG = false

att.statModifiers = {
SpeedDecMult = .1
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ar1560rndmag")
	att.description = {}
end

function att:attachFunc()


end

function att:detachFunc()

end
att.price = 15
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)


