AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "status_ghost_base"

ENT.GhostModel = Model("models/props/deployable/teleporter_1.mdl")
ENT.GhostRotation = Angle(270, 180, 0)
ENT.GhostHitNormalOffset = 0
ENT.GhostEntity = "prop_teleporter"
ENT.GhostWeapon = "weapon_zs_teleporter"
ENT.GhostDistance = 400
ENT.GhostLimitedNormal = 0.75
ENT.GhostFlatGround = true


function ENT:RecalculateValidity()
	local owner = self:GetOwner()
	if not owner:IsValid() then return end

	if SERVER or MySelf == owner then
		self:SetRotation(math.NormalizeAngle(owner:GetInfoNum("_zs_ghostrotation", 0)))
	end

	local rotation = self:GetRotation()
	local eyeangles = owner:EyeAngles()
	local shootpos = owner:GetShootPos()
	local tr = util.TraceLine({start = shootpos, endpos = shootpos + owner:GetAimVector() * 48, mask = MASK_SOLID, filter = owner})

	if tr.HitWorld and not tr.HitSky and tr.HitNormal.z >= 0.75 then
		eyeangles = tr.HitNormal:Angle()
		eyeangles:RotateAroundAxis(eyeangles:Right(), 270)

		local valid = true
		if self:IsInsideProp() then
			valid = false
		end

		for _, ent in pairs(ents.FindInSphere(tr.HitPos, 128)) do
			if ent and ent:IsValid() and ent:GetClass() == "prop_teleporter" then		
				valid = false
				break
			end
		end
		--[
		local pos = self:GetPos()
		local obbmin, obbmax = self:OBBMins(), self:OBBMaxs()
		local tbl = player.GetAll()
		local tracedata = {}
		tracedata.start = pos
		tracedata.endpos = pos
		tracedata.filter = tbl
		tracedata.mins = obbmin+Vector(0,0,2)
		tracedata.maxs = obbmax
		tracedata.mask = MASK_ALL
		local trace = util.TraceHull(tracedata)

		if trace.Hit then
			valid = false
		end
		--]]

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
	self:SetPos(pos)
	self:SetAngles(ang)

	return pos, ang
end