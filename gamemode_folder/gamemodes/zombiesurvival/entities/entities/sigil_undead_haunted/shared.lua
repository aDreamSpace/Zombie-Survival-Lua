ENT.Type = "anim"
ENT.Name = "Haunted Undead Sigil"

function ENT:SetupDataTables()
    self:NetworkVar("Float", 0, "ObjectHealth")
    self:NetworkVar("Float", 1, "MaxObjectHealth")
    self:NetworkVar("Entity", 0, "ObjectOwner")
end

function ENT:GetObjectOwner()
    return self:GetObjectOwner() or NULL
end

function ENT:SetObjectOwner(obj)
    self:SetObjectOwner(obj)
end

function ENT:GetMaxObjectHealth()
    return self:GetMaxObjectHealth() or 2000
end

function ENT:SetMaxObjectHealth(health)
    self:SetMaxObjectHealth(health)
end

function ENT:GetObjectHealth()
    return self:GetObjectHealth() or self:GetMaxObjectHealth()
end

function ENT:SetObjectHealth(health)
    self:SetObjectHealth(health)
end

function ENT:TakeObjectDamage(damage)
    local health = self:GetObjectHealth()
    self:SetObjectHealth(math.max(health - damage, 0))
end