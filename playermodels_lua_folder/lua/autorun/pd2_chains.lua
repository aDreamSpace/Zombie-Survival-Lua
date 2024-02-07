local NPC = { 	Name = "Chains", 
				Class = "npc_Citizen",
				Model = "models/shaklin/payday2/pd2_chains.mdl",
				Health = "1500",
				KeyValues = { citizentype = 4 },
				Category = "PAYDAY 2 NPCs"	}


list.Set( "NPC", "npc_pd2_chains", NPC )


/*
	Addon by Shaklin	
*/

player_manager.AddValidModel( "Chains", 		"models/player/pd2_chains_p.mdl" );
player_manager.AddValidHands( "Chains", "models/shaklin/payday2/weapons/arms/c_arms_chains.mdl", 0, "00000000" )
list.Set( "PlayerOptionsModel", "Chains", 	"models/player/pd2_chains_p.mdl" );