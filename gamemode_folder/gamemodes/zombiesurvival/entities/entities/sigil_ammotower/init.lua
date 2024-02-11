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


local ammoTable = {
	["Pistol"] = 12,
	["SMG1"] = 36,
	["ar2"] = 36,
	["357"] = 24,
	["gravity"] = 24,
	["pulse"] = 75, 
	["buckshot"] = 36,
	["battery"] = 30, 

	-- Add more ammo types as needed
}

function ENT:Think()
    if (self.Destroyed) then
        local pos = self:LocalToWorld(self:OBBCenter())

        local eff = EffectData()
        eff:SetOrigin(pos)
        util.Effect("Explosion", eff)
        self:Remove()
    else
        if (!self.ns or RealTime() >= self.ns) then
            self.ns = RealTime() + 45 -- Reset the timer for ammo regeneration
            for _, ply in pairs (player.GetAll()) do
                if (ply:GetPos():Distance(self:GetPos()) <= 200 and ply:Team() == TEAM_HUMAN) then -- Check if player is within 200 units and is human
                    for ammoType, ammoAmount in pairs(ammoTable) do
                        ply:GiveAmmo(ammoAmount, ammoType) -- Give ammo of each type in the ammo table
                    end
                end
            end
        end
    end
end