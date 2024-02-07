AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
local function RefreshCrateOwners(pl)
	for _, ent in pairs(ents.FindByClass("prop_teleporter")) do
		if ent:IsValid() and ent:GetObjectOwner() == pl then
			ent:SetObjectOwner(NULL)
		end
	end
end
hook.Add("PlayerDisconnected", "Teleporter.PlayerDisconnected", RefreshCrateOwners)
hook.Add("OnPlayerChangedTeam", "Teleporter.OnPlayerChangedTeam", RefreshCrateOwners)
--[[
function RefreshBattery(ID, replacement)
	local ent = ents.GetByIndex(ID)
	if ID == ent.teleID and replacement then
		ent:SetBatteryCharge(3)
	end
end
--]]

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end

function ENT:Initialize()
	self:SetModel("models/props/deployable/teleporter_2.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:DrawShadow(false)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
		phys:EnableCollisions(false)
	end

	self:SetMaxObjectHealth(100)
	self:SetObjectHealth(self:GetMaxObjectHealth())

	self.posVec = self:GetPos()
	self.teleID = self:EntIndex()
	if teleTbl == nil then
		teleTbl = {}
	end
	
	self.telesndchrg = CreateSound(self, "hl1/ambience/signalgear1.wav")
	self.telesndcool = CreateSound(self, "hl1/ambience/techamb2.wav")
	self.telesndport = CreateSound(self, "ambient/energy/whiteflash.wav")
	self.telesndfail = CreateSound(self, "ambient/energy/weld2.wav")
--[[
	table.insert(teleTbl, self.posVec)
	timer.Simple(0, function() --for some reason, object owner is only defined the frame after a deployable is placed...
		if self:GetObjectOwner().batteryCharge ~= nil then
			self:SetBatteryCharge(self:GetObjectOwner().batteryCharge[#self:GetObjectOwner().batteryCharge] or 0) --dont wanna lose charge when packed and placed again
			--sadly this still has the same limitations the arsenal crate has with saving levels, needs more work to be foolproof
			--limitation is that charges are logged on a strict pack up, place basis. if it is dropped, destroyed, or given anywhere inbetween, charges aren't preserved
		
			table.remove(self:GetObjectOwner().batteryCharge)
		end
	end)
	--]]
end

function ENT:KeyValue(key, value)
	key = string.lower(key)
	if key == "maxobjecthealth" then
		value = tonumber(value)
		if not value then return end

		self:SetMaxObjectHealth(value)
	elseif key == "objecthealth" then
		value = tonumber(value)
		if not value then return end

		self:SetObjectHealth(value)
	end
end

function ENT:AcceptInput(name, activator, caller, args)
	if name == "setobjecthealth" then
		self:KeyValue("objecthealth", args)
		return true
	elseif name == "setmaxobjecthealth" then
		self:KeyValue("maxobjecthealth", args)
		return true
	end
end

function ENT:SetObjectHealth(health)
	self:SetDTFloat(0, health)

	if health <= 0 and not self.Destroyed then
		self.Destroyed = true

		local effectdata = EffectData()
			effectdata:SetOrigin(self:LocalToWorld(self:OBBCenter()))
		util.Effect("Explosion", effectdata, true, true)
	end
end

function ENT:OnTakeDamage(dmginfo)
	self:TakePhysicsDamage(dmginfo)

	local attacker = dmginfo:GetAttacker()
	if not (attacker:IsValid() and attacker:IsPlayer() and attacker:Team() == TEAM_HUMAN) then
		self:SetObjectHealth(self:GetObjectHealth() - dmginfo:GetDamage())
		self:ResetLastBarricadeAttacker(attacker, dmginfo)
	end
end

function ENT:AltUse(activator, tr)
	if self.cooldown == nil then self.cooldown = 0 end
	if self.cooldown > CurTime() then
		activator:CenterNotify(COLOR_RED, "You'd burn your hands if you packed this up now!")
		return
	else
		self:PackUp(activator)
	end
end

function ENT:OnPackedUp(pl)
	pl:GiveEmptyWeapon("weapon_zs_teleporter")
	pl:GiveAmmo(1, "slam")

	pl:PushPackedItem(self:GetClass(), self:GetObjectHealth())
	--[[
	table.remove(teleTbl, table.KeyFromValue(teleTbl, self.posVec))
	pl.batteryCharge = pl.batteryCharge or {}
	pl.batteryCharge[#pl.batteryCharge+1] = self:GetBatteryCharge() or 0
	--]]

	self:Remove()
end

local pwrCheck
local checkTime
function ENT:Think()
	if self.Destroyed then
		--table.remove(teleTbl, table.KeyFromValue(teletbl, self.posVec))
		self:Remove()
	end
	local ct = CurTime()
	local ply = self.TeleportingPly
	if SERVER and ply and ply:IsValid() then
		if ply:Team() == TEAM_HUMAN then
			if self.TimeToTeleport and self.TimeToTeleport <= ct then
				self.TimeToTeleport = nil
				self.telesndchrg:Stop()
				if ply:GetPos():Distance(self:GetPos()) > 16 then
					if self.telesndfail:IsPlaying() then self.telesndfail:Stop() end
					self.telesndfail:Play()
					ply:CenterNotify(COLOR_RED, "You must be on the teleporter in order to transport")
					self.telesndcool:Stop()
					self.cooldown = ct
					self.TeleportingPly = nil
					return
				end

				GAMEMODE.TeleportingPlayers[ply:SteamID64()] = {CurTime() + 15, ply:GetPos()}
				ply:SetPos(Vector(16000, 16000, 16000)) --Somewhere safe
				net.Start("zs_teleport_init")
					net.WriteEntity(self)
				net.Send(ply)
				PushAchievementProgress(ply, "Beam me up Scotty!")
				self.TeleportingPly = nil
			end
		end
	end

	if SERVER and self.StopCoolSound and self.StopCoolSound < ct then
		self.telesndcool:Stop()
		self.StopCoolSound = nil
	end
end


function ENT:OnRemove()
	if self.telesndcool:IsPlaying() or self.telesndchrg:IsPlaying() then
		self.telesndcool:Stop()
		self.telesndchrg:Stop()
	end
end

function ENT:Use(activator, caller)
	if activator:Team() ~= TEAM_HUMAN or not activator:Alive() then return end --used to not allow teleporting on wave 0, dunno why, its enabled now

	if self.cooldown == nil then
		self.cooldown = 0
	end

	if not self:GetObjectOwner():IsValid() then
		self:SetObjectOwner(activator)
	end

	local cooldown = self.cooldown
	if cooldown > CurTime() then
		local coolTime = tostring(math.Round(cooldown - CurTime(), 1))
		activator:CenterNotify(COLOR_RED, "Teleporter is cooling. It will be ready in "..coolTime.." seconds.")
		return
	end

	if cooldown <= CurTime() then
		self.cooldown = CurTime() + 10
		self.telesndchrg:Play()
		self.telesndcool:Play()
		self.TeleportingPly = activator
		self.TimeToTeleport = CurTime() + 3
		self.StopCoolSound = CurTime() + 10
	end
end

--table.NextVal is a replacement for FindNext
concommand.Add("zs_teleport", function(ply, cmd, tblArg)
	if ply:IsValid() and ply:Alive() and ply:Team() == TEAM_HUMAN then
		if GAMEMODE.TeleportingPlayers[ply:SteamID64()] then
			local arg = tblArg[1]
			local ent = Entity(arg)
			if ent and ent:IsValid() then
				if ent:GetClass() == "prop_teleporter" then
					GAMEMODE.TeleportingPlayers[ply:SteamID64()] = nil
					ply:SetPos(ent:GetPos())
					ply:EmitSound("ambient/energy/whiteflash.wav", 100, 75)
					net.Start("zs_teleport_final")
					net.Send(ply)
				end
			end
		end
	end
end)