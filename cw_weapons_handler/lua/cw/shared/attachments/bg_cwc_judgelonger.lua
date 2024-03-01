local att = {}
att.name = "bg_cwc_judgelonger"
att.displayName = "6'' Rifled Judge Barrel"
att.displayNameShort = "6'' Rifled"
att.isBG = true

att.statModifiers = {RecoilMult = 0.1,
AimSpreadMult = -0.4,
DrawSpeedMult = -0.10,
EffectiveRangeMult = .75
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_judgelonger")
	att.description = {{t = "Creates tighter groupings.", c = CustomizableWeaponry.textColors.POSITIVE}}
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