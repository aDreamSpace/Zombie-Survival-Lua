
-----------------------------------------------------
AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Nuclear Plank"

	SWEP.ViewModelFOV = 55
	SWEP.ViewModelFlip = false

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props_debris/wood_chunk03a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.363, 1.363, -11.365), angle = Angle(180, 90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base2"] = { type = "Model", model = "models/props_c17/oildrum001_explosive.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.70365, 2.501825, -25), angle = Angle(180, 90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props_debris/wood_chunk03a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.273, 1.363, -12.273), angle = Angle(180, 90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base2"] = { type = "Model", model = "models/props_c17/oildrum001_explosive.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.70365, 2.501825, -25), angle = Angle(180, 90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.DamageType = DMG_CLUB

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/props_debris/wood_chunk03a.mdl"
SWEP.ModelScale = 0.5
SWEP.UseHands = true
SWEP.BoxPhysicsMin = Vector(-0.5764, -2.397225, -20.080572) * SWEP.ModelScale
SWEP.BoxPhysicsMax = Vector(0.70365, 2.501825, 19.973375) * SWEP.ModelScale

SWEP.MeleeDamage = 415
SWEP.MeleeRange = 48
SWEP.MeleeSize = 0.475
SWEP.Primary.Delay = 0.5

SWEP.WalkSpeed = SPEED_FASTEST

SWEP.UseMelee1 = true

SWEP.HitGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
SWEP.MissGesture = SWEP.HitGesture

SWEP.ChargeTime = 2.5

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/knife/knife_slash"..math.random(2)..".wav")
end

function SWEP:PlayHitSound()
	self:EmitSound("physics/wood/wood_plank_impact_hard"..math.random(5)..".wav")
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/flesh/flesh_impact_bullet"..math.random(5)..".wav")
end

function SWEP:PostOnMeleeHit(hitent, hitflesh, tr)
	if tr and tr.HitPos then
		local effectdata = EffectData()
			effectdata:SetOrigin(tr.HitPos)
			util.Effect("ManhackSparks", effectdata)
	end
end

local function explode(owner, wep)
	if not (owner and owner:IsValid() and owner:Team() == TEAM_HUMAN) then
		return
	end
	if not (wep and wep:IsValid()) then
		owner:Kill()
		return
	end
	
	local pos = owner:WorldSpaceCenter()
	
	owner:GodDisable()
	owner:Freeze(false)
	owner:TakeDamage(1000, owner, wep)
	
	local entities, ent = ents.FindInSphere(pos, 500)
	for i=1, #entities do
		ent = entities[i]
		if ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_UNDEAD then
			ent:TakeDamage(1000, owner, wep)
		end
	end
	--util.BlastDamage2(wep, owner, pos, 280, 1000)
	
	local effectdata = EffectData()
	effectdata:SetOrigin(pos)
	util.Effect("ManhackSparks", effectdata)
end

function SWEP:SecondaryAttack()
	local owner = self.Owner
	if not self.explode then
		self.explode = true
		if IsFirstTimePredicted() then
			owner:EmitSound("zombiesurvival/im_ya_man.wav")
			timer.Simple(1, function() owner:EmitSound("zombiesurvival/allahuakbar.wav") end)
		end
		--this is awful, but i'm lazy
		if SERVER then timer.Simple(self.ChargeTime, function() explode(owner, self) end) end
	end
end
