hook.Add("InitPostEntity", "blastdoors", function()
	--allow bots to get to a shitty cade location
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001c.mdl")
		ent:SetPos(Vector(1119.34, 5447.23, -145.77))
		ent:SetAngles(Angle(76.62, -12.99, 89.85))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
	 ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001c.mdl")
		ent:SetPos(Vector(994.07, 5458.73, -173.87))
		ent:SetAngles(Angle(-90, -90, 180))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
	 ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001c.mdl")
		ent:SetPos(Vector(1257.62, 5303.25, -124.45))
		ent:SetAngles(Angle(-89.19, 141.64, 115.4))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
	 ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001c.mdl")
		ent:SetPos(Vector(1445.37, 5368.52, -123.9))
		ent:SetAngles(Angle(89.28, -77.2, 25.78))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
	 ent:Spawn()
	end
	

end)