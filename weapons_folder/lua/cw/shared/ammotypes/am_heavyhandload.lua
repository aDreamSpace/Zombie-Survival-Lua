local att = {}
att.name = "am_heavyhandload2"
att.displayName = "Heavy Handload"
att.displayNameShort = "HLRNDs"

att.statModifiers = {DamageMult = .95,
	RecoilMult = 3.3}
att.price = 95
if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/handload")
	att.description = {{t ="A custom handloaded round loaded with extreme amounts of smokeless powder."}}
end

function att:attachFunc()
	self:unloadWeapon()
end

function att:detachFunc()
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)
