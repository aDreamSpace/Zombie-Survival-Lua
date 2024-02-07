include("shared.lua")

ENT.ColorModulation = Color(0.25, 1, 0.25)

ENT.displayDistance =  262144
local baseFont = "CW_HUD72"
local ammoText = "CW_HUD60"

ENT.upOffset = Vector(0, 0, 25)

local strAmmo = "Ammo"
local white = Color(255, 255, 255, 255)
local black = Color(0, 0, 0, 255)
ENT.setup = false

local vPos
local aEyeAng
local vB
local r, g, b, a
function ENT:DrawTranslucent()
	if not self.setup then
        self.AmmoType = self:GetAmmoName() or "Unknown"
        surface.SetFont(baseFont)
		self.x, self.y = surface.GetTextSize(self.AmmoType)
		self.baseHorSize, self.vertFontSize = self.x, 50
		self.baseHorSize = self.baseHorSize < 180 and 180 or self.baseHorSize
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

			--now using dotproducts since it is faster
			vB = (vPos - EyePos())
			vB:Normalize()
			if EyeVector():Dot(vB) > 0.85 then
				aEyeAng = EyeAngles()
				aEyeAng.p = 0
				aEyeAng.y = aEyeAng.y - 90
				aEyeAng.r = 90
				
				cam.Start3D2D(vPos + self.upOffset, aEyeAng, 0.05)
					r, g, b, a = 100, 200, 100, 220
					surface.SetDrawColor(r, g, b, a)
					surface.DrawRect(-self.halfBaseHorSize, 0, self.baseHorSize, self.vertFontSize * 2)
					
					surface.SetDrawColor(0, 0, 0, 150)
					surface.DrawRect(-self.halfBaseHorSize, self.vertFontSize, self.baseHorSize, self.vertFontSize * 3)

					draw.ShadowText(strAmmo, baseFont, 0, self.halfVertFontSize * 2, white, black, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					draw.ShadowText(self.AmmoType, ammoText, 0, self.vertFontSize + self.halfVertFontSize * 3, white, black, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					draw.ShadowText(self:GetAmmoAmount(), ammoText, 0, self.vertFontSize + self.halfVertFontSize * 5, white, black, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				cam.End3D2D()
			end
		end
	end
end