ITEM.Name = 'Le Boat'
ITEM.Price = 60000
ITEM.Model = 'models/props_canal/boat002b.mdl'
ITEM.Follower = 'boat'

function ITEM:OnEquip(ply, modifications)
	ply:Fo_CreateFollower( self.Follower )
end

function ITEM:OnHolster(ply)
	ply:Fo_RemoveFollower( self.Follower )
end