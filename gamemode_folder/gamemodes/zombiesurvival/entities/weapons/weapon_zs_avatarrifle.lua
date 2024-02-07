AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Avatar Rifle"
	SWEP.Description = "Launches acidic projectiles that have a chance to remove damage resistance"

	SWEP.Slot = 4
	SWEP.SlotPos = 0
	
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 75

	SWEP.HUD3DBone = "ValveBiped.base"
	SWEP.HUD3DPos = Vector(3.1, 0.25, -2)
	SWEP.HUD3DScale = 0.015

	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/minic23/xcom2/advent/avatar_rifle.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.184, 1.613, -1.571), angle = Angle(4.493, 76.515, 180), size = Vector(0.958, 0.958, 0.958), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/minic23/xcom2/alien/alien_pistol_sectoid.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12.567, 3.293, 1.12), angle = Angle(0, 68.716, -85.103), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	

	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/minic23/xcom2/advent/avatar_rifle.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.545, 1.113, -3.435), angle = Angle(-3.422, 84.003, -169.545), size = Vector(0.816, 0.816, 0.816), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	
	
	
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"
SWEP.Primary.Automatic = true 
SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/minic23/xcom2/advent/avatar_rifle.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = false 
SWEP.ShowWorldModel = false 
SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("")

SWEP.Primary.Delay = 0.2
SWEP.Primary.Damage = 500
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
	util.Effect("avatarrifle", e)

	GenericBulletCallback(attacker, tr, dmginfo)
end


function SWEP:EmitFireSound()

	self:EmitSound("weapons/physcannon/energy_sing_flyby2.wav", 70, 120, 0.7, CHAN_WEAPON + 20)
	self:EmitSound("ambient/levels/labs/electric_explosion5.wav", 70, 210, 0.7, CHAN_WEAPON + 20)

end
