include("shared.lua")

ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:Draw()
	self:DrawModel()
end

local matGlow = Material("sprites/glow04_noz")
local matBeam = Material("effects/bluelaser2")
local colBlue = Color(100, 100, 255)
local lightpos
local size
local range = 768
local cone = 120
local hcone = cone / 2

local vOffset = Vector(4, 0, 4)
local vOffsetBeam = Vector(4, 0, 1)
function ENT:DrawTranslucent()
	lightpos = self:LocalToWorld(vOffset)

	if self:GetOwner():IsValid() then
		render.SetMaterial(matGlow)
		render.DrawSprite(lightpos, 16, 16, COLOR_GREEN)
		render.DrawSprite(lightpos, 4, 4, COLOR_DARKGREEN)

		local fwd = self:GetForward()
		local pos = self:LocalToWorld(vOffsetBeam)
		local col = COLOR_RED
		render.SetMaterial(matBeam)
		
		--draw the two border beams first
		local ang = self:GetAngles()
		ang.y = ang.y + hcone
		local fwd = ang:Forward()
		render.DrawBeam(pos, pos + fwd * range, 8, 0, 1, COLOR_RED)

		local ang = self:GetAngles()
		ang.y = ang.y - hcone
		local fwd = ang:Forward()
		render.DrawBeam(pos, pos + fwd * range, 8, 0, 1, COLOR_RED)
	else
		render.SetMaterial(matGlow)
		render.DrawSprite(lightpos, 16, 16, colBlue)
		render.DrawSprite(lightpos, 4, 4, COLOR_WHITE)
	end
end
