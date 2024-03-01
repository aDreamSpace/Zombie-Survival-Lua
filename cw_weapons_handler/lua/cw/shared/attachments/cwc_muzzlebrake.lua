local att = {}
att.name = "cwc_muzzlebrake"
att.displayName = "Muzzle Brake"
att.displayNameShort = "Brake"

att.statModifiers = {RecoilMult = -0.25,
AuraRangeMult = 1,
AimSpreadMult = .25,
HipSpreadMult = .25,
MaxSpreadIncMult = .5
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/muzzlebrake")
	att.description = {[1] = {t = "Increases aura presence", c = CustomizableWeaponry.textColors.NEGATIVE}}
end

CustomizableWeaponry:registerAttachment(att)