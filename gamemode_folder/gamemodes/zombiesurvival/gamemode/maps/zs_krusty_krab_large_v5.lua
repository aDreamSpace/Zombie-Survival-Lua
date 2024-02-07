hook.Add("InitPostEntity", "AddBlastdoors", function()

	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(-609.8, -1252.75, -73.31))
		ent:SetAngles(Angle(-0.28, 179.7, 89.17))
		ent:SetKeyValue("solid", "6")
		ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(1588.54, -562.06, -405.85))
		ent:SetAngles(Angle(-0.28, 179.68, 91.02))
		ent:SetKeyValue("solid", "6")
		ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(-105.6, -556.26, -353.62))
		ent:SetAngles(Angle(0.08, -0.85, 90.41))
		ent:SetKeyValue("solid", "6")
		ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001c.mdl")
		ent:SetPos(Vector(436.14, 1291.33, -87.15))
		ent:SetAngles(Angle(89.95, -0.02, 180))
		ent:SetKeyValue("solid", "6")
		ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(-138.1, -1131.29, -575.04))
		ent:SetAngles(Angle(0.27, 90.25, 91.77))
		ent:SetKeyValue("solid", "6")
		ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
	ent:SetModel("models/props_lab/blastdoor001a.mdl")
	ent:SetPos(Vector(1596.31, -388.73, -357.49))
	ent:SetAngles(Angle(-0.31, 89.73, 90.01))
	ent:SetColor(Color(0, 0, 0))
	ent:SetKeyValue("solid", "6")
	 ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
	ent:SetModel("models/props_lab/blastdoor001a.mdl")
	ent:SetPos(Vector(2342.68, -1035.3, -463.5))
	ent:SetAngles(Angle(-0.3, -89.73, -0.03))
	ent:SetColor(Color(0, 0, 0))
	ent:SetKeyValue("solid", "6")
	 ent:Spawn()
	end
	

end)