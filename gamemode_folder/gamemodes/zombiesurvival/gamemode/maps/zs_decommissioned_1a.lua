hook.Add("InitPostEntity", "BLASTDOORED.NET", function()
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(-2820.83, 86.11, -19.26))
		ent:SetAngles(Angle(56.9, 90, 0))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(-2815.14, -68.58, -19.28))
		ent:SetAngles(Angle(54.26, -90.07, 0))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end

end)