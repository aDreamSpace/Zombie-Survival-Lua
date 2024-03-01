hook.Add("InitPostEntity", "BetterCades", function()
    --better sheriffs office cade
	local ent1 = ents.Create("prop_dynamic_override")
	if ent1:IsValid() then
		ent1:SetPos(Vector(-155.00, 625.47, -583.50))
		ent1:SetAngles(Angle(-0.052, -179.937, 0.005))
		ent1:SetKeyValue("solid", "6")
		ent1:SetModel(Model("models/props_lab/blastdoor001a.mdl"))
		ent1:SetColor(Color(0, 0, 0, 0))
		ent1:Spawn()
	end

    --better wells fargo cade
    local ent2 = ents.Create("prop_dynamic_override")
	if ent2:IsValid() then
		ent2:SetPos(Vector(80.48, -613.57, -628.13))
		ent2:SetAngles(Angle(-0.379, 0.293, -0.175))
		ent2:SetKeyValue("solid", "6")
		ent2:SetModel(Model("models/props_lab/blastdoor001a.mdl"))
		ent2:SetColor(Color(0, 0, 0, 0))
		ent2:Spawn()
	end

	local ent3 = ents.Create("prop_dynamic_override")
	if ent3:IsValid() then
		ent3:SetPos(Vector(-260.77, -788.46, -633.88))
		ent3:SetAngles(Angle(-0.082, 0.089, 0.030))
		ent3:SetKeyValue("solid", "6")
		ent3:SetModel(Model("models/props_lab/blastdoor001a.mdl"))
		ent3:SetColor(Color(0, 0, 0, 0))
		ent3:Spawn()
	end

	--better cades all around
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(1075.45, 588.65, -627.27))
		ent:SetAngles(Angle(-0.31, 0.22, -0.36))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(1075.32, 780.35, -626.65))
		ent:SetAngles(Angle(-0.39, 0.25, 0.33))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(991.49, 834.29, -469.5))
		ent:SetAngles(Angle(-5.76, 0.02, 89.99))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(995.4, 591.16, -511.17))
		ent:SetAngles(Angle(-5.96, 0.27, 0.01))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(1095.7, 85.46, -454.42))
		ent:SetAngles(Angle(-0.28, 179.7, 89.73))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(1095.62, -58.3, -452.55))
		ent:SetAngles(Angle(-0.15, 179.68, 90.34))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(1408.46, -272.4, -456.72))
		ent:SetAngles(Angle(-0.29, 89.67, -90.04))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(1562.71, -272.49, -458.79))
		ent:SetAngles(Angle(-0.28, -90.31, 89.84))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(1515.65, -272.51, -629.61))
		ent:SetAngles(Angle(-0.42, -89.81, 0.07))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(1293.73, -272.33, -574.09))
		ent:SetAngles(Angle(0.2, -89.78, -90.32))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(348.25, -693.21, -484.6))
		ent:SetAngles(Angle(-0.01, 0.01, 0.14))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(280.3, 359.61, -631.5))
		ent:SetAngles(Angle(-0.23, 90.29, -0.03))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(1096.11, 49.65, -572.2))
		ent:SetAngles(Angle(0, 0, 90))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent and ent:IsValid() then
		ent:SetModel("models/props_lab/blastdoor001a.mdl")
		ent:SetPos(Vector(1095.46, 81.51, -570.59))
		ent:SetAngles(Angle(-0.25, 179.54, 90.05))
		ent:SetColor(Color(0, 0, 0))
		ent:SetKeyValue("solid", "6")
	ent:Spawn()
	end

end)