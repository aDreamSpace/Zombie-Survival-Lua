include("shared.lua")

ENT.NextEmit = 0

function ENT:Initialize()
	self:DrawShadow(false)

	self.AmbientSound = CreateSound(self, "zombiesurvival/misc/kv2.ogg")
	self.AmbientSound:PlayEx(0.55, 130)

	self:GetOwner().status_mausambience = self
end

function ENT:OnRemove()
	self.AmbientSound:Stop()
end

function ENT:Think()
	self.AmbientSound:PlayEx(0.55, 130 + math.sin(RealTime()))
end

function ENT:Draw()
	if CurTime() < self.NextEmit then return end
end
