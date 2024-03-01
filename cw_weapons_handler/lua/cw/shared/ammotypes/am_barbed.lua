local att = {}
att.name = "am_barbed2"
att.displayName = "Barbed Nails"
att.displayNameShort = "Barbed"

att.statModifiers = {}
att.price = 30
if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/barbed")
	att.description = {
        {t = "Causes zombies to take damage from attacking props.", c = CustomizableWeaponry.textColors.POSITIVE},
        {t = "Nails have reduced health.", c = CustomizableWeaponry.textColors.NEGATIVE},
	}
end

function att:attachFunc()
    self.NailType = NAILTYPE_BARBED
    if CLIENT then
        self.CW_VM:SetSubMaterial(1, "phoenix_storms/wire/pcb_red")
	end
end

function att:detachFunc()
    self.NailType = NAILTYPE_NONE
    if CLIENT then
		self.CW_VM:SetSubMaterial(1, self.CW_VM:GetMaterials()[0])
	end
end

CustomizableWeaponry:registerAttachment(att)
