local att = {}
att.name = "extmag1"
att.displayName = "EM Mag"
att.displayNameShort = "EM Mag"
att.price = 25
att.isBG = true 

att.statModifiers = {
ReloadSpeedMult = -0.04, 
MagMult = 0.5, 
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/rpkmag")
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