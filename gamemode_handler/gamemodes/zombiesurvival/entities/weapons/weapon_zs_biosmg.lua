AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Bio Sub-Machine Gun"
	SWEP.Description = "Launches acidic projectiles that have a chance to remove damage resistance"

	SWEP.Slot = 4
	SWEP.SlotPos = 0
	
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 75

	SWEP.HUD3DBone = "ValveBiped.base"
	SWEP.HUD3DPos = Vector(3.1, 0.25, -2)
	SWEP.HUD3DScale = 0.015

	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/minic23/xcom2/xcom/v2/xcom_beamsmg.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.543, 1.636, -1.895), angle = Angle(0, 80.578, -180), size = Vector(0.83, 0.83, 0.83), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	

	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/minic23/xcom2/xcom/v2/xcom_beamsmg.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(11.508, 0.912, -3.297), angle = Angle(0, 88.228, 178.819), size = Vector(1.032, 1.032, 1.032), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	
	
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "smg"
SWEP.Primary.Automatic = true 
SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/minic23/xcom2/xcom/v2/xcom_beamsmg.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = false 
SWEP.ShowWorldModel = false 
SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("")
SWEP.Primary.Damage = 90
SWEP.Primary.Delay = 0.15

SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 350
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
			util.Effect("biosmg", effectdata)
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
	util.Effect("biosmg", e)

	GenericBulletCallback(attacker, tr, dmginfo)
end


function SWEP:EmitFireSound(secondary)
	self:EmitSound("weapons/crossbow/bolt_skewer1.wav", 70, 243, 0.7, CHAN_WEAPON + 21)
	--self:EmitSound("npc/scanner/combat_scan1.wav", 70, 80, 0.7, CHAN_WEAPON + 20)
end
