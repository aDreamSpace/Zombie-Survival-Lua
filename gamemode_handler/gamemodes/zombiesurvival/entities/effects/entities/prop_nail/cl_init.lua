include("shared.lua")

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:OnRemove()
	local normal = self:GetForward() * -1
	local pos = self:GetPos() + normal

	sound.Play("physics/metal/metal_box_impact_bullet"..math.random(1, 3)..".wav", pos, 75, math.random(90, 110))

	local grav = Vector(0, 0, -300)

	local emitter = ParticleEmitter(pos)
	emitter:SetNearClip(22, 32)
	for i=1, math.random(32, 48) do
		local vNormal = (VectorRand() * 0.6 + normal):GetNormalized()
		local particle = emitter:Add("effects/spark", pos + vNormal)
		particle:SetVelocity(vNormal * math.Rand(16, 100))
		particle:SetDieTime(math.Rand(0.5, 1))
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(255)
		particle:SetStartSize(math.Rand(0.4, 1.5))
		particle:SetEndSize(0)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-8, 8))
		particle:SetCollide(true)
		particle:SetBounce(0.8)
		particle:SetGravity(grav)
	end
	emitter:Finish()
end

local matOutlineWhite = Material("white_outline")
local ScaleOutline = 1.4
local colNail = Color(0, 0, 5, 220)

local drawowner
local displayowner
local redname
local vB
local vPos
local visibleDist = 200^2
local vEPos
local health
local displayowner
local redname
local deployer
local strDead = "(DEAD) "
local strEmpty = ""
local ang
local wid, hei = 180, 5
local x, y
local repairs
local ru
local mu
local green
local strFontSmaller = "ZS3D2DFont2Smaller"
local strSlash = " / "
local colNailOwner = Color(0, 177, 255)
function ENT:DrawTranslucent()
	vPos = self:GetPos()
	vEPos = EyePos()
	vB = (vPos - EyePos())
	vB:Normalize()
	drawowner = MySelf:IsValid() and MySelf:Team() == TEAM_HUMAN and (GAMEMODE.AlwaysShowNails or MySelf:KeyDown(IN_SPEED) or EyeVector():Dot(vB) > 0.99 and vEPos:DistToSqr(vPos) < visibleDist) --MySelf:TraceLine(256, MASK_SHOT).HitPos:Distance(self:GetPos()) <= 16)

	self:SetModelScale(ScaleOutline)

	if drawowner then
		health = self:GetNailHealth() / self:GetMaxNailHealth()
		render.SetColorModulation(1 - health, health, 0)
		self:DrawModel()
	end

	self:DrawModel()

	if drawowner then
		displayowner = self:GetDTString(0)
		redname = false
		if displayowner == strEmpty then
			displayowner = nil

			deployer = self:GetOwner()
			if deployer:IsValid() then
				displayowner = deployer:Name()
				if deployer:Team() ~= TEAM_HUMAN or not deployer:Alive() then
					displayowner = strDead..displayowner
					redname = true
				end
			end
		end

		ang = EyeAngles()
		ang:RotateAroundAxis(ang:Up(), -90)
		ang:RotateAroundAxis(ang:Forward(), 90)

		cam.Start3D2D(vPos, ang, 0.05)
			x, y = wid * -0.5 + 2, 0

			if self:GetMaxRepairs() > 0 then
				repairs = self:GetRepairs()
				ru = 1 - math.Clamp(repairs / self:GetMaxRepairs(), 0, 1)
				surface.SetDrawColor(0, 0, 0, 220)
				surface.DrawRect(x, y, wid, hei)
				surface.SetDrawColor(40, 40, 40, 220)
				surface.DrawOutlinedRect(x, y, wid, hei)
				surface.SetDrawColor(230, 5, 5, ru == 1 and (150 + math.abs(math.sin(RealTime() * 5)) * 105) or 220)
				surface.DrawRect(x + 1, y + 1, (wid - 2) * ru, hei - 2)

				draw.SimpleText(math.ceil(repairs), strFontSmaller, x + wid, y - 1, repairs <= 0 and COLOR_DARKRED or COLOR_GRAY, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
			end

			if self:GetMaxNailHealth() > 0 then
				mu = math.Clamp(self:GetNailHealth() / self:GetMaxNailHealth(), 0, 1)
				green = mu * 200
				colNail.r = 200 - green
				colNail.g = green

				y = y + hei + 3
				hei = 8
				x = wid * -0.5 + 2
				surface.SetDrawColor(0, 0, 0, 220)
				surface.DrawRect(x, y, wid, hei)
				surface.SetDrawColor(40, 40, 40, 220)
				surface.DrawOutlinedRect(x, y, wid, hei)
				surface.SetDrawColor(colNail)
				surface.DrawRect(x + 1, y + 1, (wid - 2) * mu, hei - 2)

				draw.SimpleText(math.ceil(self:GetNailHealth())..strSlash..math.ceil(self:GetMaxNailHealth()), strFontSmaller, x + wid / 2, y + hei + 1, colNail, TEXT_ALIGN_CENTER)
			end

			if displayowner then
				draw.SimpleText(displayowner, strFontSmaller, 0, y + 38, redname and COLOR_DARKRED or colNailOwner, TEXT_ALIGN_CENTER)
			end
		cam.End3D2D()
	end
end
