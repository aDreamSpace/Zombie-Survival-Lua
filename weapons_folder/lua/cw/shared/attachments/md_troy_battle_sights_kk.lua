local att = {}
att.name = "md_troy_battle_sights"
att.displayName = "Troy Battle Sights"
att.displayNameShort = "Tritium FS"
att.aimPos = {"TroySightPos", "TroySightAng"}
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/foldsight")
	att.description = {
		{t = "Replace iron sights with illuminated flip sights.", c = CustomizableWeaponry.textColors.VPOSITIVE},
		{t = "Can provide quick backup for broken optics,", c = CustomizableWeaponry.textColors.POSITIVE},
		{t = "a feature, which will never make sense", c = CustomizableWeaponry.textColors.VNEGATIVE},
		{t = "unless", c = CustomizableWeaponry.textColors.REGULAR},
		{t = "gamemode can break electronic sights.", c = CustomizableWeaponry.textColors.NEGATIVE},
	}
	
	att.reticle = "qq_sprites/bigdot"
	att._reticleSize = 20
	
	function att:elementRender()
		local rc = self:getSightColor(att.name)
		local vec = Vector((rc.r / 255)*(rc.r / 255), (rc.g / 255)*(rc.g / 255), (rc.b / 255)*(rc.b / 255)) // saturated
		local mat = Material("models/qq_rec/shared/battlesight_diffuse")
		
		mat:SetVector("$selfillumtint", vec)
		
		local currentPrimarySight = self:getActiveAttachmentInCategory(self.primarySightCategory or 1)
		if self.lastPrimarySight != currentPrimarySight then
			sight = CustomizableWeaponry.sights[currentPrimarySight]
			if sight then
				self.SightBackUpPos = self[att.aimPos[1]]
				self.SightBackUpAng = self[att.aimPos[2]]
				
				-- if self.troySightsWereOn then
					-- self.AimPos = self.SightBackUpPos
					-- self.AimAng = self.SightBackUpAng
				-- else
					-- self.AimPos = self.ActualSightPos
					-- self.AimAng = self.ActualSightAng
				-- end
			else
				self.AimPos = self[att.aimPos[1]]
				self.AimAng = self[att.aimPos[2]]
			end
		end
		self.lastPrimarySight = currentPrimarySight
		
		local soundTrigger = self.troySightsWereOn
		local isScopePos = (self.AimPos == self[att.aimPos[1]] and self.AimAng == self[att.aimPos[2]])
		
		//if troyvelements ok then
		local fent = self.AttachmentModelsVM.md_troyfrontsight_kk.ent
		local rent = self.AttachmentModelsVM.md_troyrearsight_kk.ent
		//end
		
		if isScopePos then
			fent:ManipulateBoneAngles(fent:LookupBone("sight"), Angle(0, 0, 0))
			rent:ManipulateBoneAngles(rent:LookupBone("sight"), Angle(0, 0, 0))
			self.troySightsWereOn = true
		else
			fent:ManipulateBoneAngles(fent:LookupBone("sight"), Angle(0, 0, -85))
			rent:ManipulateBoneAngles(rent:LookupBone("sight"), Angle(0, 0, -85))
			self.troySightsWereOn = false
		end
		
		if soundTrigger != self.troySightsWereOn then
			self:EmitSound("CW_MagnifierScope_KK_Switch")
			self:EmitSound("CW_MagnifierScope_KK_Switch")
		end
	end
	
	function att:attachFunc()
		//velements
		if self.AttachmentModelsVM.md_troyfrontsight_kk then
			self.AttachmentModelsVM.md_troyfrontsight_kk.active = true
		end
		if self.AttachmentModelsVM.md_troyrearsight_kk then
			self.AttachmentModelsVM.md_troyrearsight_kk.active = true
		end
		
		// update current aimpos
		local psc = self.primarySightCategory or 1
		local sight = CustomizableWeaponry.sights[self:getActiveAttachmentInCategory(psc)]
				
		if sight then
			self.ActualSightPos = self[sight.aimPos[1]]
			self.ActualSightAng = self[sight.aimPos[2]]
			self.SightBackUpPos = self[att.aimPos[1]]
			self.SightBackUpAng = self[att.aimPos[2]]	
			if self.troySightsWereOn == nil or self.troySightsWereOn == true then
				self.troySightsWereOn = true
				self.AimPos = self.SightBackUpPos
				self.AimAng = self.SightBackUpAng
			else
				self.AimPos = self.ActualSightPos
				self.AimAng = self.ActualSightAng
			end
		else // iron sights
			self.troySightsWereOn = true
			self.AimPos = self[att.aimPos[1]]
			self.AimAng = self[att.aimPos[2]]	
		end
		
		self.lastPrimarySight = sight
	end
	
	function att:detachFunc()
		//velements
		if self.AttachmentModelsVM.md_troyfrontsight_kk then
			self.AttachmentModelsVM.md_troyfrontsight_kk.active = false
		end
		if self.AttachmentModelsVM.md_troyrearsight_kk then
			self.AttachmentModelsVM.md_troyrearsight_kk.active = false
		end
		
		local psc = self.primarySightCategory or 1
		local currentPrimarySight = self:getActiveAttachmentInCategory(psc)
		
		// restore current aimpos
		local sight = CustomizableWeaponry.sights[currentPrimarySight]
		if sight then
			self.AimPos = self[sight.aimPos[1]]
			self.AimAng = self[sight.aimPos[2]]
		else
			self.AimPos = self.AimPos_Orig
			self.AimAng = self.AimAng_Orig
		end
		
		//restore backup sight position for current sight
		local backUp = self.BackupSights[currentPrimarySight]
		if backUp then
			self.SightBackUpPos = backUp[1]
			self.SightBackUpAng = backUp[2]
		else
			self.SightBackUpPos = nil
			self.SightBackUpAng = nil
		end
	end
end

CustomizableWeaponry:registerAttachment(att)