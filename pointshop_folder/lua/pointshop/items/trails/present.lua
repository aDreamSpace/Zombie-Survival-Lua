ITEM.Name = 'Wrapped Present'
Item.Price = 15000
ITEM.Material = 'trails/present.vmt'

function ITEM:OnEquip(ply, modifications)
	ply.WPTrail = util.SpriteTrail(ply, 0, modifications.color, false, 15, 1, 4, 0.125, self.Material)
end

function ITEM:OnHolster(ply)
	SafeRemoveEntity(ply.WPTrail)
end

function ITEM:Modify(modifications)
	PS:ShowColorChooser(self, modifications)
end

function ITEM:OnModify(ply, modifications)
	SafeRemoveEntity(ply.WPTrail)
	self:OnEquip(ply, modifications)
end