AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Simon"

	SWEP.ViewModelFOV = 80
	SWEP.ViewModelFlip = false

	SWEP.ShowWorldModel = false
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/tiggomods/weapons/DmC5/w_osiris.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/tiggomods/weapons/DmC5/v_osiris.mdl"
SWEP.WorldModel = "models/tiggomods/weapons/DmC5/w_osiris.mdl"

SWEP.HoldType = "melee2"

SWEP.MeleeDamage = 200
SWEP.MeleeRange = 600
SWEP.Primary.Delay = 0
SWEP.MeleeSize = 0
SWEP.MeleeKnockBack = 0

SWEP.WalkSpeed = SPEED_FASTEST

SWEP.SwingTime = 0
SWEP.SwingRotation = Angle(0, -20, -40)
SWEP.SwingOffset = Vector(10, 0, 0)
SWEP.SwingHoldType = "melee"

SWEP.HitDecal = "Manhackcut"
SWEP.Undroppable = true

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/tiggomods/DmC5/Osiris/sound1.wav", 75, math.random(65, 70))
end

function SWEP:PlayHitSound()
	self:EmitSound("weapons/tiggomods/DmC5/hitwall1.wav")
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("weapons/tiggomods/DmC5/hitwall1.wav")
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if hitent:IsPlayer() and hitent:Team() == TEAM_ZOMBIE and self.MeleeDamage >= hitent:Health() then
		local owner = self.Owner
		owner:SetHealth(math.min(owner:GetMaxHealth(), owner:Health()+8))
		self:EmitSound("zombiesurvival/wraithdeath"..math.random(4)..".ogg", 100, math.random(30, 100), 1, CHAN_ITEM)
	end
end

function SWEP:SecondaryAttack()
	if CurTime() >  self:GetNextSecondaryFire() then
		self:SetNextSecondaryFire(CurTime() + 45)
		self:EmitSound("zombiesurvival/wraithdeath"..math.random(4)..".ogg", 100, math.random(30, 100))
	end 
end