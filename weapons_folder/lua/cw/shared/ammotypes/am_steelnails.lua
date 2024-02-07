local att = {}
att.name = "am_steelnails2"
att.displayName = "Steel Nails"
att.displayNameShort = "Steel"

att.statModifiers = {}
att.price = 40
if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/steel")
	att.description = {
        {t = "Increase prop HP by 35%.", c = CustomizableWeaponry.textColors.POSITIVE},
	}
end

function att:attachFunc()
	self.NailType = NAILTYPE_STEEL
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
