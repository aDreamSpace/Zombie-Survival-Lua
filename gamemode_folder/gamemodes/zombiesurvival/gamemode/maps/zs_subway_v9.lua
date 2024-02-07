hook.Add("InitPostEntity", "BLASTDOORED", function()
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(2484.7, -2621.86, -213.31))
		ent:SetAngles(Angle(-0.3, -179.73, -0.68))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
	 ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001c.mdl")
		ent:SetPos(Vector(2755.29, 148.88, -394.35))
		ent:SetAngles(Angle(0.04, -90.01, 0))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
	 ent:Spawn()
	end
end)