local att = {}
att.name = "a_zsmagssniper3"
att.displayName = "Magazine Upgrade: 150%"
att.displayNameShort = "SMU150"
att.price = 180
att.isBG = true 

att.statModifiers = {
ReloadSpeedMult = -0.025, 
MagMult = 1.5, 
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/sniper")
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