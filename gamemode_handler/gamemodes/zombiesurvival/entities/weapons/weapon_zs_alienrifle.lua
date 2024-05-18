AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Alien Rifle"
	SWEP.Description = ""

	SWEP.Slot = 4
	SWEP.SlotPos = 0
	
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 75

	SWEP.HUD3DBone = "ValveBiped.base"
	SWEP.HUD3DPos = Vector(3.1, 0.25, -2)
	SWEP.HUD3DScale = 0.015

	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/minic23/xcom2/alien/alien_rifle.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.061, 0.93, -1.871), angle = Angle(178.951, -100.668, -3.977), size = Vector(0.941, 0.941, 0.941), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/cw2/weapons/w_james_p99.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10.895, 1.592, -0.152), angle = Angle(0, -16.15, -180), size = Vector(0.763, 0.763, 0.763), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	

	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/minic23/xcom2/alien/alien_rifle.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.854, 0.652, -2.161), angle = Angle(180, -92.258, 1.623), size = Vector(1.032, 1.032, 1.032), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	
	
	
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "smg"
SWEP.Primary.Automatic = true 
SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/minic23/xcom2/alien/alien_rifle.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = false 
SWEP.ShowWorldModel = false 
SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("")

SWEP.Primary.Delay = 0.17
SWEP.Primary.Damage = 145
SWEP.Primary.ClipSize = 50
SWEP.Primary.DefaultClip = 150
SWEP.Primary.Ammo = "Pulse"
SWEP.RequiredClip = 5

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.NoMagazine = true

SWEP.ConeMax = 0.005
SWEP.ConeMin = 0.005

SWEP.IronSightsPos = Vector(1.95, 3, 2.75)
SWEP.IronSightsAng = Vector(-0.15, -1, 2)


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
	
		local effectdata = EffectData()
		local distance = tr.HitPos:Distance(bullet.Src)
		for i = 0, 1, 0.1 do 
			effectdata:SetOrigin(bullet.Src + bullet.Dir * distance * i)
			util.Effect("alienrifle", effectdata)
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
	util.Effect("alienrifle", e)

	GenericBulletCallback(attacker, tr, dmginfo)
end

function SWEP:EmitFireSound()
	self:EmitSound("weapons/crossbow/fire1.wav", 70, 200, 0.7, CHAN_WEAPON + 20)
	self:EmitSound("physics/metal/metal_box_impact_bullet3.wav", 70, 145, 0.7, CHAN_WEAPON + 21)
end
