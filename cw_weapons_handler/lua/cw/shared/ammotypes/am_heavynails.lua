local att = {}
att.name = "am_heavynails2"
att.displayName = "Heavy Nails"
att.displayNameShort = "Heavy"

att.statModifiers = {}
att.price = 100
if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/heavynails")
	att.description = {
        {t = "Potential prop repair increased by 25%", c = CustomizableWeaponry.textColors.POSITIVE},
	}
end

function att:attachFunc()
	self.NailType = NAILTYPE_HEAVY
	if CLIENT then
		self.CW_VM:SetSubMaterial(1, "debug/env_cubemap_model")
	end
end

function att:detachFunc()
	self.NailType = NAILTYPE_NONE
	if CLIENT then
		self.CW_VM:SetSubMaterial(1, self.CW_VM:GetMaterials()[0])
	end
end

CustomizableWeaponry:registerAttachment(att)
