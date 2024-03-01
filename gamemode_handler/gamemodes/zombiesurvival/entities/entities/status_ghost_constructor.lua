AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "status__base"

ENT.GhostOffset = Vector(0, 0, 32)

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetMaterial("models/wireframe")
	self:SetModel("models/props_lab/reciever_cart.mdl")

	self:RecalculateValidity()
end

function ENT:IsInsideProp()
	for _, ent in pairs(ents.FindInBox(self:WorldSpaceAABB())) do
		if ent ~= self and ent:IsValid() and ent:GetMoveType() == MOVETYPE_VPHYSICS and ent:GetSolid() > 0 then return true end
	end

	return false
end

local function MoveOffset(pos, ang, offset)
	pos:Set(pos + offset.x * ang:Forward() + offset.y * ang:Right() + offset.z * ang:Up())
end

local function RotateAngles(ang, offset)
	if (offset.yaw ~= 0) then ang:RotateAroundAxis(ang:Up(), offset.yaw) end
	if (offset.pitch ~= 0) then ang:RotateAroundAxis(ang:Right(), offset.pitch) end
	if (offset.roll ~= 0) then ang:RotateAroundAxis(ang:Forward(), offset.roll) end
end

function ENT:RecalculateValidity()
	local owner = self:GetOwner()
	if not owner:IsValid() then return end

	if SERVER or MySelf == owner then
		self:SetRotation(math.NormalizeAngle(owner:GetInfoNum("_zs_ghostrotation", 0)))
	end

	local rotation = self:GetRotation()
	local eyeangles = owner:EyeAngles()
	local shootpos = owner:GetShootPos()
	local tr = util.TraceLine({start = shootpos, endpos = shootpos + owner:GetAimVector() * (self.Range or 48) + (self.VecOffset or vector_origin), mask = MASK_SOLID, filter = owner})

	if tr.HitWorld and not tr.HitSky and tr.HitNormal.z >= 0.75 then
		eyeangles = tr.HitNormal:Angle()
		eyeangles:RotateAroundAxis(eyeangles:Right(), 270)

		local valid = true
		if self:IsInsideProp() then
			valid = false
		else
			for _, ent in pairs(ents.FindInSphere(tr.HitPos, 128)) do
				if ent:IsValid() and ent:GetClass() == self.EntityClass then
					valid = false
					break
				end
			end
		end

		if valid and SERVER and GAMEMODE:EntityWouldBlockSpawn(self) then
			valid = false
		end

		self:SetValidPlacement(valid)
	else
		self:SetValidPlacement(false)
	end

	if tr.HitNormal.z >= 0.75 then
		eyeangles:RotateAroundAxis(eyeangles:Up(), owner:GetAngles().yaw + rotation)
	else
		eyeangles:RotateAroundAxis(eyeangles:Up(), rotation)
	end

	local pos, ang = tr.HitPos, eyeangles
	if (self.GhostAngOffset) then
		RotateAngles(ang, self.GhostAngOffset)
	end
	if (self.GhostOffset) then
		MoveOffset(pos, ang, self.GhostOffset)
	end
	self:SetPos(pos)
	self:SetAngles(ang)

	return pos, ang
end

function ENT:GetValidPlacement()
	return self:GetDTBool(0)
end

function ENT:SetValidPlacement(onoff)
	self:SetDTBool(0, onoff)
end

function ENT:GetRotation()
	return self:GetDTFloat(0)
end

function ENT:SetRotation(rotation)
	self:SetDTFloat(0, rotation)
end

if (SERVER) then
	function ENT:Think()
		self:RecalculateValidity()
	
		local owner = self:GetOwner()
		if not (owner:IsValid() and owner:GetActiveWeapon():IsValid() and owner:GetActiveWeapon():GetClass() == "weapon_zs_constructor") then
			self:Remove()
		end
	end
else
	ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
	
	function ENT:Think()
		self:RecalculateValidity()
	
		self:NextThink(CurTime())
		return true
	end
	
	function ENT:DrawTranslucent()
		cam.Start3D(EyePos(), EyeAngles())
			render.SuppressEngineLighting(true)
			if self:GetValidPlacement() then
				render.SetBlend(0.75)
				render.SetColorModulation(0, 1, 0)
			else
				render.SetBlend(0.5)
				render.SetColorModulation(1, 0, 0)
			end
	
			self:DrawModel()
	
			render.SetBlend(1)
			render.SetColorModulation(1, 1, 1)
			render.SuppressEngineLighting(false)
		cam.End3D()
	end
end