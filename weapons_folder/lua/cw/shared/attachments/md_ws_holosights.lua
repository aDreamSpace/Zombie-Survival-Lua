local att = {}
att.name = "md_ws_holosights"
att.displayName = "Holographic Iron Sights"
att.displayNameShort = "Holo Sights"
att.aimPos = {"WS_HOLOSIGHTPos", "WS_HOLOSIGHTAng"}
att.isSight = true

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_holosights")
	att.description = {[1] = {t = "Futuristic holographic sights that illuminate in dark areas", c = CustomizableWeaponry.textColors.POSITIVE},
						[2] = {t = "Might slightly reduce awareness.", c = CustomizableWeaponry.textColors.NEGATIVE}}
end

function att:attachFunc()
	if CLIENT then
		if self.AttachmentModelsVM.md_ws_holosights2 then
			self.AttachmentModelsVM.md_ws_holosights2.active = true
		end
	end
end

function att:detachFunc()
	if CLIENT then
		if self.AttachmentModelsVM.md_ws_holosights2 then
			self.AttachmentModelsVM.md_ws_holosights2.active = false
		end
	end
end


CustomizableWeaponry:registerAttachment(att)