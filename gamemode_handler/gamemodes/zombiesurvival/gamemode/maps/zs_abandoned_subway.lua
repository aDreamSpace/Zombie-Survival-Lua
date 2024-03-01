hook.Add("InitPostEntity", "BLASTDOORS", function()
--disable skycade spot
	local prop = ents.Create("prop_dynamic_override")
	if prop:IsValid() then
		prop:SetPos(Vector(-359.15, 564.46, 187.19))
		prop:SetAngles(Angle(-89.984, -93.370, 180.000))
		prop:SetKeyValue("solid", "6")
		prop:SetModel(Model("models/props_lab/blastdoor001c.mdl"))
		prop:SetColor(Color(0, 0, 0, 0))
		prop:Spawn()
	end
end)