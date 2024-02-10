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

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
        end

        self.NextHeal = CurTime()
    end

    function ENT:Think()
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
end