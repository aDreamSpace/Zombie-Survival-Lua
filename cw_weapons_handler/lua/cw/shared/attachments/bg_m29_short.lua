local att = {}
att.name = "bg_m29_short"
att.displayName = "Short Barrel"
att.displayNameShort = "Shortie hehe"
att.isBG = true

att.statModifiers = {RecoilMult = 0.2,
AimSpreadMult = 0.55,
DrawSpeedMult = 0.2,
OverallMouseSensMult = 0.1,
DamageMult = 0.14}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/icons/m29_short")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.m29_short)
	self:updateSoundTo("CW_AZURZAS_M29_FIRE_SHORT", CustomizableWeaponry.sounds.UNSUPPRESSED)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
	self:restoreSound()
end

att.price = 8
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)

