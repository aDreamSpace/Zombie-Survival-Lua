ITEM.Name = 'Spotlight Head'
ITEM.Price = 12500
ITEM.Model = 'models/props_wasteland/light_spotlight01_lamp.mdl'
ITEM.Attachment = 'eyes'

function ITEM:OnEquip(ply, modifications)
	ply:PS_AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:PS_RemoveClientsideModel(self.ID)
end
