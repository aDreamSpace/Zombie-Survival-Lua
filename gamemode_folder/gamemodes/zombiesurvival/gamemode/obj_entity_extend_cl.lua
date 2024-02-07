local meta = FindMetaTable("Entity")
local M_Player = FindMetaTable("Player")
local P_Team = M_Player.Team

function meta:TransAlphaToMe()
	local radius = GAMEMODE.TransparencyRadius / 9
	if radius > 0 and P_Team(MySelf) == TEAM_HUMAN then
		local dist = self:GetPos():DistToSqr(EyePos())
		if dist < radius then
			return math.max(0.1, (dist / radius) ^ 0.5)
		end
	end

	return 1
end

local y = -50
local maxbarwidth = 560
local barheight = 30
function meta:Draw3DHealthBar(percentage, name, yoffset, widthprop, nameoffset)
	yoffset = yoffset or 0
	local barwidth = maxbarwidth * (widthprop or 1)
	local startx = barwidth * -0.5

	surface.SetDrawColor(0, 0, 0, 220)
	surface.DrawRect(startx, y + yoffset, barwidth, barheight)
	surface.SetDrawColor(255 - percentage * 255, percentage * 255, 0, 220)
	surface.DrawRect(startx + 4, y + 4 + yoffset, barwidth * percentage - 8, barheight - 8)
	surface.DrawOutlinedRect(startx, y + yoffset, barwidth, barheight)

	if name then
		draw.SimpleText(name, "ZS3D2DFont", 0, yoffset + (nameoffset or 0), COLOR_WHITE, TEXT_ALIGN_CENTER)
	end
end