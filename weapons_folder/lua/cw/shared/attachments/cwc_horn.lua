local att = {}
att.name = "cwc_horn"
att.displayName = "Tactical Dootage!"
att.displayNameShort = "Horn"
att.isSuppressor = true

att.statModifiers = {AimSpreadMult = 60,
HipSpreadMult = 50,
MaxSpreadIncMult = 0.2,}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/doot")
	att.description = {{t = "Increases firing noise.", c = CustomizableWeaponry.textColors.NEGATIVE},
	{t = "May cause an annoyance.", c = CustomizableWeaponry.textColors.NEGATIVE}}
end

CustomizableWeaponry:registerAttachment(att)