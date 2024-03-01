include("shared.lua")

ENT.ColorModulation = Color(0.15, 0.8, 1)
ENT.displayDistance =  262144
local baseFont = "CW_HUD72"
local ammoText = "CW_HUD60"

function ENT:Think()
	local class = self:GetAttachmentType()
	if class ~= self.LastWeaponType then
		self.LastWeaponType = class
	end
end

ENT.upOffset = Vector(0, 0, 25)

local strWep = "Attachment"
local white = Color(255, 255, 255, 255)
local black = Color(0, 0, 0, 255)
ENT.setup = false

local vPos
local aEyeAng
local vB
local r, g, b, a
local ammonum
function ENT:DrawTranslucent()
	if not self.setup then
		self.WepType = CustomizableWeaponry.registeredAttachmentsSKey[self:GetAttachmentType()].displayName
		surface.SetFont(baseFont)
		self.x, self.y = surface.GetTextSize(self.WepType)
		self.baseHorSize, self.vertFontSize = self.x, 50
		self.baseHorSize = self.baseHorSize < 220 and 220 or self.baseHorSize
		self.baseHorSize = self.baseHorSize + 20
		self.halfBaseHorSize = self.baseHorSize * 0.5
		self.halfVertFontSize = self.vertFontSize * 0.5
		
		self.setup = true
		
		self.halfw = ScrW() / 2
		self.halfh = ScrH() / 2
		self.fracw = ScrW() / 6
	end
	self:DrawModel()
	if MySelf:Team() == TEAM_HUMAN then
		vPos = self:GetPos()
		if MySelf:GetPos():DistToSqr(vPos) < self.displayDistance then
			vB = (vPos - EyePos())
			vB:Normalize()
			if EyeVector():Dot(vB) > 0.85 then
				aEyeAng = EyeAngles()
				aEyeAng.p = 0
				aEyeAng.y = aEyeAng.y - 90
				aEyeAng.r = 90
				
				cam.Start3D2D(vPos + self.upOffset, aEyeAng, 0.05)
					r, g, b, a = 100, 100, 200, 220
					surface.SetDrawColor(r, g, b, a)
					surface.DrawRect(-self.halfBaseHorSize, 0, self.baseHorSize, self.vertFontSize * 2)
					
					surface.SetDrawColor(0, 0, 0, 150)
					surface.DrawRect(-self.halfBaseHorSize, self.vertFontSize, self.baseHorSize, self.vertFontSize * 3)
					draw.ShadowText(strWep, baseFont, 0, self.halfVertFontSize * 2, white, black, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					draw.ShadowText(self.WepType, ammoText, 0, self.vertFontSize + self.halfVertFontSize * 3, white, black, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				cam.End3D2D()
			end
		end
	end
end
