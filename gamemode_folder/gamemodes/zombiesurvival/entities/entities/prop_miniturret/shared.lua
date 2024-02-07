ENT.Type = "anim"

ENT.m_NoNailUnfreeze = true
ENT.NoNails = true

ENT.CanPackUp = true

ENT.IsBarricadeObject = true
ENT.AlwaysGhostable = true

function ENT:SetObjectHealth(health)
	self:Set_ObjectHealth(health)
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
	return self:Get_ObjectHealth()
end

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "ObjectOwner")
	self:NetworkVar("Entity", 1, "Target")
	self:NetworkVar("Float", 0, "_ObjectHealth")
	self:NetworkVar("Float", 1, "MaxObjectHealth")
	self:NetworkVar("Float", 2, "ScanAngle")
	self:NetworkVar("Float", 3, "ScanRange")
	self:NetworkVar("Int", 0, "AmmoAmount")
	self:NetworkVar("Int", 1, "MaxAmmoAmount")
	self:NetworkVar("String", 0, "AmmoType")
	self:NetworkVar("Bool", 0, "Deployed")
end

function ENT:ClearObjectOwner()
	self:SetObjectOwner(NULL)
end

function ENT:ClearTarget()
	self:SetTarget(NULL)
end

function ENT:CanBePackedBy(pl)
	local owner = self:GetObjectOwner()
	return not owner:IsValid() or owner == pl or owner:Team() ~= TEAM_HUMAN or gamemode.Call("PlayerIsAdmin", pl)
end

local tTemp = {Pos = Vector(0,0,0), Ang = Angle(0,0,0)}

function ENT:SetupAttachments()
	self.MuzzleAttach = self:GetAttachment(self:LookupAttachment("attach_muzzle")) or tTemp
	self.LaserAttach = self:GetAttachment(self:LookupAttachment("attach_laser")) or tTemp
	self.LampAttach = self:GetAttachment(self:LookupAttachment("attach_lamp")) or tTemp
	self.ScreenAttach = self:GetAttachment(self:LookupAttachment("attach_screen")) or tTemp
	self.AttachmentsSetup = true
end