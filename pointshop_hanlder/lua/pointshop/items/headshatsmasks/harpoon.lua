ITEM.Name = 'Harpoon'
ITEM.Price = 5400
ITEM.Model = 'models/props_junk/harpoon002a.mdl'
ITEM.Attachment = 'eyes'

function ITEM:OnEquip(ply)
	ply:PS_AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:PS_RemoveClientsideModel(self.ID)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(0.3, 0)
	pos = pos + (ang:Forward() * -3) + (ang:Up() * -0)
	ang:RotateAroundAxis(ang:Right(), 90)
	ang:RotateAroundAxis(ang:Up(), 108)
	
	return model, pos, ang
end