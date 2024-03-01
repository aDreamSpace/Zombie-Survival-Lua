local att = {}
att.name = "Cod_Double_Tap"
att.displayName = "Quick Shots"
att.displayNameShort = "QS"
att.description = {[1] = {t = "Increase fire rate", c = CustomizableWeaponry.textColors.VPOSITIVE}}
att.price = 55


att.statModifiers = {
FireDelayMult = -0.25}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/Perk_Cod_Double_Tap")
	att.description = {}
end

function att:attachFunc()
self.SpeedDec = 0
end

function att:DetachFunc()
self.SpeedDec = Orig 
end

CustomizableWeaponry:registerAttachment(att)