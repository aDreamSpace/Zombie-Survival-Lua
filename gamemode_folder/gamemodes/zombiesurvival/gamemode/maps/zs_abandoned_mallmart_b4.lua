hook.Add("InitPostEntityMap", "Adding", function()
	local ent = ents.Create("sigil_barricadetower")
	if ent:IsValid() then
		ent:SetPos(Vector(14033, 8607, 305))
		ent:SetAngles(Angle(0, -180, 0))
		ent:Spawn()
	end
end)


hook.Add("InitPostEntityMap", "Adding2", function()
	local ent = ents.Create("sigil_medicaltower")
	if ent:IsValid() then
		ent:SetPos(Vector(10362, 10528, 473))
		ent:SetAngles(Angle(0, -90, 0))
		ent:Spawn()
	end
end)
