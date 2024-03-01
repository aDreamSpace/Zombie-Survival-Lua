hook.Add("InitPostEntity", "FixingThings", function()
    --first lets delete some props in zspawn
    local ToDelete = {
        1536,
        1540,
        1630,
        1629,
        1574,
        1539,
    }
    
    for _, id in pairs(ToDelete) do
        local ent = ents.GetMapCreatedEntity(id)
        if ent and ent:IsValid() then
            ent:Remove()
        end
    end

    --now lets add a blastdoor ramp to one of the zspawns so bots can get out
    local ent1 = ents.Create("prop_dynamic_override")
	if ent1:IsValid() then
		ent1:SetPos(Vector(-506.62, 329.35, 215.88))
		ent1:SetAngles(Angle(-83.727, 16.848, -14.566))
		ent1:SetKeyValue("solid", "6")
		ent1:SetModel(Model("models/props_lab/blastdoor001a.mdl"))
		ent1:SetColor(Color(0, 0, 0, 0))
		ent1:Spawn()
	end

    local ent2 = ents.Create("prop_dynamic_override")
	if ent2:IsValid() then
		ent2:SetPos(Vector(-502.54, 327.46, 215.04))
		ent2:SetAngles(Angle(-48.051, 0.563, 178.903))
		ent2:SetKeyValue("solid", "6")
		ent2:SetModel(Model("models/props_lab/blastdoor001a.mdl"))
		ent2:SetColor(Color(0, 0, 0, 0))
		ent2:Spawn()
	end

    local ent3 = ents.Create("prop_dynamic_override")
	if ent3:IsValid() then
		ent3:SetPos(Vector(-340.75, 323.20, 76.75))
		ent3:SetAngles(Angle(50.089, 177.726, -0.521))
		ent3:SetKeyValue("solid", "6")
		ent3:SetModel(Model("models/props_lab/blastdoor001a.mdl"))
		ent3:SetColor(Color(0, 0, 0, 0))
		ent3:Spawn()
	end
end)