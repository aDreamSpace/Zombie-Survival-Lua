local att = {}
att.name = "Cod_Extreme_Conditioning"
att.displayName = "Caffeine Gum"
att.displayNameShort = "CG"
att.description = {[1] = {t = "Allows you to walk and aim faster", c = CustomizableWeaponry.textColors.VPOSITIVE}}
att.price = 60

att.statModifiers = {
OverallMouseSensMult = 0.5,
VelocitySensitivityMult = -0.5}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/Perk_Cod_Extreme_Conditioning")
	att.description = {}
end

function att:attachFunc()
self.SpeedDec = 0
end

function att:DetachFunc()
self.SpeedDec = Orig 
end

CustomizableWeaponry:registerAttachment(att)