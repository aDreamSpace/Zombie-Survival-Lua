local att = {}
att.name = "bg_cwc_judgelongersmooth"
att.displayName = "6'' Smoothbore Judge Barrel"
att.displayNameShort = "6'' Smooth"
att.isBG = true

att.statModifiers = {RecoilMult = 0.05,
ClumpSpreadMult = -0.25,
DrawSpeedMult = -0.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_judgelonger")
	att.description = {{t = "Creates tighter groupings with shotshells.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.three)
		if not self:isAttachmentActive("sights") then
		self:updateIronsights("JudgeLonger")
	end
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.one)
	self:revertToOriginalIronsights()
end

CustomizableWeaponry:registerAttachment(att)