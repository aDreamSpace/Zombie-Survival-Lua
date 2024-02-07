AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Bio Auto-Cannon"
	SWEP.Description = "Launches acidic projectiles that have a chance to remove damage resistance"

	SWEP.Slot = 4
	SWEP.SlotPos = 0
	
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 68


	SWEP.HUD3DBone = "ValveBiped.base"
	SWEP.HUD3DPos = Vector(3.1, 0.25, -2)
	SWEP.HUD3DScale = 0.015


	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/minic23/xcom2/xcom/v2/xcom_beamshotgun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.177, 1.432, -1.706), angle = Angle(180, -101.015, -0.169), size = Vector(1.024, 1.024, 1.024), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	

	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/minic23/xcom2/xcom/v2/xcom_beamshotgun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.94, 0.851, -0.445), angle = Angle(180, -96.625, 12.701), size = Vector(1.088, 1.088, 1.088), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "shotgun"
SWEP.Primary.Automatic = true 
SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/minic23/xcom2/xcom/v2/xcom_beamshotgun.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = false 
SWEP.ShowWorldModel = false 
SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("") 
SWEP.Primary.Shots = 5
SWEP.Primary.Delay = 0.4

SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 140
SWEP.Primary.Ammo = "Pulse"
SWEP.RequiredClip = 5
SWEP.Primary.Damage = 610
SWEP.WalkSpeed = SPEED_NORMAL

SWEP.NoMagazine = true

SWEP.ConeMax = 0.2
SWEP.ConeMin = 0.01

SWEP.IronSightsPos = Vector(1.95, 3, 2.75)
SWEP.IronSightsAng = Vector(-0.15, -1, 2)


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
	util.Effect("bioar", e)

	GenericBulletCallback(attacker, tr, dmginfo)
end


function SWEP:EmitFireSound()
	self:EmitSound("weapons/crossbow/fire1.wav", 100, 230, 0.9, CHAN_WEAPON)
end
