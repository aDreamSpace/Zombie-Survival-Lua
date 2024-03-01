AddCSLuaFile()

SWEP.Base = "weapon_zs_zombie"

SWEP.PrintName = "Flesh Creeper"

SWEP.MeleeDelay = 0.25
SWEP.MeleeReach = 49
SWEP.MeleeDamage = 44
SWEP.MeleeForceScale = 1.25
SWEP.MeleeSize = 3
SWEP.MeleeDamageType = DMG_SLASH
SWEP.Primary.Delay = 0.75

SWEP.Secondary.Automatic = false

AccessorFuncDT(SWEP, "RightClickStart", "Float", 2)
AccessorFuncDT(SWEP, "AttackAnimTime", "Float", 3)



function SWEP:PrimaryAttack()
	if self:GetHoldingRightClick() then return end

	self.BaseClass.PrimaryAttack(self)

	if self:IsSwinging() then
		self:SetAttackAnimTime(CurTime() + self.Primary.Delay)
	end
end





function SWEP:Reload()
	self.BaseClass.SecondaryAttack(self)
end

function SWEP:IsMoaning()
	return false
end

function SWEP:PlayAlertSound()
	self.Owner:EmitSound("npc/barnacle/barnacle_pull"..math.random(4)..".wav", 70)
end

function SWEP:PlayIdleSound()
	self.Owner:EmitSound("npc/barnacle/barnacle_pull"..math.random(4)..".wav", 70, 85)
end

function SWEP:PlayAttackSound()
end

function SWEP:PlayHitSound()
	self.Owner:EmitSound("physics/body/body_medium_impact_hard"..math.random(6)..".wav", 70, math.random(110, 120))
end

function SWEP:PlayMissSound()
	self.Owner:EmitSound("npc/zombie/claw_miss"..math.random(2)..".wav", 70, math.random(90, 100))
end

function SWEP:IsInAttackAnim()
	return self:GetAttackAnimTime() > 0 and CurTime() < self:GetAttackAnimTime()
end

if not CLIENT then return end

function SWEP:PreDrawViewModel(vm)
	return true
end
