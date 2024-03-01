AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local phys, vel, owner, pos, DotProduct, traceDir, trace, ownerVel, aimVec, randomShake, random, ED, distance, relation, forceDir, pos2
local td = {}

ENT.RocketSpeed = 4250
ENT.RocketModel = "models/khrcw2/ins2rpg7hvrocket.mdl"
ENT.RocketDamage = 2500
ENT.RocketRadius = 512^2

function ENT:IndividualInitalize()
	self:SetGravity(0.2)
end
