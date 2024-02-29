ITEM.Name = 'Scannie'
ITEM.Price = 88000
ITEM.Model = 'models/combine_scanner.mdl'
ITEM.Follower = 'scannie'

function ITEM:OnEquip(ply, modifications)
	ply:Fo_CreateFollower( self.Follower )
end

function ITEM:OnHolster(ply)
	ply:Fo_RemoveFollower( self.Follower )
end