AddCSLuaFile()

SWEP.Base = "weapon_zs_zombie"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel	= ""

if CLIENT then
	SWEP.UseHands = true
	SWEP.ViewModelFOV = 75
	SWEP.BobScale = 2
end

SWEP.MeleeReach = 85
SWEP.MeleeDamage = 45
SWEP.MeleeForceScale = 100000000
SWEP.MeleeSize = 5
SWEP.MeleeDamageType = DMG_SLASH
SWEP.Primary.Delay = 1.9
SWEP.Secondary.Delay = 1.6

SWEP.ThrowDelay = 1

AccessorFuncDT(SWEP, "ThrowTime", "Float", 3)

function SWEP:Think()
	self:CheckMeleeAttack()
	self:CheckThrow()
end

function SWEP:ApplyMeleeDamage(ent, trace, damage)
	if ent:IsValid() and ent:IsPlayer() then
		local vel = ent:GetPos() - self.Owner:GetPos()
		vel.z = 0
		vel:Normalize()
		vel = vel * 400
		vel.z = 200

		if ((ent.NextKnockdown or 0) < CurTime()) then
			ent:KnockDown(2)
			ent.NextKnockdown = CurTime() + 6
		end

		ent:SetGroundEntity(NULL)
		ent:SetVelocity(vel)
	end

	self.BaseClass.ApplyMeleeDamage(self, ent, trace, damage)
end

function SWEP:PrimaryAttack()
	if self:IsThrowing() then return end

	self.BaseClass.PrimaryAttack(self)
end

--[[function SWEP:Initialize()
	timer.Simple(0, function()
		if CLIENT then
			local ent = self.Owner:GetHands()
			if IsValid(ent) then
				local mdl = player_manager.TranslateToPlayerModelName("models/player/zombie_Classic.mdl")
				local info = player_manager.TranslatePlayerHands(mdl)
				if info then
					ent:SetModel(info.model)
					ent:SetSkin(info.skin)
					ent:SetBodyGroups(info.body)
				end
			end
		end
	end)

	self.BaseClass.Initialize(self)
end]]

function SWEP:Deploy()
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("fists_draw"))

	return self.BaseClass.Deploy(self)
end

local anims = {"fists_uppercut", "fists_right", "fists_left"}
function SWEP:StartSwinging()
	self.BaseClass.StartSwinging(self)

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence(anims[math.random(#anims)]))
	vm:SetPlaybackRate(0.32)
end

function SWEP:SecondaryAttack()
	if self:IsSwinging() or CurTime() <= self:GetNextSecondaryAttack() or IsValid(self.Owner.FeignDeath) then return end

	self:SetThrowTime(CurTime() + self.ThrowDelay)
	self.Owner:DoReloadEvent() -- Handled in the class file. Fires the throwing anim.

	self:SetNextSecondaryAttack(CurTime() + self.Secondary.Delay)
end

function SWEP:CheckThrow()
	if self:GetThrowing() and CurTime() >= self:GetThrowTime() then
		self:SetThrowTime(0)

		local owner = self.Owner

		owner:EmitSound("weapons/slam/throw.wav", 70, math.random(78, 82))

		if SERVER then
			local ent = ents.Create("prop_thrownbaby")
			if ent:IsValid() then
				ent:SetPos(owner:GetShootPos())
				ent:SetAngles(AngleRand())
				ent:SetOwner(owner)
				ent:Spawn()

				local phys = ent:GetPhysicsObject()
				if phys:IsValid() then
					phys:Wake()
					phys:SetVelocityInstantaneous(owner:GetAimVector() * 500)
					phys:AddAngleVelocity(VectorRand() * math.Rand(200, 300))

					ent:SetPhysicsAttacker(owner)
				end
			end
		end
	end
end

function SWEP:IsThrowing()
	return self:GetThrowTime() > 0
end
SWEP.GetThrowing = SWEP.IsThrowing

function SWEP:Reload()
	self.BaseClass.SecondaryAttack(self)
end

function SWEP:PlayAlertSound()
	self.Owner:EmitSound("ambient/creatures/teddy.wav", 77, 45)
end

function SWEP:PlayIdleSound()
	self.Owner:EmitSound("ambient/creatures/teddy.wav", 77, 60)
end

function SWEP:PlayAttackSound()
	self.Owner:EmitSound("ambient/creatures/teddy.wav", 77, 60)
end

function SWEP:PlayHitSound()
	self.Owner:EmitSound("physics/body/body_medium_impact_hard"..math.random(6)..".wav", 77, math.random(60, 70))
end

function SWEP:PlayMissSound()
	self.Owner:EmitSound("npc/zombie/claw_miss"..math.random(2)..".wav", 77, math.random(60, 70))
end
