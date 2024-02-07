local att = {}
att.name = "md_uecw_cmag"
att.displayName = "Beta C-Magazine"
att.displayNameShort = "CMAG"

att.statModifiers = {
	ReloadSpeedMult = -0.3,
	OverallMouseSensMult = -0.1
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("cw20_extras/icons/upgr_cmag")
	att.description = {[1] = {t = "Increases mag size to 100 rounds.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:unloadWeapon()
	
	if self.ActiveAttachments.md_foregrip or self.ActiveAttachments.md_m203 then
		self.ForegripOverride = false
	else
		self.ForegripOverride = true
	end
	
	self.ForegripParent = "md_uecw_cmag"
	
	self.Primary.ClipSize = 100
	self.Primary.ClipSize_Orig = 100
	if self.MagBoneName then
	self.CW_VM:ManipulateBoneScale(self.CW_VM:LookupBone(self.MagBoneName), Vector(0.009, 0.009, 0.009))
	end
end

function att:detachFunc()
	self:unloadWeapon()
	self.ForegripOverride = false
	self.Primary.ClipSize = 30
	self.Primary.ClipSize_Orig = 30
	if self.MagBoneName then
	self.CW_VM:ManipulateBoneScale(self.CW_VM:LookupBone(self.MagBoneName), Vector(1, 1, 1))
	end
end

CustomizableWeaponry:registerAttachment(att)