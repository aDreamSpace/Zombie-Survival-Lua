
-----------------------------------------------------
AddCSLuaFile()

SWEP.Base = "weapon_zs_cocknballs"

SWEP.ZombieOnly = true
SWEP.MeleeDamage = 25
SWEP.MeleeDamageProp = 2
SWEP.Primary.Delay = 0.4
SWEP.MeleeSize = 4

sound.Add({
	name = "shrek-nado.swamp",
	channel = CHAN_VOICE,
	volume = 1,
	level = 160,
	pitch = { 60, 100 },
	sound = "shreli/ambience/ambience1.ogg"
})
SWEP.moanNoise = Sound("shrek-nado.swamp")

function SWEP:SecondaryAttack()
	self:EmitSound("shreli/taunt/taunt"..math.random(2)..".wav", 75, math.random(95, 105), 1, CHAN_VOICE)
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if hitent:IsPlayer() and hitent:Team() == TEAM_HUMAN and self.MeleeDamage >= hitent:Health() then
		local owner = self.Owner
		
		local effectdata = EffectData()
			local eyePos = hitent:EyePos()
			effectdata:SetOrigin(eyePos) --position of the effect
			effectdata:SetMagnitude(20) --don't know what this does (in headshot.lua it isn't used for anything)
			effectdata:SetNormal((eyePos-hitent:EyePos()):GetNormalized()) --normalized vector pointing from players eyes to zombies eyes
			effectdata:SetEntity(hitent) --le zombie
		util.Effect("headshot", effectdata, true, true)
	end
end

if SERVER then
	SWEP.MoanDelay = 1

	function SWEP:Reload()
		if CurTime() < self:GetNextSecondaryFire() then return end
		self:SetNextSecondaryFire(CurTime() + self.MoanDelay)

		if self:IsMoaning() then
			self:StopMoaning()
		else
			self:StartMoaning()
		end
	end
end

function SWEP:StopMoaningSound()
	self.Owner:StopSound(self.moanNoise)
end

function SWEP:StartMoaningSound()
	self.Owner:EmitSound(self.moanNoise)
end

function SWEP:StopMoaning()
	if not self:IsMoaning() then return end
	self:SetMoaning(false)

	self:StopMoaningSound()
end

function SWEP:StartMoaning()
	if self:IsMoaning() then return end
	self:SetMoaning(true)

	self:StartMoaningSound()
end

function SWEP:OnRemove()
	if IsValid(self.Owner) then
		self:StopMoaning()
	end
end
SWEP.Holster = SWEP.OnRemove

function SWEP:SetMoaning(moaning)
	self:SetDTBool(0, moaning)
end

function SWEP:IsMoaning()
	return self:GetDTBool(0)
end