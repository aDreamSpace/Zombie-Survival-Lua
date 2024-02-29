INC_SERVER()

ENT.TickTime = 1
ENT.Ticks = 10
ENT.HealPower = 2.5

-- Define a global variable for the heal amount
HEAL_AMOUNT = 15

function ENT:Initialize()
    local owner = self:GetOwner()

    self:DrawShadow(false)
    self.Ticks = math.floor(self.Ticks * (owner:IsValidLivingHuman() and owner.CloudTime or 1))

    self:Fire("heal", "", self.TickTime)
    self:Fire("kill", "", self.TickTime * self.Ticks + 0.01)
end

-- Define a global function to heal a player
function HealPlayer(healer, target, healAmount, healRate, shouldHeal)
    if shouldHeal then
        local newHealth = math.min(target:Health() + healAmount, target:GetMaxHealth())
        target:SetHealth(newHealth)
    end
end

function ENT:AcceptInput(name, activator, caller, arg)
    if name ~= "heal" then return end

    self.Ticks = self.Ticks - 1

    local healer = self:GetOwner()
    if not healer:IsValidLivingHuman() then healer = self end

    local vPos = self:GetPos()
    for _, ent in pairs(ents.FindInSphere(vPos, self.Radius * (healer.CloudRadius or 1))) do
        if ent and ent:IsValidLivingHuman() and WorldVisible(vPos, ent:NearestPoint(vPos)) then
            -- Use the global function to heal the player
            HealPlayer(healer, ent, HEAL_AMOUNT, 0.5, true)
        end
    end

    if self.Ticks > 0 then
        self:Fire("heal", "", self.TickTime)
    end

    return true
end