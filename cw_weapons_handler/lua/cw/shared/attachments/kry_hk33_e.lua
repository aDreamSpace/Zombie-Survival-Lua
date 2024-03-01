local att = {}
att.name = "kry_hk33_e"
att.displayName = "Semi-Auto Lock"
att.displayNameShort = "Semi-Auto"
att.isBG = true
att.description = {[1] = {t = "Semi-Auto mode only!", c = CustomizableWeaponry.textColors.COSMETIC},
}
att.statModifiers = {RecoilMult = -0.04, AimSpreadMult = -0.08}

if CLIENT then
	att.displayIcon = surface.GetTextureID("models/weapons/v_models/kry_hk33/atts/kry_hk33_e")
end

function att:attachFunc()
	self:CycleFiremodes() 
	self.FireModes = {"semi"}
	self.Primary.Automatic = false
	self.FireDelay = 0.2
	self:setBodygroup(self.SEF.main, self.SEF.E)
	end

function att:detachFunc()
	self:CycleFiremodes()
	self.FireModes = {"auto", "semi"}
	self:CycleFiremodes()
	self:CycleFiremodes()
	self.Primary.Automatic = true
	self.FireDelay = 60 / 750
	self:setBodygroup(self.SEF.main, self.SEF.F)
end

CustomizableWeaponry:registerAttachment(att)