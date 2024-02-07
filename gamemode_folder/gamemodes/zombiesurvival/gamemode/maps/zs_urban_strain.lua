hook.Add("InitPostEntity", "AddExtraProp", function()
    local prop = ents.Create("prop_dynamic_override")
    if prop and prop:IsValid() then
        prop:SetModel("models/props_wasteland/controlroom_chair001a.mdl")
        prop:SetPos(Vector(-258.20, 952.43, 84.43))
        prop:SetAngles(Angle(0.294, 54.246, -0.050))
        prop:SetKeyValue("solid", "6")
        prop:Spawn()
    end
end)