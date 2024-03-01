include("shared.lua")

ENT.Dinged = true

function ENT:Initialize()
	self:SetRenderBounds(Vector(-72, -72, -72), Vector(72, 72, 128))
end

function ENT:SetObjectHealth(health)
	self:SetDTFloat(0, health)
end

local NextUse = 0
local vOffset = Vector(14, 0, 12)
local vOffset2 = Vector(-14, 0, 12)
local aOffset = Angle(0, 90, 60)
local aOffset2 = Angle(0, 270, 60)
local vOffsetEE = Vector(-7, -1, 8)
local ammotype
local fAmmotype

function ENT:Think()
	local wep = MySelf:GetActiveWeapon()
	if not wep:IsValid() then
		ammotype = "smg1"
	end

	if not ammotype then
		ammotype = wep:GetPrimaryAmmoTypeString()
		if not GAMEMODE.AmmoResupply[ammotype] then
			ammotype = "smg1"
		end
	end
	
	fAmmotype = GAMEMODE.AmmoNames[ammotype] or "SMG"
	ammotype = nil
	if MySelf:IsValid() and MySelf:Team() == TEAM_HUMAN then
		if self.Dinged then
			if CurTime() < NextUse then
				self.Dinged = false
			end
		elseif CurTime() >= NextUse then
			self.Dinged = true

			self:EmitSound("zombiesurvival/ding.ogg")
		end
	end

	self:NextThink(CurTime() + 0.5)

	if not self.Dinged then
		self:SetBodygroup(1, 1)
	else
		self:SetBodygroup(1, 0)
	end
	return true
end

local strName = translate.Get("resupply_box")
local strFont = "ZS3D2DFont2"
local strFontSmall = "ZS3D2DFont2Small"
local strNextResupply = "Next Resupply in: "
local strReady = "- Ready! -"
local strFormat = "%.0s%02.2i:%02.2i"
local timeformat
local strLP = "("
local strRP = ")"
function ENT:RenderInfo(pos, ang, owner)
	cam.Start3D2D(pos, ang, 0.075)
		draw.SimpleText(strName, strFont, 0, -20, NextUse <= CurTime() and COLOR_GREEN or COLOR_DARKRED, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	
		if (NextUse > CurTime()) then
			timeformat = string.FormattedTime(NextUse - CurTime(), strFormat):Left(5)
			draw.SimpleText(strNextResupply..timeformat, strFont, 0, -100, COLOR_DARKRED, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw.SimpleText(strReady, strFont, 0, -100, COLOR_GREEN, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		--local uses = MySelf.m_Caches or 0
		--draw.SimpleText(string.format("Uses left: %s", uses), strFont, 0, -50, uses > 0 and COLOR_GREEN or COLOR_DARKRED, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		
		if owner:IsValid() and owner:IsPlayer() then
			draw.SimpleText(strLP..owner:ClippedName()..strRP, strFontSmall, 0, 10, owner == MySelf and COLOR_BLUE or COLOR_GRAY, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		end
		
		draw.SimpleText(fAmmotype, strFontSmall, 0, 65, COLOR_GRAY, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	cam.End3D2D()
end

local owner
local ang
local strFaget = " is a faget"
local strFont = "ZS3D2DFont2"
local strNoOneFaget = "no one is a faget"

function ENT:Draw()
	self:DrawModel()

	if not MySelf:IsValid() then return end

	owner = self:GetObjectOwner()
	ang = self:LocalToWorldAngles(aOffset)

	self:RenderInfo(self:LocalToWorld(vOffset), ang, owner)
	self:RenderInfo(self:LocalToWorld(vOffset2), self:LocalToWorldAngles(aOffset2), owner)

	cam.Start3D2D(self:LocalToWorld(vOffsetEE), ang, 0.01)
		if owner:IsValid() then
			draw.SimpleText(owner:Nick()..strFaget, strFont, 0, 0, color_white, TEXT_ALIGN_CENTER)
		else
			draw.SimpleText(strNoOneFaget, strFont, 0, 0, color_white, TEXT_ALIGN_CENTER)
		end

	cam.End3D2D()
end

net.Receive("zs_nextresupplyuse", function(length)
	NextUse = net.ReadFloat()
end)

--[[
net.Receive("zs_nextresupplyuse", function(ln)
	local b = net.ReadBool()
	MySelf.m_Caches = net.ReadUInt(8)

	if b then
		NextUse = net.ReadFloat()
	end
end)
--]]