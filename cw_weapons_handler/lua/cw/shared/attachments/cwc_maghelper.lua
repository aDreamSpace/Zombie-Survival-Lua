local att = {}
att.name = "cwc_maghelper"
att.displayName = "Maghelper"
att.displayNameShort = "Helper"

att.statModifiers = {ReloadSpeedMult = 0.15,
OverallMouseSensMult = -0.03,
DrawSpeedMult = -0.1,}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/maghelper")
	att.description = {[1] = {t = "Improves your magazine handling, providing ease for reloads.", c = CustomizableWeaponry.textColors.NORMAL}}
	-- local renderColor = self:GetPartColor(att.name)
end

function att:attachFunc()

end

function att:detachFunc()

end

CustomizableWeaponry:registerAttachment(att)