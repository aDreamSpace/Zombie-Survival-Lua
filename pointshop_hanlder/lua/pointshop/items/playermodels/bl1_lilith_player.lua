ITEM.Name = 'Lilith the Siren'
ITEM.Price = 5500
ITEM.Model = 'models/mark2580/borderlands/bl1_lilith_player.mdl'

function ITEM:OnEquip(ply, modifications)
	if not ply._OldModel then
		ply._OldModel = ply:GetModel()
	end

	timer.Simple(1, function() ply:SetModel(self.Model) end)
end

function ITEM:OnHolster(ply)
	if ply._OldModel then
		ply:SetModel(ply._OldModel)
	end
end

function ITEM:PlayerSetModel(ply)
	ply:SetModel(self.Model)
end

if (SERVER) then
	player_manager.AddValidModel( 'bl1_lilith_player', 'models/mark2580/borderlands/bl1_lilith_player.mdl' )
	AddCSLuaFile( 'bl1_lilith_player.lua' )
end

list.Set( 'PlayerOptionsModel',  'bl1_lilith_player', 'models/mark2580/borderlands/bl1_lilith_player.mdl' )
