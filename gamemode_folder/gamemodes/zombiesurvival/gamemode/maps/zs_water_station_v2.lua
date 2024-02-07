hook.Add("InitPostEntity", "blastdoord", function()
	--add a prop bridge
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
	ent:SetModel("models/props_lab/blastdoor001a.mdl")
	ent:SetPos(Vector(1114.85, -338.7, 244.08))
	ent:SetAngles(Angle(-53, 176.93, -6.64))
	ent:SetColor(Color(0, 0, 0))
	ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
	ent:SetModel("models/props_lab/blastdoor001a.mdl")
	ent:SetPos(Vector(756.22, -146.43, 65.07))
	ent:SetAngles(Angle(52.35, -7.66, 19.23))
	ent:SetColor(Color(0, 0, 0))
	ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
	ent:SetModel("models/props_lab/blastdoor001a.mdl")
	ent:SetPos(Vector(916.87, -248.79, 173.99))
	ent:SetAngles(Angle(65.5, -13.5, 11.66))
	ent:SetColor(Color(0, 0, 0))
	ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
	ent:SetModel("models/props_lab/blastdoor001a.mdl")
	ent:SetPos(Vector(832.76, -192.75, 124.62))
	ent:SetAngles(Angle(61.8, -11.35, 14.52))
	ent:SetColor(Color(0, 0, 0))
	ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
	ent:SetModel("models/props_lab/blastdoor001a.mdl")
	ent:SetPos(Vector(686.32, -113.42, 10.89))
	ent:SetAngles(Angle(60.11, -7.49, 16.5))
	ent:SetColor(Color(0, 0, 0))
	ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
	ent:SetModel("models/props_lab/blastdoor001a.mdl")
	ent:SetPos(Vector(1006.39, -296.45, 217.23))
	ent:SetAngles(Angle(71.92, 8.88, 27.85))
	ent:SetColor(Color(0, 0, 0))
	ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end

	--block op cading spot
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001c.mdl")
		ent:SetPos(Vector(520.79, 1920.66, -510.87))
		ent:SetAngles(Angle(-0.02, -179.98, 1.82))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
		ent:Spawn()
	end

end)
