local att = {}
att.name = "md_attironsights"
att.displayName = "Iron Sights"
att.displayNameShort = "Ironsights"
att.isSight = true
att.aimPos = {"IsightsPos", "IsightsAng"}

if CLIENT then
	att.displayIcon = surface.GetTextureID("cw20_extras/icons/upgr_rearsight")
	att.description = {[1] = {t = "Gives You Ironsights", c = CustomizableWeaponry.textColors.COSMETIC}}
end

function att:attachFunc()
	if CLIENT then
		if self.AttachmentModelsVM.md_couldbewhat then
			self.AttachmentModelsVM.md_couldbewhat.active = true
		end
	end
end

function att:detachFunc()
	if CLIENT then
		if self.AttachmentModelsVM.md_couldbewhat then
			self.AttachmentModelsVM.md_couldbewhat.active = false
		end
	end
end

att.price = 10
att.model = "models/items/battery.mdl"

CustomizableWeaponry:registerAttachment(att)
