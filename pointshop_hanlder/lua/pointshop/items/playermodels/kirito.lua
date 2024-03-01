ITEM.Name = 'Kirito'
ITEM.Price = 4500
ITEM.Model = 'models/player/bennyd/kirito.mdl'

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
	player_manager.AddValidModel( 'kirito', 'models/player/bennyd/kirito.mdl' )
	AddCSLuaFile( 'kirito.lua' )
end

list.Set( 'PlayerOptionsModel',  'kirito', 'models/player/bennyd/kirito.mdl' )