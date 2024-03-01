AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.ExplosionDamage = 1200
ENT.ExplosionRange = 728 ^ 2
ENT.ExplosionAngle = 120
ENT.ExplosiveName = "prop_claymore"
local function RefreshClaymoreOwners(pl)
	for _, ent in pairs(ents.FindByClass("prop_claymore")) do
		if ent:IsValid() and ent:GetOwner() == pl then
			ent:SetOwner(NULL)
		end
	end
end
hook.Add("PlayerDisconnected", "Claymore.PlayerDisconnected", RefreshClaymoreOwners)
hook.Add("OnPlayerChangedTeam", "Claymore.OnPlayerChangedTeam", RefreshClaymoreOwners)

ENT.NextBlip = 0

function ENT:Initialize()
	self:SetModel("models/maxofs2d/motion_sensor.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
		phys:Wake()
	end

	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
end

function ENT:AltUse(activator, tr)
	self:PackUp(activator)
end

function ENT:OnTakeDamage(dmginfo)
	self:TakePhysicsDamage(dmginfo)

	if not self.Exploded and dmginfo:GetDamage() >= 9 then
		local attacker = dmginfo:GetAttacker()
		if not (attacker:IsValid() and attacker:IsPlayer() and attacker:Team() == TEAM_HUMAN) then
			self.ForceExplode = true
			self:Explode()
		end
	end
end

function ENT:Use(activator, caller)
	if self.Exploded or self:GetExplodeTime() ~= 0 or not activator:IsPlayer() or activator:Team() ~= TEAM_HUMAN or self:GetMaterial() ~= "" then return end

	local owner = self:GetOwner()
	if owner == activator or not owner:IsValid() then
		self:SetOwner(activator)
	end
end


local trace = {nil, nil, mask = MASK_SOLID_BRUSHONLY}
function ENT:Explode()
	if self.Exploded then return end
	self.Exploded = true

	local owner = self:GetOwner()
	if owner:IsValid() and owner:IsPlayer() and owner:Team() == TEAM_HUMAN then
		local pos = self:GetPos()

		--util.BlastDamage2(self, owner, pos, 320, self.ExplosionDamage)

		--since this is a claymore, we should enumerate the entities that are in a box directly infront of it
		local tPlys = player.GetAll()

		local dmginfo = DamageInfo()
		dmginfo:SetDamageType(DMG_BLAST)
		dmginfo:SetDamage(self.ExplosionDamage)
		dmginfo:SetAttacker(owner)
		dmginfo:SetInflictor(self)

		local vFwd = self:GetForward()
		for i = 1, #tPlys do
			local ply = tPlys[i]
			if ply and ply:IsValid() and (ply:Team() == TEAM_UNDEAD or ply == owner) then
				--first a quick distance check
				if pos:DistToSqr(ply:GetPos()) > self.ExplosionRange then
					continue
				end

				--take a simple dot product of our explosion angle
				--this is a directional cone, we'll just grab everything in the cone
				local vTargetFwd = (ply:GetPos() - pos)
				vTargetFwd:Normalize()
		
				local dot = vFwd:Dot(vTargetFwd)
				local degrees = math.deg(math.acos(dot))
				if degrees > self.ExplosionAngle / 2 then
					continue
				end
		
				trace.start = vPos
				trace.endpos = ply:WorldSpaceCenter()
				local tr = util.TraceLine(trace)
				if tr.Hit then
					continue
				end

				ply:TakeDamageInfo(dmginfo)
			end
		end

		local effectdata = EffectData()
		effectdata:SetOrigin(pos)
		
		util.Effect("Explosion", effectdata)
	end
end

function ENT:Think()
	if self.Exploded then
		self:Remove()
		return
	end

	local pos = self:GetPos()
	local tPlys = player.GetAll()
	local vFwd = self:GetForward()
	for i = 1, #tPlys do
		local ply = tPlys[i]
		if ply and ply:IsValid() and (ply:Team() == TEAM_UNDEAD) and ply:Alive() then
			--first a quick distance check
			if pos:DistToSqr(ply:GetPos()) > self.ExplosionRange then
				continue
			end

			--take a simple dot product of our explosion angle
			--this is a directional cone, we'll just grab everything in the cone
			local vTargetFwd = (ply:GetPos() - pos)
			vTargetFwd:Normalize()
	
			local dot = vFwd:Dot(vTargetFwd)
			local degrees = math.deg(math.acos(dot))
			if degrees > self.ExplosionAngle / 2 then
				continue
			end
	
			trace.start = vPos
			trace.endpos = ply:WorldSpaceCenter()

			local tr = util.TraceLine(trace)
			if tr.Hit then
				continue
			end

			self:Explode()
		end
	end

	self:NextThink(CurTime() + 0.25)
	return true
end

function ENT:OnPackedUp(pl)
	pl:GiveEmptyWeapon("weapon_zs_claymore")
	pl:GiveAmmo(1, "mp5_grenade")

	self:Remove()
end
