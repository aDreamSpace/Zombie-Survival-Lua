AddCSLuaFile()

-- this shit lets me change grenade types

local att = {}
att.name = "am_m79_ammo"
att.displayName = "Grenade Type"
att.displayNameShort = "Grenades"
att.isGrenadeLauncher = true

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/m79_ammo")
	att.description = {[1] = {t = "Allows the swapping of grenade types.", c = CustomizableWeaponry.textColors.REGULAR}}
end

CustomizableWeaponry:registerAttachment(att)