local att = {}
att.name = "a_zsmagar3"
att.displayName = "Magazine Upgrade: 85%"
att.displayNameShort = "MM100"
att.price = 125
att.isBG = true 

att.statModifiers = {
ReloadSpeedMult = -0.025, 
MagMult = 0.85, 
}


if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/ar")
	att.description = {{t = "Increases ammo capacity by 85%.", c = CustomizableWeaponry.textColors.POSITIVE}}
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