local att = {}
att.name = "bg_am180_supp"
att.displayName = "Suppressed Barrel"
att.displayNameShort = "Suppressor"
att.isBG = true
att.isSuppressor = true

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/saker")
	att.description = {[1] = {t = "Decreases firing noise.\nReduces aura range.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.suppressed)
	self.dt.Suppressed = true
	self.AuraRange = 512
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
	self:resetSuppressorStatus()
end
att.price = 5
att.model = "models/items/battery.mdl"

CustomizableWeaponry:registerAttachment(att)

