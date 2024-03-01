local att = {}
att.name = "bg_m29_medium"
att.displayName = "Medium Barrel"
att.displayNameShort = "Medium"
att.isBG = true

att.statModifiers = {RecoilMult = 0.1,
AimSpreadMult = 0.25,
DrawSpeedMult = 0.1,
OverallMouseSensMult = 0.05,
DamageMult = 0.07}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/icons/m29_medium")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.m29_medium)
	self:updateSoundTo("CW_AZURZAS_M29_FIRE_MEDIUM", CustomizableWeaponry.sounds.UNSUPPRESSED)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
	self:restoreSound()
end
att.price = 8
att.model = "models/items/battery.mdl"

CustomizableWeaponry:registerAttachment(att)

