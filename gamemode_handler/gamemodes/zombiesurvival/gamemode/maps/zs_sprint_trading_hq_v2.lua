hook.Add("InitPostEntity", "Blastdoors", function()
	--requested
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(-308.57, -309.46, 62.26))
		ent:SetAngles(Angle(0.26, -179.61, 91.15))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
		ent:Spawn()
	end
end)