hook.Add("InitPostEntity", "PlaceBlastdoors", function()
	--disable skycade spot
	local ent1 = ents.Create("prop_dynamic_override")
	if ent1:IsValid() then
		ent1:SetPos(Vector(179.98, 1280.80, 892.50))
		ent1:SetAngles(Angle(-88.584, -113.968, -158.939))
		ent1:SetKeyValue("solid", "6")
		ent1:SetModel(Model("models/props_lab/blastdoor001c.mdl"))
		ent1:SetColor(Color(0, 0, 0, 0))
		ent1:Spawn()
	end

	local ent1 = ents.Create("prop_dynamic_override")
	if ent1:IsValid() then
		ent1:SetPos(Vector(177.81, 1281.34, 890.24))
		ent1:SetAngles(Angle(89.449, -57.292, -144.371))
		ent1:SetKeyValue("solid", "6")
		ent1:SetModel(Model("models/props_lab/blastdoor001c.mdl"))
		ent1:SetColor(Color(0, 0, 0, 0))
		ent1:Spawn()
	end

	local ent1 = ents.Create("prop_dynamic_override")
	if ent1:IsValid() then
		ent1:SetPos(Vector(370.35, 1255.49, 891.07))
		ent1:SetAngles(Angle(-89.997, 179.339, 180.000))
		ent1:SetKeyValue("solid", "6")
		ent1:SetModel(Model("models/props_lab/blastdoor001c.mdl"))
		ent1:SetColor(Color(0, 0, 0, 0))
		ent1:Spawn()
	end
end)