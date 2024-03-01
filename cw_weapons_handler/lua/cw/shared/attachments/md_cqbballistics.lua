local att = {}
att.name = "md_cqbballistics"
att.displayName = "CQB Ballistics"
att.displayNameShort = "CQB"

att.statModifiers = {RecoilMult = -0.25,
AimSpreadMult = -.15,
HipSpreadMult = -.15,
MaxSpreadIncMult = -.15,
EffectiveRangeMult = -.75
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("extras/icons/cqbballistics")
	att.description = {[1] = {t = "Severely reduced range for recoil management.", c = CustomizableWeaponry.textColors.NEGATIVE}}
end

CustomizableWeaponry:registerAttachment(att)