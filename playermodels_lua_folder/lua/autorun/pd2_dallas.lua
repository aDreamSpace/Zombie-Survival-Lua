local NPC = { 	Name = "Dallas", 
				Class = "npc_Citizen",
				Model = "models/shaklin/payday2/pd2_dallas.mdl",
				Health = "1500",
				KeyValues = { citizentype = 4 },
				Category = "PAYDAY 2 NPCs"	}


list.Set( "NPC", "npc_pd2_dallas", NPC )


/*
	Addon by Shaklin	
*/

player_manager.AddValidModel( "Dallas", 		"models/player/pd2_dallas_p.mdl" );
player_manager.AddValidHands( "Dallas", "models/shaklin/payday2/weapons/arms/c_arms_dallas.mdl", 0, "00000000" )
list.Set( "PlayerOptionsModel", "Dallas", 	"models/player/pd2_dallas_p.mdl" );