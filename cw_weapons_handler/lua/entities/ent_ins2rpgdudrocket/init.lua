AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local phys, vel, owner, pos, DotProduct, traceDir, trace, ownerVel, aimVec, randomShake, random, ED, distance, relation, forceDir, pos2
local td = {}

ENT.RocketModel = "models/khrcw2/ins2rpg7rocket.mdl"
ENT.RocketSpeed = 3000
ENT.RocketDamage = 2000
ENT.RocketRadius = 512^2

function ENT:IndividualInitalize()
	self:SetGravity(math.random(.5, 1))
end
