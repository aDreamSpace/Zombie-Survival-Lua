local att = {}
att.name = "am_minishells2"
att.displayName = "Mini Shells"
att.displayNameShort = "Mini Shells"
att.price = 25

att.statModifiers = {DamageMult = -0.2,
MagMult = 1
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/minishells")
	att.description = {{t = "Doubles the amount of ammo that can be loaded.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:unloadWeapon()
end

function att:detachFunc()
    self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)