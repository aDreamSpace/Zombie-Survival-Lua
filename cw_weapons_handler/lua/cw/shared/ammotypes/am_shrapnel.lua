local att = {}
att.name = "am_shrapnel2"
att.displayName = "Shrapnel Load"
att.displayNameShort = "Shrapnel"

att.statModifiers ={
DamageMult = -0.90,
ClumpSpreadMult = 2
}
att.price = 5
att.worth = 5
if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/shrapnel")
	att.description = {{t = "You stuffed random crap into your shell, may or may not work", c = CustomizableWeaponry.textColors.REGULAR}}
end

function att:attachFunc()
	self.bulType = 6
	self:unloadWeapon()
	
end

function att:detachFunc()
	self.bulType = 0
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)