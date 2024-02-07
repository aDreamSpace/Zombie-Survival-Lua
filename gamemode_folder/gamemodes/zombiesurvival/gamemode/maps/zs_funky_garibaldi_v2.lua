hook.Add("InitPostEntity", "AddBlastdoors", function()
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(4299.5, -4041.58, -2701.73))
		ent:SetAngles(Angle(-0.39, 90.17, -0.22))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
		ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(4509.16, -4016.59, -2702.59))
		ent:SetAngles(Angle(-0.22, 94.2, 0.29))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
		ent:Spawn()
	end
end)