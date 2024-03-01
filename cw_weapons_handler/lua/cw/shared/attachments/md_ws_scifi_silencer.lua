local att = {}
att.name = "md_ws_scifi_silencer"
att.displayName = "Sci Fi Suppressor"
att.displayNameShort = "Sci Fi"
att.isSuppressor = true

att.statModifiers = {
	OverallMouseSensMult = -0.10, //-0.05
	RecoilMult = -0.20,
	//DamageMult = -0.1 -- your lucky
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_ws_scifi_silencer")
	att.description = {[1] = {t = "Decreases firing noise.", c = CustomizableWeaponry.textColors.POSITIVE},
						[2] = {t = "No damage loss", c = CustomizableWeaponry.textColors.VPOSITIVE}}
end

function att:attachFunc()
	self.dt.Suppressed = true
end

function att:detachFunc()
	self.dt.Suppressed = false
end

CustomizableWeaponry:registerAttachment(att)