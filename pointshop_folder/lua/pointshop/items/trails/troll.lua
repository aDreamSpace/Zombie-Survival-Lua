ITEM.Name = 'Troll'
Item.Price = 15000
ITEM.Material = 'trails/troll.vmt'

function ITEM:OnEquip(ply, modifications)
	ply.ElectricTrail = util.SpriteTrail(ply, 0, modifications.color, false, 15, 1, 4, 0.125, self.Material)
end

function ITEM:OnHolster(ply)
	SafeRemoveEntity(ply.ElectricTrail)
end

function ITEM:Modify(modifications)
	PS:ShowColorChooser(self, modifications)
end

function ITEM:OnModify(ply, modifications)
	SafeRemoveEntity(ply.ElectricTrail)
	self:OnEquip(ply, modifications)
end