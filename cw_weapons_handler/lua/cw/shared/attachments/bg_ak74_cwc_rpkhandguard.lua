local att = {}
att.name = "bg_ak74_cwc_rpkhandguard"
att.displayName = "Heavy Handguard"
att.displayNameShort = "H. handguard"
att.isBG = true

att.statModifiers = {
SpreadPerShotMult = -0.3,
RecoilMult = 0.15,
SpreadCooldownMult = 0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ak74_heavyhandguard")
	att.description = {[1] = {t = "Adds extra weight to the front.", c = CustomizableWeaponry.textColors.NORMAL}}
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.rpkhg)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.rpk)
end

CustomizableWeaponry:registerAttachment(att)