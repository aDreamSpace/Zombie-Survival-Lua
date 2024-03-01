if (SERVER) then
     player_manager.AddValidModel( "Lilith_bl1", "models/mark2580/borderlands/bl1_lilith_player.mdl" )
	 AddCSLuaFile( "lilith_player_npc.lua" )
end
list.Set( "PlayerOptionsModel", "Lilith_bl1", "models/mark2580/borderlands/bl1_lilith_player.mdl" )