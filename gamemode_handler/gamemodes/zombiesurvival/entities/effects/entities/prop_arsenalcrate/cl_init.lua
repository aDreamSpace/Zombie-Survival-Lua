include("shared.lua")
local RefreshTime = 0.1

function ENT:Initialize()
	self:SetRenderBounds(Vector(-72, -72, -72), Vector(72, 72, 128))
end

function ENT:SetObjectHealth(health)
	self:SetDTFloat(0, health)
end

function ENT:Think()
	self.XPFraction = self:GetXPFraction()
	self.Level = self:GetLevel()
	
	self:SetNextClientThink(CurTime() + RefreshTime)

	return true
end

local colFlash = Color(30, 255, 30)
local t
local owner
local w, h = 600, 420
local maxz
local vLocal = Vector(1, 0, 0)

local strName = translate.Get("arsenal_crate")
local strFont = "ZS3D2DFont2"
local strBuyText = translate.Get("purchase_now")
local strFontSmall = "ZS3D2DFont2Small"
local strLP = "("
local strRP = ")"
function ENT:Draw()
	self:DrawModel()
	if MySelf:IsValid() then
		owner = self:GetObjectOwner()
		maxz = maxz or self:OBBMaxs().z
		vLocal.z = maxz

		cam.Start3D2D(self:LocalToWorld(vLocal), self:GetAngles(), 0.05)
			draw.SimpleText(strName, strFont, 0, 0, COLOR_GRAY, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			if MySelf:Team() == TEAM_HUMAN and GAMEMODE:PlayerCanPurchase(MySelf) then
				colFlash.a = math.abs(math.sin(CurTime() * 5)) * 255
				draw.SimpleText(strBuyText, strFontSmall, 0, -64, colFlash, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end

			if owner:IsValid() and owner:IsPlayer() then
				draw.SimpleText(strLP..owner:ClippedName()..strRP, strFontSmall, 0, 64, owner == MySelf and COLOR_BLUE or COLOR_GRAY, TEXT_ALIGN_CENTER)
			end
		cam.End3D2D()
	end
end
