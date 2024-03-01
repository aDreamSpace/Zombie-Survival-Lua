include("shared.lua")

function ENT:Initialize()
	local size = self:GetScanRange() + 32
	local nsize = -size
	self:SetRenderBounds(Vector(nsize, nsize, nsize * 0.25), Vector(size, size, size * 0.25))
end

function ENT:SetObjectHealth(health)
	self:SetDTFloat(0, health)
end

ENT.Pitch = 0
ENT.Yaw = 0
function ENT:UpdatePose(p, y)
	if p and y then
		y = y * -1
		p = p * -1
		self.Pitch = Lerp(0.025, self.Pitch, p)
		self.Yaw = Lerp(0.025, self.Yaw, y)
	end

	self:SetPoseParameter("aim_yaw", self.Yaw)
	self:SetPoseParameter("aim_pitch", self.Pitch)
	self:InvalidateBoneCache()
end

ENT.ReturnDelay = 0
ENT.LaserAttach = {}
function ENT:Think()
	local target = self:GetTarget()
	local p = nil
	local y = nil
	if target and target:IsValid() then
		local vTPos = target:WorldSpaceCenter()
		local pos2 = self.LaserAttach.Pos or self:GetPos()
		--update the pose parameters
		--first we need the angle
		local vec = vTPos - pos2
		--vec:Normalize()
		local ang = vec:Angle()
		local ang = self:WorldToLocalAngles(ang)
		p = ang.p
		y = ang.y
		self.ReturnDelay = CurTime() + 2
		
	end
	if self.ReturnDelay < CurTime() then
		p = 0
		y = 0
	end
	self:UpdatePose(p, y)
end

--reference: https://github.com/alliedmodders/hl2sdk/blob/sdk2013/game/server/hl2/npc_turret_ground.cpp#L594
local matBeam = Material("effects/blueblacklargebeam")
local matGlow = Material("sprites/glow04_noz")
--local matBeam = Material("effects/bluelaser2")
local TEXT_ALIGN_CENTER = TEXT_ALIGN_CENTER
local draw_SimpleText = draw.SimpleText
local surface_SetDrawColor = surface.SetDrawColor
local surface_DrawRect = surface.DrawRect
local cam_Start3D2D = cam.Start3D2D
local cam_End3D2D = cam.End3D2D
local smokegravity = Vector(0, 0, 200)
local aScreen = Angle(0, 270, 60)
local vScreen = Vector(0, -2, 45)

function ENT:Draw()
	self:DrawModel()

	if not self:GetDeployed() then return end

	if not self.AttachmentsSetup then
		self:SetupAttachments()
	end

	--gonna assume we have a 3D rendering context here
	local owner = self:GetObjectOwner()
	local target = self:GetTarget()

	if self:GetAmmoAmount() > 0 and owner and owner:IsValid() then
		local range = self:GetScanRange()
		local cone = self:GetScanAngle()
		local hcone = cone / 2
		local fwd = self:GetAngles():Forward()
		--print(self:LookupAttachment("attach_muzzle"))
		local pos = self.LampAttach.Pos--fwd * 8 + self:GetPos() + Vector(0, 0, 1)
		if not (target and target:IsValid()) then
			local col = col or color_white
			render.SetMaterial(matBeam)
			--draw the two border beams first
			local ang = self:GetAngles()
			ang.y = ang.y + hcone
			local fwd = ang:Forward()
			render.DrawBeam(pos, pos + fwd * range, 8, 0, 1, col)

			local ang = self:GetAngles()
			ang.y = ang.y - hcone
			local fwd = ang:Forward()
			render.DrawBeam(pos, pos + fwd * range, 8, 0, 1, col)

			--draw the scan
			local ang = self:GetAngles()
			for i = 1, 5 do
				local angS = Angle(ang.p, ang.y + hcone * math.sin(CurTime() * 2 - i / 20), ang.r)
				local vangS = angS:Forward()
				render.DrawBeam(pos, pos + vangS * range, 2, 0, 1, col)
			end

			render.SetMaterial(matGlow)
			render.DrawSprite(pos, 16, 16, col)
		else
			local col = col or color_white
			render.SetMaterial(matBeam)
			--draw the two border beams first
			local ang = self:GetAngles()
			ang.y = ang.y + hcone
			local fwd = ang:Forward()
			render.DrawBeam(pos, pos + fwd * range, 8, 0, 1, col)

			local ang = self:GetAngles()
			ang.y = ang.y - hcone
			local fwd = ang:Forward()
			render.DrawBeam(pos, pos + fwd * range, 8, 0, 1, col)

			local pos2 = self:GetAttachment(self:LookupAttachment("attach_laser")).Pos
			--we have a target so we should draw a beam toward it
			local col2 = COLOR_RED
			local vTPos = target:WorldSpaceCenter()
			render.DrawBeam(pos2, vTPos, 3, 0, 1, col2)

			render.SetMaterial(matGlow)
			render.DrawSprite(pos2, 128, 16, col2)
		end
	end

	--screen
	local owner = self:GetObjectOwner()
	local ammo = self:GetAmmoAmount()
	local flash = math.sin(CurTime() * 15) > 0
	local wid, hei = 256, 256
	local x = wid / 2

	local Scr = self.ScreenAttach.Ang
	--local Scr = Angle(aAng.p, aAng.y - 180, aAng.r + 45)

	cam_Start3D2D(self.ScreenAttach.Pos, Scr, 0.075)

		surface_SetDrawColor(0, 0, 0, 160)
		surface_DrawRect(-128, -128, wid, hei)

		--:/
		surface_SetDrawColor(200, 200, 200, 200)
		surface_DrawRect(-128, -128, 10, hei)
		surface_DrawRect(118, -118, 10, hei-20)
		surface_DrawRect(-118, -128, wid - 10, 10)
		surface_DrawRect(-118, 118, wid - 10, 10)

		if owner:IsValid() and owner:IsPlayer() then
			draw_SimpleText(owner:ClippedName(), "ZSHUDFontSmall", 0, 25, owner == MySelf and COLOR_BLUE or COLOR_WHITE, TEXT_ALIGN_CENTER)
		end
		draw_SimpleText("Health: "..(math.floor(self:GetObjectHealth() / self:GetMaxObjectHealth()) * 100).."%", "ZSHUDFontSmall", 0, 0, COLOR_WHITE, TEXT_ALIGN_CENTER)
		
		if ammo > 0 then
			draw_SimpleText("Ammo: "..ammo.."/"..self:GetMaxAmmoAmount(), "ZSHUDFontSmall", 0, 50, COLOR_WHITE, TEXT_ALIGN_CENTER)
		elseif flash then
			draw_SimpleText("EMPTY", "ZSHUDFontSmall", 0, 50, COLOR_RED, TEXT_ALIGN_CENTER)
		end

		draw_SimpleText("Ammotype: "..GAMEMODE.AmmoNames[self:GetAmmoType()] or "Unknown", "ZSHUDFontSmall", 0, 75, COLOR_WHITE, TEXT_ALIGN_CENTER)
	cam_End3D2D()
end
