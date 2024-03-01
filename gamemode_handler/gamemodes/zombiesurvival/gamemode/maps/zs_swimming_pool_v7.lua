hook.Add("InitPostEntityMap", "Adding", function()

	--covers a hole in the wall that makes a cading location useless
	local ent2 = ents.Create("prop_dynamic_override")
	if ent2:IsValid() then
		ent2:SetPos(Vector(571.26, 176.65, 60.70))
		ent2:SetAngles(Angle(0.061, -0.056, 89.987))
		ent2:SetKeyValue("solid", "6")
		ent2:SetModel(Model("models/props_lab/blastdoor001a.mdl"))
		ent2:SetColor(Color(0, 0, 0, 0))
		ent2:Spawn()
	end
end)