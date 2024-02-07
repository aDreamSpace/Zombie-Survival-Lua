AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.CleanupPriority = 1

ENT.RemoveOnSpawn = {
	["weapon_zs_fists"] = true,
	["cw_melee_fists"] = true
}

function ENT:Initialize()
	self.m_Health = 200
	self.IgnorePickupCount = self.IgnorePickupCount or false
	self.Forced = self.Forced or false
	self.NeverRemove = self.NeverRemove or false --Make sure this is set to TRUE so that if this is spawned BY THE MAP then it doesnt get destroyed
	self.IgnoreUse = self.IgnoreUse or false

	self:SetModel("models/props_junk/cardboard_box003b.mdl") --...?
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)

	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetMaterial("material")
		phys:EnableMotion(true)
		phys:SetMass(10)
		phys:Wake()
	end

	self:ItemCreated()
end

function ENT:SetShouldRemoveAmmo(bool)
	self.m_DontRemoveAmmo = not bool
end

function ENT:GetShouldRemoveAmmo()
	return not self.m_DontRemoveAmmo
end

function ENT:Use(activator, caller)
	if self.IgnoreUse then return end
	self:GiveToActivator(activator, caller)
end

function ENT:GiveToActivator(activator, caller)
	if  not activator:IsPlayer()
		or not activator:Alive()
		or activator:Team() ~= TEAM_HUMAN
		or self.Removing
		or (activator:KeyDown(GAMEMODE.UtilityKey) and not self.Forced)
		or self.NoPickupsTime and CurTime() < self.NoPickupsTime and self.NoPickupsOwner ~= activator then 
		
		self:Input("OnPickupFailed", activator)
		return 
	end

	local attype = self:GetAttachmentType()
	if not attype then 
		self:Input("OnPickupFailed", activator)
		return 
	end

	local tWeps = activator:GetWeapons() --gee bill, 3 loops
	for _, wep in pairs(tWeps) do
		if wep and wep:IsValid() and wep.CW20Weapon and wep.Attachments then
			for _, info in pairs(wep.Attachments) do 
				for _, att in pairs(info.atts) do
					if att == attype then
						CustomizableWeaponry:giveAttachment(activator, attype, false)
						self:Remove()
						return
					end
				end
			end
		end
	end
end

function ENT:KeyValue(key, value)
	key = string.lower(key)
	if key == "weapontype" then
		self:SetWeaponType(value)
	elseif key == "ignorepickupcount" then
		self.IgnorePickupCount = tonumber(value) == 1
	elseif key == "neverremove" then
		self.NeverRemove = tonumber(value) == 1
	elseif key == "ignoreuse" then
		self.IgnoreUse = tonumber(value) == 1
	elseif key == "empty" then
		self.Empty = tonumber(value) == 1
	elseif string.sub(key, 1, 2) == "on" then
		self:AddOnOutput(key, value)
	end
end

function ENT:AcceptInput(name, activator, caller, arg)
	name = string.lower(name)
	if name == "givetoactivator" then
		self.Forced = true
		self:GiveToActivator(activator,caller)
		return true
	elseif name == "setneverremove" then
		self.NeverRemove = tonumber(arg) == 1
		return true
	elseif name == "setignorepickupcount" then
		self.IgnorePickupCount = tonumber(arg) == 1
		return true
	elseif name == "setignoreuse" then
		self.IgnoreUse = tonumber(arg) == 1
		return true
	elseif name == "setweapontype" then
		self:SetWeaponType(arg)
		return true
	elseif name == "setempty" then
		self.Empty = tonumber(arg) == 1
	elseif string.sub(name, 1, 2) == "on" then
		self:FireOutput(name, activator, caller, args)
	end
end

function ENT:OnTakeDamage(dmginfo)
	if self.NeverRemove then return end
	self:TakePhysicsDamage(dmginfo)
	local attacker = dmginfo:GetAttacker()
	if not (attacker:IsValid() and attacker:IsPlayer() and attacker:Team() == TEAM_HUMAN) then
		self.m_Health = self.m_Health - dmginfo:GetDamage()
	end

	if self.m_Health <= 0 then
		self:RemoveNextFrame()
	end
end
