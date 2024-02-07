--Add Playermodel
player_manager.AddValidModel( "Ins2 Security Light", "models/player/ins_security_light.mdl" )
player_manager.AddValidHands( "Ins2 Security Light", "models/arms/security_light_arms.mdl", 0, "00000000" )

local Category = "Insurgency 2"

local NPC =
{
	Name = "Ins2 Security Light (Friendly)",
	Class = "npc_citizen",
	Weapons = { "weapon_smg1" },
	Numgrenades = "4",
	Health = "70",
	KeyValues = { citizentype = 4 },
	Model = "models/npc/ins_security_light_f.mdl",
	Category = Category
}

list.Set( "NPC", "ins_security_light_friendly", NPC )

local NPC =
{
	Name = "Ins2 Security Light (Enemy)",
	Class = "npc_combine_s",
	Weapons = { "weapon_smg1" },
	Numgrenades = "4",
	Health = "70",
	Numgrenades = "4",
	Model = "models/npc/ins_security_light_e.mdl",
	Category = Category
}

list.Set( "NPC", "ins_security_light_enemy", NPC )
