AddCSLuaFile()


if CLIENT then
	SWEP.PrintName = "Bio Blaster"

end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "shotgun"
SWEP.Primary.Automatic = true 
SWEP.ViewModel = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = false 
SWEP.ShowWorldModel = false 
SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("") 
SWEP.Primary.Damage = 20
SWEP.Primary.Delay = 0.25

SWEP.Primary.ClipSize = 999999
SWEP.Primary.DefaultClip = 999999
SWEP.Primary.Ammo = ""
SWEP.RequiredClip = 0

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.NoMagazine = true

SWEP.ConeMax = 0
SWEP.ConeMin = 0

SWEP.IronSightsPos = Vector(1.95, 3, 2.75)
SWEP.IronSightsAng = Vector(-0.15, -1, 2)

SWEP.Primary.Cooldown = 3 -- Cooldown duration in seconds
SWEP.Primary.BulletsBeforeCooldown = 10 -- Number of bullets before cooldown

function SWEP:Initialize()
    self.BaseClass.Initialize(self)
    self.BulletsFired = 0 -- Initialize bullets fired counter
end

function SWEP:PrimaryAttack()
    if not self:CanPrimaryAttack() then return end

    self:EmitFireSound()
    self:ShootBullets(self.Primary.Damage, self.Primary.NumShots, self:GetCone())
    self.IdleAnimation = CurTime() + self:SequenceDuration()

    self.BulletsFired = self.BulletsFired or 0 -- Ensure BulletsFired is initialized
    self.BulletsFired = self.BulletsFired + 1 -- Increment bullets fired counter

    if self.BulletsFired >= self.Primary.BulletsBeforeCooldown then
        self:SetNextPrimaryFire(CurTime() + self.Primary.Cooldown)
        self.BulletsFired = 0 -- Reset bullets fired counter
    else
        self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    end
end

function SWEP:ShootBullets(dmg, numbul, cone)
    local bullet = {}
    bullet.Num = numbul
    bullet.Src = self.Owner:GetShootPos()
    bullet.Dir = self.Owner:GetAimVector()
    bullet.Spread = Vector(cone, cone, 0)
    bullet.Tracer = 0
    bullet.Force = 10
    bullet.Damage = dmg
    bullet.Callback = function(attacker, tr, dmginfo)
        self.BulletCallback(attacker, tr, dmginfo)
    
        -- Create multiple "bioblaster" effects along the bullet's path
        local effectdata = EffectData()
        for i = 0, 1, 0.01 do -- Decrease the step size to create more effects
            effectdata:SetOrigin(bullet.Src + bullet.Dir * tr.HitPos:Distance(bullet.Src) * i)
            util.Effect("bioblaster", effectdata)
        end
    end

    self.Owner:FireBullets(bullet)

    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self.Owner:MuzzleFlash()
    self.Owner:SetAnimation(PLAYER_ATTACK1)

    if not self.Primary.Automatic then
        self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    end
end

function SWEP.BulletCallback(attacker, tr, dmginfo)
	local ent = tr.Entity
	if ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_UNDEAD then
		ent:AddLegDamage(8)
	end
	
	local e = EffectData()
		e:SetOrigin(tr.HitPos)
		e:SetNormal(tr.HitNormal)
		e:SetRadius(8)
		e:SetMagnitude(1)
		e:SetScale(1)
	util.Effect("bioblaster", e)

	GenericBulletCallback(attacker, tr, dmginfo)
end

function SWEP:EmitFireSound()
	self:EmitSound("npc/barnacle/barnacle_die2.wav")
	self:EmitSound("npc/barnacle/barnacle_digesting1.wav")
	self:EmitSound("npc/barnacle/barnacle_digesting2.wav")
end

function SWEP:DoImpactEffect( tr, nDamageType )

	return true 

end