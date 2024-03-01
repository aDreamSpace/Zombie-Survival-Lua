ITEM.Name = 'Hope'
ITEM.Price = 45000
ITEM.Model = 'models/pigeon.mdl'
ITEM.Follower = 'white_pigeon'

function ITEM:OnEquip(ply, modifications)
	ply:Fo_CreateFollower( self.Follower )
end

function ITEM:OnHolster(ply)
	ply:Fo_RemoveFollower( self.Follower )
end