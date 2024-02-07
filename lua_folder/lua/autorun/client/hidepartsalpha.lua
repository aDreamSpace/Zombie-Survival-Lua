local minAlpha = 0.3 -- 20% transparency when standing RIGHT NEXT to zombies
local distanceMaxAlpha = 100 -- 500 units (roughly ) away and further will show the players items in full transparency

hook.Add("PacExportsDone", "pacexportsdone", function(exported)

	--local pacEx = exported
	--if pacEx == nil then return end

	local partsFromEnt = exported

	local teams = {
		human = TEAM_HUMAN, -- fading transparency
		zombie = TEAM_UNDEAD -- complete negate
	}

	hook.Add("Think", "hideandmakeshitalpha", function()

		for _, ply in ipairs(player.GetAll()) do
			if IsValid(ply) and ply:IsPlayer() then
				if ply == MySelf then continue end
				local partList = partsFromEnt(ply)
				if table.Count(partList) == 0 then continue end
				local dist = MySelf:GetPos():Distance(ply:GetPos()) / distanceMaxAlpha
				local calc = math.Clamp(dist, minAlpha, 1)
				for _, part in pairs(partList) do
					if !(part.Alpha) then continue end -- item cant be made invisible
					if ply:Team() == teams.zombie then
						part.Alpha = 0
					elseif ply:Team() == teams.human then
						part.Alpha = calc
					end
				end
			end
		end

	end)

end)

hook.Add("PS2_VisualsShouldShow", "hideps2trailsssss", function(ply)
	if ply:Team() == TEAM_UNDEAD then return false end
end)
