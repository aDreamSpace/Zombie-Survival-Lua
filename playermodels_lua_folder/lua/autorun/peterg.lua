player_manager.AddValidModel( "Peter Griffin", "models/player/familyguy/peterg/peterg.mdl" );
list.Set( "PlayerOptionsModel", "Peter Griffin", "models/player/familyguy/peterg/peterg.mdl" );

--NPC Time!
local Category = "Family Guy" --This is where the npc will show up
 
local NPC = {   Name = "Peter (Friendly Shotgun)", 
                Class = "npc_citizen",
                Model = "models/player/familyguy/peterg/peterg.mdl", 
                Health = "125", 
                KeyValues = { citizentype = 4 }, 
                Weapons = { "weapon_shotgun" }, 
                Category = Category }
                               
list.Set( "NPC", "npc_petg_f_sg", NPC )

local Category = "Family Guy" --This is where the npc will show up
 
local NPC = {   Name = "Peter (Friendly RPG)", 
                Class = "npc_citizen",
                Model = "models/player/familyguy/peterg/peterg.mdl", 
                Health = "125", 
                KeyValues = { citizentype = 4 }, 
                Weapons = { "weapon_rpg" }, 
                Category = Category }
                               
list.Set( "NPC", "npc_petg_f_rpg", NPC )

local Category = "Family Guy" --This is where the npc will show up
 
local NPC = {   Name = "Peter (Friendly Pulse Rifle)", 
                Class = "npc_citizen",
                Model = "models/player/familyguy/peterg/peterg.mdl", 
                Health = "125", 
                KeyValues = { citizentype = 4 }, 
                Weapons = { "weapon_ar2" }, 
                Category = Category }
                               
list.Set( "NPC", "npc_petg_f_pr", NPC )

local Category = "Family Guy" --This is where the npc will show up
 
local NPC = {   Name = "Peter (Hostile Shotgun)", 
                Class = "npc_combine",
                Model = "models/player/familyguy/peterg/peterg.mdl", --Path to your model
                Health = "125", 
                Weapons = { "weapon_shotgun" }, 
                Category = Category }
                               
list.Set( "NPC", "npc_petg_h_sg", NPC )

local Category = "Family Guy" --This is where the npc will show up
 
local NPC = {   Name = "Peter (Hostile RPG)", 
                Class = "npc_combine",
                Model = "models/player/familyguy/peterg/peterg.mdl", --Path to your model
                Health = "125", 
                Weapons = { "weapon_rpg" }, 
                Category = Category }
                               
list.Set( "NPC", "npc_petg_h_rpg", NPC )

local Category = "Family Guy" --This is where the npc will show up
 
local NPC = {   Name = "Peter (Hostile Pulse Rifle)", 
                Class = "npc_combine",
                Model = "models/player/familyguy/peterg/peterg.mdl", --Path to your model
                Health = "125", 
                Weapons = { "weapon_ar2" }, 
                Category = Category }
                               
list.Set( "NPC", "npc_petg_h_pr", NPC )




	