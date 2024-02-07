AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Executioner's Greatsword"
	SWEP.ViewModelFOV = 60
	SWEP.ViewModelFlip = false
	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.VElements = {
	}
	
	SWEP.VElements = {
	--["Executioner Axe"] = { type = "Model", model = "models/demonssouls/great sword.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.518, 3.635, 0), angle = Angle(-10.52, -8.183, -180), size = Vector(0.56, 0.56, 0.56), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	["sword"] = { type = "Model", model = "models/demonssouls/weapons/great sword.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-2.597, 0.518, -0.519), angle = Angle(-85.325, 68.96, 1.169), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
		
	}

	SWEP.WElements = {
	--["Executioner Axe"] = { type = "Model", model = "models/demonssouls/great sword.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.519, 4.675, 0), angle = Angle(-12.858, -15.195, 180), size = Vector(1.21, 1.21, 1.21), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	["sword"] = { type = "Model", model = "models/demonssouls/weapons/great sword.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.635, 1.557, -1.558), angle = Angle(-82.987, 82.986, 0), size = Vector(1.014, 1.014, 1.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	
	}
end

SWEP.Base = "weapon_zs_basemelee"
SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/demonssouls/weapons/great sword.mdl"
SWEP.UseHands = true

SWEP.HoldType = "melee2"

SWEP.MeleeDamage = 250

SWEP.MeleeRange = 80

SWEP.MeleeSize = 1.5

SWEP.MeleeKnockBack = 32

SWEP.WalkSpeed = SPEED_NORMAL

--SWEP.StaminaUse = 20

SWEP.SwingTime = 0.85

SWEP.SwingRotation = Angle(0, -20, -40)

SWEP.SwingOffset = Vector(10, 0, 0)

SWEP.SwingHoldType = "melee"

SWEP.HitDecal = "Manhackcut"

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/tiggomods/residentevil5/eaxe/axe1.wav", 75, math.random(65, 70))
end

function SWEP:PlayHitSound()
	self:EmitSound("weapons/tiggomods/residentevil5/eaxe/axe2.wav")
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("weapons/tiggomods/residentevil5/eaxe/axe2.wav")
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if hitent:IsPlayer() and hitent:Team() == TEAM_ZOMBIE and self.MeleeDamage >= hitent:Health() then
		local owner = self.Owner
		self:EmitSound("zombiesurvival/wraithdeath"..math.random(4)..".ogg", 100, math.random(30, 100), 1, CHAN_VOICE)

		local effectdata = EffectData()
			local eyePos = hitent:EyePos()
			effectdata:SetOrigin(eyePos) --position of the effect
			effectdata:SetMagnitude(20) --don't know what this does (in headshot.lua it isn't used for anything)
			effectdata:SetNormal((eyePos-hitent:EyePos()):GetNormalized()) --normalized vector pointing from players eyes to zombies eyes
			effectdata:SetEntity(hitent) --le zombie
		util.Effect("headshot", effectdata, true, true)
	end
end

function SWEP:SecondaryAttack()
	if CurTime() >  self:GetNextSecondaryFire() then
		self:SetNextSecondaryFire(CurTime() + 20)
		self:EmitSound("zombiesurvival/wraithdeath"..math.random(4)..".ogg", 100, math.random(30, 100))
	end 
end