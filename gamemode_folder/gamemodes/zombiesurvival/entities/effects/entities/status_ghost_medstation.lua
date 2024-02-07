AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "status_ghost_base"

ENT.GhostModel = Model("models/props/deployable/medstation_1.mdl")
ENT.GhostRotation = Angle(270, 0, 0)
ENT.GhostHitNormalOffset = 12
ENT.GhostEntity = "prop_medstation"
ENT.GhostWeapon = "weapon_zs_medstation"
ENT.GhostDistance = 96 --big deployable, needs more room
ENT.GhostLimitedNormal = 0.75
