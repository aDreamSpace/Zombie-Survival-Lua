include("shared.lua")

ENT.Seed = 0
ENT.Tall = 0
ENT.Blocked = false

function ENT:Initialize()
	local dist = math.max(16, GAMEMODE.DynamicSpawnDist) * 2

	self:SetRenderBounds(Vector(-dist, -dist, -dist), Vector(dist, dist, dist))
	self:ManipulateBoneScale(0, self.ModelScale)

	self.AmbientSound = CreateSound(self, "ambient/levels/citadel/citadel_drone_loop5.wav")

	self.FloorModel = ClientsideModel("models/props_wasteland/antlionhill.mdl")
	if self.FloorModel:IsValid() then
		self.FloorModel:SetParent(self)
		self.FloorModel:SetOwner(self)
		self.FloorModel:SetPos(self:GetPos())
		self.FloorModel:SetAngles(self:GetAngles())
		self.FloorModel:Spawn()
		self.FloorModel:ManipulateBoneScale(0, Vector(0.01, 0.01, 0.01))
		self.FloorModel:SetMaterial("models/flesh")
	end

	self.Seed = math.Rand(0, 10)
end

local EmitSounds = {
	Sound("physics/flesh/flesh_squishy_impact_hard1.wav"),
	Sound("physics/flesh/flesh_squishy_impact_hard2.wav"),
	Sound("physics/flesh/flesh_squishy_impact_hard3.wav"),
	Sound("physics/flesh/flesh_squishy_impact_hard4.wav"),
	Sound(")npc/barnacle/barnacle_die1.wav"),
	Sound(")npc/barnacle/barnacle_die2.wav"),
	Sound(")npc/barnacle/barnacle_digesting1.wav"),
	Sound(")npc/barnacle/barnacle_digesting2.wav"),
	Sound(")npc/barnacle/barnacle_gulp1.wav"),
	Sound(")npc/barnacle/barnacle_gulp2.wav")
}

local blocked
local nearest
local CT
local a
local hscale

function ENT:Think()
	self.Tall = math.Approach(self.Tall, math.Clamp(self:GetNestHealth() / self:GetNestMaxHealth(), 0.001, 1), FrameTime())
	if not self.NextUpdate then self.NextUpdate = 0 end
	CT = CurTime()

	if MySelf:IsValid() and MySelf:Team() == TEAM_UNDEAD and self.NextUpdate < CT then
		self.NextUpdate = CT + 0.5 --We should cache this since A: team.GetPlayers is slow and B: We don't need to know if we're blocked every frame!
		blocked = false
		nearest = self:GetPos()
		for _, human in pairs(team.GetPlayers(TEAM_HUMAN)) do
			if util.SkewedDistance(human:GetPos(), nearest, 2.75) <= GAMEMODE.DynamicSpawnDist then
				blocked = true
				break
			end
		end

		self.Blocked = blocked
	end

	if self.FloorModel:IsValid() then
		a = math.abs(math.sin(CT)) ^ 3
		hscale = 0.2 + a * 0.04
		self.FloorModel:ManipulateBoneScale(0, Vector(hscale * 1.1 + 0.05, hscale * 1.1 + 0.05, 0.02 * self.Tall))
	end

	if self.DoEmitNextFrame then
		self.DoEmitNextFrame = nil
		self:EmitSound(EmitSounds[math.random(#EmitSounds)], 65, math.random(95, 105))
	end

	self.AmbientSound:PlayEx(0.6, 100 + CT % 1)
end

function ENT:OnRemove()
	self.AmbientSound:Stop()

	if self.FloorModel:IsValid() then
		self.FloorModel:Remove()
	end
end

ENT.NextEmit = 0
local gravParticle = Vector(0, 0, -200)
local matFlesh = Material("models/flesh")
local matWireframe = Material("models/wireframe")
local matBeam = Material("Effects/laser1", "smooth")
local r, g = 0, 0
local colRing = Color(0, 0, 0, 255)
local curtime
local a
local hscale
local built
local floormodel
local fmvalid
local frametime
local ringtime
local ringsize
local beamsize
local up
local ang
local ringpos
local blocked
local pos
local emitter
local particle

local strParticleName = "noxctf/sprite_bloodspray"

function ENT:Draw()
	curtime = CurTime() + self.Seed
	a = math.abs(math.sin(curtime)) ^ 3
	hscale = 0.2 + a * 0.04
	built = self:GetNestBuilt()
	floormodel = self.FloorModel
	fmvalid = floormodel:IsValid()

	if MySelf:IsValid() and MySelf:Team() == TEAM_UNDEAD and built then
		frametime = FrameTime() * 500
		ringtime = (curtime / 2 % 1) ^ 0.5
		ringsize = ringtime * GAMEMODE.DynamicSpawnDist
		beamsize = ringtime * 20
		up = self:GetUp()
		ang = self:GetForward():Angle()
		ang.yaw = curtime * 360 % 360
		ringpos = self:GetPos() + up * 16
		blocked = self.Blocked
		a = (1 - ringtime) * 0.8
		r = math.Approach(r, blocked and 255 or 0, frametime)
		g = math.Approach(g, blocked and 0 or 255, frametime)
		colRing.r = r * a
		colRing.g = g * a

		render.SetMaterial(matBeam)
		render.StartBeam(19)
		for i=1, 19 do
			render.AddBeam(ringpos + ang:Forward() * ringsize, beamsize, beamsize, colRing)
			ang:RotateAroundAxis(up, 20)
		end
		render.EndBeam()
	end

	if built then
		render.ModelMaterialOverride(matFlesh)
	else
		render.ModelMaterialOverride(matWireframe)
		render.SetColorModulation(self.Tall, 0, 0)
	end

	if fmvalid then
		floormodel:ManipulateBoneScale(0, Vector(hscale * 1.1 + 0.05, hscale * 1.1 + 0.05, 0.02 * self.Tall))
	end

	self:ManipulateBoneScale(0, Vector(hscale, hscale, (0.1 - a * 0.005) * self.Tall))
	self:DrawModel()

	render.SetColorModulation(1, 1, 1)
	render.ModelMaterialOverride()

	if not built or curtime < self.NextEmit then return end
	self.NextEmit = curtime + math.Rand(0.4, 2)

	if math.random(4) == 1 then
		self.DoEmitNextFrame = true
	end

	pos = self:GetPos() + self:GetUp() * 8
	emitter = ParticleEmitter(pos)
	emitter:SetNearClip(16, 24)

	for i=0, math.Rand(0, 1) ^ 0.5 * 10 do
		particle = emitter:Add(strParticleName..math.random(8), pos)
		particle:SetGravity(gravParticle)
		particle:SetDieTime(math.Rand(4, 6))
		particle:SetVelocity(Angle(math.Rand(-85, -70), math.Rand(0, 360), 0):Forward() * math.Rand(100, 200))
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(255)
		particle:SetStartSize(math.Rand(2, 4))
		particle:SetEndSize(0)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-2, 2))
		particle:SetColor(180, 0, 0)
		particle:SetCollide(true)
	end

	emitter:Finish()
end
