AddCSLuaFile()

SWEP.Base = "weapon_zs_zombie"
SWEP.PrintName = "Slapper"

SWEP.KnockbackScale = 0
SWEP.MeleeDelay = 0.25
SWEP.MeleeReach = 40
SWEP.MeleeDamage = 34

SWEP.DelayWhenDeployed = true

function SWEP:Reload()
	self:SecondaryAttack()
end

function SWEP:StartMoaning()
end

function SWEP:StopMoaning()
end

function SWEP:IsMoaning()
	return false
end
