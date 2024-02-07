include("shared.lua")

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:DrawTranslucent()
	local h = MySelf:Team() == TEAM_HUMAN

	self:DrawModel()
	
	if (h) then
		local owner = self:GetObjectOwner()
		local hpfrac = self:GetObjectHealth() / self:GetMaxObjectHealth()
		local fufrac = self:GetObjectFuel() / self:GetMaxObjectFuel()
	
		local pos, ang = self:GetPos(), self:GetAngles()
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Forward(), 90)
		pos = pos + ang:Up() * 17 + ang:Forward() * 4 + ang:Right() * -26
		cam.Start3D2D(pos, ang, 0.05)
			draw.RoundedBox(8, -280, -50, 560, 200, Color(0, 0, 0, 220))
			draw.SimpleText("Nail Economy", "ZS3D2DFont2", 0, -10, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			if (IsValid(owner)) then
				draw.SimpleText("(" .. owner:Nick() .. ")", "ZS3D2DFont2Smaller", 0, 42, team.GetColor( TEAM_HUMAN ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end

			draw.RoundedBox(math.min(hpfrac * 272.5, 8), -275, 105, math.Round(272.5 * hpfrac), 40, Color(255 - 255 * hpfrac, 255 * hpfrac, 0))
			draw.SimpleText("HP: " .. math.Round(hpfrac * 100) .. "%", "ZS3D2DFont2Smaller", -135, 85, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			
			draw.RoundedBox(math.min(fufrac * 272.5, 8), 2.5, 105, math.Round(272.5 * fufrac), 40, Color(255, 150, 0))
			draw.SimpleText("POWER: " .. math.Round(fufrac * 100) .. "%", "ZS3D2DFont2Smaller", 145, 85, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		cam.End3D2D()
	end
end