local att = {}
att.name = "bg_tr09_mp9_tan"
att.displayName = "Tan"
att.displayNameShort = "Tan"
att.isBG = true

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/bg_tr09_mp9_tan")
	att.description = {[1] = {t = "Changes the weapon's body to Tan.", c = CustomizableWeaponry.textColors.COSMETIC}}
end

function att:attachFunc()
	if SERVER then
		return
	end

	if self.CW_VM then
		self.CW_VM:SetSkin(1)
	end
	if self.WMEnt then
		self.WMEnt:SetSkin(1)
	end
end

function att:detachFunc()
	if SERVER then
		return
	end

	if self.CW_VM then
		self.CW_VM:SetSkin(0)
	end
	if self.WMEnt then
		self.WMEnt:SetSkin(0)
	end
end

CustomizableWeaponry:registerAttachment(att)