local att = {}
att.name = "md_dualmag_m27"
att.displayName = "Dual Mags"
att.displayNameShort = "Dual"
att.isBG = true

att.statModifiers = {
	OverallMouseSensMult = -0.05
}
	

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/dualmag")
		att.description = {[1] = {t = "Two magazines stuck together.", c = CustomizableWeaponry.textColors.POSITIVE},
						[2] = {t = "Increases full reload speed.", c = CustomizableWeaponry.textColors.NEGATIVE}}
							
						
end

function att:attachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.Dual)
	self.Animations = {fire = {"Shoot1","shoot2"},
	reload = "Reload_full_taped",
	reload_empty = "reload",
	idle = "Idle",
	draw = "fold"}
	self.ReloadTime = 1.55
	self.ReloadHalt = 1.55
end

function att:detachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.regular)
	self:unloadWeapon()
	self.Animations = {fire = {"Shoot1","shoot2"},
	reload = "Reload_full",
	reload_empty = "reload",
	idle = "Idle",
	draw = "fold"}
	self.ReloadTime = 1.7
	self.ReloadHalt = 1.7
end
att.price = 25
att.model = "models/items/battery.mdl"


CustomizableWeaponry:registerAttachment(att)


