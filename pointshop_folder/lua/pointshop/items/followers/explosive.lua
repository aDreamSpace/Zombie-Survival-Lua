ITEM.Name = 'Ze Explosive'
ITEM.Price = 55000
ITEM.Model = 'models/props_c17/oildrum001_explosive.mdl'
ITEM.Follower = 'explosive'

function ITEM:OnEquip(ply, modifications)
	ply:Fo_CreateFollower( self.Follower )
end

function ITEM:OnHolster(ply)
	ply:Fo_RemoveFollower( self.Follower )
end