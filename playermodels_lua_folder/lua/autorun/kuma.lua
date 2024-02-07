local function AddPlayerModel( name, model ) 

	list.Set( "PlayerOptionsModel", name, model ) 
	player_manager.AddValidModel( name, model ) 
end 

AddPlayerModel( "Tekken (Kuma Costume)", "models/player/kuma/kuma.mdl" )