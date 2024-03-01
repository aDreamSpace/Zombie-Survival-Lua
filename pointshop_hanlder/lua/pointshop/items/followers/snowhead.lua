ITEM.Name = 'Snowhead'
ITEM.Price = 60000
ITEM.Model = 'models/props/cs_office/Snowman_face.mdl'
ITEM.Follower = 'snowhead'

function ITEM:OnEquip(ply, modifications)
	ply:Fo_CreateFollower( self.Follower )
end

function ITEM:OnHolster(ply)
	ply:Fo_RemoveFollower( self.Follower )
end