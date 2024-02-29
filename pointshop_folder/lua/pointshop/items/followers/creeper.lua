ITEM.Name = 'Creeper'
ITEM.Price = 20000
ITEM.Model = 'models/player/creeper.mdl'
ITEM.Follower = 'creeper'

function ITEM:OnEquip(ply, modifications)
	ply:Fo_CreateFollower( self.Follower )
end

function ITEM:OnHolster(ply)
	ply:Fo_RemoveFollower( self.Follower )
	hook.Remove( "KeyPress", "keypress_creeper" )
end