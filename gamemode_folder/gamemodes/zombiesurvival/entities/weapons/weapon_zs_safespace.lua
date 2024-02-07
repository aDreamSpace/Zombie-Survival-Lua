AddCSLuaFile()
SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = Model("models/Items/ammocrate_ar2.mdl")

SWEP.AmmoIfHas = true

SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Ammo = "Hornet"
SWEP.Primary.Delay = 1
SWEP.Primary.Automatic = true

SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "dummy"

SWEP.WalkSpeed = SPEED_NORMAL
SWEP.FullWalkSpeed = SPEED_SLOWEST

function SWEP:Initialize()
	self:SetWeaponHoldType("slam")
	self:SetDeploySpeed(1.1)
	self:HideViewAndWorldModel()
end

function SWEP:SetReplicatedAmmo(count)
	self:SetDTInt(0, count)
end

function SWEP:GetReplicatedAmmo()
	return self:GetDTInt(0)
end

function SWEP:GetWalkSpeed()
	if self:GetPrimaryAmmoCount() > 0 then
		return self.FullWalkSpeed
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:CanPrimaryAttack()
	if self.Owner:IsHolding() or self.Owner:GetBarricadeGhosting() then return false end

	return true
end

function SWEP:Holster()
	return true
end
----------------
--SERVER BLOCK
----------------

if SERVER then

function SWEP:Deploy()
	gamemode.Call("WeaponDeployed", self.Owner, self)

	return true
end

function SWEP:OnRemove()
end

function SWEP:Holster()
	return true
end
function MakeSafeSpace(ply,pos,ang)
    --if IsValid(ply) and (not ply:CheckLimit("safespaces")) then return false end
        
    local ent = ents.Create("gmod_safespace")
    if not IsValid(ent) then return false end
            
    ent:SetPos(pos)
    ent:SetAngles(ang)
    Doors:SetupOwner(ent,ply)
    ent:Spawn()
    ent:Activate()

    return ent
end


function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	local owner = self.Owner
	self:SetNextPrimaryAttack(CurTime() + self.Primary.Delay)

    local tr = owner:GetEyeTraceNoCursor()
    if tr.Hit and tr.HitWorld and not (tr.Entity and tr.Entity:IsValid() and tr.Entity:IsPlayer()) then
        local ang
        ang = tr.HitNormal:Angle()
		ang.pitch = ang.pitch + 90
		local pos = tr.HitPos
		pos.z = pos.z + 4
        local ent = MakeSafeSpace(self:GetOwner(), pos, ang)
    end
end

function SWEP:Think()

end
end

-----------------
--CLIENT BLOCK
-----------------

if CLIENT then

SWEP.PrintName = "Safe Space"
SWEP.Description = "When you absolutely need a place to cade."
SWEP.DrawCrosshair = false

SWEP.Slot = 4
SWEP.SlotPos = 0

function SWEP:DrawHUD()
	if GetConVarNumber("crosshair") ~= 1 then return end
	self:DrawCrosshairDot()
end

function SWEP:PrimaryAttack()
end

function SWEP:DrawWeaponSelection(...)
	return self:BaseDrawWeaponSelection(...)
end

function SWEP:Think()
end

function SWEP:Deploy()
	gamemode.Call("WeaponDeployed", self.Owner, self)

	return true
end
end