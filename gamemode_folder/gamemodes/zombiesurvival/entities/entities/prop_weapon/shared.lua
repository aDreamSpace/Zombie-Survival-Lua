ENT.Type = "anim"
ENT.Base = "prop_baseoutlined"

ENT.NoNails = true

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "AmmoAmount")
end

function ENT:SetAmmoAmount(amount)
    if amount ~= self:GetAmmoAmount() then
        self:SetDTInt(0, amount)
    end
end

function ENT:SetWeaponType(class)
    local weptab = weapons.GetStored(class)
    if weptab then
        if weptab.WorldModel then
            self:SetModel(weptab.WorldModel)
        elseif weptab.Base then
            local weptabb = weapons.GetStored(weptab.Base)
            if weptabb and weptabb.WorldModel then
                self:SetModel(weptabb.WorldModel)
            end
        end

        if SERVER and weptab.BoxPhysicsMax then
            self:PhysicsInitBox(weptab.BoxPhysicsMin, weptab.BoxPhysicsMax)
            self:SetCollisionBounds(weptab.BoxPhysicsMin, weptab.BoxPhysicsMax)
            self:SetSolid(SOLID_VPHYSICS)
            self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
        end

        if weptab.ModelScale then
            self:SetModelScale(weptab.ModelScale, 0)
        end
    end

    self:SetDTString(0, class)
end

function ENT:GetWeaponType()
    return self:GetDTString(0)
end
