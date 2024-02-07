local att = {}
att.name = "md_ws_swr_silencer"
att.displayName = "SWR Trident"
att.displayNameShort = "Trident"
att.isSuppressor = true

att.statModifiers = {
	OverallMouseSensMult = -0.10,
	RecoilMult = -0.10,
	DamageMult = -0.05,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_ws_swr_silencer")
	att.description = {[1] = {t = "Decreases firing noise.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.dt.Suppressed = true
end

function att:detachFunc()
	self.dt.Suppressed = false
end

CustomizableWeaponry:registerAttachment(att)