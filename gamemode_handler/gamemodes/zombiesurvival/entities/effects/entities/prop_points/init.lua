AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.CleanupPriority = 2
ENT.DecreasePointTimer = 0.3

local keyVals = {
["beamcount_max"] = 8,
["beamcount_min"] = 2,
["interval_max"] = 5,
["interval_min"] = 0.1,
["lifetime_max"] = 0.3,
["lifetime_min"] = 0.3,
["m_Color"] = "100 100 255",
["m_flRadius"] = 256,
["m_SoundName"] = "DoSpark",
["texture"] = "sprites/physbeam.vmt",
["thick_max"] = 5,
["thick_min"] = 2,
}


function ENT:Initialize()
	self.m_Health = 100
	self.IgnorePickupCount = self.IgnorePickupCount or false
	self.Forced = self.Forced or false
	self.NeverRemove = self.NeverRemove or false
	self.IgnoreUse = self.IgnoreUse or false
	self:SetModel("models/props_junk/popcan01a.mdl")
	self:PhysicsInitSphere(8, "glass")
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)

	self:SetUseType(SIMPLE_USE)

	timer.Simple(0, function() self:SetGravity(0.05) end)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(true)
		phys:SetBuoyancyRatio(1)
		phys:Wake()
	end

end

function ENT:Use(activator, caller)
	if activator:IsPlayer() and activator:Alive() and not activator:KeyDown(GAMEMODE.UtilityKey) and activator:Team() == TEAM_HUMAN and not self.Removing then
		if self.IgnoreUse then return end
		self:GiveToActivator(activator, caller)
	end
end

local ltBlue = Color(100, 100, 255, 255)
function ENT:GiveToActivator(activator, caller)
	activator:AddPoints(self:GetPointValue())
	activator:CenterNotify(ltBlue, "You've absorbed "..tostring(math.Round(self:GetPointValue())).." points.")
	self:Remove()
end

function ENT:Think()
	self.NextPointDecrease = self.NextPointDecrease or 0
	if self.NextPointDecrease < CurTime() then
		self.NextPointDecrease = CurTime() + self.DecreasePointTimer or 1
		self:SetPointValue(self:GetPointValue() - 1)
		if self:GetPointValue() <= 0 then
			self:Remove()
		end
	end
end

function ENT:OnTakeDamage(dmginfo)
	if self.NeverRemove then return end
	self:TakePhysicsDamage(dmginfo)
	local ply = dmginfo:GetAttacker()
	if ply:IsValid() and ply:IsPlayer() and ply:Team() == TEAM_HUMAN then return end

	self.m_Health = self.m_Health - dmginfo:GetDamage()
	if self.m_Health <= 0 then
		self:RemoveNextFrame()
	end
end
