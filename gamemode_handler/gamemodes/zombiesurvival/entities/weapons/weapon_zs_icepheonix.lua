AddCSLuaFile()

SWEP.Base = "weapon_zs_zombie"

if CLIENT then
	SWEP.PrintName = "Pheonix Bird"
end

SWEP.Primary.Delay = 2
SWEP.Secondary.Delay = 3 --For this, I don't know what to do here... I won't touch this.

SWEP.ViewModel = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"

SWEP.PukeAmt = 4
SWEP.PukeAmtFocus = 2
SWEP.NextPuke = 0
SWEP.PukeLeft = 0

function SWEP:Initialize()
	self:HideViewAndWorldModel()

	self.BaseClass.Initialize(self)
end

function SWEP:PrimaryAttack()
	if CurTime() < self:GetNextPrimaryFire() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)

	self.PukeLeft = self.PukeAmt
	self.Focused = false
end

function SWEP:SecondaryAttack()
	if CurTime() < self:GetNextSecondaryFire() then return end
	self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
	if CurTime() < self:GetNextPrimaryFire() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	self.PukeLeft = self.PukeAmtFocus
	self.Focused = true
end

function SWEP:Reload()
end

if not SERVER then return end

function SWEP:Think()
    local pl = self.Owner

    if self.PukeLeft > 0 and CurTime() >= self.NextPuke then
        self.PukeLeft = self.PukeLeft - 1
        local ent = ents.Create("projectile_icepheonix")
        if ent:IsValid() then
            ent:SetPos(pl:EyePos())
            ent:SetOwner(pl)
            ent:SetPhysicsAttacker(pl)
            ent:Spawn()

            local phys = ent:GetPhysicsObject()
            if phys:IsValid() then
                local ang = pl:EyeAngles()
                if not self.Focused then
                    ang:RotateAroundAxis(ang:Forward(), math.Rand(-10, 10)) -- Decreased range
                    ang:RotateAroundAxis(ang:Up(), math.Rand(-10, 10)) -- Decreased range
                elseif self.Focused then
                    if self.PukeLeft == 1 then
                        self.Focused = false
                    end
                    ang:RotateAroundAxis(ang:Forward(), math.Rand(-2, 2)) -- Decreased range
                    ang:RotateAroundAxis(ang:Up(), math.Rand(-2, 2)) -- Decreased range
                end

                phys:SetVelocityInstantaneous(ang:Forward() * math.Rand(600, 1000))
            end
        end
    end

    self:NextThink(CurTime())
    return true
end