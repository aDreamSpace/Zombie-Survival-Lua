ITEM.Name = 'Lamar'
ITEM.Price = 75000
ITEM.Model = 'models/headcrabclassic.mdl'
ITEM.Follower = 'lamar_headcrab'

function ITEM:OnEquip(ply, modifications)
	ply:Fo_CreateFollower( self.Follower )
end

function ITEM:OnHolster(ply)
	ply:Fo_RemoveFollower( self.Follower )
end