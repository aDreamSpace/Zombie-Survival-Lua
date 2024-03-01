local att = {}
att.name = "am_dragonsbreath2"
att.displayName = "Dragon's Breath"
att.displayNameShort = "Incendiary"

att.statModifiers = {DamageMult = 1.25, 
ClumpSpreadMult = 3.5,
RecoilMult = 2.9}
att.price = 425

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/dragon")
	att.description = {
		{t ="Pellets apply additional burn damage to zombies.", c = CustomizableWeaponry.textColors.POSITIVE}
		
		
		}
end

function att:attachFunc()

	self.bulType = BULTYPE_FIRE
	self:unloadWeapon()
	--self.DoImpactEffect = function() end


end

function att:detachFunc()

	self.bulType = 0
	self:unloadWeapon()
	--self.DoImpactEffect = CW_BULIMPACTFUNC

end

CustomizableWeaponry:registerAttachment(att)
