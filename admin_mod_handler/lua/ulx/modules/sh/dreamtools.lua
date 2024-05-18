local CATEGORY_NAME = "Cheats"

function ulx.heal(calling_ply, target_ply)
    if not IsValid(calling_ply) then return end

    if not target_ply then
        target_ply = calling_ply
    end

    target_ply:SetHealth(target_ply:GetMaxHealth())

  --  ulx.fancyLogAdmin(calling_ply, "#A healed #T to full health", target_ply)
end
local heal = ulx.command(CATEGORY_NAME, "ulx heal", ulx.heal, "!heal")
heal:addParam{type=ULib.cmds.PlayerArg}
heal:defaultAccess(ULib.ACCESS_ADMIN)
heal:help("Heal yourself or another player to full health")


function ulx.givecurrentammo(calling_ply)
    if not IsValid(calling_ply) then return end

    local weapon = calling_ply:GetActiveWeapon()
    if not IsValid(weapon) then return end

    local ammo_type = weapon:GetPrimaryAmmoType()
    if ammo_type == -1 then return end

    local max_ammo = 4000
    calling_ply:SetAmmo(max_ammo, ammo_type)

    ulx.fancyLogAdmin(calling_ply, "#A gave themselves full ammo for their current weapon")
end
local givecurrentammo = ulx.command(CATEGORY_NAME, "ulx givecurrentammo", ulx.givecurrentammo, "!givecurrentammo")
givecurrentammo:defaultAccess(ULib.ACCESS_ADMIN)
givecurrentammo:help("Give yourself full ammo for your current weapon")