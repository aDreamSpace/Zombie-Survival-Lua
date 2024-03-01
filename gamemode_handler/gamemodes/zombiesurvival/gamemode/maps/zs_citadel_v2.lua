hook.Add("InitPostEntity", "NewBlastdoors", function()
local ent = ents.Create("prop_dynamic_override")
if ent and ent:IsValid() then
ent:SetModel("models/props_lab/blastdoor001a.mdl")
ent:SetPos(Vector(1511.65, -211.22, 1032.36))
ent:SetAngles(Angle(3.45, 90.96, 0.01))
ent:SetColor(Color(0, 0, 0))
ent:SetKeyValue("solid", "6")
ent:Spawn()
end

local ent = ents.Create("prop_dynamic_override")
if ent and ent:IsValid() then
ent:SetModel("models/props_lab/blastdoor001a.mdl")
ent:SetPos(Vector(1388.33, -225.41, 1025.22))
ent:SetAngles(Angle(0, 89.06, -1.01))
ent:SetColor(Color(0, 0, 0))
ent:SetKeyValue("solid", "6")
ent:Spawn()
end

local ent = ents.Create("prop_dynamic_override")
if ent and ent:IsValid() then
ent:SetModel("models/props_lab/blastdoor001a.mdl")
ent:SetPos(Vector(1482.82, -216.79, 1108.2))
ent:SetAngles(Angle(-2.65, -91.29, 89.19))
ent:SetColor(Color(0, 0, 0))
ent:SetKeyValue("solid", "6")
ent:Spawn()
end
end)