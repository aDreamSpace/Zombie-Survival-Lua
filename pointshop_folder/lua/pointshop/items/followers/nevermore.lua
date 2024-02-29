ITEM.Name = 'Crow Pet'
ITEM.Price = 85000
ITEM.Model = 'models/crow.mdl'
ITEM.Follower = 'nevermore'

function ITEM:OnEquip(ply, modifications)
	ply:Fo_CreateFollower( self.Follower )
end

function ITEM:OnHolster(ply)
	ply:Fo_RemoveFollower( self.Follower )
end