AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.LastHitSomething = 0
ENT.NextFireTime = 1
ENT.TurretModel = "models/Combine_turrets/Floor_turret.mdl"
ENT.TurretHealth = 350
ENT.TurretAmmo = "buckshot"

--info for bullet struct
ENT.TurretDamage = 45
ENT.TurretSpread = Vector(0.05, 0.05, 0)
ENT.TurretBulletCount = 8
ENT.TurretForce = 5
ENT.TurretTracer = 3

ENT.FireSound = "weapons/shotgun/shotgun_fire6.wav"

local function RefreshTurretOwners(pl)
	for _, ent in pairs(ents.FindByClass("prop_shotgunturret")) do
		if ent:IsValid() and ent:GetObjectOwner() == pl then
			ent:ClearObjectOwner()
			ent:ClearTarget()
		end
	end
end
hook.Add("PlayerDisconnected", "ShotGunTurret.PlayerDisconnected", RefreshTurretOwners)
hook.Add("OnPlayerChangedTeam", "ShotGunTurret.OnPlayerChangedTeam", RefreshTurretOwners)
