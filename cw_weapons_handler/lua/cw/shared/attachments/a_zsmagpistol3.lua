local att = {}
att.name = "a_zsmagpistol3"
att.displayName = "Magazine Upgrade: 125%"
att.displayNameShort = "MU125"
att.price = 120
att.isBG = true 

att.statModifiers = {
ReloadSpeedMult = -0.025, 
MagMult = 1.25, 
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/pistol")
	att.description = {{t = "Increases ammo capacity by 125%.", c = CustomizableWeaponry.textColors.POSITIVE}}
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