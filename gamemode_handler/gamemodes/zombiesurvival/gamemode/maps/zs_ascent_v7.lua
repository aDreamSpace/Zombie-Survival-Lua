hook.Add("InitPostEntityMap", "Adding", function()
	GAMEMODE.ZombieDamageMultiplier = 2
end)



if SERVER then 
ents.FindByClass("func_wall_toggle")[2]:Remove()
ents.FindByClass("func_wall_toggle")[1]:Remove() 
end

