ITEM.Name = 'Luigi'
ITEM.Price = 5500
ITEM.Model = 'models/sinful/luigib.mdl'

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
	player_manager.AddValidModel( 'luigib', 'models/sinful/luigib.mdl' )
	AddCSLuaFile( 'luigib.lua' )
end

list.Set( 'PlayerOptionsModel',  'luigib', 'models/sinful/luigib.mdl' )