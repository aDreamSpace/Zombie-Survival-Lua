ENT.Type = "anim"
ENT.Base = "prop_baseoutlined"

ENT.NoNails = true

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "AmmoAmount")
    self:NetworkVar("String", 0, "WeaponType")
end

function ENT:SetAmmoAmount(amount)
    if amount ~= self:GetAmmoAmount() then
        self:SetDTInt(0, amount)
    end
end

function ENT:SetWeaponType(class)
    if class == nil then
        print("Warning: Attempting to set weapon type with nil class.")
        return
    end
    
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
        
        self:SetWeaponType(class)
    else
        print("Warning: Unable to get weapon information for class '" .. tostring(class) .. "'.")
    end
end

function ENT:GetWeaponType()
    return self:GetDTString(0)
end