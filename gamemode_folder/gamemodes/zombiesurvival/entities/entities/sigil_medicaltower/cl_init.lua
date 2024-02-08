include("shared.lua")

ENT.NextUpdate = 0.15
ENT.NextEmit = 0
ENT.NextEmitDelay = 0.06
ENT.Deploying = false

function ENT:Initialize()
	self:SetRenderBounds(Vector(-72, -72, -72), Vector(72, 72, 128))
	self.NextDeploy = 0
end

local vOffset = Vector(0, -7.1, 46)
local vOffset2 = Vector(0, 7.1, 46)
local aOffset = Angle(0, 0, 90)
local aOffset2 = Angle(0, 180, 90)
local vOffsetEE = Vector(-15, 0, 8)

function ENT:SetObjectHealth(health)
	self:SetDTFloat(0, health)
end

ENT.NextUpdate = 0.5
ENT.NextEmit = 0.5
ENT.NextEmitDelay = 0.5
ENT.Rotation = math.random(360)

function ENT:Think()
	local matWhite = Material("models/debug/debugwhite")
	local matGlow = Material("sprites/light_glow02_add")
	local cDraw = Color(255, 255, 255)
	local cDrawWhite = Color(255, 255, 255)
	self:EmitSound("ambient/atmosphere/tunnel1.wav", 80, 80)
		self:RemoveAllDecals()
		
		local curtime = CurTime()
		local sat = math.abs(math.sin(curtime))
		local colsat = sat * 0.125
		local eyepos = EyePos()
		local eyeangles = EyeAngles()
		local forwardoffset = self:GetForward() * 16
		local rightoffset = self:GetRight() * 16
		local healthperc = self:GetObjectHealth() / self:GetMaxObjectHealth()
		local r, g, b = 0.15 + colsat, 0.4 + colsat, 1
		local radius = 180 + math.cos(sat) * 40
		local whiteradius = 122 + math.sin(sat) * 32
		local up = self:GetUp()
		local spritepos = self:GetPos() + up
		local spritepos2 = self:WorldSpaceCenter()
	
		local dlight = DynamicLight(self:EntIndex())
		if dlight then
			dlight.Pos = self:GetPos()
			dlight.r = r * 255
			dlight.g = g * 255
			dlight.b = b * 255
			dlight.Brightness = (2 + sat) * healthperc
			dlight.Size = 300 + sat * 50
			dlight.Decay = 400 + sat * 200
			dlight.DieTime = curtime + 0.5
		end
	
		r = r * healthperc
		g = g * healthperc
		b = b * healthperc
		render.SuppressEngineLighting(true)
		render.SetColorModulation(1, 1, 1)
		self:DrawModel()
	
		render.SetColorModulation(r, g, b)
		
		render.ModelMaterialOverride(matWhite)
		render.SetBlend(0.1 * healthperc)
	
		self:DrawModel()
	
		--[[r = r * healthperc
		g = g * healthperc
		b = b * healthperc]]
		render.SetColorModulation(r, g, b)
	
	    --self:SetModelScaleVector(Vector(0.1, 0.1, 0.9 * math.max(0.02, healthperc)) * self.ModelScale)
		render.SetBlend(1)
		cam.Start3D(eyepos + forwardoffset + rightoffset, eyeangles)
		self:DrawModel()
		cam.End3D()
		cam.Start3D(eyepos + forwardoffset - rightoffset, eyeangles)
		self:DrawModel()
		cam.End3D()
		cam.Start3D(eyepos - forwardoffset + rightoffset, eyeangles)
		self:DrawModel()
		cam.End3D()
		cam.Start3D(eyepos - forwardoffset - rightoffset, eyeangles)
		self:DrawModel()
		cam.End3D()
	 --   self:SetModelScaleVector(Vector(1, 1, 1) * self.ModelScale)
	
		render.SetBlend(1)
		render.ModelMaterialOverride()
		render.SuppressEngineLighting(false)
		render.SetColorModulation(0.294, 0, 0.608)
	
		self.Rotation = self.Rotation + FrameTime() * 5
	if self.Rotation >= 360 then
		self.Rotation = self.Rotation - 360
	end
	
		cDraw.r = r * 255
		cDraw.g = g * 255
		cDraw.b = b * 255
		cDrawWhite.r = healthperc * 255
		cDrawWhite.g = cDrawWhite.r
		cDrawWhite.b = cDrawWhite.r
	
		render.SetMaterial(matGlow)
		render.DrawQuadEasy(spritepos, up, whiteradius, whiteradius, cDrawWhite, self.Rotation)
		render.DrawQuadEasy(spritepos, up * -1, whiteradius, whiteradius, cDrawWhite, self.Rotation)
		render.DrawQuadEasy(spritepos, up, radius, radius, cDraw, self.Rotation)
		render.DrawQuadEasy(spritepos, up * -1, radius, radius, cDraw, self.Rotation)
		render.DrawSprite(spritepos2, whiteradius, whiteradius * 4, cDrawWhite)
		render.DrawSprite(spritepos2, radius, radius * 2, cDraw)
	
		if curtime < self.NextEmit then return end
		self.NextEmit = curtime + 0.2
	
		local offset = VectorRand()
		offset.z = 0
		offset:Normalize()
		offset = offset * math.Rand(-32, 32)
		offset.z = 1
		local pos = self:LocalToWorld(offset)
	
		local emitter = ParticleEmitter(pos)
		emitter:SetNearClip(24, 32)
		
		local particle = emitter:Add("sprites/glow04_noz", pos)
		particle:SetDieTime(math.Rand(1.5, 4))
		particle:SetVelocity(Vector(0, 0, math.Rand(32, 64)))
		particle:SetStartAlpha(0)
		particle:SetEndAlpha(255)
		particle:SetStartSize(math.Rand(8, 17))
		particle:SetEndSize(0)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-1, 1))
		particle:SetColor(r * 255, g * 255, b * 255)
		particle:SetCollide(true)
	
		emitter:Finish()

	end


function ENT:DeployParticles(startstop)
	self.started = self.started or false
	if startstop == true and !self.started then
		self.posR = self:GetPos() + self:GetAngles():Forward() * 8 + Vector(0,0,40)
		self.posL = self:GetPos() + self:GetAngles():Forward() * -8 + Vector(0,0,40)
		self.emitterR = ParticleEmitter(self.posR)
		self.emitterR:SetNearClip(32, 64)
		self.emitterL = ParticleEmitter(self.posL)
		self.emitterL:SetNearClip(32, 64)
		self.started = true
	elseif startstop == false then
		if !self.emitterR:IsValid() or !self.emitterL:IsValid() then return end
		self.emitterR:Finish()
		self.emitterL:Finish()
		self.started = false
	end
end


function ENT:GenerateParticles()

end

function ENT:RenderInfo(pos, ang, owner)
	local h = MySelf:Team() == TEAM_HUMAN
	self:DrawModel()
	
	if (h) then
		local dist = self:GetPos():DistToSqr(MySelf:GetPos())
		if dist > 500*500 then return end -- Don't render if more than 500 units away

		local hpfrac = self:GetObjectHealth() / self:GetMaxObjectHealth()
	
		local pos = self:GetPos() + Vector(0, 0, 40) -- Adjust this as needed
		local ang = (MySelf:GetPos() - pos):Angle()
		ang:RotateAroundAxis(ang:Right(), -90)
		ang:RotateAroundAxis(ang:Up(), 90)
		
		cam.Start3D2D(pos, ang, 0.05)
			cam.IgnoreZ(true) -- Ignore the Z-buffer
			draw.SimpleText("Medical Sigil", "ZS3D2DFont2", 0, -10, COLOR_ORANGE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	
			draw.RoundedBox(math.min(hpfrac * 542.5, 8), -275, 105, math.Round(542.5 * hpfrac), 40, Color(255 - 255 * hpfrac, 255 * hpfrac, 0))
			draw.SimpleText("Health: " .. math.Round(hpfrac * 100) .. "%", "ZS3D2DFont2Small", -135, 85, COLOR_PURPLE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText("Heals nearby players", "ZS3D2DFont2Smaller", 0, 200, COLOR_GREEN, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText("Gives 5% healing bonus", "ZS3D2DFont2Smaller", 0, 240, COLOR_GREEN, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			cam.IgnoreZ(false) -- Stop ignoring the Z-buffer
		cam.End3D2D()
	end
end

hook.Add("PreDrawHalos", "AddBlueHalo", function()
	local ply = LocalPlayer()
	for _, ent in pairs(ents.FindByClass("sigil_medicaltower")) do
		if IsValid(ent) and ply:GetPos():Distance(ent:GetPos()) <= 100 then
			halo.Add({ent}, Color(8, 0, 249), 1, 1, 2, true, true)
		end
	end
end)


function ENT:Draw()
	self:DrawModel()

	if not MySelf:IsValid() then return end

	local owner = self:GetObjectOwner()
	local ang = self:LocalToWorldAngles(aOffset)

	self:RenderInfo(self:LocalToWorld(vOffset), ang, owner)
	self:RenderInfo(self:LocalToWorld(vOffset2), self:LocalToWorldAngles(aOffset2), owner)
end