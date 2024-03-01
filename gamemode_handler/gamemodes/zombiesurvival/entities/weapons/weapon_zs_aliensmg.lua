AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Alien SMG"
	SWEP.Description = "Launches acidic projectiles that have a chance to remove damage resistance"

	SWEP.Slot = 4
	SWEP.SlotPos = 0
	
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 75

	SWEP.HUD3DBone = "ValveBiped.base"
	SWEP.HUD3DPos = Vector(3.1, 0.25, -2)
	SWEP.HUD3DScale = 0.015

	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/minic23/xcom2/alien/alien_shotgun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.061, 0.93, -1.871), angle = Angle(178.951, -100.668, -3.977), size = Vector(0.941, 0.941, 0.941), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/cw2/weapons/w_james_p99.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(11.347, 1.593, -0.396), angle = Angle(0, -16.15, -180), size = Vector(0.763, 0.763, 0.763), color = Color(0, 0, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	

	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/minic23/xcom2/alien/alien_shotgun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.052, 0.875, -2.369), angle = Angle(166.652, -88.358, 1.623), size = Vector(0.967, 0.967, 0.967), color = Color(0, 0, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/cw2/weapons/w_ghosts_p226.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.594, 5.71, -3.932), angle = Angle(0, 4.452, -81.233), size = Vector(1.006, 1.006, 1.006), color = Color(0, 0, 0, 255), surpresslightning = true, material = "custommapping/gridmap", skin = 0, bodygroup = {} }
	}
	
	
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "physgun"
SWEP.Primary.Automatic = true 
SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/minic23/xcom2/alien/alien_shotgun.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = false 
SWEP.ShowWorldModel = false 
SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("")
SWEP.Primary.Damage = 109

SWEP.Primary.Delay = 0.15

SWEP.Primary.ClipSize = 80
SWEP.Primary.DefaultClip = 180
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
	util.Effect("aliensmg", e)

	GenericBulletCallback(attacker, tr, dmginfo)
end

function SWEP:EmitFireSound()
	self:EmitSound("weapons/shotgun/shotgun_fire6.wav", 70, 180, 0.7, CHAN_WEAPON + 20)
	self:EmitSound("weapons/crossbow/bolt_skewer1.wav", 70, 243, 0.7, CHAN_WEAPON + 21)
end
