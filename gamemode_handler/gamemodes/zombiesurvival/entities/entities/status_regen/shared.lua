ENT.Type = "anim"
ENT.Base = "status__base"

function ENT:OnInitialize()
	self:DrawShadow(false)
	if self:GetDTFloat(1) == 0 then
		self:SetDTFloat(1, CurTime())
	end
end

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "Life")
end

function ENT:AddLife(hp)
	self:SetLife(math.min(100, self:GetLife() + hp))
end