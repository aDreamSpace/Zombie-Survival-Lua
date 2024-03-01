ENT.Type = "anim"
ENT.Base = "status__base"

function ENT:Initialize()
	self:DrawShadow(false)
	if self:GetDTFloat(1) == 0 then
		self:SetDTFloat(1, CurTime())
	end
end

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "Damage")
end

function ENT:AddDamage(damage)
	local newDmg = math.min(self:GetDamage() + damage, 300)
	self:SetDamage(newDmg)
end