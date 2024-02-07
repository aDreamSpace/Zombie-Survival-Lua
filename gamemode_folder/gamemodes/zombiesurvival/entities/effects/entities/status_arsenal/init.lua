AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:SetPlayer(pPlayer, bExists)
	if bExists then
		self:PlayerSet(pPlayer, bExists)
	else
		local bValid = pPlayer and pPlayer:IsValid()
		if bValid then
			self:SetPos(pPlayer:GetPos() + Vector(0,0,16))
		end
		self.Owner = pPlayer
		pPlayer[self:GetClass()] = self
		self:SetOwner(pPlayer)
		self:SetParent(pPlayer)
		if bValid then
			self:PlayerSet(pPlayer)
		end
	end
end

function ENT:PlayerSet(pPlayer, bExists)
end

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetModelScale(0.5, 0)

	self:SetModel("models/items/item_item_crate.mdl")
	self:SetSolid(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
end

function ENT:Think()
	local owner = self:GetOwner()
	if not (owner:IsValid() and owner:Alive() and owner:HasWeapon("weapon_zs_arsenalcrate")) then self:Remove() end
end
