AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Bio Pistol"
	SWEP.Description = "Launches acidic projectiles that have a chance to remove damage resistance"

	SWEP.Slot = 4
	SWEP.SlotPos = 0
	
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 64

	SWEP.HUD3DBone = "ValveBiped.square"
	SWEP.HUD3DPos = Vector(3.1, 0.25, -2)
	SWEP.HUD3DScale = 0.015

SWEP.VElements = {
	["base"] = { type = "Model", model = "models/minic23/xcom2/xcom/v2/xcom_beamgun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.57, 0.749, -6.225), angle = Angle(0, -92.32, -1.221), size = Vector(0.583, 0.583, 0.583), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


SWEP.WElements = {
	["base"] = { type = "Model", model = "models/minic23/xcom2/xcom/v2/xcom_beamgun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.772, 2.209, -7.426), angle = Angle(0, -95.036, -7.952), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "pistol"
SWEP.Primary.Automatic = true 
SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/minic23/xcom2/xcom/v2/xcom_beamgun.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = false 
SWEP.ShowWorldModel = false 
SWEP.Primary.Damage = 94
SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_Pistol.Reload")

SWEP.Primary.Delay = 0.29

SWEP.Primary.ClipSize = 40
SWEP.Primary.DefaultClip = 150
SWEP.Primary.Ammo = "Pulse"
SWEP.RequiredClip = 5

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.NoMagazine = true

SWEP.ConeMax = 0.005
SWEP.ConeMin = 0.005

SWEP.IronSightsPos = Vector(1.25, 3, 2.75)
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
	util.Effect("biopistol", e)

	GenericBulletCallback(attacker, tr, dmginfo)
end

function SWEP:EmitFireSound()
	self:EmitSound("^weapons/mortar/mortar_fire1.wav", 70, math.random(88, 92), 0.65)
	self:EmitSound("npc/barnacle/barnacle_gulp2.wav", 70, 70, 0.85, CHAN_AUTO + 20)
end
