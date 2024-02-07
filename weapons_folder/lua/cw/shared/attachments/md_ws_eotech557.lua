local att = {}
att.name = "md_ws_eotech557"
att.displayName = "EoTech 557"
att.displayNameShort = "EoTech7"
att.aimPos = {"WS_EoTech557Pos", "WS_EoTech557Ang"}
att.FOVModifier = 15
att.isSight = true
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT
att.statModifiers = {OverallMouseSensMult = -0.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_ws_eotech557")
	att.description = {[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE}}
	
	att.reticle = "cw2/reticles/White_Snow/eotech_reddot"
	att._reticleSize = 3.5 //2.5
	
	function att:drawReticle()
		if not self:isAiming() or not self:isReticleActive() then
			return
		end
		
		diff = self:getDifferenceToAimPos(self.WS_EoTech557Pos, self.WS_EoTech557Ang, att._reticleSize)
		
		-- draw the reticle only when it's close to center of the aiming position
		if diff > 0.9 and diff < 1.1 then
			cam.IgnoreZ(true)
				render.SetMaterial(att._reticle)
				dist = math.Clamp(math.Distance(1, 1, diff, diff), 0, 0.13)
				
				local EA = self.Owner:EyeAngles() + self.Owner:GetPunchAngle()
				
				local renderColor = self:getSightColor(att.name)
				renderColor.a = (0.13 - dist) / 0.13 * 255
				
				local pos = EyePos() + EA:Forward() * 100
				
				for i = 1, 2 do
					render.DrawSprite(pos, att._reticleSize, att._reticleSize, renderColor)
				end
			cam.IgnoreZ(false)
		end
	end
end

CustomizableWeaponry:registerAttachment(att)