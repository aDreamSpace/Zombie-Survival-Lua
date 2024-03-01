EFFECT.LifeTime = 4

function EFFECT:Init(data)
	self:SetRenderBounds(Vector(-64, -64, -64), Vector(64, 64, 64))

	self.Seed = math.Rand(0, 10)

	local pos = data:GetOrigin()
	local amount = math.Round(data:GetMagnitude())

	self.Pos = pos
	self.Message = "+"..amount.." BLOOD!"

	self.DeathTime = CurTime() + self.LifeTime
end

function EFFECT:Think()
	self.Pos.z = self.Pos.z + FrameTime() * 4
	return CurTime() < self.DeathTime
end

local col = Color(255, 60, 60, 255)
local col2 = Color(0, 0, 0, 255)
local delta
local ang, right
local strFont = "ZS3D2DFont2Small"

function EFFECT:Render()
	delta = math.Clamp(self.DeathTime - CurTime(), 0, self.LifeTime) / self.LifeTime
	col.a = delta * 240
	col2.a = col.a
	ang = EyeAngles()
	right = ang:Right()
	ang:RotateAroundAxis(ang:Up(), -90)
	ang:RotateAroundAxis(ang:Forward(), 90)
	cam.IgnoreZ(true)
		cam.Start3D2D(self.Pos + math.sin(CurTime() + self.Seed) * 30 * delta * right, ang, (delta * 0.24 + 0.09) / 2)
			draw.SimpleText(self.Message, strFont, 0, -21, col, TEXT_ALIGN_CENTER)
		cam.End3D2D()
	cam.IgnoreZ(false)
end
