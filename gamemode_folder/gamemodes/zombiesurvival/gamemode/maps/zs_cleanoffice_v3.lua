hook.Add("InitPostEntity", "FixLighting", function()

	--dims the map lighting so it is bearable
	engine.LightStyle(0, "b") BroadcastLua("render.RedownloadAllLightmaps(true)")
	util.RemoveAll("color_*")

	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(168.72, -143.74, 106.46))
		ent:SetAngles(Angle(-0.25, 0.27, -179.93))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
		ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(-272.7, -141.8, 0.44))
		ent:SetAngles(Angle(0.3, 179.74, -0.05))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
		ent:Spawn()
	end
end)