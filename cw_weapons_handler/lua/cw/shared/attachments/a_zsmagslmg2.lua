local att = {}
att.name = "a_zsmagslmg2"
att.displayName = "LMG Bullet Belt 150"
att.displayNameShort = "BB150"
att.price = 155
att.isBG = true 

att.statModifiers = {
ReloadSpeedMult = -0.045, 
MagMult = 1.5, 
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/lmgbelt")
	att.description = {{t = "Increases ammo capacity by 150%.", c = CustomizableWeaponry.textColors.POSITIVE}}
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