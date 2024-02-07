local att = {}
att.name = "md_corkscrewrifling"
att.displayName = "Corkscrew Rifling"
att.displayNameShort = "CSR"

att.price = 30

att.statModifiers = {RecoilMult = -0.10,
AimSpreadMult = -.10,
HipSpreadMult = -.10,
MaxSpreadIncMult = -.10,
EffectiveRangeMult = .15
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("extras/icons/corkscrewrifling")
	att.description = {[1] = {t = "Balanced barrel that slightly increases range.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

CustomizableWeaponry:registerAttachment(att)