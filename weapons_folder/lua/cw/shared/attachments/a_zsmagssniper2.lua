local att = {}
att.name = "a_zsmagssniper2"
att.displayName = "Magazine Upgrade: 60%"
att.displayNameShort = "SMU60"
att.price = 90
att.isBG = true 

att.statModifiers = {
ReloadSpeedMult = -0.025, 
MagMult = 0.6, 
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/sniper")
	att.description = {{t = "Increases ammo capacity by 60%.", c = CustomizableWeaponry.textColors.POSITIVE}}
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