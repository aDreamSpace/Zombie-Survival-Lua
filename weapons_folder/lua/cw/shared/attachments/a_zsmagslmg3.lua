local att = {}
att.name = "a_zsmagslmg3"
att.displayName = "LMG Bullet Belt 200"
att.displayNameShort = "BB200"
att.price = 250
att.isBG = true 

att.statModifiers = {
ReloadSpeedMult = -0.065, 
MagMult = 2, 
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/lmgbelt")
	att.description = {{t = "Increases ammo capacity by 200%.", c = CustomizableWeaponry.textColors.POSITIVE}}
end


function att:attachFunc()
--	self:setBodygroup(self.MagBGs.main, self.MagBGs.round60)
	self:unloadWeapon()
	
end

function att:detachFunc()
--	self:setBodygroup(self.MagBGs.main, self.MagBGs.regular)
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end

  
CustomizableWeaponry:registerAttachment(att)