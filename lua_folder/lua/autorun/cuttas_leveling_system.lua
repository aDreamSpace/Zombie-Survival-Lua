if SERVER then
    include("sv_cuttas_leveling.lua")
    include("cl_cuttas_leveling.lua")
    include("shared_cuttas_leveling.lua")
    
    AddCSLuaFile("cl_cuttas_leveling.lua")
    AddCSLuaFile("vgui_cuttas_leveling_skills.lua")
    AddCSLuaFile("shared_cuttas_leveling.lua")
elseif CLIENT then
    include("cl_cuttas_leveling.lua")
    include("vgui_cuttas_leveling_skills.lua")
    include("shared_cuttas_leveling.lua")
end

