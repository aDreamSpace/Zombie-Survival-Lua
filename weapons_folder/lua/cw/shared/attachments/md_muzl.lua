local att = {}
att.name = "md_muzl"
att.displayName = "Enhanced Muzzlebrake"
att.displayNameShort = "Mzlbrake"

att.statModifiers = {RecoilMult = -0.25,
AimSpreadMult = -.5}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_muzl")
	att.description = {[1] = {t = "Decreases recoil.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
end

function att:detachFunc()
end

CustomizableWeaponry:registerAttachment(att)