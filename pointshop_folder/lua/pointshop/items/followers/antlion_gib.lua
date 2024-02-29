ITEM.Name = 'Antlion Gib'
ITEM.Price = 20000
ITEM.Model = 'models/Gibs/Antlion_gib_Large_2.mdl'
ITEM.Follower = 'antlion_head'

function ITEM:OnEquip(ply, modifications)
	ply:Fo_CreateFollower( self.Follower )
end

function ITEM:OnHolster(ply)
	ply:Fo_RemoveFollower( self.Follower )
end