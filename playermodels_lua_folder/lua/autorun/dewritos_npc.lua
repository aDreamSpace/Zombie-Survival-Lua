local Category = "Dewritos NPC" 

--Friendly--

local NPC = {
Name			= "Dewrito",
Category		= Category,
Class			= "npc_citizen",
KeyValues		= { citizentype = 4, Squadname = "dewrito", Health = "200" },
Model			= "models/npc/dewrito_friendly.mdl",
Skin			= 0,
Weapons			= { "weapon_smg1", "weapon_ar2", "weapon_shotgun" }
}
list.Set( "NPC", "dewritos_npc_friendly", NPC )

--Medic--

local NPC = {
Name			= "Dewrito Medic",
Category		= Category,
Class			= "npc_citizen",
SpawnFlags		= SF_CITIZEN_MEDIC,
KeyValues		= { citizentype = 4, Squadname = "dewrito", Health = "210" },
Model			= "models/npc/dewrito_friendly.mdl",
Skin			= 1,
Weapons			= { "weapon_pistol", "weapon_smg1" }
}
list.Set( "NPC", "dewritos_npc_medic", NPC )

--Enemy--

local NPC = {
Name			= "Dewrito Enemy",
Category		= Category,
Class			= "npc_combine_s",
KeyValues		= { Squadname = "dewrito_enemy", Health = "200", Numgrenades = 5 },
Model			= "models/npc/dewrito_enemy.mdl",
Skin			= 0,
Weapons			= { "weapon_ar2", "weapon_crossbow", "weapon_shotgun" },
}
list.Set( "NPC", "dewritos_npc_enemy", NPC )