player_manager.AddValidModel( "Antlion hl2", "models/echo/hl2_antlion_pm.mdl" )
player_manager.AddValidModel( "Antlion Worker", "models/echo/antlion_worker_pm.mdl" )
player_manager.AddValidHands( "Antlion Worker", "models/weapons/c_arms_antlion_worker.mdl", 0, "0" )
player_manager.AddValidHands( "Antlion hl2", "models/weapons/c_arms_hl2antlion.mdl", 0, "0" )

hook.Add("PreDrawPlayerHands", "c_arms_hl2antlion", function(hands, vm, ply, wpn)
    if IsValid(hands) and hands:GetModel() == "models/weapons/c_arms_hl2antlion.mdl" then
        hands:SetSkin(ply:GetSkin())
    end
end)