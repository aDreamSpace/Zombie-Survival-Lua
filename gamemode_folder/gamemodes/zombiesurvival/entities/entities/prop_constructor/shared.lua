ENT.Type = "anim"

ENT.Name = ""

ENT.m_NoNailUnfreeze = true
ENT.NoNails = true

ENT.CanPackUp = true
ENT.PackUpTime = 1

ENT.IsBarricadeObject = true

function ENT:SetObjectHealth(health)
	self:SetDTFloat(0, health)
	if health <= 0 and not self.Destroyed then
		self.Destroyed = true
	end
end

function ENT:ShouldNotCollide(ent)
	if ent:IsValid() and ent:IsPlayer() then
		return false
	end

    return true
end

function ENT:GetObjectHealth()
	return self:GetDTFloat(0)
end

function ENT:SetMaxObjectHealth(health)
	self:SetDTFloat(1, health)
end

function ENT:GetMaxObjectHealth()
	return self:GetDTFloat(1)
end

function ENT:SetObjectFuel(fuel)
	self:SetDTFloat(2, fuel)
end

function ENT:GetObjectFuel()
	return self:GetDTFloat(2)
end

function ENT:SetMaxObjectFuel(fuel)
	self:SetDTFloat(3, fuel)
end

function ENT:GetMaxObjectFuel()
	return self:GetDTFloat(3)
end

function ENT:SetObjectOwner(ent)
	self:SetDTEntity(0, ent)
end

function ENT:GetObjectOwner()
	return self:GetDTEntity(0)
end

function ENT:ClearObjectOwner()
	self:SetObjectOwner(NULL)
end

function ENT:HitByWrench(wep, owner, tr)
	local hp, max = self:GetObjectHealth(), self:GetMaxObjectHealth()
	if (hp < max) then
		local toadd = math.min(max - hp, wep.HealStrength)
		self:SetObjectHealth(hp + toadd)
		gamemode.Call("PlayerRepairedObject", owner, self, toadd, self)
	end

	return true
end

function ENT:CanBePackedBy(pl)
	local owner = self:GetObjectOwner()
	return not owner:IsValid() or owner == pl or owner:Team() ~= TEAM_HUMAN or gamemode.Call("PlayerIsAdmin", pl)
end