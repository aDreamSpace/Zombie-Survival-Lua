AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("ActivateAbility")
util.AddNetworkString("DeactivateAbility")

function SWEP:Initialize()
    self:SetNWFloat("AbilityCooldown", 0)
    self:SetNWBool("AbilityActive", false)
end

function SWEP:SecondaryAttack()
    if CurTime() < self:GetNWFloat("AbilityCooldown") or self:GetNWBool("AbilityActive") then return end
    self:ActivateAbility()
end

function SWEP:ActivateAbility()
    if self:GetNWBool("AbilityActive") then return end
    self.Primary.Delay = self.Primary.Delay * 0.5
    self.MeleeDamage = self.MeleeDamage * 2.5
    self:SetNWBool("AbilityActive", true)

    timer.Simple(5, function() -- Change 5 to the duration of the ability
        if IsValid(self) then
            self:DeactivateAbility()
        end
    end)

    net.Start("ActivateAbility")
    net.WriteEntity(self)
    net.Broadcast()
end

function SWEP:DeactivateAbility()
    self.Primary.Delay = self.Primary.Delay / 0.5
    self.MeleeDamage = self.MeleeDamage / 2.5
    self:SetNWBool("AbilityActive", false)
    self:SetNWFloat("AbilityCooldown", CurTime() + 30)

    net.Start("DeactivateAbility")
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