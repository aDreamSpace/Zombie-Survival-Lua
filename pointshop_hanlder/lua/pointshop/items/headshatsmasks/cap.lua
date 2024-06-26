ITEM.Name = 'Snowman Cap'
ITEM.Price = 15500
ITEM.Model = "models/props/cs_office/Snowman_hat.mdl"
ITEM.Attachment = 'eyes'

function ITEM:OnEquip(ply, modifications)
	ply:PS_AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:PS_RemoveClientsideModel(self.ID)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	model:SetModelScale(1, 0)
	pos = pos + (ang:Forward() * -2) + (ang:Up() * 5)
	ang:RotateAroundAxis(ang:Up(), -90)
	
	return model, pos, ang
end
