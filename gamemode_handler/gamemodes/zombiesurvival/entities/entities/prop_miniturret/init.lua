AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local function RefreshCrateOwners(pl)
	for _, ent in pairs(ents.FindByClass("prop_miniturret")) do
		if ent:IsValid() and ent:GetObjectOwner() == pl then
			ent:SetObjectOwner(NULL)
		end
	end
end
hook.Add("PlayerDisconnected", "Miniturret.PlayerDisconnected", RefreshCrateOwners)
hook.Add("OnPlayerChangedTeam", "Miniturret.OnPlayerChangedTeam", RefreshCrateOwners)

ENT.TurretBulletCount = 1
ENT.TurretSpread = Vector(0.10, 0.06, 0)
ENT.TurretDamage = 18
ENT.TurretForce = 1
ENT.TurretTracer = 1
ENT.TurretFireDelay = 60/800
ENT.ShootSound = "^weapons/smg1/npc_smg1_fire1.wav"
function ENT:Initialize()
	--self:SetModel("models/Items/item_item_crate.mdl")
	self:SetModel("models/pa_zs/deployable/new_turret_simple.mdl")
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end

	self:SetMaxObjectHealth(200)
	self:SetObjectHealth(self:GetMaxObjectHealth())
	self:SetTarget(NULL)
	self:SetAmmoType("alyxgun")
	self:SetScanRange(512)
	self:SetScanAngle(60)
	self:SetMaxAmmoAmount(1500)
	self:SetPos(self:GetPos() + Vector(0, 0, -12))
	self:SetDeployed(false)
	self:SetAutomaticFrameAdvance(true)
	self:ResetSequence("deploy")
	--self:SetupAttachments()
end

function ENT:CalculateAttachments()
end

function ENT:SetObjectHealth(health)
	self:SetDTFloat(0, health)
	if health <= 0 and not self.Destroyed then
		self.Destroyed = true

		local ent = ents.Create("prop_physics")
		if ent:IsValid() then
			ent:SetModel(self:GetModel())
			ent:SetMaterial(self:GetMaterial())
			ent:SetAngles(self:GetAngles())
			ent:SetPos(self:GetPos())
			ent:SetSkin(self:GetSkin() or 0)
			ent:SetColor(self:GetColor())
			ent:Spawn()
			ent:Fire("break", "", 0)
			ent:Fire("kill", "", 0.1)
		end
	end
end

function ENT:OnTakeDamage(dmginfo)
	self:TakePhysicsDamage(dmginfo)

	local attacker = dmginfo:GetAttacker()
	if not (attacker:IsValid() and attacker:IsPlayer() and attacker:Team() == TEAM_HUMAN) then
		self:ResetLastBarricadeAttacker(attacker, dmginfo)
		self:SetObjectHealth(self:GetObjectHealth() - dmginfo:GetDamage())
	end
end

function ENT:Use(activator, caller)
	local ishuman = activator:Team() == TEAM_HUMAN and activator:Alive()

	if not self.NoTakeOwnership and not self:GetObjectOwner():IsValid() and ishuman then
		self:SetObjectOwner(activator)
	end

	local iAmmo = self:GetAmmoAmount()
	local iMaxAmmo = self:GetMaxAmmoAmount()
	if iAmmo < iMaxAmmo then
		local strAmmo = self:GetAmmoType()
		local iAvailable = activator:GetAmmoCount(strAmmo)
		local iToGive = math.min(75, iAvailable, iMaxAmmo - iAmmo)
		if iToGive > 0 then
			self:SetAmmoAmount(iAmmo + iToGive)
			activator:RemoveAmmo(iToGive, strAmmo)
			self:EmitSound("npc/turret_floor/click1.wav")
		end
	end
end

function ENT:AltUse(activator, tr)
	self:PackUp(activator)
end

function ENT:OnPackedUp(pl)
	pl:GiveEmptyWeapon("weapon_zs_miniturret")
	pl:GiveAmmo(1, "9mmRound")

	pl:GiveAmmo(self:GetAmmoAmount(), self:GetAmmoType())


	pl:PushPackedItem(self:GetClass(), self:GetObjectHealth())
	
	self:Remove()
end

ENT.NextUpdate = 0
ENT.NextShoot = 0
local trace = {nil, nil, mask = MASK_SOLID_BRUSHONLY}

function ENT:VerifyTarget()
	local target = self:GetTarget()
	if target and target:IsValid() then
		local vPos = self:GetPos()
		local vTPos = target:GetPos()
		local range = self:GetScanRange()
		range = range * range

		if not target:Alive() or target:Health() <= 0 or vTPos:DistToSqr(vPos) > range then
			self:ClearTarget()
			return
		end

		local vFwd = self:GetAngles():Forward()
		local vTargetFwd = (vTPos - vPos)
		vTargetFwd:Normalize()

		local dot = vFwd:Dot(vTargetFwd)
		local degrees = math.deg(math.acos(dot))

		if degrees > self:GetScanAngle() / 2 then
			self:ClearTarget()
			return
		end

		trace.start = vPos
		trace.endpos = target:WorldSpaceCenter()
		local tr = util.TraceLine(trace)

		if tr.Hit then
			self:ClearTarget()
			return
		end
	end
end

function ENT:Think()
	if self.Destroyed then
		self:Remove()
	end

	local bDeployed = self:GetDeployed()
	if not bDeployed then
		local seq = self:GetSequenceName(self:GetSequence())
		if seq == "deploy" and self:GetCycle() >= 1 or seq == "idle" then
			self:SetDeployed(true)
		end
	end

	local flCT = CurTime()
	if self.NextUpdate < flCT and bDeployed then
		self.NextUpdate = flCT + 0.3

		local target = self:GetTarget()
		local vPos = self:GetPos()
		local range = self:GetScanRange() ^ 2

		--store a dot product calculation here
		local vFwd = self:GetAngles():Forward()

		if target and target:IsValid() then
			--make sure our target is still valid
			self:VerifyTarget()
		else
			--search for a new target
			--loop through all players, and for every zombie player we need ot make sure it fulfills 2 requirements
			--A: the player is within range
			--and B: the player is within the scan angles

			local tPlys = player.GetAll()
			for i = 1, #tPlys do
				local ply = tPlys[i]
				if ply and ply:IsValid() and ply:Alive() and ply:Team() == TEAM_UNDEAD then
					--first a distance calculation
					local vPPos = ply:GetPos()
					if vPPos:DistToSqr(vPos) < range then
						--then the dotproduct calculation
						local vPPosFwd = (vPPos - vPos)
						vPPosFwd:Normalize()
						local dot = vFwd:Dot(vPPosFwd)
						local degrees = math.deg(math.acos(dot))

						if degrees < self:GetScanAngle() / 2 then
							--lastly, do a trace to see if we have line of sight
							trace.start = vPos
							trace.endpos = ply:WorldSpaceCenter()
				
							local tr = util.TraceLine(trace)
				
							if not tr.Hit then
								self:SetTarget(ply)
								break
							end
							
							
						end
					end
				end
			end
		end
	end

	if self.NextShoot < flCT then
		self.NextShoot = flCT + self.TurretFireDelay
		self:VerifyTarget()
		local target = self:GetTarget()
		if target and target:IsValid() then
			local src = self:GetAttachment(self:LookupAttachment("attach_muzzle")).Pos --self.MuzzleAttach.Pos
			local vTEyePos = target:LocalToWorld(target:OBBCenter())
			if not (target:IsPlayer() and target:GetZombieClassTable().NoHead) then
				local boneid = target:GetHitBoxBone(HITGROUP_HEAD, 0)
				if boneid and boneid > 0 then
					local p, a = target:GetBonePosition(boneid)
					if p then
						vTEyePos = p
					end
				end
			end
			--vTEyePos.z = vTEyePos.z - 8
			local dir = vTEyePos - src
			dir:Normalize()

			self:FireBullet(src, dir)
		end
	end

	self:NextThink(flCT)
	return true
end

local function BulletCallback(attacker, tr, dmginfo)
    local ent = tr.Entity
    if ent:IsValid() then
        if ent:IsPlayer() then
            if ent:Team() == TEAM_UNDEAD then
                if ent.NoTurretDmgTime and ent.NoTurretDmgTime > CurTime() then
                    dmginfo:SetDamage(0)
                end
            elseif ent:Team() == TEAM_HUMAN then
                dmginfo:SetDamage(0)
            end
        else
            local phys = ent:GetPhysicsObject()
            if ent:GetMoveType() == MOVETYPE_VPHYSICS and phys:IsValid() and phys:IsMoveable() then
                ent:SetPhysicsAttacker(attacker)
            end
        end
        
        dmginfo:SetAttacker(attacker:GetObjectOwner())
        dmginfo:SetInflictor(attacker)
    end
end

local tBulInfo = {nil, nil, nil, nil, nil, nil, nil, nil, nil, nil}
function ENT:FireBullet(src, dir)
	local owner = self:GetObjectOwner()
	local iAmmo = self:GetAmmoAmount()
	if owner and owner:IsValid() then
		if iAmmo > 0 then
			self:SetAmmoAmount(iAmmo - 1)
			
			tBulInfo.Num = self.TurretBulletCount
			tBulInfo.Src = src
			tBulInfo.Dir = dir
			tBulInfo.Spread = self.TurretSpread
			tBulInfo.Tracer = self.TurretTracer
			tBulInfo.Force = self.TurretForce
			tBulInfo.Damage = self.TurretDamage
			tBulInfo.Callback = BulletCallback
			--tBulInfo.IgnoreEntity = owner--self
			tBulInfo.Attacker = self

			self:EmitSound(self.ShootSound)
			--owner:FireBullets(tBulInfo)
			self:FireBullets(tBulInfo)
			self:ResetSequence("fire")

			local edata = EffectData()
			edata:SetEntity(self)
			edata:SetAttachment(self:LookupAttachment("attach_muzzle"))
			edata:SetFlags(5)
			edata:SetScale(1)

			util.Effect("MuzzleFlash", edata, true, true)
		--else
		--	self:EmitSound("weapons/shotgun/shotgun_empty.wav")
		--	self.NextShoot = self.NextShoot + 0.5
		end
	end
end
