local att = {}
att.name = "bg_tr09_mp9_chromosynth"
att.displayName = "Chromosynth"
att.displayNameShort = "Sci-Fi"
att.isBG = true

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/bg_tr09_mp9_chromosynth")
	att.description = {[1] = {t = "Changes the gun to a futuristic Gray look with glowy spots. ", c = CustomizableWeaponry.textColors.COSMETIC},
	[2] = {t = "(Color changes depending on Physics Gun color.)", c = CustomizableWeaponry.textColors.REGULAR}}
end

function att:attachFunc()
	if SERVER then
		return
	end

	if self.CW_VM then
		self.CW_VM:SetSkin(2)
	end
	if self.WMEnt then
		self.WMEnt:SetSkin(2)
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