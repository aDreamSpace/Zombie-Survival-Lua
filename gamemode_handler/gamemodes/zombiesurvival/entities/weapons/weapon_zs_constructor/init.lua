AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function SWEP:Deploy()
	gamemode.Call("WeaponDeployed", self.Owner, self)

	self:SpawnGhost()

	return true
end

function SWEP:OnRemove()
	self:RemoveGhost()
end

function SWEP:Holster()
	self:RemoveGhost()
	return true
end

function SWEP:SpawnGhost()
	local owner = self.Owner
	if owner and owner:IsValid() then
		owner:GiveStatus("ghost_constructor")
	end
end

function SWEP:RemoveGhost()
	local owner = self.Owner
	if owner and owner:IsValid() then
		owner:RemoveStatus("ghost_constructor", false, true)
	end
end

function SWEP:PrimaryAttack()
	local owner = self.Owner

	local status = owner["status_ghost_constructor"]
	if not (status and status:IsValid()) then return end
	status:RecalculateValidity()
	if not status:GetValidPlacement() then return end

	local pos, ang = status:RecalculateValidity()
	if not pos or not ang then return end

	self:SetNextPrimaryAttack(CurTime() + self.Primary.Delay)

	local ent = ents.Create("prop_constructor")
	if ent:IsValid() then
		ent:SetPos(pos)
		ent:SetAngles(ang)
		ent:Spawn()

		ent:SetObjectOwner(owner)

		ent:EmitSound("npc/dog/dog_servo12.wav")

		ent:GhostAllPlayersInMe(5)

		local stored = owner:PopPackedItem(ent:GetClass())
		if stored then
			ent:SetObjectHealth(stored[1])
			ent:SetObjectFuel(stored[2])
		end

		owner:StripWeapon(self:GetClass())
	end
end
