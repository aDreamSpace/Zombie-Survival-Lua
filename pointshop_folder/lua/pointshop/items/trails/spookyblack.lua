ITEM.Name = 'Spooky Black'
Item.Price = 15000
ITEM.Material = 'trails/spookyblack.vmt'

function ITEM:OnEquip(ply, modifications)
	ply.SpookyBlackTrail = util.SpriteTrail(ply, 0, modifications.color, false, 15, 1, 4, 0.125, self.Material)
end

function ITEM:OnHolster(ply)
	SafeRemoveEntity(ply.SpookyBlackTrail)
end

function ITEM:Modify(modifications)
	PS:ShowColorChooser(self, modifications)
end

function ITEM:OnModify(ply, modifications)
	SafeRemoveEntity(ply.SpookyBlackTrail)
	self:OnEquip(ply, modifications)
end