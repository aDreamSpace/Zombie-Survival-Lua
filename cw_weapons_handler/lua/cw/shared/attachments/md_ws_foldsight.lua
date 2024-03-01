local att = {}
att.name = "md_ws_foldsight"
att.displayName = "Folding sights"
att.displayNameShort = "Fold"
att.aimPos = {"WS_FoldSightPos", "WS_FoldSightAng"}
att.isSight = true

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_ws_foldsight")
	att.description = {[1] = {t = "A folding variant of regular ironsights.", c = CustomizableWeaponry.textColors.COSMETIC}}
end
	
function att:attachFunc()
	if CLIENT then
		if self.AttachmentModelsVM.md_ws_foldsight2 then
			self.AttachmentModelsVM.md_ws_foldsight2.active = true
		end
	end
end

function att:detachFunc()
	if CLIENT then
		if self.AttachmentModelsVM.md_ws_foldsight2 then
			self.AttachmentModelsVM.md_ws_foldsight2.active = false
		end
	end
end

CustomizableWeaponry:registerAttachment(att)