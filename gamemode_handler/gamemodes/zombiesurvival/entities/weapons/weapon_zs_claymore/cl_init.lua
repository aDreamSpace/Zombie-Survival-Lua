include("shared.lua")

SWEP.PrintName = "M18A1 Claymore"
SWEP.Description = "A mine that has a directional explosive payload.\nPress PRIMARY ATTACK to deploy.\nPress SPRINT on a deployed detonation pack to disarm and retrieve it."
SWEP.DrawCrosshair = false

SWEP.Slot = 4
SWEP.SlotPos = 0

function SWEP:Deploy()
	gamemode.Call("WeaponDeployed", self.Owner, self)

	return true
end

function SWEP:DrawHUD()
	if GetConVarNumber("crosshair") ~= 1 then return end
	self:DrawCrosshairDot()
end

function SWEP:PrimaryAttack()
end

function SWEP:DrawWeaponSelection(...)
	return self:BaseDrawWeaponSelection(...)
end
