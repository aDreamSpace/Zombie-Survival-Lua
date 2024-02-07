AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "status_ghost_base"

ENT.GhostModel = Model("models/pa_zs/deployable/new_turret.mdl")
ENT.GhostRotation = Angle(270, 0, 0)
ENT.GhostHitNormalOffset = 12
ENT.GhostEntity = "prop_miniturret"
ENT.GhostWeapon = "weapon_zs_miniturret"
ENT.GhostDistance = 128
ENT.GhostLimitedNormal = 0.75
ENT.GhostFlatGround = false
