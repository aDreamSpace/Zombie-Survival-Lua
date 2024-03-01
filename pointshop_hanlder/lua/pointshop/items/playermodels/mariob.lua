ITEM.Name = 'Mario'
ITEM.Price = 5500
ITEM.Model = 'models/sinful/mariob.mdl'

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
	player_manager.AddValidModel( 'mariob', 'models/sinful/mariob.mdl' )
	AddCSLuaFile( 'mariob.lua' )
end

list.Set( 'PlayerOptionsModel',  'mariob', 'models/sinful/mariob.mdl' )