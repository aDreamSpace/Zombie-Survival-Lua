local att = {}
att.name = "am_matchgrade2"
att.displayName = "Match grade rounds"
att.displayNameShort = "MRNDs"

att.statModifiers = {RecoilMult = -0.25,
EffectiveRangeMult = 2}
att.price = 15
att.worth = 15
if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/match")
	att.description = {}
end

function att:attachFunc()
	self:unloadWeapon()
end

function att:detachFunc()
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)