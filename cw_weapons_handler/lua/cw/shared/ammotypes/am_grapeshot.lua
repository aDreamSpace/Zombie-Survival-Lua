local att = {}
att.name = "am_grapeshot2"
att.displayName = "GrapeShot"
att.displayNameShort = "GSRNDs"

att.statModifiers = {DamageMult = -0.7,
	VelocitySensitivityMult = -50,
	ShotsMult = 18,
	RecoilMult = 3,
	EffectiveRangeMult = -.8
	}
att.price = 185
if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/grapeshot")
	att.description = {{t = "Increases pellet amount to 16.", c = CustomizableWeaponry.textColors.POSITIVE},
	}
end

function att:attachFunc()
	self:unloadWeapon()
	self.CrosshairEnabled = true
	self.CrosshairParts = {left = false, right = false, upper = false, lower = false}
	self.ClumpSpread = .05
	self.ClumpSpread_Orig = .05
end

function att:detachFunc()
	self:unloadWeapon()
	self.CrosshairEnabled = false
	self.CrosshairParts = {left = true, right = true, upper = true, lower = true}
	self.ClumpSpread = self.ClumpSpread_ORIG_REAL
	self.ClumpSpread_orig = self.ClumpSpread_ORIG_REAL
end

CustomizableWeaponry:registerAttachment(att)
