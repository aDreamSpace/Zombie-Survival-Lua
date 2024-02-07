local att = {}
att.name = "am_kristallnacht2"
att.displayName = "Glass Shot"
att.displayNameShort = "Kristallnacht"

att.statModifiers = {DamageMult = -0.6, 
ClumpSpreadMult = 2,
EffectiveRangeMult = -.5
}
att.price = 30
if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/nachos")
	att.description = {{t = "Changes amount of shots per round to a random integer.", c = CustomizableWeaponry.textColors.POSITIVE},
		{t ="Pellets apply 2 additional bleed damage to zombies.", c = CustomizableWeaponry.textColors.POSITIVE}
		
		
		}
end

function att:attachFunc()

	self.bulType = 1
	self:unloadWeapon()
	--self.DoImpactEffect = function() end


end

function att:detachFunc()

	self.bulType = 0
	self:unloadWeapon()
	--self.DoImpactEffect = CW_BULIMPACTFUNC

end

CustomizableWeaponry:registerAttachment(att)
