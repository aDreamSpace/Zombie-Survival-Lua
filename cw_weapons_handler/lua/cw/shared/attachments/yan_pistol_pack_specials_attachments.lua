local att = {}
att.name = "md_special_pistol_sight"
att.displayName = "Delta Point"
att.displayNameShort = "Delta"
att.aimPos = {"DeltaPointPos", "DeltaPointAng"}
att.FOVModifier = 20
att.withoutRail = true
att.isSight = true
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT

att.statModifiers = {
AimSpreadMult = -0.05,
MaxSpreadIncMult = -0.05,
OverallMouseSensMult = -0.05
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/delta")
	att.description = {[1] = {t = "Looks cool and Provides a small but precise reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE}}
	
	att.reticle = "delta_reticle/reddot"  -- 	att.reticle = "cw2/reticles/aim_reticule"
	att._reticleSize = 0.27

	function att:drawReticle()
		if not self:isAiming() or not self:isReticleActive() then
			return
		end
		
		diff = self:getDifferenceToAimPos(self.DeltaPointPos, self.DeltaPointAng, att._reticleSize)

		-- draw the reticle only when it's close to center of the aiming position
		if diff > 0.9 and diff < 1.1 then
			cam.IgnoreZ(true)
				render.SetMaterial(att._reticle)
				dist = math.Clamp(math.Distance(1, 1, diff, diff), 0, 0.13)
				
				local EA = self:getReticleAngles()
				
				local renderColor = self:getSightColor(att.name)
				renderColor.a = (0.13 - dist) / 0.13 * 255
				
				local pos = EyePos() + EA:Forward() * 100
				
				for i = 1, 2 do
					render.DrawSprite(pos, att._reticleSize, att._reticleSize, renderColor)
				end
			cam.IgnoreZ(false)
		end
	end
end

CustomizableWeaponry:registerAttachment(att)

local att = {}
att.name = "md_pist_rmr"
att.displayName = "Trijicon RMR"
att.displayNameShort = "RMR"
att.aimPos = {"RMRPos", "RMRAng"}
att.FOVModifier = 15
att.withoutRail = true
att.isSight = true
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/rmr")
	att.description = {[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE},
	[2] = {t = "Slightly increases aim zoom.", c = CustomizableWeaponry.textColors.POSITIVE},
	[3] = {t = "Narrow scope may decrease awareness.", c = CustomizableWeaponry.textColors.NEGATIVE}}
	
	att.reticle = "cw2/reticles/aim_reticule"
	att._reticleSize = 0.4
	
	function att:drawReticle()
		if not self:isAiming() or not self:isReticleActive() then
			return
		end
		
		diff = self:getDifferenceToAimPos(self.RMRPos, self.RMRAng, 1)
		
		-- draw the reticle only when it's close to center of the aiming position
		if diff > 0.9 and diff < 1.1 then
			cam.IgnoreZ(true)
				render.SetMaterial(att._reticle)
				dist = math.Clamp(math.Distance(1, 1, diff, diff), 0, 0.13)
				
				local EA = self:getReticleAngles()
				
				local renderColor = self:getSightColor(att.name)
				renderColor.a = (0.13 - dist) / 0.13 * 255
				
				local pos = EyePos() + EA:Forward() * 100
				
				for i = 1, 2 do
					render.DrawSprite(pos, att._reticleSize, att._reticleSize, renderColor)
				end
			cam.IgnoreZ(false)
		end
	end
end

CustomizableWeaponry:registerAttachment(att)

local att = {}
att.name = "md_pist_docter"
att.displayName = "Docter Sight"
att.displayNameShort = "Docter"
att.aimPos = {"DocterPos", "DocterAng"}
att.FOVModifier = 15
att.withoutRail = true
att.isSight = true
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT



if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/docter")
	att.description = {[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE}}
	
	att.reticle = "cw2/reticles/aim_reticule"
	att._reticleSize = 0.5

	function att:drawReticle()
		if not self:isAiming() or not self:isReticleActive() then
			return
		end
		
		diff = self:getDifferenceToAimPos(self.DocterPos, self.DocterAng, att._reticleSize)

		-- draw the reticle only when it's close to center of the aiming position
		if diff > 0.9 and diff < 1.1 then
			cam.IgnoreZ(true)
				render.SetMaterial(att._reticle)
				dist = math.Clamp(math.Distance(1, 1, diff, diff), 0, 0.13)
				
				local EA = self:getReticleAngles()
				
				local renderColor = self:getSightColor(att.name)
				renderColor.a = (0.13 - dist) / 0.13 * 255
				
				local pos = EyePos() + EA:Forward() * 100
				
				for i = 1, 2 do
					render.DrawSprite(pos, att._reticleSize, att._reticleSize, renderColor)
				end
			cam.IgnoreZ(false)
		end
	end
end

CustomizableWeaponry:registerAttachment(att)

local att = {}
att.name = "md_pist_insight_x2"
att.displayName = "Insight X2 LAM"
att.displayNameShort = "X2 LAM"
att.laserRange = 4096
att.laserBeamRange = 75
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_BEAM

att.statModifiers = {VelocitySensitivityMult = -0.2,
OverallMouseSensMult = -0.05,
HipSpreadMult = -0.2,
DrawSpeedMult = -0.05,
MaxSpreadIncMult = -0.25}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/insight_x2")
	local beam = Material("cw2/reticles/aim_reticule")
	local laserDot = Material("cw2/reticles/aim_reticule")
	
	att.reticle = "cw2/reticles/aim_reticule"
	local td = {}
	
	function att:elementRender()
		local model = self.AttachmentModelsVM.md_pist_insight_x2.ent
		local pos = model:GetPos()
		local ang = self:getLaserAngles(model)
		local angs = nil
		
		if not self.freeAimOn then
			if self.dt.State == CW_AIMING then
				angs = self.LaserAngAdjustAim
			end
		end
		
		angs = angs or self.LaserAngAdjust
		
		-- rotate and prepare the position
		ang:RotateAroundAxis(ang:Right(), angs.p)
		ang:RotateAroundAxis(ang:Up(), angs.y)
		ang:RotateAroundAxis(ang:Forward(), angs.r)
		
		local dir = ang * 1
		
		if not self.freeAimOn then
			if self.dt.State == CW_AIMING then
				dir.p = self.Owner:EyeAngles().p
			end
		end
		
		local fw = dir:Forward()
		local laserPos = pos + ang:Right() * self.LaserPosAdjust.x + ang:Forward() * self.LaserPosAdjust.y + ang:Up() * self.LaserPosAdjust.z
		
		td.start = laserPos
		td.endpos = td.start + fw * att.laserRange
		td.filter = self.Owner
		
		local tr = util.TraceLine(td)
		
		if not self.lastLaserPos then
			self.lastLaserPos = tr.HitPos
		end
		
		local dist = math.Clamp(att.laserRange * tr.Fraction, 0, att.laserBeamRange)
		
		if util.PointContents(tr.HitPos) != CONTENTS_SOLID and not self.NearWall then
			local renderColor = self:getSightColor(att.name)
			local laserHQ = GetConVarNumber("cw_laser_quality") > 1
			
			-- draw the beam
			renderColor.a = 100
			render.SetMaterial(beam)
			
			render.DrawBeam(laserPos + fw, laserPos + fw * dist, 0.1, 0, 0.99, renderColor)
			
			if laserHQ then
				renderColor.a = 50
				render.DrawBeam(laserPos + fw, laserPos + fw * dist, 0.6, 0, 0.99, renderColor)
				
				renderColor.a = 25
				render.DrawBeam(laserPos + fw, laserPos + fw * dist, 1, 0, 0.99, renderColor)
			end
			
			-- draw the dot if the model is not out of world bounds
			renderColor.a = 255
			
			render.SetMaterial(laserDot)
			
			if GetConVarNumber("cw_laser_blur") >= 1 then
				render.DrawBeam(self.lastLaserPos, tr.HitPos, 1.5, 0, 0.99, renderColor)
				
				local dist = math.Clamp(self.lastLaserPos:Distance(tr.HitPos), 0, 2)

				dist = 1 - (dist / 2)
				
				if dist < 2 then
					renderColor.a = 255 * dist
					render.DrawSprite(tr.HitPos, 1.5, 1.5, renderColor)
					
					if laserHQ then
						renderColor.a = 33 * dist
						render.DrawSprite(tr.HitPos, 3, 3, renderColor)
					end
				end
			else
				render.DrawSprite(tr.HitPos, 1.5, 1.5, renderColor)
				
				if laserHQ then
					renderColor.a = 33
					render.DrawSprite(tr.HitPos, 3, 3, renderColor)
				end
			end
			
			self.lastLaserPos = tr.HitPos
		end
	end
	
function att:attachFunc()
self:setBodygroup(self.ExtrasBGs.main, self.ExtrasBGs.front_mag)
end

function att:detachFunc()
self:setBodygroup(self.ExtrasBGs.main, self.ExtrasBGs.regular)
self:restoreSound()
end

end

CustomizableWeaponry:registerAttachment(att)


local att = {}
att.name = "md_special_suppressor"
att.displayName = "Silencerco Osprey"
att.displayNameShort = "Osprey"
att.isSuppressor = true

att.statModifiers = {
RecoilMult = -0.2,
AimSpreadMult = -0.1,
OverallMouseSensMult = -0.05,
DamageMult = -0.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/osprey")
	att.description = {[1] = {t = "looks cool and obstructs less the sight", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.dt.Suppressed = true
end

function att:detachFunc()
	self:resetSuppressorStatus()
end

CustomizableWeaponry:registerAttachment(att)

local att = {}
att.name = "bg_pist_revolver_long_barrel"
att.displayName = "Long Barrel"
att.displayNameShort = "Long"
att.isBG = true
att.SpeedDec = 5

att.statModifiers = {
DamageMult = 0.05,
AimSpreadMult = -0.15,
HipSpreadMult = -0.15,
-- MaxSpreadIncMult = -0.1,
RecoilMult = 0.15,
OverallMouseSensMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/colt_long")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.long)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
	self:restoreSound()
end

CustomizableWeaponry:registerAttachment(att)

local att = {}
att.name = "bg_pist_revolver_short_barrel"
att.displayName = "Short Barrel"
att.displayNameShort = "Short"
att.isBG = true
att.SpeedDec = -5

att.statModifiers = {
DamageMult = -0.05,
AimSpreadMult = 0.15,
HipSpreadMult = 0.15,
-- MaxSpreadIncMult = -0.1,
RecoilMult = -0.15,
FireDelayMult = -0.15,
OverallMouseSensMult = 0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/colt_short")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.short)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
	self:restoreSound()
end

CustomizableWeaponry:registerAttachment(att)

--[[
local att = {}
att.name = "bg_pist_revolver_sw628_long_barrel"
att.displayName = "Long Barrel"
att.displayNameShort = "Long"
att.isBG = true
att.SpeedDec = 1

att.statModifiers = {
DamageMult = 0.1,
AimSpreadMult = -0.15,
HipSpreadMult = -0.15,
-- MaxSpreadIncMult = -0.1,
RecoilMult = 0.1,
FireDelayMult = 0.1,
OverallMouseSensMult = -0.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/colt_long")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.long)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
	self:restoreSound()
end

CustomizableWeaponry:registerAttachment(att)
--]]

local att = {}
att.name = "bg_pist_long_barrel"
att.displayName = "Long Barrel"
att.displayNameShort = "Long"
att.isBG = true
att.SpeedDec = 1

att.statModifiers = {
DamageMult = 0.1,
AimSpreadMult = -0.15,
HipSpreadMult = -0.15,
-- MaxSpreadIncMult = -0.1,
RecoilMult = 0.1,
FireDelayMult = 0.05,
OverallMouseSensMult = -0.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/barrel_ext")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.long)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
	self:restoreSound()
end

CustomizableWeaponry:registerAttachment(att)

local att = {}
att.name = "bg_carbine_barrel"
att.displayName = "Carbine Barrel"
att.displayNameShort = "Carbine"
att.isBG = true
att.SpeedDec = 5

att.statModifiers = {
DamageMult = 0.3,
AimSpreadMult = -0.5,
HipSpreadMult = -0.3,
MaxSpreadIncMult = -0.1,
RecoilMult = 0.3,
FireDelayMult = 0.55,
OverallMouseSensMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/barrel_ext")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.long)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
	self:restoreSound()
end

CustomizableWeaponry:registerAttachment(att)

local att = {}
att.name = "bg_pist_stock"
att.displayName = "Pistol Stock"
att.displayNameShort = "Stock"
att.isBG = true

att.statModifiers = {
RecoilMult = -0.2,
AimSpreadMult = -0.15,
HipSpreadMult = -0.15,
MaxSpreadIncMult = -0.2,
DrawSpeedMult = -0.1,
VelocitySensitivityMult = 0.1,
OverallMouseSensMult = -0.15}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/pistol_stock")
end

function att:attachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.stock)
end

function att:detachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.nostock)
end

CustomizableWeaponry:registerAttachment(att)

local att = {}
att.name = "bg_codol_glock_36_mag2"
att.displayName = "GLock 36 Mag"
att.displayNameShort = "36 Mag"
att.isBG = true

att.statModifiers = {
ReloadSpeedMult = -0.1,
OverallMouseSensMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/glock_36_mag")
	att.description = {[1] = {t = "Increases mag size to 36 rounds.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.glockround36)
	self:unloadWeapon()
	self.Primary.ClipSize = 36
	self.Primary.ClipSize_Orig = 36
end

function att:detachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.regular)
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end

CustomizableWeaponry:registerAttachment(att)