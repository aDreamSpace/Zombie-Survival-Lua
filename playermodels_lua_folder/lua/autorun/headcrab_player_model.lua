player_manager.AddValidModel( "headcrab", "models/player/headcrab.mdl" );
list.Set( "PlayerOptionsModel", "headcrab", "models/player/headcrab.mdl" );

local NPC = { Name = "Headcrab",
Class = "npc_citizen",
Model = "models/player/headcrab.mdl",
Health = "100",
KeyValues = { citizentype = 4 },
Category = "Headcrab" }

list.Set( "NPC", "headcrab", NPC )