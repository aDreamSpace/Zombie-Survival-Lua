local att = {}
att.name = "a_zsmagshotgun1"
att.displayName = "Drum Upgrade: 20%"
att.displayNameShort = "DU20"
att.price = 30
att.isBG = true 

att.statModifiers = {
ReloadSpeedMult = -0.025, 
MagMult = 0.2, 
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/shotgun")
	att.description = {{t = "Increases ammo capacity by 20%.", c = CustomizableWeaponry.textColors.POSITIVE}}
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