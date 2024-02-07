AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Alpha Crab"
end

SWEP.Base = "weapon_zs_zombie"

SWEP.MeleeDamage = 37
SWEP.MeleeForceScale = 1.25

SWEP.Primary.Delay = 1.2

function SWEP:Reload()
	self.BaseClass.SecondaryAttack(self)
end

function SWEP:PlayAlertSound()
	self:PlayAttackSound()
end

function SWEP:PlayIdleSound()
	self.Owner:EmitSound("npc/barnacle/barnacle_tongue_pull"..math.random(3)..".wav")
end

function SWEP:PlayAttackSound()
	self.Owner:EmitSound("NPC_HeadCrab.Attack", 70, math.Rand(40, 50))
end

function SWEP:PlayHitSound()
	self.Owner:EmitSound("zsounds/attack/chadcrab/crabsmack"..math.random(1, 5), 70, math.Rand(70, 100))
end

if not CLIENT then return end

function SWEP:ViewModelDrawn()
	render.ModelMaterialOverride(0)
end

local matSheet = Material("models/weapons/v_zombiearms/ghoulsheet")
function SWEP:PreDrawViewModel(vm)
	render.ModelMaterialOverride(matSheet)
end
