player_manager.AddValidModel( "Kizuna AI", "models/player/dewobedil/vocaloid/kizuna_ai/default_p.mdl" );
player_manager.AddValidHands( "Kizuna AI", "models/player/dewobedil/vocaloid/kizuna_ai/c_arms/default_p.mdl", 0, "00000000" )

local Category = "AI"

local NPC =
{
	Name = "Kizuna AI(Friendly)",
	Class = "npc_citizen",
	Health = "100",
	KeyValues = { citizentype = 4 },
	Model = "models/player/dewobedil/vocaloid/kizuna_ai/default_f.mdl",
	Category = Category
}

list.Set( "NPC", "npc_kizuna_ai_default_f", NPC )

local NPC =
{
	Name = "Kizuna AI(Enemy)",
	Class = "npc_combine_s",
	Health = "100",
	Numgrenades = "4",
	Model = "models/player/dewobedil/vocaloid/kizuna_ai/default_e.mdl",
	Weapons = { "weapon_pistol" },
	Category = Category
}

list.Set( "NPC", "npc_kizuna_ai_default_e", NPC )

if SERVER then
	resource.AddWorkshop("870523620")
end