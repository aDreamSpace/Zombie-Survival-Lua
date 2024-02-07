hook.Add("InitPostEntity", "BLASTDOORED.ORG", function()
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
	ent:SetModel("models/props_lab/blastdoor001a.mdl")
	ent:SetPos(Vector(-1773.09, 1234.35, 437.62))
	ent:SetAngles(Angle(-56.1, -163.49, 164.13))
	ent:SetColor(Color(0, 0, 0))
	ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
	ent:SetModel("models/props_lab/blastdoor001a.mdl")
	ent:SetPos(Vector(-1845.1, 1119.71, 359.29))
	ent:SetAngles(Angle(50.95, -16.72, -12.5))
	ent:SetColor(Color(0, 0, 0))
	ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
	ent:SetModel("models/props_lab/blastdoor001a.mdl")
	ent:SetPos(Vector(-1797.29, 1058.92, 350.58))
	ent:SetAngles(Angle(1.61, -86.91, -0.01))
	ent:SetColor(Color(0, 0, 0))
	ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end	
end)