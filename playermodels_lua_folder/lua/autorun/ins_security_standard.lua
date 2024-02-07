--Add Playermodel
player_manager.AddValidModel( "Ins2 Security Standard", "models/player/ins_security_standard.mdl" )
player_manager.AddValidHands( "Ins2 Security Standard", "models/arms/security_standard_arms.mdl", 0, "00000000" )

local Category = "Insurgency 2"

local NPC =
{
	Name = "Ins2 Security Standard (Friendly)",
	Class = "npc_citizen",
	Weapons = { "weapon_smg1" },
	Numgrenades = "4",
	Health = "100",
	KeyValues = { citizentype = 4 },
	Model = "models/npc/ins_security_standard_f.mdl",
	Category = Category
}

list.Set( "NPC", "ins_security_standard_friendly", NPC )

local NPC =
{
	Name = "Ins2 Security Standard (Enemy)",
	Class = "npc_combine_s",
	Weapons = { "weapon_smg1" },
	Numgrenades = "4",
	Health = "100",
	Numgrenades = "4",
	Model = "models/npc/ins_security_standard_e.mdl",
	Category = Category
}

list.Set( "NPC", "ins_security_standard_enemy", NPC )
