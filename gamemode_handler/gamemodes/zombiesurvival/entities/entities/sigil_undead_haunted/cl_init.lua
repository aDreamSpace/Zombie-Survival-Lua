include("shared.lua")

-- Initialize function
function ENT:Initialize()
    self:SetRenderBounds(Vector(-72, -72, -72), Vector(72, 72, 128))
    self.NextDeploy = 0
end

-- Think function to handle particle effects and rendering
function ENT:Think()
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

    -- Create dynamic light
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

    -- Adjust colors based on health percentage
    r = r * healthperc
    g = g * healthperc
    b = b * healthperc

    -- Suppress engine lighting and draw the model
    render.SuppressEngineLighting(true)
    render.SetColorModulation(1, 1, 1)
    self:DrawModel()
    render.SetColorModulation(r, g, b)

    -- Draw additional effects and sprites
    render.ModelMaterialOverride(matWhite)
    render.SetBlend(0.1 * healthperc)
    self:DrawModel()
    render.SetColorModulation(r, g, b)

    -- Set up rendering angles for sprites
    local ang = self:LocalToWorldAngles(aOffset)
    local ang2 = self:LocalToWorldAngles(aOffset2)

    -- Draw sprites and quad effects
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

    -- Draw quad and sprite effects
    render.SetBlend(1)
    render.ModelMaterialOverride()
    render.SuppressEngineLighting(false)
    render.SetColorModulation(0.294, 0, 0.608)

    -- Update rotation angle
    self.Rotation = self.Rotation + FrameTime() * 5
    if self.Rotation >= 360 then
        self.Rotation = self.Rotation - 360
    end

    -- Set up drawing colors
    cDraw.r = r * 255
    cDraw.g = g * 255
    cDraw.b = b * 255
    cDrawWhite.r = healthperc * 255
    cDrawWhite.g = cDrawWhite.r
    cDrawWhite.b = cDrawWhite.r

    -- Draw glowing sprites and quads
    render.SetMaterial(matGlow)
    render.DrawQuadEasy(spritepos, up, whiteradius, whiteradius, cDrawWhite, self.Rotation)
    render.DrawQuadEasy(spritepos, up * -1, whiteradius, whiteradius, cDrawWhite, self.Rotation)
    render.DrawQuadEasy(spritepos, up, radius, radius, cDraw, self.Rotation)
    render.DrawQuadEasy(spritepos, up * -1, radius, radius, cDraw, self.Rotation)
    render.DrawSprite(spritepos2, whiteradius, whiteradius * 4, cDrawWhite)
    render.DrawSprite(spritepos2, radius, radius * 2, cDraw)

    -- Emit particle effects
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
    particle:SetColor(255, 0, 0) -- Set particle color to red
    particle:SetCollide(true)

    emitter:Finish()
end

-- Render HUD information
function ENT:RenderInfo(pos, ang, owner)
    local h = LocalPlayer():Team() == TEAM_HUMAN
    self:DrawModel()

    if (h) then
        local dist = self:GetPos():DistToSqr(LocalPlayer():GetPos())
        if dist > 500 * 500 then return end -- Don't render if more than 500 units away

        local hpfrac = self:GetObjectHealth() / self:GetMaxObjectHealth()

        local pos = self:GetPos() + Vector(0, 0, 40) -- Adjust this as needed
        local ang = (LocalPlayer():GetPos() - pos):Angle()
        ang:RotateAroundAxis(ang:Right(), -90)
        ang:RotateAroundAxis(ang:Up(), 90)

        cam.Start3D2D(pos, ang, 0.05)
        cam.IgnoreZ(true) -- Ignore the Z-buffer
        draw.SimpleText("Haunted Undead Sigil", "ZS3D2DFont2", 0, -10, COLOR_ORANGE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        draw.RoundedBox(math.min(hpfrac * 542.5, 8), -275, 105, math.Round(542.5 * hpfrac), 40, Color(255 - 255 * hpfrac, 255 * hpfrac, 0))
        draw.SimpleText("Health: " .. math.Round(hpfrac * 100) .. "%", "ZS3D2DFont2Small", -135, 85, COLOR_PURPLE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Heals nearby zombies", "ZS3D2DFont2Smaller", 0, 200, COLOR_GREEN, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Damages nearby humans", "ZS3D2DFont2Smaller", 0, 240, COLOR_RED, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        cam.IgnoreZ(false) -- Stop ignoring the Z-buffer
        cam.End3D2D()
    end
end
 
-- Draw function to render the entity
function ENT:Draw()
    self:DrawModel()

    if not LocalPlayer():IsValid() then return end

    local owner = self:GetObjectOwner()
    local ang = self:LocalToWorldAngles(aOffset)

    self:RenderInfo(self:LocalToWorld(vOffset), ang, owner)
    self:RenderInfo(self:LocalToWorld(vOffset2), self:LocalToWorldAngles(aOffset2), owner)
end