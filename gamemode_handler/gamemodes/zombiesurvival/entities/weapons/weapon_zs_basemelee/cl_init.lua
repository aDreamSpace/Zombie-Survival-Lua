include("shared.lua")
include("animations.lua")

SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.ViewModelFOV = 60

SWEP.Slot = 0
SWEP.SlotPos = 0

function SWEP:TranslateFOV(fov)
	return GAMEMODE.FOVLerp * fov
end

function SWEP:DrawWeaponSelection(...)
	return self:BaseDrawWeaponSelection(...)
end

function SWEP:DrawHUD()
	if GetConVarNumber("crosshair") ~= 1 then return end
	self:DrawCrosshairDot()
end

function SWEP:OnRemove()
	self:Anim_OnRemove()
end

function SWEP:ViewModelDrawn()
	self:Anim_ViewModelDrawn()
end

function SWEP:PreDrawViewModel(vm)
	if self.ShowViewModel == false then
		render.SetBlend(0)
	end
end

function SWEP:PostDrawViewModel(vm)
	if self.ShowViewModel == false then
		render.SetBlend(1)
	end
end

function SWEP:DrawWorldModel()
	local owner = self:GetOwner()
	if owner:IsValid() and owner.ShadowMan then return end

	self:Anim_DrawWorldModel()
end

hook.Add("HUDPaint", "DrawMeleeCooldownBar", function()
    local ply = LocalPlayer()

    -- Check if the player is using a melee weapon
    local wep = ply:GetActiveWeapon()
    if IsValid(wep) and wep:IsWeapon() and wep:GetClass() == "weapon_zs_melee" then
        local nextAttackTime = wep:GetNextPrimaryFire()
        local cooldown = nextAttackTime - CurTime()

        if cooldown > 0 then
            local x, y = ScrW() / 2, ScrH() / 2 + 30
            local width, height = 200, 20
            local padding = 10

            -- Draw the background
            draw.RoundedBox(8, x - width / 2, y + padding, width, height, Color(0, 0, 0, 150))

            -- Draw the cooldown bar
            local progress = math.Clamp(cooldown / wep.Primary.Delay, 0, 1)
            draw.RoundedBox(8, x - width / 2, y + padding, width * progress, height, Color(255, 0, 0, 255))
        end
    end
end)

local ghostlerp = 0
function SWEP:GetViewModelPosition(pos, ang)
	if self:IsSwinging() then
		local rot = self.SwingRotation
		local offset = self.SwingOffset

		ang = Angle(ang.pitch, ang.yaw, ang.roll) -- Copy

		local swingend = self:GetSwingEnd()
		local delta = self.SwingTime - math.Clamp(swingend - CurTime(), 0, self.SwingTime)
		local power = CosineInterpolation(0, 1, delta / self.SwingTime)

		if power >= 0.9 then
			power = (1 - power) ^ 0.4 * 2
		end

		pos = pos + offset.x * power * ang:Right() + offset.y * power * ang:Forward() + offset.z * power * ang:Up()

		ang:RotateAroundAxis(ang:Right(), rot.pitch * power)
		ang:RotateAroundAxis(ang:Up(), rot.yaw * power)
		ang:RotateAroundAxis(ang:Forward(), rot.roll * power)
	end

	if self.Owner:GetBarricadeGhosting() then
		ghostlerp = math.min(1, ghostlerp + FrameTime() * 4)
	elseif ghostlerp > 0 then
		ghostlerp = math.max(0, ghostlerp - FrameTime() * 5)
	end

	if ghostlerp > 0 then
		pos = pos + 3.5 * ghostlerp * ang:Up()
		ang:RotateAroundAxis(ang:Right(), -30 * ghostlerp)
	end

	return pos, ang
end
