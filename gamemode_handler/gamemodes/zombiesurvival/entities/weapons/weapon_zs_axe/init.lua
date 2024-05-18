AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("ActivateAxeAbility")
util.AddNetworkString("DeactivateAxeAbility")

function SWEP:Initialize()
    self:SetNWFloat("AbilityAxeCooldown", 0)
    self:SetNWBool("AbilityAxeActive", false)
end

function SWEP:SecondaryAttack()
    if CurTime() < self:GetNWFloat("AbilityAxeCooldown") or self:GetNWBool("AbilityAxeActive") then return end
    self:ActivateAbility()
end

function SWEP:ActivateAbility()
    if self:GetNWBool("AbilityAxeActive") then return end
    self.Primary.Delay = self.Primary.Delay * 0.5
    self.MeleeDamage = self.MeleeDamage * 5
    self:SetNWBool("AbilityAxeActive", true)

    timer.Simple(5, function() 
        if IsValid(self) then
            self:DeactivateAbility()
        end
    end)

    net.Start("ActivateAxeAbility")
    net.WriteEntity(self)
    net.Broadcast()
end

function SWEP:DeactivateAbility()
    self.Primary.Delay = self.Primary.Delay / 0.5
    self.MeleeDamage = self.MeleeDamage / 5
    self:SetNWBool("AbilityAxeActive", false)
    self:SetNWFloat("AbilityAxeCooldown", CurTime() + 15)

    net.Start("DeactivateAxeAbility")
    net.WriteEntity(self)
    net.Broadcast()
end

function SWEP:PlaySwingSound()
    self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(165, 170))
end

function SWEP:PlayHitSound()
    self:EmitSound("weapons/melee/golf club/golf_hit-0"..math.random(4)..".ogg", 75, math.random(160, 190))
end

function SWEP:PlayHitFleshSound()
    self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav")
end