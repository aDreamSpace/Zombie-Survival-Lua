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
    if (IsValid(phys)) then
        phys:EnableMotion(false)
    end
end

function ENT:Think()
    if (!self.ns or CurTime() >= self.ns) then
        self.ns = CurTime() + 5 -- Reset the timer for healing
        for _, v in pairs (ents.FindByClass("prop_nail")) do
            if (v:GetPos():Distance(self:GetPos()) <= 256) then
                local hp, max = v:GetNailHealth(), v:GetMaxNailHealth()
                if (hp < max) then
                    v:GetBaseEntity():SetBarricadeHealth(math.min(max, hp + 30))
                end
            end
        end
    end

    self:NextThink(CurTime())
    return true
end

function ENT:OnTakeDamage(dmginfo)
	self:TakePhysicsDamage(dmginfo)

	local attacker = dmginfo:GetAttacker()
	if not (attacker:IsValid() and attacker:IsPlayer() and attacker:Team() == TEAM_HUMAN) then
		self:ResetLastBarricadeAttacker(attacker, dmginfo)
		self:SetObjectHealth(self:GetObjectHealth() - dmginfo:GetDamage())
	end
end

