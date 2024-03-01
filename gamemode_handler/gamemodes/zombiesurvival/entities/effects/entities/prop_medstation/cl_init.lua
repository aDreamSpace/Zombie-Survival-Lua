include("shared.lua")

ENT.NextUpdate = 0.15
ENT.NextEmit = 0
ENT.NextEmitDelay = 0.05
ENT.Deploying = false

function ENT:Initialize()
	self:SetRenderBounds(Vector(-72, -72, -72), Vector(72, 72, 128))
	self.NextDeploy = 0
end

local vOffset = Vector(0, -7.1, 46)
local vOffset2 = Vector(0, 7.1, 46)
local aOffset = Angle(0, 0, 90)
local aOffset2 = Angle(0, 180, 90)
local vOffsetEE = Vector(-15, 0, 8)

function ENT:SetObjectHealth(health)
	self:SetDTFloat(0, health)
end

function ENT:Think()
	self.timer = self.timer or 0
	if self.timer < CurTime() then
		self.timer = CurTime() + self.NextUpdate
		self.IsDispensing = self:GetDispensing()
		self.StoredMeds = self:GetStoredMeds()
	end
	
	if self.IsDispensing and !self.Deploying then
		self:DeployParticles(true)
		self.Deploying = true
	elseif !self.IsDispensing and self.Deploying then
		self:DeployParticles(false)
		self.Deploying = false
		self.NextDeploy = CurTime() + self.WaitTime
	end

	if self.started then
		self:GenerateParticles()
	end
	
	self:SetNextClientThink(CurTime() + self.NextEmitDelay)
	return true
end

function ENT:DeployParticles(startstop)
	self.started = self.started or false
	if startstop == true and !self.started then
		self.posR = self:GetPos() + self:GetAngles():Forward() * 8 + Vector(0,0,40)
		self.posL = self:GetPos() + self:GetAngles():Forward() * -8 + Vector(0,0,40)
		self.emitterR = ParticleEmitter(self.posR)
		self.emitterR:SetNearClip(32, 64)
		self.emitterL = ParticleEmitter(self.posL)
		self.emitterL:SetNearClip(32, 64)
		self.started = true
	elseif startstop == false then
		if !self.emitterR:IsValid() or !self.emitterL:IsValid() then return end
		self.emitterR:Finish()
		self.emitterL:Finish()
		self.started = false
	end
end

function ENT:OnRemove()
	if self.IsDispensing then
		if self.emitterR and self.emitterR:IsValid() then
			self.emitterR:Finish()
		end
		if self.emitterL and self.emitterL:IsValid() then
			self.emitterL:Finish()
		end
	end
end

function ENT:GenerateParticles()
	local right = self:GetAngles():Forward()
	local left = self:GetAngles():Forward() * -1
	if self.started ~= true then return end
	if !self.emitterR:IsValid() or !self.emitterL:IsValid() then return end
	local particleR = self.emitterR:Add("particles/smokey", self.posR)
	particleR:SetVelocity(right * math.Rand(40, 50))
	particleR:SetDieTime(math.Rand(0.5, 1.5))
	particleR:SetStartAlpha(math.Rand(10, 50))
	particleR:SetEndAlpha(0)
	particleR:SetStartSize(3.6)
	particleR:SetEndSize(math.Rand(48, 64))
	particleR:SetRoll(math.Rand(-2, 2))
	particleR:SetColor(50, 50, 220)

	local particleL = self.emitterL:Add("particles/smokey", self.posL)
	particleL:SetVelocity(left * math.Rand(40, 50))
	particleL:SetDieTime(math.Rand(0.5, 1.5))
	particleL:SetStartAlpha(math.Rand(10, 50))
	particleL:SetEndAlpha(0)
	particleL:SetStartSize(3.6)
	particleL:SetEndSize(math.Rand(48, 64))
	particleL:SetRoll(math.Rand(-2, 2))
	particleL:SetColor(50, 50, 220)
end

function ENT:RenderInfo(pos, ang, owner)
	cam.Start3D2D(pos, ang, 0.04)
		draw.SimpleText("Medical Station", "ZS3D2DFont2", 0, -250, COLOR_GREEN, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText("Stored MedPower: "..tostring(self.StoredMeds), "ZS3D2DFont2", 0, -170, COLOR_GREEN, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText(self.IsDispensing and "Dispensing product..." or (self.StoredMeds <= 0 or !owner:IsValid()) and "Halted" or  "Next deploy in: "..tostring(math.Round(self.NextDeploy - CurTime())), "ZS3D2DFont2", 0, -100, self.IsDispensing and COLOR_GREEN or COLOR_DARKRED, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		if owner:IsValid() and owner:IsPlayer() then
			draw.SimpleText("LOGGED IN: ", "ZS3D2DFont2Small", 0, -20, COLOR_GRAY, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			draw.SimpleText(owner:ClippedName(), "ZS3D2DFont2Small", 0, 20, COLOR_GRAY, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		end	
	cam.End3D2D()
end

function ENT:Draw()
	self:DrawModel()

	if not MySelf:IsValid() then return end

	local owner = self:GetObjectOwner()
	local ang = self:LocalToWorldAngles(aOffset)

	self:RenderInfo(self:LocalToWorld(vOffset), ang, owner)
	self:RenderInfo(self:LocalToWorld(vOffset2), self:LocalToWorldAngles(aOffset2), owner)
end