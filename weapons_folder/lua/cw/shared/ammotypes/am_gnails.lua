local att = {}
att.name = "am_gnails2"
att.displayName = "Galvanized Nails"
att.displayNameShort = "Galvanized"

att.statModifiers = {}
att.price = 70
if CLIENT then
   att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/gnails")
	att.description = {
        {t = "Potential prop repairs increased by 10%, prop health increased by 15%.", c = CustomizableWeaponry.textColors.POSITIVE},
	}
end

function att:attachFunc()
	self.NailType = NAILTYPE_GALVANIZED
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
