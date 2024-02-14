AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

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
    if IsValid(phys) then
        phys:EnableMotion(false)
    end

    self.NextPoints = CurTime() + 20 -- Initial timer for points generation
end

function ENT:Think()
    if self.Destroyed then
        local pos = self:LocalToWorld(self:OBBCenter())
        local eff = EffectData()
        eff:SetOrigin(pos)
        util.Effect("Explosion", eff)
        self:Remove()
        self:OnBreak()
    else
        if CurTime() >= self.NextPoints then
            self.NextPoints = CurTime() + 20 -- Reset the timer for points generation
            for _, ply in pairs(player.GetAll()) do
                if ply:Team() == TEAM_HUMAN and ply:Alive() and ply:GetPos():Distance(self:GetPos()) <= 200 then
                    ply:AddPoints(5) -- Give 5 points to nearby living humans
                end
            end
        end
    end
end

function ENT:OnBreak()
    local aliveHumans = 0
    for _, ply in pairs(player.GetAll()) do
        if ply:Team() == TEAM_HUMAN and ply:Alive() then
            aliveHumans = aliveHumans + 1
        end
    end

    local pointsToLose = math.floor(aliveHumans * 0.75) -- 75% of points for each alive human
    for _, ply in pairs(player.GetAll()) do
        if ply:Team() == TEAM_HUMAN and ply:Alive() then
            ply:TakePoints(pointsToLose)
        end
    end
end
