AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Lamp"

	SWEP.ViewModelFOV = 65
	SWEP.ViewModelFlip = false

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props_interiors/Furniture_Lamp01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 1.85, -8), angle = Angle(183, 0, 2), size = Vector(1.5, 1.5, 1.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props_interiors/Furniture_Lamp01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.837, 1.638, -10), angle = Angle(180, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/props_interiors/Furniture_Lamp01a.mdl"
SWEP.UseHands = true

SWEP.HoldType = "melee2"

SWEP.DamageType = DMG_CLUB

SWEP.MeleeDamage = 75
SWEP.MeleeRange = 85
SWEP.MeleeSize = 2

SWEP.Primary.Delay = 1

SWEP.WalkSpeed = SPEED_FASTEST

SWEP.SwingRotation = Angle(0, -90, -60)
SWEP.SwingOffset = Vector(0, 30, -40)
SWEP.SwingTime = 1
SWEP.SwingHoldType = "melee"

function SWEP:MeleeSwing()
	local owner = self.Owner

	owner:DoAttackEvent()

	local filter = owner:GetMeleeFilter()

	--owner:LagCompensation(true)

	local tr = owner:ClipHullMeleeTrace(self.MeleeRange, self.MeleeSize, filter)
	if tr.Hit then
		local damagemultiplier = (owner.BuffMuscular and owner:Team()==TEAM_HUMAN) and 1.2 or 1
		local damage = self.MeleeDamage * damagemultiplier
		local hitent = tr.Entity
		local hitflesh = tr.MatType == MAT_FLESH or tr.MatType == MAT_BLOODYFLESH or tr.MatType == MAT_ANTLION or tr.MatType == MAT_ALIENFLESH

		if self.HitAnim then
			self:SendWeaponAnim(self.HitAnim)
		end
		self.IdleAnimation = CurTime() + self:SequenceDuration()

		if hitflesh then
			util.Decal(self.BloodDecal, tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
			self:PlayHitFleshSound()
			if SERVER and not (hitent:IsValid() and hitent:IsPlayer() and hitent:Team() == owner:Team()) then
				util.Blood(tr.HitPos, math.Rand(damage * 0.25, damage * 0.6), (tr.HitPos - owner:GetShootPos()):GetNormalized(), math.Rand(damage * 6, damage * 12), true)
			end
			if not self.NoHitSoundFlesh then
				self:PlayHitSound()
			end
		else
			util.Decal(self.HitDecal, tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
			self:PlayHitSound()
		end

		if self.OnMeleeHit and self:OnMeleeHit(hitent, hitflesh, tr) then
			--owner:LagCompensation(false)
			return
		end

		if SERVER and hitent:IsValid() then
			damage = self.MeleeDamage * damagemultiplier

			if hitent:GetClass() == "func_breakable_surf" then
				hitent:Fire("break", "", 0.01) -- Delayed because no way to do prediction.
			else
				local dmginfo = DamageInfo()
				dmginfo:SetDamagePosition(tr.HitPos)
				dmginfo:SetDamage(damage)
				dmginfo:SetAttacker(owner)
				dmginfo:SetInflictor(self)
				dmginfo:SetDamageType(self.DamageType)
				if hitent:IsPlayer() then
					hitent:MeleeViewPunch(damage)
					if hitent:IsHeadcrab() then
						damage = damage * 2
						dmginfo:SetDamage(damage)
					end
					gamemode.Call("ScalePlayerDamage", hitent, tr.HitGroup, dmginfo)

					if self.MeleeKnockBack > 0 then
						hitent:ThrowFromPositionSetZ(tr.HitPos, self.MeleeKnockBack, nil, true)
					end
					if hitent:IsPlayer() and hitent:WouldDieFrom(damage, dmginfo:GetDamagePosition()) then
						dmginfo:SetDamageForce(math.min(self.MeleeDamage, 50) * 400 * owner:GetAimVector())
					end
				end

				if hitent:IsPlayer() then
					SHADEFLASHLIGHTDAMAGE = true
					hitent:TakeDamageInfo(dmginfo)
					SHADEFLASHLIGHTDAMAGE = false
					
				else
					-- Again, no way to do prediction.
					timer.Simple(0, function()
						if hitent:IsValid() then
							-- Workaround for propbroken not calling.
							local h = hitent:Health()

							hitent:TakeDamageInfo(dmginfo)

							if hitent:Health() <= 0 and h ~= hitent:Health() then
								gamemode.Call("PropBroken", hitent, owner)
							end

							local phys = hitent:GetPhysicsObject()
							if hitent:GetMoveType() == MOVETYPE_VPHYSICS and phys:IsValid() and phys:IsMoveable() then
								hitent:SetPhysicsAttacker(owner)
							end
						end
					end)
				end
			end
		end

		if self.PostOnMeleeHit then self:PostOnMeleeHit(hitent, hitflesh, tr) end
	else
		if self.MissAnim then
			self:SendWeaponAnim(self.MissAnim)
		end
		self.IdleAnimation = CurTime() + self:SequenceDuration()
		self:PlaySwingSound()

		if self.PostOnMeleeMiss then self:PostOnMeleeMiss(tr) end
	end

	--owner:LagCompensation(false)
end

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 80, math.Rand(65, 70))
end

function SWEP:PlayHitSound()
	self:EmitSound("physics/metal/metal_solid_impact_hard"..math.random(4, 5)..".wav")
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav")
end
