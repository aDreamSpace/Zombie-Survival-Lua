local att = {}
att.name = "Cod_Steady_Aim"
att.displayName = "Steady Aim"
att.displayNameShort = "SA"
att.description = {[1] = {t = "Allows More Accuracy", c = CustomizableWeaponry.textColors.VPOSITIVE}}
att.price = 30

att.statModifiers = {
AimSpreadMult = -0.5,
HipSpreadMult = -0.5}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/Perk_Cod_Steady_Aim")
	att.description = {}
end

function att:attachFunc()
self.SpeedDec = 0
end

function att:DetachFunc()
self.SpeedDec = Orig 
end

CustomizableWeaponry:registerAttachment(att)