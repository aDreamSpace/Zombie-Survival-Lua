local NPC = { 	Name = "Hoxton", 
				Class = "npc_Citizen",
				Model = "models/shaklin/payday2/pd2_hoxton.mdl",
				Health = "1500",
				KeyValues = { citizentype = 4 },
				Category = "PAYDAY 2 NPCs"	}


list.Set( "NPC", "npc_pd2_hoxton", NPC )


/*
	Addon by Shaklin	
*/

player_manager.AddValidModel( "Hoxton", 		"models/player/pd2_hoxton_p.mdl" );
player_manager.AddValidHands( "Hoxton", "models/shaklin/payday2/weapons/arms/c_arms_hoxton.mdl", 0, "00000000" )
list.Set( "PlayerOptionsModel", "Hoxton", 	"models/player/pd2_hoxton_p.mdl" );