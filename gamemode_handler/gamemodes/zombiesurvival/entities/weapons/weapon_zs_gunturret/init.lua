AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

SWEP.GhostName = "ghost_gunturret"
SWEP.PairedEnt = "prop_gunturret"
SWEP.ControllerSWEP = "weapon_zs_gunturretcontrol"
SWEP.EntAmmoName = "smg1"
SWEP.StatusName = "status_ghost_gunturret"

function SWEP:Deploy()
	gamemode.Call("WeaponDeployed", self.Owner, self)

	self.IdleAnimation = CurTime() + self:SequenceDuration()

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
		owner:GiveStatus(self.GhostName)
	end
end

function SWEP:RemoveGhost()
	local owner = self.Owner
	if owner and owner:IsValid() then
		owner:RemoveStatus(self.GhostName, false, true)
	end
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	local owner = self.Owner

	local status = owner[self.StatusName]
	if not (status and status:IsValid()) then return end
	status:RecalculateValidity()
	if not status:GetValidPlacement() then return end

	local pos, ang = status:RecalculateValidity()
	if not pos or not ang then return end

	self:SetNextPrimaryAttack(CurTime() + self.Primary.Delay)

	local channel = GAMEMODE:GetFreeChannel(self.PairedEnt)
	if channel == -1 then
		owner:SendLua("surface.PlaySound(\"buttons/button8.wav\")")
		owner:CenterNotify(COLOR_RED, translate.ClientGet(owner, "no_free_channel"))
		return
	end

	local ent = ents.Create(self.PairedEnt)
	if ent:IsValid() then
		ent:SetPos(pos)
		ent:SetAngles(ang)
		ent:Spawn()

		ent:SetObjectOwner(owner)
		ent:SetChannel(channel)

		ent:EmitSound("npc/dog/dog_servo12.wav")

		ent:GhostAllPlayersInMe(5)

		self:TakePrimaryAmmo(1)

		local stored = owner:PopPackedItem(ent:GetClass())
		if stored then
			ent:SetObjectHealth(stored[1])
		end

		local ammo = math.min(owner:GetAmmoCount(self.EntAmmoName), 250)
		ent:SetAmmo(ammo)
		owner:RemoveAmmo(ammo, self.EntAmmoName)

		if not owner:HasWeapon(self.ControllerSWEP) then
			owner:Give(self.ControllerSWEP)
		end

		if self:GetPrimaryAmmoCount() <= 0 then
			owner:StripWeapon(self:GetClass())
		end
	end
end
