ITEM.Name = 'Rockety'
ITEM.Price = 30000
ITEM.Model = 'models/Items/AR2_Grenade.mdl'
ITEM.Follower = 'rockety'

function ITEM:OnEquip(ply, modifications)
	ply:Fo_CreateFollower( self.Follower )
end

function ITEM:OnHolster(ply)
	ply:Fo_RemoveFollower( self.Follower )
end