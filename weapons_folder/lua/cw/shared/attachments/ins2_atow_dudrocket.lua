local att = {}
att.name = "ins2_atow_dudrocket"
att.displayName = "Defective Rocket"
att.displayNameShort = "DEF"
att.isBG = true
att.price = 8

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/rpg7aloha")
	att.description = {[1] = {t = "A standard HEAT warhead with a damaged rocket.", c = CustomizableWeaponry.textColors.NEGATIVE},
	[2] = {t = "Fuel and trajectory is rarely consistent, it may just fall out!", c = CustomizableWeaponry.textColors.NEGATIVE},
	[3] = {t = "It may or may not work correctly/kill you.", c = CustomizableWeaponry.textColors.NEGATIVE }}
	
end

function att:attachFunc()
self:unloadWeapon()
end

function att:detachFunc()
self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)
