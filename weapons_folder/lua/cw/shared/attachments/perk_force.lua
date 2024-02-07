local att = {}
att.name = "Perk_Force"
att.displayName = "Gorilla Grip"
att.displayNameShort = "GP"
att.description = {[1] = {t = "Decrease Recoil", c = CustomizableWeaponry.textColors.VPOSITIVE}}
att.price = 60

att.statModifiers = {
RecoilMult = -0.65}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/Perk_force")
	att.description = {}
end

function att:attachFunc()
self.SpeedDec = 0
end

function att:DetachFunc()
self.SpeedDec = Orig 
end

CustomizableWeaponry:registerAttachment(att)