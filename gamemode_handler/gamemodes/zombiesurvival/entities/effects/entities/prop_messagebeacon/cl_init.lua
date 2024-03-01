include("shared.lua")

function ENT:Initialize()
	self:SetModelScale(0.333, 0)
end

function ENT:SetMessageID(id)
	self:SetDTInt(0, id)
end

local w, h = 600, 420
local owner
local strLP = "("
local strRP = ")"
local strFont = "ZS3D2DFont2Small"
function ENT:Draw()
	self:DrawModel()

	if not MySelf:IsValid() then return end

	owner = self:GetObjectOwner()

	cam.Start3D2D(self:LocalToWorld(Vector(1, 0, self:OBBMaxs().z + 5)), self:GetAngles(), 0.05)
		if owner:IsValid() and owner:IsPlayer() then
			draw.SimpleText(strLP..owner:ClippedName()..strRP, strFont, 0, 0, owner == MySelf and COLOR_BLUE or COLOR_GRAY, TEXT_ALIGN_CENTER)
		end

	cam.End3D2D()
end
