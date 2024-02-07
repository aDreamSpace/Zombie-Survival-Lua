hook.Add("InitPostEntityMap", "Adding", function()
	local ent = ents.FindByClass("trigger_teleport")

	ent[1]:Remove()
	ent[3]:Remove()
	ent[7]:Remove()
	ent[11]:Remove()
	ent[13]:Remove()
	ent[14]:Remove()

	--disable pub secret room cade
	local ent1 = ents.Create("prop_dynamic_override")
	if ent1:IsValid() then
		ent1:SetPos(Vector(-1019.92, 644.73, 214.99))
		ent1:SetAngles(Angle(-0.263, -89.680, -0.681))
		ent1:SetKeyValue("solid", "6")
		ent1:SetModel(Model("models/props_lab/blastdoor001a.mdl"))
		ent1:SetColor(Color(0, 0, 0, 0))
		ent1:Spawn()
	end

	--disable keypad for another secret room cade
	local btn = ents.FindByName("kp_*")
	if btn and #btn > 0 then
		for _, v in pairs(btn) do
			if v:GetClass() == "func_button" then
				v:Remove()
			end
		end
	end
end)
