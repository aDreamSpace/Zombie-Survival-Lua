AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self.Touched = {}
	self.OriginalAngles = self:GetAngles()
	
	self:Fire("kill", "", 15)
	
	self:SetModel("models/Gibs/HGIBS.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetTrigger(true)
	
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetMass(4)
		phys:SetBuoyancyRatio(0.01)
		phys:EnableDrag(false)
		phys:Wake()
	end
	

end

function ENT:PhysicsCollide(data, phys)
    if self.Done then return end
    self.Done = true

    self:Fire("kill", "", 0.4)

    local normal = data.HitNormal
    local speed = phys:GetVelocity():Length()

    -- Apply an impulse to maintain velocity in the direction of the collision normal
    phys:ApplyForceCenter(normal * speed * 10)

    -- Disable motion and parent to the hit entity if applicable
    phys:EnableMotion(false)
    self:SetPos(data.HitPos)
    self:SetAngles(normal:Angle())

    local hitent = data.HitEntity
    if hitent and hitent:IsValid() then
        local hitphys = hitent:GetPhysicsObject()
        if hitphys:IsValid() and hitphys:IsMoveable() then
            self:SetParent(hitent)
        end

        -- Check if the hit entity is a player and not of a specific team (e.g., TEAM_ZOMBIE or TEAM_HUMAN)
        if hitent:IsPlayer() and hitent:Team() ~= TEAM_ZOMBIE and hitent:Team() ~= TEAM_HUMAN then
            return -- Do not apply collision logic to players not on specific teams
        end
    end
end



function ENT:StartTouch(ent)
	if self.Done or self.Touched[ent] or not ent:IsValid() then return end

	local owner = self:GetOwner()
	if not owner:IsValid() then owner = self end

	if ent == owner or ent:IsPlayer() and (ent:Team() == self.Team or not ent:Alive()) then return end

	self.Touched[ent] = true

	ent:TakeDamage(22, owner, self)
end
