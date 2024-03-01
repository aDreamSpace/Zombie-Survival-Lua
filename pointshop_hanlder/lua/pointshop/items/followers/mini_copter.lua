ITEM.Name = 'Mini Copter'
ITEM.Price = 120000
ITEM.Model = 'models/Gibs/helicopter_brokenpiece_06_body.mdl'
ITEM.Follower = 'small_copter'

function ITEM:OnEquip(ply, modifications)
	ply:Fo_CreateFollower( self.Follower )
end

function ITEM:OnHolster(ply)
	ply:Fo_RemoveFollower( self.Follower )
end