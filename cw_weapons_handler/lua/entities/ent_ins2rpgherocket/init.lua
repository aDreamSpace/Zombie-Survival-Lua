AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local phys, vel, owner, pos, DotProduct, traceDir, trace, ownerVel, aimVec, randomShake, random, ED, distance, relation, forceDir, pos2
local td = {}

ENT.RocketModel = "models/khrcw2/ins2rpg7herocket.mdl"
ENT.RocketSpeed = 250
ENT.RocketDamage = 2750
ENT.RocketRadius = 512^2

function ENT:IndividualInitalize()
	self:SetGravity(0.5)
end
