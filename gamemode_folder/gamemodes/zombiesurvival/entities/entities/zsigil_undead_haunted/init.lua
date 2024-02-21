AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")



function ENT:Initialize()
    self:SetModel("models/props_c17/gravestone_cross001a.mdl")
    self:SetModelScale(0.5, 0)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:EnableMotion(false)
    end
    self:SetPos(self:GetPos() - Vector(0,0,-30))
    self:SetMaxObjectHealth(2000)
    self:SetObjectHealth(self:GetMaxObjectHealth())

    -- Store a reference to the entity
end


function ENT:OnTakeDamage(dmg)
    -- If the attacker is a zombie, don't apply any damage
    local attacker = dmg:GetAttacker()
    if attacker:IsPlayer() and attacker:Team() == TEAM_UNDEAD then
        return
    end

    self:SetObjectHealth(self:GetObjectHealth() - dmg:GetDamage())

    if self:GetObjectHealth() <= 0 then
        self:Remove()
    end
end 
