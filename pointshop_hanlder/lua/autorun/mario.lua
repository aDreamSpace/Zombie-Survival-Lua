if (SERVER) then
     player_manager.AddValidModel( "mario_beta", "models/sinful/mariob.mdl" )
	 AddCSLuaFile( "mario.lua" )
end
list.Set( "PlayerOptionsModel", "mario_beta", "models/sinful/mariob.mdl" )
