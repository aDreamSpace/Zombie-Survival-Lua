local att = {}
att.name = "cwc_flashhider"
att.displayName = "Flash Hider"
att.displayNameShort = "F. Hider"

att.statModifiers = {DamageMult = 0.05,
RecoilMult = 0.1,
AimSpreadMult = -0.05,
HipSpreadMult = -0.15}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/flashhider")
	att.description = {[1] = {t = "Reduces muzzle flash obstruction.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
end

function att:detachFunc()
end

CustomizableWeaponry:registerAttachment(att)