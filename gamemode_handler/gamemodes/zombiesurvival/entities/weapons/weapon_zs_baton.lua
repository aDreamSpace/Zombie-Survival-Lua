AddCSLuaFile()
if CLIENT then
	SWEP.PrintName = "'Bloodhound' Baton"
	SWEP.ViewModelFOV = 60
	SWEP.Description = "Although very weak compared to the other weapons, this baton\nhas the ability to grow more powerful the more it hits zombies."
	SWEP.ViewModelBoneMods = {

		["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(-6, 1, 3), angle = Angle(0, 0, 0) }

	}

end

SWEP.Base = "weapon_zs_basemelee"
SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/weapons/w_stunbaton.mdl"
SWEP.UseHands = true

SWEP.HoldType = "melee"
SWEP.IsBluntWeapon = true
SWEP.NoDamageBonuses = true

SWEP.MeleeDamage = 1
SWEP.DefaultDamage = 1
SWEP.MeleeRange = 65
SWEP.MeleeSize = 1.5
SWEP.Primary.Delay = 0.3
SWEP.MaxDamage = 1500

-- The player has to get a total of (MaxDamage - DefaultDamge) * 3 hits to get the max power
SWEP.SwingTime = 0.17
SWEP.SwingRotation = Angle(60, 0, 0)
SWEP.SwingOffset = Vector(0, -50, 0)
SWEP.SwingHoldType = "grenade"

function SWEP:AddBatonHits(amt)
    self.Owner.BatonHits = (self.Owner.BatonHits or 0) + amt
end

function SWEP:PlaySwingSound()
	self:EmitSound("Weapon_StunStick.Swing")
end

function SWEP:PlayHitSound()
	self:EmitSound("Weapon_StunStick.Melee_HitWorld")
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("Weapon_StunStick.Melee_Hit")
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	if self.Owner.BatonHits then
		self.MeleeDamage = math.max(self.DefaultDamage, math.min(self.DefaultDamage + ((self.Owner.BatonHits or 0) / 3), self.MaxDamage))
	end

	if self.SwingTime == 0 then
		self:MeleeSwing()
	else
		self:StartSwinging()
	end
end

if SERVER then
    function SWEP:OnMeleeHit(hitent, hitflesh, tr)
        if hitent:IsNPC() or (hitent:IsPlayer() and hitent:Team() == TEAM_UNDEAD) then
            self:AddBatonHits(2)
        end
    end
end

if CLIENT then
	local texGradDown = surface.GetTextureID("VGUI/gradient_down")
	local colBarEmpty = Color(255, 0, 0, 200)
	local colBarFull = Color(0, 255, 0, 200)
	local colBar = Color(255, 0, 0, 200)

	function SWEP:DrawHUD()
		if GetConVarNumber("crosshair") ~= 1 then return end
		self:DrawCrosshairDot()
	
		local screenscale = BetterScreenScale()
		local wid, hei = 256, 16
		local x, y = ScrW() - wid - 96, ScrH() - hei - 72
		surface.SetFont("ZSHUDFontSmall")
		local tw, th = surface.GetTextSize("Power")
		local texty = y - 4 - th
	
		surface.SetDrawColor(5, 5, 5, 180)
	
		surface.DrawRect(x, y, wid, hei)
	
		local power = (self.MaxDamage - (self.DefaultDamage or 0)) * 3
		local frac = math.min(1, math.max(1, self.Owner.BatonHits or 0) / power)
	
		local colBarEmpty = Color(255, 0, 0, 200)
		local colBarFull = Color(0, 255, 0, 200)
		local colBar = Color(255, 0, 0, 200)
	
		colBar.r = math.Approach(colBarEmpty.r, colBarFull.r, math.abs(colBarEmpty.r - colBarFull.r) * frac)
		colBar.g = math.Approach(colBarEmpty.g, colBarFull.g, math.abs(colBarEmpty.g - colBarFull.g) * frac)
		colBar.b = math.Approach(colBarEmpty.b, colBarFull.b, math.abs(colBarEmpty.b - colBarFull.b) * frac)
	
		surface.SetDrawColor(colBar)
		surface.SetTexture(texGradDown)
		surface.DrawTexturedRect(x, y, wid * frac , hei)
	
		draw.SimpleText("Power", "ZSHUDFontSmall", x, texty, COLOR_GREEN, TEXT_ALIGN_LEFT)
	end
end

function SWEP:MeleeSwing()
	local owner = self.Owner
	owner:DoAttackEvent()
	local filter = owner:GetMeleeFilter()
	--owner:LagCompensation(true)
	local tr = owner:ClipHullMeleeTrace(self.MeleeRange, self.MeleeSize, filter)
	--local tr = owner:CompensatedMeleeTrace(self.MeleeRange, self.MeleeSize)

	if tr.Hit then
		local damage = self.MeleeDamage * (owner.HumanMeleeDamageMultiplier or 1)

		local hitent = tr.Entity
		local hitflesh = tr.MatType == MAT_FLESH or tr.MatType == MAT_BLOODYFLESH or tr.MatType == MAT_ANTLION or tr.MatType == MAT_ALIENFLESH

		if self.HitAnim then
			self:SendWeaponAnim(self.HitAnim)
		end

		self.IdleAnimation = CurTime() + self:SequenceDuration()

		if hitflesh then
			self:PlayHitFleshSound()
			if not self.NoHitSoundFlesh then
				self:PlayHitSound()
			end

			if SERVER and not (hitent:IsValid() and hitent:IsPlayer() and hitent:Team() == owner:Team()) then
				util.Blood(tr.HitPos, math.Rand(damage * 0.01, damage * 0.01), (tr.HitPos - owner:GetShootPos()):GetNormalized(), math.Rand(damage * 6, damage * 12), true)
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
			if hitent:GetClass() == "func_breakable_surf" then
				hitent:Fire("break", "", 0)
			else
				local dmginfo = DamageInfo()
				dmginfo:SetDamagePosition(tr.HitPos)
				dmginfo:SetDamage(damage)
				dmginfo:SetAttacker(owner)
				dmginfo:SetInflictor(self)
				dmginfo:SetDamageType(self.DamageType)
				dmginfo:SetDamageForce(self.MeleeDamage * 200 * owner:GetAimVector())

				if hitent:IsPlayer() then
					hitent:MeleeViewPunch(damage)
					gamemode.Call("ScalePlayerDamage", hitent, tr.HitGroup, dmginfo, true, true)
					if self.MeleeKnockBack > 0 then
						hitent:ThrowFromPositionSetZ(tr.HitPos, self.MeleeKnockBack, nil, true)
					end
				end
				hitent:TakeDamageInfo(dmginfo)

				local phys = hitent:GetPhysicsObject()

				if hitent:GetMoveType() == MOVETYPE_VPHYSICS and phys:IsValid() and phys:IsMoveable() then
					hitent:SetPhysicsAttacker(owner)
				end
			end
		end

		if self.PostOnMeleeHit then self:PostOnMeleeHit(hitent, hitflesh, tr) end

		if CLIENT then
			local tr2 = owner:DoubleTrace(self.MeleeRange, MASK_SHOT, self.MeleeSize, filter)
			if tr2.HitPos == tr.HitPos then
				owner:FireBullets({Num = 1, Src = owner:GetShootPos(), Dir = (tr2.HitPos - owner:GetShootPos()):GetNormal(), Spread = Vector(0, 0, 0), Tracer = 0, Force = self.MeleeDamage * 200, Damage = damage, HullSize = self.MeleeSize * 2})
			end
		end
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

