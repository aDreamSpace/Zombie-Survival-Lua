local att = {}
att.name = "am_luckylast2"
att.displayName = "Lucky Round"
att.displayNameShort = "Lucky"
att.price = 150

att.statModifiers ={
DamageMult = -0.25,
RecoilMult = 0}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/lucky")
	att.description = {{t = "Quintruples the damage of your last round in the magazine.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:unloadWeapon()	
end

function att:detachFunc()
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)