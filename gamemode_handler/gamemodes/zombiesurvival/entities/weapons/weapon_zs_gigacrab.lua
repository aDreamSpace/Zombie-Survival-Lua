AddCSLuaFile()

SWEP.Base = "weapon_zs_headcrab"

if CLIENT then
	SWEP.PrintName = "Giga Crab"
end

SWEP.PounceDamage = 25
SWEP.Primary.Delay = 0.2
SWEP.NoHitRecovery = 3
SWEP.HitRecovery = 3
SWEP.PropDamage = 50

function SWEP:EmitBiteSound()
	self.Owner:EmitSound("NPC_FastHeadcrab.Bite", 70, math.random(140, 170))
end

function SWEP:EmitIdleSound()
	self.Owner:EmitSound("NPC_FastHeadcrab.Idle")
end

function SWEP:EmitAttackSound()
	self.Owner:EmitSound("NPC_FastHeadcrab.Attack", 70, math.random(160, 180))
end

function SWEP:Reload()
end
