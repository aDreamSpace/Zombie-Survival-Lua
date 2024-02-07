
SWEP.Author = "Damien"
SWEP.PrintName = "'Gravestone' Stick"

-- Do jack shit

SWEP.UseHands = true

SWEP.HoldType = "melee"
SWEP.ViewModelFOV = 80
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel = "models/props_c17/gravestone_cross001a.mdl"
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false 



SWEP.VElements = {
	["gravestone"] = { type = "Model", model = "models/props_c17/gravestone_cross001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.624, 2.895, -28.659), angle = Angle(180, 180, -5.844), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


SWEP.WElements = {
	["gravestone"] = { type = "Model", model = "models/props_c17/gravestone_cross001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(22.038, -1.015, -32.007), angle = Angle(24.819, -7.127, -180), size = Vector(0.5, 0.5, 0.735), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.Base = "weapon_zs_basemelee"
SWEP.DamageType = DMG_CLUB
SWEP.MeleeRange = 115
SWEP.MeleeSize = 2.5
--SWEP.MeleeKnockBack = 130 unbalanced, affected shades too much

--Damage and Delay
SWEP.MeleeDamage = 1000
SWEP.Primary.Delay = .20

SWEP.WalkSpeed = SPEED_FASTEST

SWEP.UseMelee1 = true

SWEP.StaminaUse = 6

SWEP.HitGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
SWEP.MissGesture = SWEP.HitGesture

SWEP.SwingTime = 0.4

--Do not edit this
function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(35, 45))
end

function SWEP:PlayHitSound()
	self:EmitSound("physics/metal/metal_canister_impact_hard"..math.random(3)..".wav", 75, math.Rand(86, 90))
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav", 75, math.Rand(86, 90))
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if hitent:IsPlayer() and hitent:Team() == TEAM_ZOMBIE and self.MeleeDamage >= hitent:Health() then
		local owner = self.Owner
		self:EmitSound("spiritsounds/exp_hellhound_spirit_"..math.random(5)..".wav", 100, math.random(30, 100), 1, CHAN_VOICE)

		local effectdata = EffectData()
			local eyePos = hitent:EyePos()
			effectdata:SetOrigin(eyePos) 
			effectdata:SetMagnitude(10) 
			effectdata:SetNormal((eyePos-hitent:EyePos()):GetNormalized()) 
			effectdata:SetEntity(hitent) 
		util.Effect("headshot", effectdata, true, true)
	end
end


