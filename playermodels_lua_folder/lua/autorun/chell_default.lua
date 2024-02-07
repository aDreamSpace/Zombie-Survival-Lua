player_manager.AddValidModel( "Chell", "models/player/dewobedil/mmd/chell/default_p.mdl" );
player_manager.AddValidHands( "Chell", "models/player/dewobedil/mmd/chell/c_arms/default_p.mdl", 0, "00000000" )

local Category = "MMD"

local NPC =
{
	Name = "Chell (Friendly)",
	Class = "npc_citizen",
	Health = "100",
	KeyValues = { citizentype = 4 },
	Model = "models/player/dewobedil/mmd/chell/default_f.mdl",
	Category = Category
}

list.Set( "NPC", "npc_chell_default_f", NPC )

local NPC =
{
	Name = "Chell (Enemy)",
	Class = "npc_combine_s",
	Health = "100",
	Numgrenades = "4",
	Model = "models/player/dewobedil/mmd/chell/default_e.mdl",
	Category = Category
}

list.Set( "NPC", "npc_chell_default_e", NPC )

if SERVER then
	resource.AddWorkshop("946847096")
end