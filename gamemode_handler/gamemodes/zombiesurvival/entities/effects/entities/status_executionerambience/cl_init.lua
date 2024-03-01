
-----------------------------------------------------
include("shared.lua")

ENT.RenderGroup = RENDERGROUP_NONE

function ENT:Initialize()
	self:DrawShadow(false)
	
	self.StartTime = CurTime() - 0.1
	self.Danger = 0
	
	hook.Add("SetupWorldFog", self, self.SetupWorldFog)
	hook.Add("SetupSkyboxFog", self, self.SetupSkyFog)
end

function ENT:SetupWorldFog()
	if MySelf:Team() == TEAM_ZOMBIE then return end
	
	local timeScale = math.Clamp((CurTime() - self.StartTime)/5, 0, 1)
	render.FogMode(1)
	render.FogStart(1/timeScale)
	render.FogEnd(750 + 1/timeScale)
	render.FogMaxDensity(timeScale)

	local colScale = 255*timeScale
	render.FogColor(colScale, colScale - 225 * self.Danger, colScale - 225 * self.Danger)
	
	local owner = self:GetOwner()
	if MySelf:IsLineOfSightClear(owner) then
		self.Danger = math.Clamp(self.Danger + FrameTime() * (1 - MySelf:GetPos():Distance(owner:GetPos())/700), 0, 1)
	else
		self.Danger = math.Clamp(self.Danger - FrameTime()/3, 0, 1)
	end

	return true
end

function ENT:SetupSkyFog(scale)
	if MySelf:Team() == TEAM_ZOMBIE then return end
	
	local timeScale = math.Clamp((CurTime() - self.StartTime)/5, 0, 1)
	render.FogMode(1)
	render.FogStart(scale/timeScale)
	render.FogEnd((750 + 1/timeScale) * scale)
	render.FogMaxDensity(timeScale)

	local colScale = 255*timeScale
	render.FogColor(colScale, colScale - 225 * self.Danger, colScale - 225 * self.Danger)
	
	return true
end

function ENT:Draw()
end