ENT.Type = "anim"

ENT.CanPackUp = true
ENT.PackUpTime = 4

ENT.m_NoNailUnfreeze = true
ENT.NoNails = true

ENT.NoPropDamageDuringWave0 = true

ENT.ExplosionDelay = 1

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "ExplodeTime")

end

function ENT:SetObjectOwner(owner)
	self:SetOwner(owner)
end

function ENT:GetObjectOwner()
	return self:GetOwner()
end
