include("shared.lua")
function ENT:Initialize()
	self:SetRenderBounds(Vector(-72, -72, -72), Vector(72, 72, 128))
	self.batModel = false
end

local skinTbl = {
[1] = {2, Color(255, 0, 0)},
[2] = {1, Color(255, 110, 36)},
[3] = {0, Color(0, 255, 0)},
}

local mat = Material("sprites/glow04_noz") 
function ENT:Draw()
	self:DrawModel()
	local stage = 3
	local pos = self:GetPos()
	local fixvec = Vector(-10,-27,14)
	local fixvec2 = Vector(-5,-27,14)
	local fixvec3 =	Vector(-1,-27,14)
	fixvec:Rotate(self:GetAngles())
	fixvec2:Rotate(self:GetAngles())
	fixvec3:Rotate(self:GetAngles())
	cam.Start3D()
		render.SetMaterial(mat)
		render.DrawSprite(pos+fixvec, 16, 16, skinTbl[stage][2])
		render.DrawSprite(pos+fixvec2, 16, 16, skinTbl[stage][2])
		render.DrawSprite(pos+fixvec3, 16, 16, skinTbl[stage][2])
	cam.End3D()
end

function ENT:SetObjectHealth(health)
	self:SetDTFloat(0, health)
	if health <= 0 and not self.Destroyed then
		self.Destroyed = true
		if self.bat and self.bat:IsValid() then
			self.bat:Remove()
		end
	end
end

function ENT:Think()
	local entid = self:EntIndex()
	local ent = self
	
	if not self.batModel and self.batModel ~= true or !self.bat:IsValid() then
		self.bat = ClientsideModel("models/props/deployable/batterybox.mdl", RENDERGROUP_TRANSLUCENT)
		self.bat:SetParent(ents.GetByIndex(entid))
		self.bat:SetLocalPos(Vector(0, -19, 10))
		self.bat:SetLocalAngles(Angle(0,0,0))
		self.batModel = true
	end


	self:SetNextClientThink(CurTime() + 0.2)
	return true
end

function ENT:OnRemove()
	if self.bat and self.bat:IsValid() then
		self.bat:Remove()
	end
end


function ENT:OpenTeleportMenu()
	local tblTele = ents.FindByClass("prop_teleporter")
	local iNumTele = #tblTele
	


end