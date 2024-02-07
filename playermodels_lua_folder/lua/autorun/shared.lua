list.Set( "PlayerOptionsModel", "Agent Smith", "models/player/smith.mdl" )
player_manager.AddValidModel( "Agent Smith", "models/player/smith.mdl" )

local Category = "Agent Smith"

local NPC = { 	Name = "Smith - Hostile", 
				Class = "npc_combine_s",
				Model = "models/player/smith.mdl",
				Squadname = "Smith",
				Numgrenades = "0",
				Health = "100",
				Category = Category	}

list.Set( "NPC", "npc_smith_h", NPC )

