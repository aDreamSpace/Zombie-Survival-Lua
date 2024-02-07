local att = {}
att.name = "bg_midabodyframe"
att.displayName = "MIDA Multi Tool Body Frame"
att.displayNameShort = "MIDA Body"

att.statModifiers = {RecoilMult = -0.30,
OverallMouseSensMult = 0}

att.price = 85

--If there is a dependency, it cannot use custom icons because of some freak out bug.--
if CLIENT then
	att.displayIcon = surface.GetTextureID("extras/icons/midabody")
end

CustomizableWeaponry:registerAttachment(att)