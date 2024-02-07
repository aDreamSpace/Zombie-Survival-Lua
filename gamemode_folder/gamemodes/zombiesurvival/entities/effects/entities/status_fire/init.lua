AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:PlayerSet(pPlayer, bExists)
	pPlayer.Fire = self
end

local owner
local dmg
local dir
function ENT:Think()
	owner = self:GetOwner()
	
	if self:GetDamage() <= 0 then
		self:Remove()
		return
	end
	
	if !owner:Alive() then
		self:Remove()
	end

	dmg = math.Clamp(self:GetDamage(), 1, 1)

	owner:TakeDamage(dmg, self.Damager and self.Damager:IsValid() and self.Damager:IsPlayer() and self.Damager:Team() ~= owner:Team() and self.Damager or owner, self)
	self:AddDamage(-dmg)

	dir = VectorRand()
	dir:Normalize()
	util.Blood(owner:WorldSpaceCenter(), 3, dir, 32)

	self:NextThink(CurTime() + 0.04)
	return true
end
