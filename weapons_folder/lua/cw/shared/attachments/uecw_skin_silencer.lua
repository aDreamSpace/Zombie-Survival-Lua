local att = {}
att.name = "uecw_skin_silencer"
att.displayName = "Tactical Suppressor"
att.displayNameShort = "Suppressor"
att.isSuppressor = true

att.statModifiers = {RecoilMult = -0.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/suppressor")
	att.description = {[1] = {t = "Decreases firing noise", c = CustomizableWeaponry.textColors.POSITIVE},
	[2] = {t = "Does not negate any damage", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.dt.Suppressed = true
	self.SkinSilencerInstalled = true
end

function att:detachFunc()
	self.dt.Suppressed = false
	self.SkinSilencerInstalled = false
end
CustomizableWeaponry:registerAttachment(att)