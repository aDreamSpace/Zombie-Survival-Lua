local att = {}
att.name = "bg_cr_barrel_long"
att.displayName = "Long Barrel"
att.displayNameShort = "Long"
att.isBG = true

att.statModifiers = {DamageMult = 0.10,
AimSpreadMult = -0.1,
RecoilMult = -0.1,
OverallMouseSensMult = -0.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ar15longbarrel")
	att.description = {[1] = {t = "Extends length of barrel.", c = CustomizableWeaponry.textColors.POSITIVE}}
end


function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.long)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
end

att.price = 35
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)


local att = {}
att.name = "bg_cr_barrel_short"
att.displayName = "Short Barrel"
att.displayNameShort = "Short"
att.isBG = true
att.SpeedDec = -5

att.statModifiers = {
AimSpreadMult = 0.1,
RecoilMult = 0.1,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ar15longbarrel")
	att.description = {[1] = {t = "Reduces length of barrel.", c = CustomizableWeaponry.textColors.POSITIVE}}
end


function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.short)
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
end

att.price = 25
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)

--
-- Sights
--

local att = {}
att.name = "bg_cr_scope"
att.displayName = "Scope"
att.displayNameShort = "Scope"
att.isBG = true
att.isSight = true
att.aimPos = {"CRScopePos", "CRScopeAng"}

att.withoutRail = true

att.statModifiers = {OverallMouseSensMult = -0.2}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/sg1scope")
	att.description = {[1] = {t = "Provides 2x magnification.", c = CustomizableWeaponry.textColors.POSITIVE},
	[2] = {t = "Narrow scope greatly decreases awareness.", c = CustomizableWeaponry.textColors.NEGATIVE},
	[3] = {t = "Is disorienting at close range.", c = CustomizableWeaponry.textColors.NEGATIVE}}
	
	local old, x, y, ang
	local reticle = surface.GetTextureID("cw2/reticles/scope_leo")
	
	att.zoomTextures = {[1] = {tex = reticle, offset = {0, 1}}}
	
	local lens = surface.GetTextureID("cw2/gui/lense")
	local lensMat = Material("cw2/gui/lense")
	local cd, alpha = {}, 0.5
	local Ini = true
	
	-- render target var setup
	cd.x = 0
	cd.y = 0
	cd.w = 512
	cd.h = 512
	cd.fov = 10
	cd.drawviewmodel = false
	cd.drawhud = false
	cd.dopostprocess = false
	
	function att:drawRenderTarget()
		local complexTelescopics = self:canUseComplexTelescopics()
		
		-- if we don't have complex telescopics enabled, don't do anything complex, and just set the texture of the lens to a fallback 'lens' texture
		if not complexTelescopics then
			self.TSGlass:SetTexture("$basetexture", lensMat:GetTexture("$basetexture"))
			return
		end
		
		if self:canSeeThroughTelescopics(att.aimPos[1]) then
			alpha = math.Approach(alpha, 0, FrameTime() * 5)
		else
			alpha = math.Approach(alpha, 1, FrameTime() * 5)
		end
		
		x, y = ScrW(), ScrH()
		old = render.GetRenderTarget()
	
		ang = self:getTelescopeAngles()
		
		if not self.freeAimOn then
			ang.r = self.BlendAng.z
			ang:RotateAroundAxis(ang:Right(), self.ACOGAxisAlign.right)
			ang:RotateAroundAxis(ang:Up(), self.ACOGAxisAlign.up)
			ang:RotateAroundAxis(ang:Forward(), self.ACOGAxisAlign.forward)
		end
		
		cd.angles = ang
		cd.origin = self.Owner:GetShootPos()
		render.SetRenderTarget(self.ScopeRT)
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
				surface.SetTexture(reticle)
				surface.DrawTexturedRect(0, 0, 512, 512)
				surface.SetDrawColor(150 * light[1], 150 * light[2], 150 * light[3], 255 * alpha)
				surface.SetTexture(lens)
				surface.DrawTexturedRectRotated(256, 256, 512, 512, 90)
			cam.End2D()
		render.SetViewPort(0, 0, x, y)
		render.SetRenderTarget(old)
		
		if self.TSGlass then
			self.TSGlass:SetTexture("$basetexture", self.ScopeRT)
		end
	end
end

function att:attachFunc()
	self.OverrideAimMouseSens = 0.15
	self.SimpleTelescopicsFOV = 80
	self.BlurOnAim = true
	self.ZoomTextures = att.zoomTextures
	
	self:setBodygroup(self.SightBGs.main, self.SightBGs.scope)
end

function att:detachFunc()
	self.OverrideAimMouseSens = nil
	self.SimpleTelescopicsFOV = nil
	self.BlurOnAim = false
	self:setBodygroup(self.SightBGs.main, self.SightBGs.none)
end
att.price = 10
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)

local att = {}
att.name = "bg_cr_sight"
att.displayName = "Sight"
att.displayNameShort = "Sight"
att.isBG = true
att.isSight = true
att.aimPos = {"CRSightPos", "CRSightAng"}
att.withoutRail = true

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ak74_rpkbarrel")
	att.description = {[1] = {t = "Adds a rear sight.", c = CustomizableWeaponry.textColors.POSITIVE}}
end


function att:attachFunc()
	self:setBodygroup(self.SightBGs.main, self.SightBGs.sight)
end

function att:detachFunc()
	self:setBodygroup(self.SightBGs.main, self.SightBGs.none)
end

att.price = 15
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)

--
--Stocks
--

local att = {}
att.name = "bg_cr_stock_short"
att.displayName = "Short Stock"
att.displayNameShort = "Short"
att.isBG = true
att.SpeedDec = -10

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ak74heavystock")
	att.description = {[1] = {t = "Shortens rear stock.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.short)
end

function att:detachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.regular)
end

att.price = 10
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)


local att = {}
att.name = "bg_cr_saddle"
att.displayName = "Ammo Saddle"
att.displayNameShort = "Saddle"
att.isBG = true
att.SpeedDec = 5

att.statModifiers = {ReloadSpeedMult = 0.2,}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ak74heavystock")
	att.description = {[1] = {t = "Adds an easy to reach ammo saddle.", c = CustomizableWeaponry.textColors.POSITIVE}}
end


function att:attachFunc()
	self:setBodygroup(self.SaddleBGs.main, self.SaddleBGs.saddle)
end

function att:detachFunc()
	self:setBodygroup(self.SaddleBGs.main, self.SaddleBGs.none)
end

att.price = 15
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)


--
--Ammo Tube
--

local att = {}
att.name = "bg_cr_tube_long"
att.displayName = "Long Tube"
att.displayNameShort = "Long"
att.isBG = true

att.statModifiers = {
	MagMult = 2
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ar15longbarrel")
	att.description = {[1] = {t = "Further lengthens ammo tube.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.long)
	self:unloadWeapon()
end

function att:detachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.regular)
end

att.price = 20
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)


local att = {}
att.name = "bg_cr_tube_med"
att.displayName = "Medium Tube"
att.displayNameShort = "Medium"
att.isBG = true

att.statModifiers = {MagMult = 1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ar15longbarrel")
	att.description = {[1] = {t = "Lengthens ammo tube.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.med)
	self:unloadWeapon()
end

function att:detachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.regular)
end

att.price = 12
att.model = "models/items/battery.mdl"
CustomizableWeaponry:registerAttachment(att)


