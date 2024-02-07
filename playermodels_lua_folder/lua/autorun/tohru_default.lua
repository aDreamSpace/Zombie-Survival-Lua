player_manager.AddValidModel( "Tohru", "models/player/dewobedil/maid_dragon/tohru/default_p.mdl" );
player_manager.AddValidHands( "Tohru", "models/player/dewobedil/maid_dragon/tohru/c_arms/default_p.mdl", 0, "00000000" )

local Category = "Maid Dragon"

local NPC =
{
	Name = "Tohru (Friendly)",
	Class = "npc_citizen",
	Health = "100",
	KeyValues = { citizentype = 4 },
	Model = "models/player/dewobedil/maid_dragon/tohru/default_f.mdl",
	Category = Category
}

list.Set( "NPC", "npc_tohru_default_f", NPC )

local NPC =
{
	Name = "Tohru (Enemy)",
	Class = "npc_combine_s",
	Health = "100",
	Numgrenades = "4",
	Model = "models/player/dewobedil/maid_dragon/tohru/default_e.mdl",
	Category = Category
}

list.Set( "NPC", "npc_tohru_default_e", NPC )

if SERVER then
	resource.AddWorkshop("908040809")
end