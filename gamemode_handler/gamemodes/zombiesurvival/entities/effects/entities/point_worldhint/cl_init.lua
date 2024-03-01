include("shared.lua")

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
end

function ENT:Draw()
end

local pos
local eyepos
local range
local dist
function ENT:DrawHint()
	if self:GetViewable() == 0 or self:GetViewable() == MySelf:Team() then
		pos = self:GetPos()
		eyepos = EyePos()
		range = self:GetRange()

		if range <= 0 then
			DrawWorldHint(self:GetHint(), pos)
		else
			dist = pos:Distance(eyepos)
			if dist <= range then
				DrawWorldHint(self:GetHint(), pos)
			end
		end
	end
end
