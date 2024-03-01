include("shared.lua")

function ENT:Draw()
end

function ENT:Initialize()
	self:GetOwner().Regen = self
end
