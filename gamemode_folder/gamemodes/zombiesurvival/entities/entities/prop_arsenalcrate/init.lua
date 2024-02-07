AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local MaxLevel = 4
local XPToNextLevel = {
		[1] = 300,
		[2] = 500,
		[3] = 1000,
		[4] = 4000
	}

local function RefreshCrateOwners(pl)
	for _, ent in pairs(ents.FindByClass("prop_arsenalcrate")) do
		if ent:IsValid() and ent:GetObjectOwner() == pl then
			ent:SetObjectOwner(NULL)
		end
	end
end
hook.Add("PlayerDisconnected", "ArsenalCrate.PlayerDisconnected", RefreshCrateOwners)
hook.Add("OnPlayerChangedTeam", "ArsenalCrate.OnPlayerChangedTeam", RefreshCrateOwners)


function ENT:Initialize()
	self:SetModel("models/Items/item_item_crate.mdl")
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end

	self:SetMaxObjectHealth(200)
	self:SetObjectHealth(self:GetMaxObjectHealth())
	
	
	self.XPToNextLevel = XPToNextLevel

	self.MaxLevel = MaxLevel
	timer.Simple(0, function()
		local ply = self:GetObjectOwner()
		--print(ply)
	
		if ply.ArsenalLevelData == nil then
			ply.ArsenalLevelData = {}
		end
		if ply.ArsenalLevelData == nil then
			print("Arsenal created by a NULL entity, not a player!")
		return
		end
		
		local plTblNum = #ply.ArsenalLevelData
		local plTblNext = plTblNum + 1
	
		if plTblNum > 0 then
			self:SetLevel(ply.ArsenalLevelData[plTblNum])
			table.remove(ply.ArsenalLevelData)
		else
			self:SetLevel(0)
		end
	
	end)
end

function ENT:KeyValue(key, value)
	key = string.lower(key)
	if key == "maxcratehealth" then
		value = tonumber(value)
		if not value then return end

		self:SetMaxObjectHealth(value)
	elseif key == "cratehealth" then
		value = tonumber(value)
		if not value then return end

		self:SetObjectHealth(value)
	end
end

function ENT:AcceptInput(name, activator, caller, args)
	if name == "setcratehealth" then
		self:KeyValue("cratehealth", args)
		return true
	elseif name == "setmaxcratehealth" then
		self:KeyValue("maxcratehealth", args)
		return true
	end
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

	if gamemode.Call("PlayerCanPurchase", activator) then
		activator:SendLua("GAMEMODE:OpenPointsShop()")
	elseif ishuman then
		activator:CenterNotify(COLOR_RED, translate.ClientGet(activator, "you_cant_purchase_now"))
	end
end

function ENT:AltUse(activator, tr)
	self:PackUp(activator)
end

function ENT:OnPackedUp(pl)
	pl:GiveEmptyWeapon("weapon_zs_arsenalcrate")
	pl:GiveAmmo(1, "airboatgun")

	pl:PushPackedItem(self:GetClass(), self:GetObjectHealth())
	if pl.ArsenalLevelData == nil then
		pl.ArsenalLevelData = {}
	end
	local plTbl = pl.ArsenalLevelData or {}
	local plTblNum = #plTbl
	local plTblNext = plTblNum + 1
	--print(plTblNum)
	plTbl[plTblNext] = self:GetLevel()
	
	--print(plTbl[plTblNext])
	
	self:Remove()
end
--[[
local LevelFuncs = {
	function(ent) ent:SetMaxObjectHealth(200 * 2) ent:SetObjectHealth(ent:GetMaxObjectHealth()) end,
	function(ent) ent.FastPack = true end,
	function(ent) ent.AmmoMult = 1.5 end,
	function(ent) ent.Teleporter = true end,
}
--]]
function ENT:Think()
	if self.Destroyed then
		self:Remove()
	end
	
	
	if self:GetLevel() < self.MaxLevel then
		local xp = self:GetXP()
		local lvl = self:GetLevel()
		local target = self.XPToNextLevel[lvl + 1]
		self:SetXPFraction(xp / target)
		
		if xp >= target then
			self:SetXP(0)
			self:SetLevel(lvl + 1)
		end
	end
end


