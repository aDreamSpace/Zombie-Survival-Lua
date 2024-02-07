local att = {}
att.name = "bg_sks_20rnd"
att.displayName = "20 Round Internal Magazine"
att.displayNameShort = "20 Round"
att.isBG = true

att.statModifiers = {
	MagMult = 1
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/rpkmag")
	att.description = {[1] = {t = "Allows additional ammo to be loaded.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.twenty)
	--local anims = self.Animations
	--anims.reload = "reload_20rnd_partial"
	--anims.reload_empty = "reload_20rnd_empty"
	self.SKS20RND = true

	self:unloadWeapon()
end

function att:detachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.none)
	--local anims = self.Animations
	--anims.reload = "reload_10rnd_partial"
	--anims.reload_empty = "reload_10rnd_empty"
	self.SKS20RND = false

	self:unloadWeapon()
end

att.price = 15
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)

local att = {}
att.name = "bg_sks_30rnd"
att.displayName = "30 Round Magazine"
att.displayNameShort = "30 Round"
att.isBG = true

att.statModifiers = {
	MagMult = 2
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/rpkmag")
	att.description = {[1] = {t = "Further allows additional ammo to be loaded.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.thirty)
	--local anims = self.Animations
	--anims.reload = "reload_30rnd_partial"
	--anims.reload_empty = "reload_30rnd_empty"
	self.SKS30RND = true

	self:unloadWeapon()
end

function att:detachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.none)
	--local anims = self.Animations
	--anims.reload = "reload_10rnd_partial"
	--anims.reload_empty = "reload_10rnd_empty"
	self.SKS30RND = false

	self:unloadWeapon()
end

att.price = 35
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)


local att = {}
att.name = "bg_sks_barrelgl"
att.displayName = "Barrel Grenade Launcher"
att.displayNameShort = "Barrel GL"
att.isBG = true

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ak74_rpkbarrel")
	att.description = {[1] = {t = "Allows grenades to be fired from barrel.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.gl)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.none)
end

att.price = 80
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)

