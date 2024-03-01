include("shared.lua")

ENT.NextUpdate = 0.15
ENT.NextEmit = 0
ENT.NextEmitDelay = 0.06
ENT.Deploying = false

function ENT:Initialize()
	self:SetRenderBounds(Vector(-72, -72, -72), Vector(72, 72, 128))
	self:EmitSound("ambient/atmosphere/tunnel1.wav", 40, math.random(180, 200))
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
			draw.SimpleText("Power Cell Sigil", "ZS3D2DFont2", 0, -10, COLOR_ORANGE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	
			draw.RoundedBox(math.min(hpfrac * 542.5, 8), -275, 105, math.Round(542.5 * hpfrac), 40, Color(255 - 255 * hpfrac, 255 * hpfrac, 0))
			draw.SimpleText("Health: " .. math.Round(hpfrac * 100) .. "%", "ZS3D2DFont2Small", -135, 85, COLOR_PURPLE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText("Gives nearby players Power Cell", "ZS3D2DFont2Smaller", 0, 200, COLOR_GREEN, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			cam.IgnoreZ(false) -- Stop ignoring the Z-buffer
		cam.End3D2D()
	end
end


function ENT:Draw()
	self:DrawModel()
	self:DrawParticles()
	if not MySelf:IsValid() then return end

	local owner = self:GetObjectOwner()
	local ang = self:LocalToWorldAngles(aOffset)
	
	self:RenderInfo(self:LocalToWorld(vOffset), ang, owner)
	self:RenderInfo(self:LocalToWorld(vOffset2), self:LocalToWorldAngles(aOffset2), owner)
end


function ENT:DrawParticles()
    local curtime = CurTime()
    local sat = math.abs(math.sin(curtime))
    local healthperc = self:GetObjectHealth() / self:GetMaxObjectHealth()
    local r, g, b = 0, 255, 255  -- Set to cyan color directly
    local radius = 180 + math.cos(sat) * 40
    local whiteradius = 122 + math.sin(sat) * 32
    local up = self:GetUp()
    local spritepos = self:GetPos() + up
    local spritepos2 = self:WorldSpaceCenter()
	
    local emitter = ParticleEmitter(spritepos)
    emitter:SetNearClip(24, 32)

    local particle = emitter:Add("sprites/glow04_noz", spritepos)
    particle:SetDieTime(math.Rand(1.5, 2))
    particle:SetVelocity(Vector(0, 0, math.Rand(32, 64)))
    particle:SetStartAlpha(0)
    particle:SetEndAlpha(155)
    particle:SetStartSize(math.Rand(8, 17))
    particle:SetEndSize(0)
    particle:SetRoll(math.Rand(0, 360))
    particle:SetRollDelta(math.Rand(-1, 1))
    particle:SetColor(r, g, b)  -- This will now set the color to cyan
    particle:SetCollide(true)

    emitter:Finish()
end