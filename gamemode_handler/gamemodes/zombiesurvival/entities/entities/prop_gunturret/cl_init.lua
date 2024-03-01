include("shared.lua")

ENT.NextEmit = 0

ENT.ScanSound = "npc/turret_wall/turret_loop1.wav"
ENT.ShootSound = "npc/combine_gunship/gunship_weapon_fire_loop6.wav"

function ENT:Initialize()
	self.BeamColor = Color(0, 255, 0, 255)

	self.ScanningSound = CreateSound(self, self.ScanSound)
	self.ShootingSound = CreateSound(self, self.ShootSound)

	local size = self.SearchDistance + 32
	local nsize = -size
	self:SetRenderBounds(Vector(nsize, nsize, nsize * 0.25), Vector(size, size, size * 0.25))
end

function ENT:Think()
	if self:GetObjectOwner():IsValid() and self:GetAmmo() > 0 and self:GetMaterial() == "" then
		self.ScanningSound:PlayEx(0.55, 100 + math.sin(CurTime()))
		if not self.SoundPerShot then
			if self:IsFiring() or self:GetTarget():IsValid() then
				self.ShootingSound:PlayEx(1, 100 + math.cos(CurTime()))
			else
				self.ShootingSound:Stop()
			end
		end
	else
		self.ScanningSound:Stop()
		self.ShootingSound:Stop()
	end
end

function ENT:IndividualRemove()
end

function ENT:OnRemove()
	self.ScanningSound:Stop()
	self.ShootingSound:Stop()
	self:IndividualRemove()
end

function ENT:SetObjectHealth(health)
	self:SetDTFloat(3, health)
end

local TEXT_ALIGN_CENTER = TEXT_ALIGN_CENTER
local draw_SimpleText = draw.SimpleText
local surface_SetDrawColor = surface.SetDrawColor
local surface_DrawRect = surface.DrawRect
local cam_Start3D2D = cam.Start3D2D
local cam_End3D2D = cam.End3D2D
local smokegravity = Vector(0, 0, 200)
local aScreen = Angle(0, 270, 60)
local vScreen = Vector(0, -2, 45)
local strYaw = "aim_yaw"
local strPitch = "aim_pitch"
local strParticle = "particles/smokey"
local strFont = "DefaultFont"
local strControl = translate.Get("manual_control")
local strEmpty = translate.Get("empty")
local strIntegrity = "integrity_x"
local strFontBold = "DefaultFontBold"
local strFontSmall = "DefaultFontSmall"
local strLB = "["
local strSlash = " / "
local strRB = "]"
local strCH = "CH. "
local healthpercent
local owner
local ammo
local flash
local wid, hei
local x
local pos, sat
local emitter, particle
function ENT:Draw()
	self:CalculatePoseAngles()
	self:SetPoseParameter(strYaw, self.PoseYaw)
	self:SetPoseParameter(strPitch, self.PosePitch)

	self:DrawModel()

	healthpercent = self:GetObjectHealth() / self:GetMaxObjectHealth()

	if healthpercent <= 0.5 and CurTime() >= self.NextEmit then
		self.NextEmit = CurTime() + 0.05

		pos = self:DefaultPos()
		sat = healthpercent * 360

		emitter = ParticleEmitter(pos)
		emitter:SetNearClip(24, 32)

		particle = emitter:Add(strParticle, pos)
		particle:SetStartAlpha(180)
		particle:SetEndAlpha(0)
		particle:SetStartSize(0)
		particle:SetEndSize(math.Rand(8, 32))
		particle:SetColor(sat, sat, sat)
		particle:SetVelocity(VectorRand():GetNormalized() * math.Rand(8, 64))
		particle:SetGravity(smokegravity)
		particle:SetDieTime(math.Rand(0.8, 1.6))
		particle:SetAirResistance(150)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-4, 4))
		particle:SetCollide(true)
		particle:SetBounce(0.2)

		emitter:Finish()
	end

	owner = self:GetObjectOwner()
	ammo = self:GetAmmo()
	flash = math.sin(CurTime() * 15) > 0
	wid, hei = 128, 92
	x = wid / 2

	cam_Start3D2D(self:LocalToWorld(vScreen), self:LocalToWorldAngles(aScreen), 0.075)

		surface_SetDrawColor(0, 0, 0, 160)
		surface_DrawRect(0, 0, wid, hei)

		surface_SetDrawColor(200, 200, 200, 160)
		surface_DrawRect(0, 0, 8, 16)
		surface_DrawRect(wid - 8, 0, 8, 16)
		surface_DrawRect(8, 0, wid - 16, 8)

		surface_DrawRect(0, hei - 16, 8, 16)
		surface_DrawRect(wid - 8, hei - 16, 8, 16)
		surface_DrawRect(8, hei - 8, wid - 16, 8)

		if owner:IsValid() and owner:IsPlayer() then
			draw_SimpleText(owner:ClippedName(), strFont, x, 10, owner == MySelf and COLOR_BLUE or COLOR_WHITE, TEXT_ALIGN_CENTER)
		end
		draw_SimpleText(translate.Format(strIntegrity, math.ceil(healthpercent * 100)), strFontBold, x, 25, COLOR_WHITE, TEXT_ALIGN_CENTER)

		if flash and self:GetManualControl() then
			draw_SimpleText(strControl, strFont, x, 40, COLOR_YELLOW, TEXT_ALIGN_CENTER)
		end
		
		if ammo > 0 then
			draw_SimpleText(strLB..ammo..strSlash..self.MaxAmmo..strRB, strFontBold, x, 55, COLOR_WHITE, TEXT_ALIGN_CENTER)
		elseif flash then
			draw_SimpleText(strEmpty, strFontBold, x, 55, COLOR_RED, TEXT_ALIGN_CENTER)
		end

		draw_SimpleText(strCH..self:GetChannel()..strSlash..GAMEMODE.MaxChannels[self:GetClass()], strFontSmall, x, 70, COLOR_WHITE, TEXT_ALIGN_CENTER)

	cam_End3D2D()
end

local matBeam = Material("effects/laser1")
local matGlow = Material("sprites/glow04_noz")
function ENT:DrawTranslucent()
	if self:GetMaterial() ~= "" then return end

	local lightpos = self:LightPos()

	local ang = self:GetGunAngles()

	local colBeam = self.BeamColor

	local hasowner = self:GetObjectOwner():IsValid()
	local hasammo = self:GetAmmo() > 0
	local manualcontrol = self:GetManualControl()

	local tr = util.TraceLine({start = lightpos, endpos = lightpos + ang:Forward() * (manualcontrol and 4096 or self.SearchDistance), mask = MASK_SHOT, filter = self:GetCachedScanFilter()})

	if not hasowner then
		local rate = FrameTime() * 512
		colBeam.r = math.Approach(colBeam.r, 0, rate)
		colBeam.g = math.Approach(colBeam.g, 0, rate)
		colBeam.b = math.Approach(colBeam.b, 255, rate)
	elseif not hasammo or not manualcontrol and self:GetTarget():IsValid() then
		local rate = FrameTime() * 512
		colBeam.r = math.Approach(colBeam.r, 255, rate)
		colBeam.g = math.Approach(colBeam.g, 0, rate)
		colBeam.b = math.Approach(colBeam.b, 0, rate)
	elseif manualcontrol then
		local rate = FrameTime() * 512
		colBeam.r = math.Approach(colBeam.r, 255, rate)
		colBeam.g = math.Approach(colBeam.g, 255, rate)
		colBeam.b = math.Approach(colBeam.b, 0, rate)
	else
		local rate = FrameTime() * 200
		colBeam.r = math.Approach(colBeam.r, 0, rate)
		colBeam.g = math.Approach(colBeam.g, 255, rate)
		colBeam.b = math.Approach(colBeam.b, 0, rate)
	end

	if hasowner and hasammo then
		render.SetMaterial(matBeam)
		render.DrawBeam(lightpos, tr.HitPos, 1, 0, 1, COLOR_WHITE)
		render.DrawBeam(lightpos, tr.HitPos, 4, 0, 1, colBeam)
		render.SetMaterial(matGlow)
		render.DrawSprite(lightpos, 4, 4, COLOR_WHITE)
		render.DrawSprite(lightpos, 16, 16, colBeam)
		render.DrawSprite(tr.HitPos, 2, 2, COLOR_WHITE)
		render.DrawSprite(tr.HitPos, 8, 8, colBeam)
	else
		render.SetMaterial(matGlow)
		render.DrawSprite(lightpos, 4, 4, COLOR_WHITE)
		render.DrawSprite(lightpos, 16, 16, colBeam)
	end
end
