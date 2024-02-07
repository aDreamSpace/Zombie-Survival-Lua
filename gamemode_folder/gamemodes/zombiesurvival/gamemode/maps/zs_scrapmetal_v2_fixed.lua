hook.Add("InitPostEntity", "BlastdoorsEverywhere", function()

    --disable a river cading spot
	local ent1 = ents.Create("prop_dynamic_override")
	if ent1:IsValid() then
		ent1:SetPos(Vector(-876.85, -2848.95, -437.00))
		ent1:SetAngles(Angle(25.967, -89.966, 0.088))
		ent1:SetKeyValue("solid", "6")
		ent1:SetModel(Model("models/props_lab/blastdoor001c.mdl"))
		ent1:SetColor(Color(0, 0, 0, 0))
		ent1:Spawn()
	end

    local ent2 = ents.Create("prop_dynamic_override")
	if ent2:IsValid() then
		ent2:SetPos(Vector(-1046.11, -2891.91, -341.49))
		ent2:SetAngles(Angle(-24.429, 89.951, 179.886))
		ent2:SetKeyValue("solid", "6")
		ent2:SetModel(Model("models/props_lab/blastdoor001c.mdl"))
		ent2:SetColor(Color(0, 0, 0, 0))
		ent2:Spawn()
	end

    local ent3 = ents.Create("prop_dynamic_override")
	if ent3:IsValid() then
		ent3:SetPos(Vector(-1214.23, -2847.50, -437.16))
		ent3:SetAngles(Angle(-26.882, 90.129, -0.152))
		ent3:SetKeyValue("solid", "6")
		ent3:SetModel(Model("models/props_lab/blastdoor001c.mdl"))
		ent3:SetColor(Color(0, 0, 0, 0))
		ent3:Spawn()
	end

    local ent4 = ents.Create("prop_dynamic_override")
	if ent4:IsValid() then
		ent4:SetPos(Vector(-1384.77, -2848.45, -437.62))
		ent4:SetAngles(Angle(-24.508, 90.333, 0.890))
		ent4:SetKeyValue("solid", "6")
		ent4:SetModel(Model("models/props_lab/blastdoor001c.mdl"))
		ent4:SetColor(Color(0, 0, 0, 0))
		ent4:Spawn()
	end

    local ent5 = ents.Create("prop_dynamic_override")
	if ent5:IsValid() then
		ent5:SetPos(Vector(-1553.12, -2850.11, -435.82))
		ent5:SetAngles(Angle(-23.039, 90.082, 0.350))
		ent5:SetKeyValue("solid", "6")
		ent5:SetModel(Model("models/props_lab/blastdoor001c.mdl"))
		ent5:SetColor(Color(0, 0, 0, 0))
		ent5:Spawn()
	end

    local ent6 = ents.Create("prop_dynamic_override")
	if ent6:IsValid() then
		ent6:SetPos(Vector(-1721.49, -2851.48, -434.32))
		ent6:SetAngles(Angle(24.233, -89.877, -0.308))
		ent6:SetKeyValue("solid", "6")
		ent6:SetModel(Model("models/props_lab/blastdoor001c.mdl"))
		ent6:SetColor(Color(0, 0, 0, 0))
		ent6:Spawn()
	end

    local ent7 = ents.Create("prop_dynamic_override")
	if ent7:IsValid() then
		ent7:SetPos(Vector(-1889.53, -2891.83, -335.49))
		ent7:SetAngles(Angle(22.067, -89.872, 179.764))
		ent7:SetKeyValue("solid", "6")
		ent7:SetModel(Model("models/props_lab/blastdoor001c.mdl"))
		ent7:SetColor(Color(0, 0, 0, 0))
		ent7:Spawn()
	end

    local ent8 = ents.Create("prop_dynamic_override")
	if ent8:IsValid() then
		ent8:SetPos(Vector(-2057.95, -2894.92, -335.75))
		ent8:SetAngles(Angle(23.438, -89.899, 179.767))
		ent8:SetKeyValue("solid", "6")
		ent8:SetModel(Model("models/props_lab/blastdoor001c.mdl"))
		ent8:SetColor(Color(0, 0, 0, 0))
		ent8:Spawn()
	end
    
    local ent9 = ents.Create("prop_dynamic_override")
	if ent9:IsValid() then
		ent9:SetPos(Vector(-2226.29, -2892.02, -334.37))
		ent9:SetAngles(Angle(21.731, -89.834, 179.797))
		ent9:SetKeyValue("solid", "6")
		ent9:SetModel(Model("models/props_lab/blastdoor001c.mdl"))
		ent9:SetColor(Color(0, 0, 0, 0))
		ent9:Spawn()
	end

    local ent10 = ents.Create("prop_dynamic_override")
	if ent10:IsValid() then
		ent10:SetPos(Vector(-2394.70, -2891.62, -334.37))
		ent10:SetAngles(Angle(-21.545, 90.171, -179.747))
		ent10:SetKeyValue("solid", "6")
		ent10:SetModel(Model("models/props_lab/blastdoor001c.mdl"))
		ent10:SetColor(Color(0, 0, 0, 0))
		ent10:Spawn()
	end

    local ent11 = ents.Create("prop_dynamic_override")
	if ent11:IsValid() then
		ent11:SetPos(Vector(-2563.12, -2894.81, -333.97))
		ent11:SetAngles(Angle(-23.372, 90.280, -179.712))
		ent11:SetKeyValue("solid", "6")
		ent11:SetModel(Model("models/props_lab/blastdoor001c.mdl"))
		ent11:SetColor(Color(0, 0, 0, 0))
		ent11:Spawn()
	end

    local ent12 = ents.Create("prop_dynamic_override")
	if ent12:IsValid() then
		ent12:SetPos(Vector(-2731.45, -2894.97, -331.55))
		ent12:SetAngles(Angle(-21.845, 90.086, -179.658))
		ent12:SetKeyValue("solid", "6")
		ent12:SetModel(Model("models/props_lab/blastdoor001c.mdl"))
		ent12:SetColor(Color(0, 0, 0, 0))
		ent12:Spawn()
	end

    local ent13 = ents.Create("prop_dynamic_override")
	if ent13:IsValid() then
		ent13:SetPos(Vector(-2891.41, -2851.26, -427.95))
		ent13:SetAngles(Angle(-21.904, 93.390, -1.264))
		ent13:SetKeyValue("solid", "6")
		ent13:SetModel(Model("models/props_lab/blastdoor001c.mdl"))
		ent13:SetColor(Color(0, 0, 0, 0))
		ent13:Spawn()
	end

	timer.Create("BootlegTriggerHurt", 3, 0, function()
		local tblEnts = ents.FindInBox(Vector(-3000, -2898, -440), Vector(-800, -2342, 318))
		for _, ent in pairs(tblEnts) do
			if ent and ent:IsValid() and ent:IsPlayer() then
				ent:TakeDamage(5000, ent, ent)
			end
		end
	end)
end)