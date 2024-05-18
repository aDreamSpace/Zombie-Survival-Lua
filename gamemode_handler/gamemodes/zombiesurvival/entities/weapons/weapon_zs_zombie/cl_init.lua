include("shared.lua")

SWEP.PrintName = "Zombie"
SWEP.ViewModelFOV = 90
SWEP.DrawCrosshair = false

function SWEP:Reload()
end

function SWEP:DrawWorldModel()
end
SWEP.DrawWorldModelTranslucent = SWEP.DrawWorldModel


function SWEP:DrawHUD()
	if GetConVarNumber("crosshair") ~= 1 then return end
	self:DrawCrosshairDot()
end

function SWEP:DrawWeaponSelection(...)
	return self:BaseDrawWeaponSelection(...)
end

hook.Add("HUDPaint", "DrawGlobalCooldownBar", function()
    local ply = LocalPlayer()

    local wep = ply:GetActiveWeapon()
    if IsValid(wep) and wep:IsWeapon() or wep.Base == "weapon_zs_zombie" then
        local nextAttackTime = wep:GetNextPrimaryFire() + 0.01 
        local cooldown = nextAttackTime - CurTime()

        if cooldown < 0 then return end

        local x, y = ScrW() / 2, ScrH() / 2 + 30
        local width, height = 200, 20
        local padding = 10

        draw.RoundedBoxEx(0, x - width / 2, y + padding + 10, width, height, Color(0, 0, 0, 150), false, false, false, false)

        local delay = wep.Primary and wep.Primary.Delay or 1
        local lastPrimaryFire = wep.LastPrimaryFire or nextAttackTime - delay
        local maxCooldown = nextAttackTime - lastPrimaryFire
        local progress = math.Clamp(cooldown / maxCooldown, 0, 1)
        draw.RoundedBoxEx(0, x - width / 2, y + padding + 10, width * (1 - progress), height, Color(0, 255, 119), false, false, false, false)

        draw.SimpleText(string.format("%4.2fs", cooldown), "ZSHUDFontSmall", x, y + padding + height / 2 + 10, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end)