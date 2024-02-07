--we should store the infusion effects in a table so they can be called with linear time, even though this is marginal
INFUSION_NONE = 0
INFUSION_FIRE = 1
INFUSION_BLOOD = 2
INFUSION_POISON = 3
INFUSION_SHARP = 4
INFUSION_HEAVY = 5
INFUSION_RAW = 6
INFUSION_CHAOS = 7
INFUSION_BOOM = 8


local tIEffects = {}
tIEffects[INFUSION_FIRE] = function(ent, dmg, this)
	--inflicts flame
	local owner = this:GetOwner()
	if owner and owner:IsValid() then
		local status = ent:GiveStatus("fire")
		if status and status:IsValid() then
			status:AddDamage(dmg)
			status.Damager = owner
		end
	end
end

tIEffects[INFUSION_BLOOD] = function(ent, dmg, this)
	--inflicts bleed
	owner = this:GetOwner()
	if owner and owner:IsValid() then
		local status = ent:GiveStatus("zbleed")
		if status and status:IsValid() then
			status:AddDamage(dmg)
			status.Damager = owner
		end
	end

end

tIEffects[INFUSION_POISON] = function(ent, dmg, this)
	--poison for zombies
	owner = this:GetOwner()
	if owner and owner:IsValid() then
		local status = ent:GiveStatus("zpoison")
		if status and status:IsValid() then
			status:AddDamage(dmg)
			status.Damager = owner
		end
	end
end

local tPen = {
	start = nil,
	endpos = nil,
	filter = nil
}
local function FireAnotherTrace(start, filter, ang, range)
	tPen.start = start
	tPen.endpos = start + ang * range
	tPen.filter = filter
	
	local tr = util.TraceLine(tPen)

	return tr.Entity
end

tIEffects[INFUSION_SHARP] = function(ent, dmg, this)
	--melee weapons penetrate multiple zombies
	--code is similar to the penetration code for bullets
	local owner = this:GetOwner() --ALWAYS cache the owner if we're going to be using it, since indexing this takes a long time
	if owner and owner:IsValid() then
		local ang = owner:GetAimVector()
		local start = owner:GetShootPos()
		local dmgFalloff = this.dmgFalloff or (1/2)
		local pdmg = nil
		local range = this.PrimaryAttackRange or this.SecondaryAttackRange
		local hitEnts = {}
		--lets build a list of all the ents that are in our way
		--we'll run our traces only 10 times since by then our damage will be small enough to not matter
		--I should probably find a better way to do this but this breaks out of it automatically, so that should manage itself
		for i = 1, 10 do
			local ent = FireAnotherTrace(start, hitEnts, ang, range)
			if ent and ent:IsValid() and ent:IsPlayer() then
				table.insert(hitEnts, ent)
			else --as soon as we hit something that isn't a player? stop doing calculations
				break
			end
		end

		--now lets loop through all of our ents and deal damage to all of them
		for i = 1, #hitEnts do
			local ply = hitEnts[i]
			if ply and ply:IsValid() and ply:Team() == TEAM_UNDEAD and ply ~= ent and ply ~= owner then
				pdmg = pdmg or dmg
				pdmg = pdmg * dmgFalloff
				if SERVER then
					ply:TakeDamage(pdmg, owner, this)
				end
			end
		end		
	end
end

tIEffects[INFUSION_HEAVY] = function(ent, dmg, this)
	--melee weapons do substantial knockback
	local iKnockback = math.min(dmg * 1.25, 225)
	ent:SetGroundEntity(NULL)
	ent:ThrowFromPositionSetZ(this:WorldSpaceCenter(), iKnockback, nil, true)
end

--tIEffects[INFUSION_RAW] = function(ent, dmg, this)
	--removes ranged dmg and instead uses an average
--end

tIEffects[INFUSION_CHAOS] = function(ent, dmg, this)
	--more damage is dealt the more points a person has to spend
	local owner = this:GetOwner()
	if owner and owner:IsValid() and owner:IsPlayer() and owner:Team() == TEAM_HUMAN then
		local iDmg = math.min(owner:GetPoints(), 200)
		ent:TakeDamage(iDmg, owner, this)
	end
end

local flRad = 64 ^ 2
tIEffects[INFUSION_BOOM] = function(ent, dmg, this)
	--crafted with explosive barrel + stone
	local owner = this:GetOwner()
	if owner and owner:IsValid() then
		util.BlastDamageHZ(this, owner, ent:WorldSpaceCenter(), flRad, dmg, DMG_GENERIC)

		local effectdata = EffectData()
		effectdata:SetOrigin(ent:WorldSpaceCenter())
		util.Effect("ManhackSparks", effectdata, true, true)
	end
end


--this func is basically used to handle special stuff that attachments will want to add
function SWEP:ApplySpecialEffect(ent, dmg)
	local bIsPlayer = ent and ent:IsValid() and ent:IsPlayer()
	local owner = self:GetOwner()

	if bIsPlayer and owner and owner:IsValid() and owner:Team() == TEAM_HUMAN and owner.WeaponMaster then
		local life = math.ceil(dmg * owner.WeaponMaster)
		local regen = owner:GiveStatus("regen")
		if regen and regen:IsValid() then
			regen:AddLife(life) 
		end
	end

	--process infusions last
	if self.InfusionType and self.InfusionType ~= INFUSION_NONE then
		local fEffect = tIEffects[self.InfusionType]
		if fEffect and bIsPlayer then
			if self.InfusionMult then
				dmg = dmg * self.InfusionDmg
			else
				dmg = self.InfusionDmg
			end

			fEffect(ent, dmg, self)
		end
	end
end

--convienience functions to make setting up damages easy
--only for use with CW Melee
function SWEP:SetPrimaryDamageMult(min, max)
	self.PrimaryAttackDamage_Orig = self.PrimaryAttackDamage_Orig or {self.PrimaryAttackDamage[1], self.PrimaryAttackDamage[2]}
	self.PrimaryAttackDamage[1] = math.Round(self.PrimaryAttackDamage_Orig[1] * min)
	self.PrimaryAttackDamage[2] = math.Round(self.PrimaryAttackDamage_Orig[2] * max)
end

function SWEP:SetSecondaryDamageMult(min, max)
	self.SecondaryAttackDamage_Orig = self.SecondaryAttackDamage_Orig or {self.SecondaryAttackDamage[1], self.SecondaryAttackDamage[2]}
	self.SecondaryAttackDamage[1] = math.Round(self.SecondaryAttackDamage_Orig[1] * min)
	self.SecondaryAttackDamage[2] = math.Round(self.SecondaryAttackDamage_Orig[2] * max)
end

function SWEP:SetupAverageDamage(bSecondary)
	if bSecondary then
		self.SecondaryAttackDamage_Orig = self.SecondaryAttackDamage_Orig or {self.SecondaryAttackDamage[1], self.SecondaryAttackDamage[2]}

		local avg = math.Round((self.SecondaryAttackDamage_Orig[1] + self.SecondaryAttackDamage_Orig[2]) / 2)
		self.SecondaryAttackDamage[1] = avg
		self.SecondaryAttackDamage[2] = avg
	else
		self.PrimaryAttackDamage_Orig = self.PrimaryAttackDamage_Orig or {self.PrimaryAttackDamage[1], self.PrimaryAttackDamage[2]}

		local avg = math.Round((self.PrimaryAttackDamage_Orig[1] + self.PrimaryAttackDamage_Orig[2]) / 2)
		self.PrimaryAttackDamage[1] = avg
		self.PrimaryAttackDamage[2] = avg
	end
end

--must be called after using the before two because i'm lazy
function SWEP:ResetPrimaryDamage()
	self.PrimaryAttackDamage = {self.PrimaryAttackDamage_Orig[1], self.PrimaryAttackDamage_Orig[2]}
end

function SWEP:ResetSecondaryDamage()
	self.SecondaryAttackDamage = {self.SecondaryAttackDamage_Orig[1], self.SecondaryAttackDamage_Orig[2]}
end


