AddCSLuaFile()

-- Tiny optimization

SWEP.Base = "weapon_zs_fastzombie"

SWEP.ViewModel = Model("models/weapons/v_fza.mdl")
SWEP.WorldModel = Model("models/weapons/w_crowbar.mdl")
SWEP.PrintName = "Xeno Stalker"
if CLIENT then
	SWEP.ViewModelFOV = 70
end

SWEP.MeleeDelay = 0
SWEP.MeleeReach = 40
SWEP.MeleeDamage = 29
SWEP.MeleeForceScale = 0.2
SWEP.MeleeSize = 1.5
SWEP.MeleeDamageType = DMG_SLASH
SWEP.Primary.Delay = 0.7

SWEP.PounceDamage = 1 --SWEP.PounceDamage = 10
SWEP.PounceDamageType = DMG_IMPACT
SWEP.PounceReach = 26
SWEP.PounceSize = 12
SWEP.PounceStartDelay = 0.5
SWEP.PounceDelay = 1.25
SWEP.PounceVelocity = 700

SWEP.RoarTime = 1.6

SWEP.Secondary.Automatic = false

SWEP.NextClimbSound = 0
SWEP.NextAllowPounce = 0
SWEP.NextTraitCheck = 0
SWEP.FastClimb = false
SWEP.PlusForce = false

function SWEP:PlayHitSound()
    self.Owner:EmitSound("NPC_FastZombie.AttackHit", 60, 160)
end

function SWEP:PlayMissSound()
    self.Owner:EmitSound("NPC_FastZombie.AttackMiss", 60, 160)
end

function SWEP:PlayIdleSound()
    self.Owner:EmitSound("NPC_FastZombie.AlertFar", 60, 160)
    self:SetRoarEndTime(CurTime() + self.RoarTime)
end

function SWEP:PlayAlertSound()
    self.Owner:EmitSound("NPC_FastZombie.Frenzy", 60, 160)
    self:SetRoarEndTime(CurTime() + self.RoarTime)
end

function SWEP:StartSwingingSound()
    self.Owner:EmitSound("NPC_FastZombie.Gurgle", 60, 160)
end

function SWEP:StopSwingingSound()
    self.Owner:StopSound("NPC_FastZombie.Gurgle")
end