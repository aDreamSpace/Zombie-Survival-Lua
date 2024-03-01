hook.Add("InitPostEntityMap", "Adding", function()
	for _, ent in pairs(ents.FindByClass("func_button")) do ent:Remove() end

	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001c.mdl")
		ent:SetPos(Vector(-4818.33, 1276.29, -210.34))
		ent:SetAngles(Angle(3.33, -179.44, 0.29))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
		ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001c.mdl")
		ent:SetPos(Vector(-4818.86, 1107.46, -211.11))
		ent:SetAngles(Angle(2.1, -179.8, 0.55))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
		ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001c.mdl")
		ent:SetPos(Vector(-4816.92, 770.59, -210.35))
		ent:SetAngles(Angle(2.78, 179.66, 0.64))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
		ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001c.mdl")
		ent:SetPos(Vector(-4819.18, 939.09, -211.64))
		ent:SetAngles(Angle(1.15, 179.76, 0.53))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
		ent:Spawn()
	end
end)
