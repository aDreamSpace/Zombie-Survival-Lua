AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

-- Configurable options
ENT.HealAmount = 22
ENT.HealRadius = 300
ENT.HealDelay = 7

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/props_c17/gravestone_cross001a.mdl")
        self:SetModelScale(0.5)
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_NONE)
        self:SetUseType(SIMPLE_USE)
        self:SetCustomCollisionCheck(true)
        self:CollisionRulesChanged()
        self:SetCollisionGroup(COLLISION_GROUP_WORLD)
        self:SetMaxObjectHealth(2000)
        self:SetObjectHealth(self:GetMaxObjectHealth())
        self:SetPos(self:GetPos() - Vector(0,0,-30))
        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
        end

        self.NextHeal = CurTime()
    end
end 

    function ENT:Think()
        -- If the entity is destroyed, explode and stop thinking
        if self.Destroyed then
            self:Explode()
            return
        end

        if CurTime() >= self.NextHeal then
            local healed = false

            for _, ply in ipairs(ents.FindInSphere(self:GetPos(), self.HealRadius)) do
                if ply:IsPlayer() and ply:Team() == TEAM_HUMANS and ply:Health() < ply:GetMaxHealth() then
                    ply:SetHealth(math.min(ply:Health() + self.HealAmount, ply:GetMaxHealth()))
                    healed = true
                end
            end

            if healed then
                self:EmitSound("npc/scanner/combat_scan1.wav", 60, 250)
            end

            self.NextHeal = CurTime() + self.HealDelay
        end

        self:NextThink(CurTime())
        return true
    end

function ENT:OnTakeDamage(dmg)
    local attacker = dmg:GetAttacker()
    -- Only apply damage if the attacker is a player and on the TEAM_UNDEAD team
    if attacker:IsPlayer() and attacker:Team() == TEAM_UNDEAD then
        self:SetObjectHealth(self:GetObjectHealth() - dmg:GetDamage())
        if self:GetObjectHealth() <= 0 then
            self:Explode()
        end
    end
end


function ENT:Explode()
    -- Apply blast damage
    util.BlastDamage(self, self, self:GetPos(), 100, 100)  -- Adjust the radius and damage as needed

    -- Create a visual explosion effect
    local effectdata = EffectData()
    effectdata:SetOrigin(self:GetPos())
    util.Effect("Explosion", effectdata)

    -- Remove the entity
    self:Remove()
end