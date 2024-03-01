local att = {}
att.name = "bg_cwc_judgelongsmooth"
att.displayName = "4'' SmoothBore Judge Barrel"
att.displayNameShort = "4'' Smooth"
att.isBG = true

att.statModifiers = {RecoilMult = 0.05,
ClumpSpreadMult = -0.15,
DrawSpeedMult = -0.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_judgelong")
	att.description = {{t = "Creates tighter groupings with shotshells.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.two)
		if not self:isAttachmentActive("sights") then
		self:updateIronsights("JudgeLong")
	end
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.one)
	self:revertToOriginalIronsights()
end

CustomizableWeaponry:registerAttachment(att)