local att = {}
att.name = "ins2_atow_herocket"
att.displayName = "FRAG Warhead"
att.displayNameShort = "FRAG"
att.isBG = true
att.SpeedDec = 5
att.price = 50

att.statModifiers = {DamageMult = -.398,
ReloadSpeedMult = -.15}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/rpg7frag")
	att.description = {[1] = {t = "An anti-personnel fragmenting shrapnel charge.", c = CustomizableWeaponry.textColors.POSITIVE},
	[2] = {t = "Fragmentation increases lethal radius.", c = CustomizableWeaponry.textColors.POSITIVE},
	[3] = {t = "Trajectory is worsened and blast damage is lessened.", c = CustomizableWeaponry.textColors.NEGATIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.WarheadBGs.main, self.WarheadBGs.he)
	self:unloadWeapon()
end

function att:detachFunc()
	self:setBodygroup(self.WarheadBGs.main, self.WarheadBGs.heat)
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)
