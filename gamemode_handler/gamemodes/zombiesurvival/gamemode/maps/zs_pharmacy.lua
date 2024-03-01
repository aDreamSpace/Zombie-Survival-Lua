hook.Add("InitPostEntity", "BLASTDOORED", function()
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
	ent:SetModel("models/props_lab/blastdoor001a.mdl")
	ent:SetPos(Vector(-926.35, 806.07, 81.2))
	ent:SetAngles(Angle(72.87, 146.16, 15.48))
	ent:SetColor(Color(0, 0, 0))
	ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
	ent:SetModel("models/props_lab/blastdoor001a.mdl")
	ent:SetPos(Vector(-866, 729.76, 35.1))
	ent:SetAngles(Angle(62.81, 132.5, 3.87))
	ent:SetColor(Color(0, 0, 0))
	ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
	ent:SetModel("models/props_lab/blastdoor001a.mdl")
	ent:SetPos(Vector(-797.72, 644.82, 8.28))
	ent:SetAngles(Angle(70.92, 129.25, 0))
	ent:SetColor(Color(0, 0, 0))
	ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
end)