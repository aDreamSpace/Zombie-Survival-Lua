ITEM.Name = 'Blood Trail'
Item.Price = 15000
ITEM.Material = 'trails/blood.vmt'

function ITEM:OnEquip(ply, modifications)
	ply.blood = util.SpriteTrail(ply, 0, modifications.color, false, 15, 1, 4, 0.125, self.Material)
end

function ITEM:OnHolster(ply)
	SafeRemoveEntity(ply.blood)
end

function ITEM:Modify(modifications)
	PS:ShowColorChooser(self, modifications)
end

function ITEM:OnModify(ply, modifications)
	SafeRemoveEntity(ply.blood)
	self:OnEquip(ply, modifications)
end