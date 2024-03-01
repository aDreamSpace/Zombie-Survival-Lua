include("shared.lua")

function ENT:Initialize()
	self:SetRenderBounds(Vector(-72, -72, -72), Vector(72, 72, 72))

	self:CreateAmbientSounds()
	self:CreateSubModel()

	self.PixVis = util.GetPixelVisibleHandle()

	hook.Add("CreateMove", self, self.CreateMove)
	hook.Add("ShouldDrawLocalPlayer", self, self.ShouldDrawLocalPlayer)
	hook.Add("CalcView", self, self.CalcView)
end

function ENT:CreateSubModel()
end

function ENT:CreateAmbientSounds()
	self.AmbientSound = CreateSound(self, "npc/manhack/mh_engine_loop1.wav")
	self.AmbientSound2 = CreateSound(self, "npc/manhack/mh_blade_loop1.wav")
end

function ENT:PlayAmbientSounds()
	self.AmbientSound:PlayEx(0.5, math.min(80 + self:GetVelocity():Length() * 0.3, 160))
	self.AmbientSound2:PlayEx(0.3, 100 + math.sin(CurTime()))
end

ENT.NextEmit = 0
local smokegravity = Vector(0, 0, 64)
local perc
local pos
local sat
local emitter
local particle
local strParticleName = "particles/smokey"
function ENT:Think()
	self:PlayAmbientSounds()

	perc = math.Clamp(self:GetObjectHealth() / self:GetMaxObjectHealth(), 0, 255)
	if perc < 0.5 and CurTime() >= self.NextEmit then
		self.NextEmit = CurTime() + 0.05 + perc * math.Rand(0.05, 0.25)

		pos = self:GetPos()
		sat = perc * 90

		emitter = ParticleEmitter(pos)
		emitter:SetNearClip(16, 24)

		particle = emitter:Add(strParticleName, pos)
		particle:SetStartAlpha(180)
		particle:SetEndAlpha(0)
		particle:SetStartSize(0)
		particle:SetEndSize(math.Rand(8, 20))
		particle:SetVelocity(self:GetVelocity() * 0.7 + VectorRand():GetNormalized() * math.Rand(4, 24))
		particle:SetGravity(smokegravity)
		particle:SetDieTime(math.Rand(0.8, 1.6))
		particle:SetAirResistance(150)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-2, 2))
		particle:SetCollide(true)
		particle:SetBounce(0.2)
		particle:SetColor(sat, sat, sat)

		emitter:Finish()
	end
end

function ENT:OnRemove()
	self.AmbientSound:Stop()
	self.AmbientSound2:Stop()
	self:RemoveSubModel()
end

function ENT:RemoveSubModel()
end

function ENT:SetObjectHealth(health)
	self:SetDTFloat(0, health)
end

function ENT:DrawSubModel()
end

local colLight = Color(255, 0, 0)
local colWhite = Color(255, 255, 255)
local colHealth = Color(255, 255, 255)
local matLight = Material("sprites/light_ignorez")
local owner
local ang
local right
local perc
local epos
local LightNrm
local ViewNormal
local Distance
local ViewDot
local vcol
local LightPos
local Visibile
local Alpha
local Size


local strFont = "ZS3D2DFont"
local strFontBig = "ZS3D2DFontBig"

function ENT:DrawTranslucent()
	self:DrawModel()

	self:DrawSubModel()
	owner = self:GetOwner()

	if MySelf:IsValid() and MySelf:Team() == TEAM_HUMAN and owner:IsValid() and owner:IsPlayer() then
		ang = EyeAngles()
		ang.pitch = 0
		right = ang:Right()
		ang:RotateAroundAxis(ang:Up(), 270)
		ang:RotateAroundAxis(ang:Forward(), 90)
		cam.Start3D2D(self:LocalToWorld(Vector(0, 0, 16)), ang, 0.025)
			draw.SimpleTextBlurry(owner:Name(), strFont, 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			perc = math.Clamp(self:GetObjectHealth() / self:GetMaxObjectHealth(), 0, 1)
			colHealth.r = 255
			colHealth.g = perc ^ 0.3 * 255
			colHealth.b = perc * 255
			draw.SimpleTextBlurry(math.ceil(perc * 100), strFontBig, 0, 0, colHealth, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		cam.End3D2D()
	end

	epos = self:GetRedLightPos()
	LightNrm = self:GetRedLightAngles():Forward()
	ViewNormal = epos - EyePos()
	Distance = ViewNormal:Length()
	ViewNormal:Normalize()
	ViewDot = ViewNormal:Dot( LightNrm * -1 )

	if ViewDot >= 0 then
		if owner:IsValid() and owner:IsPlayer() then
			vcol = owner:GetPlayerColor()
			if vcol then
				if vcol == vector_origin then
					vcol.x = 1 vcol.y = 1 vcol.z = 1
				end
				vcol:Normalize()
				vcol = vcol * 2.55
				colLight.r = math.Clamp(vcol.r * 100, 0, 255)
				colLight.g = math.Clamp(vcol.g * 100, 0, 255)
				colLight.b = math.Clamp(vcol.b * 100, 0, 255)
			end
		end

		LightPos = epos + LightNrm * 5

		render.SetMaterial(matLight)
		Visibile = util.PixelVisible( LightPos, 16, self.PixVis )

		if not Visibile then return end

		Size = math.Clamp(Distance * Visibile * ViewDot * 0.9, 20, 210)

		Distance = math.Clamp(Distance, 32, 800)
		Alpha = math.Clamp((1000 - Distance) * Visibile * ViewDot, 0, 100)
		colLight.a = Alpha
		colWhite.a = Alpha

		render.DrawSprite(LightPos, Size, Size, colLight, Visibile * ViewDot)
		render.DrawSprite(LightPos, Size*0.4, Size*0.4, colWhite, Visibile * ViewDot)
	end
end

function ENT:CreateMove(cmd)
	if self:GetOwner() ~= MySelf then return end

	if not self:BeingControlled() then return end

	local buttons = cmd:GetButtons()

	cmd:ClearMovement()

	if bit.band(buttons, IN_JUMP) ~= 0 then
		buttons = buttons - IN_JUMP
		buttons = buttons + IN_BULLRUSH
	end

	if bit.band(buttons, IN_DUCK) ~= 0 then
		buttons = buttons - IN_DUCK
		buttons = buttons + IN_GRENADE1
	end

	cmd:SetButtons(buttons)
end

function ENT:ShouldDrawLocalPlayer(pl)
	if self:GetOwner() ~= MySelf then return end

	if self:BeingControlled() then
		return true
	end
end

local ViewHullMins = Vector(-4, -4, -4)
local ViewHullMaxs = Vector(4, 4, 4)

function ENT:GetCachedPlayers()
	if not self.NextUpdate then self.NextUpdate = 0 end
	if self.NextUpdate < CurTime() then
		self.CACHEDPLAYERLIST = player.GetAll()
		self.NextUpdate = CurTime() + 0.5
	end
	return self.CACHEDPLAYERLIST
end

function ENT:CalcView(pl, origin, angles, fov, znear, zfar)
	if self:GetOwner() ~= pl then return end

	if not self:BeingControlled() then return end

	local filter = self:GetCachedPlayers()
	filter[#filter + 1] = self
	local tr = util.TraceHull({start = self:GetPos(), endpos = self:GetPos() + angles:Forward() * -48, mask = MASK_SHOT, filter = filter, mins = ViewHullMins, maxs = ViewHullMaxs})

	return {origin = tr.HitPos + tr.HitNormal * 3}
end
