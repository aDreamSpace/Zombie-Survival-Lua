local att = {}
att.name = "md_fas2_leupold"
att.displayName = "Leupold MK4 Scope"
att.displayNameShort = "Leupold"
att.aimPos = {"LeupoldPos", "LeupoldAng"}
att.FOVModifier = 15
att.isSight = true

att.statModifiers = {
	OverallMouseSensMult = -0.2
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/md_fas2_leupold")
	att.description = {
		[1] = {t = "Provides 8x magnification.", c = CustomizableWeaponry.textColors.POSITIVE},
		[2] = {t = "Narrow scope reduces awareness.", c = CustomizableWeaponry.textColors.NEGATIVE},
		[3] = {t = "Is very disorienting when engaging targets at close range.", c = CustomizableWeaponry.textColors.NEGATIVE}
	}
	
	local old, x, y, ang
	local reticle = surface.GetTextureID("models/qq_rec/fas2_2015/scope_leo")
	
	local RTMat = Material("models/qq_rec/fas2_2015/lens_special")
	local SimpleRTMat = Material("models/qq_rec/cod4_2014/weapon_red_dot_reflexsight")
	
	att.zoomTextures = { 
		{tex = surface.GetTextureID("models/qq_rec/cod4_2014/weapon_red_dot_reflexsight"), offset = {0, 1}},
		{tex = reticle, offset = {0, 1}},
	}
	
	local lens = surface.GetTextureID("cw2/gui/lense")
	local lensMat = Material("cw2/gui/lense")
	local cd, alpha, reticleTime = {}, 0.5, 0
	local Ini = true
	
	-- render target var setup
	cd.x = 0
	cd.y = 0
	cd.w = 512
	cd.h = 512
	cd.fov = 2.5
	cd.drawviewmodel = false
	cd.drawhud = false
	cd.dopostprocess = false
	
	function att:drawRenderTarget()
		local complexTelescopics = self:canUseComplexTelescopics()
		
		local isAiming = self:isAiming()
		local freeze = GetConVarNumber("cw_kk_freeze_reticles") != 0
		local correctMDL = self.AttachmentModelsVM.md_fas2_leupold.model == "models/v_fas2_leupold.mdl"
		
		if (isAiming /*or freeze*/) and correctMDL then 
			self.AttachmentModelsVM.md_fas2_leupold.ent:SetBodygroup(1, 1)
		elseif correctMDL then 
			self.AttachmentModelsVM.md_fas2_leupold.ent:SetBodygroup(1, 0)
		end
		
		if not complexTelescopics then
			RTMat:SetTexture("$basetexture", lensMat:GetTexture("$basetexture"))
			SimpleRTMat:SetTexture("$basetexture",CustomizableWeaponry_KK_SimpleTelescopeRT)
			
			x, y = ScrW(), ScrH()
			old = render.GetRenderTarget()
	
			render.SetRenderTarget(CustomizableWeaponry_KK_SimpleTelescopeRT)
			render.SetViewPort(0, 0, 1024, 1024)
			render.Clear(0,0,0,0,true,true)
			
			-- if CustomizableWeaponry_KK_SimpleTelescopeRT_Ini then
				-- render.RenderView()
				-- render.Clear(0,0,0,0,false,false)
				-- CustomizableWeaponry_KK_SimpleTelescopeRT_Ini = false
			-- end
			
			cam.Start2D()
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(reticle)
				surface.DrawTexturedRect(0, 0, 1024, 1024)
			
				local trace = {}
				trace.start = self.Owner:GetShootPos()
				trace.endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector()*60000
				trace.filter = self.Owner
				local tr = util.TraceLine(trace)
				local dist = math.Round(self.Owner:GetShootPos():Distance(tr.HitPos)/39.37, 1)
				local txt = dist .. "m"
				local range = math.Round(self.EffectiveRange/39.37, 1)
				local percent = math.Clamp((dist - (range / 2)) / (range / 2), 0, 1)
				
				surface.SetFont( "CW_HUD28" )
				if percent == 0 then
					surface.SetTextColor(0, 255, 0, 255)
				elseif percent>0 and percent<1 then
					surface.SetTextColor(255, 255, 0, 255)
				elseif percent == 1 then
					surface.SetTextColor(255, 0, 0, 255)
				end
				surface.SetTextPos(650 - surface.GetTextSize(txt), 760)
				surface.DrawText(txt)
			cam.End2D()
			
			render.SetViewPort(0, 0, x, y)
			render.SetRenderTarget(old)
			return
		end
		
		if self:canSeeThroughTelescopics(att.aimPos[1]) then
			alpha = math.Approach(alpha, 0, FrameTime() * 5)
			reticleTime = math.Approach(reticleTime, 1, FrameTime() * 1.8)
		else
			alpha = math.Approach(alpha, 1, FrameTime() * 5)
			reticleTime = 0
		end
		
		if freeze then
			alpha = 0
		end
		
		x, y = ScrW(), ScrH()
		old = render.GetRenderTarget()
	
		-- ang = self:getMuzzlePosition().Ang
		-- ang = MySelf:EyeAngles() + MySelf:GetPunchAngle()
		
		-- print("=====================")
		-- print(ang)
		-- print(self.AttachmentModelsVM.md_fas2_leupold.angle)
		-- print(MySelf:EyeAngles() + MySelf:GetPunchAngle())
		-- print("=====================")
		
		if correctMDL then
			ang = self.AttachmentModelsVM.md_fas2_leupold.ent:GetAngles()
			
			if self.ViewModelFlip then
				ang.r = -self.BlendAng.z
			else
				ang.r = self.BlendAng.z
			end
				
			ang:RotateAroundAxis(ang:Right(), self.LeupoldAxisAlign.right)
			ang:RotateAroundAxis(ang:Up(), self.LeupoldAxisAlign.up)
			ang:RotateAroundAxis(ang:Forward(), self.LeupoldAxisAlign.forward)
		else
			ang = MySelf:EyeAngles() + MySelf:GetPunchAngle()
			
			if self.ViewModelFlip then
				ang.r = -self.BlendAng.z
			else
				ang.r = self.BlendAng.z
			end
		end
		
		cd.angles = ang
		cd.origin = self.Owner:GetShootPos()
		render.SetRenderTarget(CustomizableWeaponry_KK_MagnifyingRT)
		render.SetViewPort(0, 0, 512, 512)
			if alpha < 1 or Ini then
				render.RenderView(cd)
				Ini = false
			end
			
			ang = self.Owner:EyeAngles()
			ang.p = ang.p + self.BlendAng.x
			ang.y = ang.y + self.BlendAng.y
			ang.r = ang.r + self.BlendAng.z
			ang = -ang:Forward()
			
			local light = render.ComputeLighting(self.Owner:GetShootPos(), ang)
			
			cam.Start2D()
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(surface.GetTextureID("models/qq_rec/fas2_2015/scope_leo"))
				surface.DrawTexturedRect(-256, -256, 1024, 1024)
				
				-- surface.SetDrawColor(255, 255, 255, 255)
				-- surface.SetTexture(surface.GetTextureID("models/qq_rec/cod4_2014/fake"))
				-- surface.DrawTexturedRect(0, 0, 512, 512)	
				
				-- if self.AttachmentModelsVM.md_fas2_leupold.showDist then
					local trace = {}
					trace.start = self.Owner:GetShootPos()
					trace.endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector()*60000
					trace.filter = self.Owner
					local tr = util.TraceLine(trace)
					local dist = math.Round(self.Owner:GetShootPos():Distance(tr.HitPos)/39.37, 1)
					local txt = dist .. "m"
					local range = math.Round(self.EffectiveRange/39.37, 1)
					-- local rangePen = math.Round(self.PenetrativeRange/39.37, 1)
					local percent = math.Clamp((dist - (range / 2)) / (range / 2), 0, 1)
				
					surface.SetFont( "CW_HUD24" )
					if percent == 0 then
						surface.SetTextColor(0, 255, 0, 255)
					elseif percent>0 and percent<1 then
						surface.SetTextColor(255, 255, 0, 255)
					elseif percent == 1 then
						surface.SetTextColor(255, 0, 0, 255)
					end
					surface.SetTextPos(350 - surface.GetTextSize(txt), 280)
					surface.DrawText(txt)
					
					-- txt = range .. "m"
					-- surface.SetTextColor(255, 255, 255, 255)
					-- surface.SetTextPos(350 - surface.GetTextSize(txt), 300)
					-- surface.DrawText(txt)
					
					-- self.EffectiveRange
					-- self.DamageFallOff
					-- self.PenetrativeRange
				-- end
					
				local dh, dv, rx, ry
				
				dh = 1
				dv = 1
					
				if reticleTime == 1 then
					dh = math.Clamp(self:getDifferenceToAimPos(self.AimPos, self.AimAng, 0, 1, -0.5),0,2)
					dv = math.Clamp(self:getDifferenceToAimPos(self.AimPos, self.AimAng, 1, 0, -1),0,2)
				end
				
				rx = -1024 + dh * 512
				ry = -1024 + dv * 512
		
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(surface.GetTextureID("models/qq_rec/cod4_2014/fake_long"))
				surface.DrawTexturedRect(rx, ry, 1536, 1536)	
				
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(surface.GetTextureID("models/qq_rec/cod4_2014/fake"))
				surface.DrawTexturedRect(0, 0, 512, 512)	
				
				surface.SetDrawColor(150 * light[1], 150 * light[2], 150 * light[3], 255 * alpha)
				surface.SetTexture(lens)
				surface.DrawTexturedRectRotated(256, 256, 512, 512, 90)
			cam.End2D()
		render.SetViewPort(0, 0, x, y)
		render.SetRenderTarget(old)
		
		if RTMat then
			RTMat:SetTexture("$basetexture", CustomizableWeaponry_KK_MagnifyingRT)
		end
	end
end

function att:attachFunc()
	if CLIENT then
		if self.AttachmentModelsVM.md_fas2_leupold_mount then
			self.AttachmentModelsVM.md_fas2_leupold_mount.active = true
		end
		if self.AttachmentModelsVM.md_fas2_leupold_mount_2 then
			self.AttachmentModelsVM.md_fas2_leupold_mount_2.active = true
		end
		
		self.CrosshairPartsOrig = self.CrosshairParts
		self.CrosshairParts = {left = false, right = false, upper = false, lower = false}
	end
	
	self.OverrideAimMouseSens = 0.25
	self.SimpleTelescopicsFOV = 120
	self.BlurOnAim = true
	self.ZoomTextures = att.zoomTextures
end

function att:detachFunc()
	if CLIENT then
		if self.AttachmentModelsVM.md_fas2_leupold_mount then
			self.AttachmentModelsVM.md_fas2_leupold_mount.active = false
		end
		if self.AttachmentModelsVM.md_fas2_leupold_mount_2 then
			self.AttachmentModelsVM.md_fas2_leupold_mount_2.active = false
		end
		
		self.CrosshairParts = self.CrosshairPartsOrig
	end
	
	self.OverrideAimMouseSens = nil
	self.SimpleTelescopicsFOV = nil
	self.BlurOnAim = false
end

CustomizableWeaponry:registerAttachment(att)