AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Bio AR"
	SWEP.Description = "Launches acidic projectiles that have a chance to remove damage resistance"

	SWEP.Slot = 4
	SWEP.SlotPos = 0
	
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 75

	SWEP.HUD3DBone = "ValveBiped.base"
	SWEP.HUD3DPos = Vector(3.1, 0.25, -2)
	SWEP.HUD3DScale = 0.015

	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/minic23/xcom2/xcom/v2/xcom_beamrifle.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.11, 1.457, -0.917), angle = Angle(180, -102.256, 0), size = Vector(1.021, 1.021, 1.021), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	

	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/minic23/xcom2/xcom/v2/xcom_beamrifle.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12.204, 1.169, -2.863), angle = Angle(180, -84.221, 15.59), size = Vector(0.992, 0.992, 0.992), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "smg"
SWEP.Primary.Automatic = true 
SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/minic23/xcom2/xcom/v2/xcom_beamrifle.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = false 
SWEP.ShowWorldModel = false 
SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("")
SWEP.Primary.Damage = 84
SWEP.Primary.Delay = 0.18

SWEP.Primary.ClipSize = 80
SWEP.Primary.DefaultClip = 190
SWEP.Primary.Ammo = "Pulse"
SWEP.RequiredClip = 5

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.NoMagazine = true

SWEP.ConeMax = 0.005
SWEP.ConeMin = 0.005

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
	self:EmitSound("weapons/crossbow/fire1.wav", 70, 180, 0.7, CHAN_WEAPON + 20)
	self:EmitSound("weapons/crossbow/bolt_skewer1.wav", 70, 243, 0.7, CHAN_WEAPON + 21)
end
