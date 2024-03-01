hook.Add("InitPostEntityMap", "Adding", function()
	local ent = ents.Create("sigil_barricadetower")
	if ent:IsValid() then
		ent:SetPos(Vector(447, 4410, 80))
		ent:SetAngles(Angle(19, -90, 0))
		ent:Spawn()
	end
end)

hook.Add("InitPostEntityMap", "Adding2", function()
	local ent = ents.Create("sigil_medicaltower")
	if ent:IsValid() then
		ent:SetPos(Vector(-124, 2657, 80))
		ent:SetAngles(Angle(0, 0, 0))
		ent:Spawn()
	end
end)
