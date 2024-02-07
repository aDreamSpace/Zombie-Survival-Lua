local att = {}
att.name = "md_uecw_emag"
att.displayName = "E-Magazine"
att.displayNameShort = "EMAG"

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("gmod4phun/emag/upgr_emag")
	att.description = {[1] = {t = "Increases mag size to 40 rounds.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:unloadWeapon()
	self.Primary.ClipSize = 40
	self.Primary.ClipSize_Orig = 40
	if self.MagBoneName then
	self.CW_VM:ManipulateBoneScale(self.CW_VM:LookupBone(self.MagBoneName), Vector(0.009, 0.009, 0.009))
	end
end

function att:detachFunc()
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
	if self.MagBoneName then
	self.CW_VM:ManipulateBoneScale(self.CW_VM:LookupBone(self.MagBoneName), Vector(1, 1, 1))
	end
end

CustomizableWeaponry:registerAttachment(att)