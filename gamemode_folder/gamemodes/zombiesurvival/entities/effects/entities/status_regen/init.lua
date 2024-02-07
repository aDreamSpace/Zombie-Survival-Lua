AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:PlayerSet(pPlayer, bExists)
	pPlayer.Regen = self
end

ENT.FirstThink = true
function ENT:Think()
	local owner = self:GetOwner()
	
	if self:GetLife() <= 0 then
		self:Remove()
		return
	end
	
	if !owner:Alive() then
		self:Remove()
	end
	if not self.FirstThink then
		local hp = math.Clamp(self:GetLife(), 1, 8)
		owner:SetHealth(math.min(owner:GetMaxHealth(), owner:Health() + hp))
		self:AddLife(-hp)
	end

	self.FirstThink = false
	self:NextThink(CurTime() + 7)
	return true
end
