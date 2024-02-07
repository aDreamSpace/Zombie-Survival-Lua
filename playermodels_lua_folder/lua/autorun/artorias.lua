-- COPYRIGHT MODEL @FROMSOFTWARE DARKSOULS/GARRYS MOD; ADDON BY DARKWRAITH 
local NPC = { 	Name = "Artorias", 
				Class = "npc_Citizen",
				Model = "models/dwdarksouls/models/artoriasNPC.mdl",
				Health = "1200",
				KeyValues = { citizentype = 4 },
				Category = "Dark Souls"	}


list.Set( "NPC", "npc_Artorias", NPC )
list.Set( "PlayerOptionsModel", "Artorias", 	"models/dwdarksouls/models/artorias.mdl" )

player_manager.AddValidModel( "Artorias", 	"models/dwdarksouls/models/artorias.mdl")
player_manager.AddValidHands( "Artorias", 	"models/dwdarksouls/models/artoriasfp.mdl", 0, "00000000" )