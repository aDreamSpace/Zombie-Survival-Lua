local att = {}
att.name = "a_zsmagshotgun2"
att.displayName = "Drum Upgrade: 50%"
att.displayNameShort = "DU50"
att.price = 75
att.isBG = true 

att.statModifiers = {
ReloadSpeedMult = -0.025, 
MagMult = 0.5, 
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/shotgun")
	att.description = {{t = "Increases ammo capacity by 50%.", c = CustomizableWeaponry.textColors.POSITIVE}}
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