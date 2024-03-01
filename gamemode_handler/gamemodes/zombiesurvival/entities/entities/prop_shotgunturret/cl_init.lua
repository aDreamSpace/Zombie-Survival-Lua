include("shared.lua")

ENT.NextEmit = 0

ENT.ScanSound = "npc/turret_wall/turret_loop1.wav"
ENT.ShootSound = "npc/combine_gunship/gunship_weapon_fire_loop6.wav"
ENT.BeamCol = Color(0, 255, 0, 255)
function ENT:IndividualRemove()
	if self.ShotgunModel and self.ShotgunModel:IsValid() then
		self.ShotgunModel:Remove()
	end
end

--TODO: Rewrite this with inheritence with base gunturret
local TEXT_ALIGN_CENTER = TEXT_ALIGN_CENTER
local draw_SimpleText = draw.SimpleText
local surface_SetDrawColor = surface.SetDrawColor
local surface_DrawRect = surface.DrawRect
local cam_Start3D2D = cam.Start3D2D
local cam_End3D2D = cam.End3D2D
local smokegravity = Vector(0, 0, 200)
local aScreen = Angle(0, 270, 60)
local vScreen = Vector(0, -2, 45)
function ENT:Draw()
	self:CalculatePoseAngles()
	self:SetPoseParameter("aim_yaw", self.PoseYaw)
	self:SetPoseParameter("aim_pitch", self.PosePitch)

	self:DrawModel()

	local vec, ang = self:ShootPos(true)

	ang.yaw = ang.yaw + 180
	ang.pitch = ang.pitch * -1

	if !(self.ShotgunModel and self.ShotgunModel:IsValid()) then
		--local att = self:GetAttachment(self:LookupAttachment("eyes"))
		self.ShotgunModel = ClientsideModel("models/weapons/w_shotgun.mdl", RENDERGROUP_OPAQUE)
		--self.ShotgunModel:FollowBone(self, self:LookupAttachment("eyes"))
		--self.ShotgunModel:SetPredictable(false)
		self.ShotgunModel:SetPos(vec)
		self.ShotgunModel:SetAngles(ang)
	else
		self.ShotgunModel:SetPos(vec)
		self.ShotgunModel:SetAngles(ang)
	end


	local healthpercent = self:GetObjectHealth() / self:GetMaxObjectHealth()

	if healthpercent <= 0.5 and CurTime() >= self.NextEmit then
		self.NextEmit = CurTime() + 0.05

		local pos = self:DefaultPos()
		local sat = healthpercent * 360

		local emitter = ParticleEmitter(pos)
		emitter:SetNearClip(24, 32)

		local particle = emitter:Add("particles/smokey", pos)
		particle:SetStartAlpha(180)
		particle:SetEndAlpha(0)
		particle:SetStartSize(0)
		particle:SetEndSize(math.Rand(8, 32))
		particle:SetColor(sat, sat, sat)
		particle:SetVelocity(VectorRand():GetNormalized() * math.Rand(8, 64))
		particle:SetGravity(smokegravity)
		particle:SetDieTime(math.Rand(0.8, 1.6))
		particle:SetAirResistance(150)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-4, 4))
		particle:SetCollide(true)
		particle:SetBounce(0.2)

		emitter:Finish()
	end

	local owner = self:GetObjectOwner()
	local ammo = self:GetAmmo()
	local flash = math.sin(CurTime() * 15) > 0
	local wid, hei = 128, 92
	local x = wid / 2

	cam_Start3D2D(self:LocalToWorld(vScreen), self:LocalToWorldAngles(aScreen), 0.075)

		surface_SetDrawColor(0, 0, 0, 160)
		surface_DrawRect(0, 0, wid, hei)

		surface_SetDrawColor(200, 200, 200, 160)
		surface_DrawRect(0, 0, 8, 16)
		surface_DrawRect(wid - 8, 0, 8, 16)
		surface_DrawRect(8, 0, wid - 16, 8)

		surface_DrawRect(0, hei - 16, 8, 16)
		surface_DrawRect(wid - 8, hei - 16, 8, 16)
		surface_DrawRect(8, hei - 8, wid - 16, 8)

		if owner:IsValid() and owner:IsPlayer() then
			draw_SimpleText(owner:ClippedName(), "DefaultFont", x, 10, owner == MySelf and COLOR_BLUE or COLOR_WHITE, TEXT_ALIGN_CENTER)
		end
		draw_SimpleText(translate.Format("integrity_x", math.ceil(healthpercent * 100)), "DefaultFontBold", x, 25, COLOR_WHITE, TEXT_ALIGN_CENTER)

		if flash and self:GetManualControl() then
			draw_SimpleText(translate.Get("manual_control"), "DefaultFont", x, 40, COLOR_YELLOW, TEXT_ALIGN_CENTER)
		end

		if ammo > 0 then
			draw_SimpleText("["..ammo.." / "..self.MaxAmmo.."]", "DefaultFontBold", x, 55, COLOR_WHITE, TEXT_ALIGN_CENTER)
		elseif flash then
			draw_SimpleText(translate.Get("empty"), "DefaultFontBold", x, 55, COLOR_RED, TEXT_ALIGN_CENTER)
		end

	cam_End3D2D()
end