AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Juggernaut"
	SWEP.ViewModelFOV = 75
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.HoldType = "melee2"

SWEP.DamageType = DMG_CLUB

SWEP.ViewModel = "models/weapons/v_sledgehammer/v_sledgehammer.mdl"
SWEP.WorldModel = "models/weapons/w_sledgehammer.mdl"
SWEP.AlertDelay = 3.2
SWEP.MeleeDamage = 750
SWEP.MeleeRange = 70
SWEP.MeleeSize = 1.75
SWEP.MeleeKnockBack = 70
SWEP.BattlecryInterval = 0
SWEP.StaminaUse = 18

SWEP.Primary.Delay = 1
SWEP.HowlDelay = 3
SWEP.WalkSpeed = SPEED_SLOWEST

SWEP.SwingRotation = Angle(60, 0, -80)
SWEP.SwingOffset = Vector(0, -30, 0)
SWEP.SwingTime = 0.75
SWEP.SwingHoldType = "melee"

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(35, 45))
end

function SWEP:PlayAttackSound()
	self:GetOwner():EmitSound("npc/antlion_guard/angry"..math.random(3)..".wav", 75, math.random(50, 75))
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav", 75, math.Rand(86, 90))
end


function SWEP:SetSwingAnimTime(time)
	self:SetDTFloat(3, time)
end

function SWEP:GetSwingAnimTime()
	return self:GetDTFloat(3)
end

function SWEP:StartSwinging()
	self.BaseClass.StartSwinging(self)
	self:SetSwingAnimTime(CurTime() + 1)
end

function SWEP:PrimaryAttack()
	if self.Owner:IsOnGround() then self.BaseClass.PrimaryAttack(self) end
end


function SWEP:Reload()
	self.BaseClass.SecondaryAttack(self)
end

local function DoFleshThrow(pl, wep)
	if pl:IsValid() and pl:Alive() and wep:IsValid() then
		pl:ResetSpeed()

		local startpos = pl:GetPos()
		startpos.z = pl:GetShootPos().z
		local heading = pl:GetAimVector()

		local ent = ents.Create("projectile_corgasgrenade")
		if ent:IsValid() then
			ent:SetPos(startpos + heading * 8)
			ent:SetAngles(AngleRand())
			ent:SetOwner(pl)
			ent:Spawn()

			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then
				phys:SetVelocityInstantaneous(heading * 300)
				phys:AddAngleVelocity(VectorRand() * 45)
			end
		end

		pl:EmitSound("ambient/levels/citadel/weapon_disintegrate3"..math.random(2, 4)..".wav", 72, math.random(70, 80))

		pl:RawCapLegDamage(CurTime() + 2)
	end
end

local function DoSwing(pl, wep)
	if pl:IsValid() and pl:Alive() and wep:IsValid() then
		pl:EmitSound("ambient/levels/citadel/weapon_disintegrate3.wav", 72, math.random(75, 90))
		if wep.SwapAnims then wep:SendWeaponAnim(ACT_VM_HITCENTER) else wep:SendWeaponAnim(ACT_VM_SECONDARYATTACK) end
		wep.IdleAnimation = CurTime() + wep:SequenceDuration()
		wep.SwapAnims = not wep.SwapAnims
	end
end

function SWEP:SecondaryAttack()
	if CurTime() < self:GetNextPrimaryFire() or CurTime() < self:GetNextSecondaryFire() then return end

	local owner = self.Owner

	self:SetSwingAnimTime(CurTime() + 0)
	self.Owner:DoAnimationEvent(ACT_RANGE_ATTACK2)
	--self.Owner:EmitSound("")
	self.Owner:SetSpeed(310)
	self:SetNextSecondaryFire(CurTime() + 1)
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	timer.Simple(0.3, function() DoSwing(owner, self) end)
	timer.Simple(1, function() DoFleshThrow(owner, self) end)
end



if not CLIENT then return end

function SWEP:ViewModelDrawn()
	render.SetColorModulation(1, 1, 1)
end

function SWEP:PreDrawViewModel(vm)
	render.SetColorModulation(1, 0.9, 0.6)
end
