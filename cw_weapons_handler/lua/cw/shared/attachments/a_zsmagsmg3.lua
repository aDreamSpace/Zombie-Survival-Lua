local att = {}
att.name = "a_zsmagsmg3"
att.displayName = "Magazine Upgrade: 125%"
att.displayNameShort = "MMU125"
att.price = 150
att.isBG = true 

att.statModifiers = {
ReloadSpeedMult = -0.025, 
MagMult = 1.25, 
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/smg")
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