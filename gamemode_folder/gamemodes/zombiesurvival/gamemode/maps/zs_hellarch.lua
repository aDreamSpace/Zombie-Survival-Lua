hook.Add("InitPostEntityMap", "dustfix", function()
    for k, v in pairs(ents.FindByClass("func_dust*")) do
        v:Remove()
    end
end)