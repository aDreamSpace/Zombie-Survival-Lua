local att = {}
att.name = "bg_45lc"
att.displayName = "Pistol Caliber"
att.displayNameShort = "Pistol"
att.isBG = true

att.statModifiers = {
RecoilMult = 0.25,
AimSpreadMult = 10,
HipSpreadMult = 100,
VelocitySensitivityMult = -50,
EffectiveRangeMult = .72
} 

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/slugrounds")
	att.description = {{t = "Uses bullets instead of shot.", c = CustomizableWeaponry.textColors.REGULAR}}
end

function att:attachFunc()
	self:unloadWeapon()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.shell)
	self.Primary.Ammo = "pistol"
	self.Primary.Ammo_Orig = "buckshot"
	self.CrosshairEnabled = true
	self.CrosshairParts = {left = true, right = true, upper = true, lower = true}
	self.ClumpSpread = nil
	self.Damage = 175
	self.Damage_Orig = 175
	self.Shots = 1
	self.Shots_Orig = 1
end

function att:detachFunc()
	self:unloadWeapon()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.shell2)
	self.CrosshairEnabled = true
	self.CrosshairParts = {left = false, right = false, upper = false, lower = false}
  	self.Primary.Ammo = self.Primary.Ammo_Orig
	self.Primary.Ammo_Orig = self.Primary.Ammo_Orig
	self.ClumpSpread = self.ClumpSpread_Orig
	self.Shots = self.Shots_ORIG_REAL
	self.Shots_Orig = self.Shots_ORIG_REAL
	self.Damage = 25
	self.Damage_Orig = 25
end

CustomizableWeaponry:registerAttachment(att)