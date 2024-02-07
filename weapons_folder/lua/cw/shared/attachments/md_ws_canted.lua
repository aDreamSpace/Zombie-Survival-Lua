local att = {}
att.name = "md_ws_canted"
att.displayName = "Canted NcStar Sights"
att.displayNameShort = "Canted"
//att.isSight = true
//att.FOVModifier = 15
att.aimPos = {"WS_CantedPos", "WS_CantedAng"}
//att.statModifiers = {}

// Knife Kitty is awesome
if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_ws_canted")
	att.description = {[1] = {t = "Double tap use key while aiming to use.", c = CustomizableWeaponry.textColors.COSMETIC}}
end

function att:attachFunc()
if CLIENT then
	if self.AttachmentModelsVM.md_ws_canted2 then
		self.AttachmentModelsVM.md_ws_canted2.active = true
	end
end
end

 function att:elementRender()
		if not self.ActiveAttachments[att.name] then return end
		// use camelcase
		local currentPrimarySight = self:getActiveAttachmentInCategory(self.primarySightCategory or 1)
		if self.lastPrimarySight != currentPrimarySight then
			self.SightBackUpPos = self[att.aimPos[1]]
			self.SightBackUpAng = self[att.aimPos[2]]
			
		if not CustomizableWeaponry.sights[currentPrimarySight] then
			self.ActualSightPos = self.AimPos_Orig				
			self.ActualSightAng = self.AimAng_Orig
		end
end
end

function att:detachFunc()	
if CLIENT then
	if self.AttachmentModelsVM.md_ws_canted2 then
		self.AttachmentModelsVM.md_ws_canted2.active = false
	end
end
/*
if CustomizableWeaponry_KK_HK416 then
		self.KKRenderTargetFunc = nil
		
		local backUp = self.BackupSights[self:getActiveAttachmentInCategory(self.SightCategoryIndex or 1)]
		if backUp then
			self.SightBackUpPos = backUp[1]
			self.SightBackUpAng = backUp[2]
		else
			self.SightBackUpPos = nil
			self.SightBackUpAng = nil
			
	end
end
*/

	self.SightBackUpPos = nil
	self.SightBackUpAng = nil
	//self.SightBackUpPos = self.SightBackUpPos_Orig
	//self.SightBackUpAng = self.SightBackUpAng_Orig
	
end



//confirmed
CustomizableWeaponry:registerAttachment(att)