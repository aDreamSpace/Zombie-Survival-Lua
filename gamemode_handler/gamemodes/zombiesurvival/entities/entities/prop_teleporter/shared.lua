ENT.Type = "anim"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.m_NoNailUnfreeze = true
ENT.NoNails = true

ENT.CanPackUp = true

ENT.IsBarricadeObject = true
ENT.AlwaysGhostable = true

function ENT:SetupDataTables()
	--self:NetworkVar("Int", 0, "BatteryCharge")
	self:NetworkVar("Float", 1, "MaxObjectHealth")
	self:NetworkVar("Entity", 0, "ObjectOwner")
	self:NetworkVar("Entity", 1, "Teleporting")
	self:NetworkVar("Float", 2, "TeleportTime")
end

function ENT:SetObjectHealth(health)
	self:SetDTFloat(0, health)
	if health <= 0 and not self.Destroyed then
		self.Destroyed = true

		local ent = ents.Create("prop_physics")
		if ent:IsValid() then
			ent:SetModel(self:GetModel())
			ent:SetMaterial(self:GetMaterial())
			ent:SetAngles(self:GetAngles())
			ent:SetPos(self:GetPos())
			ent:SetSkin(self:GetSkin() or 0)
			ent:SetColor(self:GetColor())
			ent:Spawn()
			ent:Fire("break", "", 0)
			ent:Fire("kill", "", 0.1)
		end
	end
end

function ENT:GetObjectHealth()
	return self:GetDTFloat(0)
end

function ENT:ClearObjectOwner()
	self:SetObjectOwner(NULL)
end
