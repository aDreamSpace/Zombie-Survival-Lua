AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
SWEP.GhostName = "ghost_shotgunturret"
SWEP.PairedEnt = "prop_shotgunturret"
SWEP.ControllerSWEP = "weapon_zs_shotgunturretcontrol"
SWEP.EntAmmoName = "buckshot"
SWEP.StatusName = "status_ghost_shotgunturret"