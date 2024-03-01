hook.Add("InitPostEntity", "BetterSpawns", function()
    --lets delete ALL zombie spawns since they're all dumb
    local spawns = ents.FindByClass("info_player_undead")
    for _, ent in pairs(spawns) do
        ent:Remove()
    end

    --now lets make better ones!

    --table of vectors, each one will become a new spawn, just add more vectors for more spawns
    local newspawns = {
        Vector(2936.9, 59.91, -373.72),
        Vector(2756.42, 62.69, -360.41),
        Vector(2817.54, 92.14, -360.41),
        Vector(3219.39, 10.76, -397.34),
    }

    for _, v in ipairs(newspawns) do
        local spawn = ents.Create("info_player_undead")
        if spawn and spawn:IsValid() then
            spawn:SetPos(v)
            spawn:Spawn()
        end
    end
end)