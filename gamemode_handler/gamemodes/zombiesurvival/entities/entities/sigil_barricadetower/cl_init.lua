include("shared.lua")

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
function ENT:Initialize()
    self:SetMaterial("models/debug/debugwhite") -- Set the material to debug white
end

function ENT:DrawTranslucent()
    local h = LocalPlayer():Team() == TEAM_HUMAN
    self:DrawModel()
    
    if h then
        local dist = self:GetPos():DistToSqr(LocalPlayer():GetPos())
        if dist > 500 * 500 then return end -- Don't render if more than 500 units away

        local hpfrac = self:GetObjectHealth() / self:GetMaxObjectHealth()
    
        local pos = self:GetPos() + Vector(0, 0, 40) -- Adjust this as needed
        local ang = (LocalPlayer():GetPos() - pos):Angle()
        ang:RotateAroundAxis(ang:Right(), -90)
        ang:RotateAroundAxis(ang:Up(), 90)
        
        cam.Start3D2D(pos, ang, 0.05)
            cam.IgnoreZ(true) -- Ignore the Z-buffer
            draw.SimpleText("Barricade Sigil", "ZS3D2DFont2", 0, -10, COLOR_ORANGE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

            draw.RoundedBox(math.min(hpfrac * 542.5, 8), -275, 105, math.Round(542.5 * hpfrac), 40, Color(255 - 255 * hpfrac, 255 * hpfrac, 0))
            draw.SimpleText("Health: " .. math.Round(hpfrac * 100) .. "%", "ZS3D2DFont2Small", -135, 85, COLOR_PURPLE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText("Heals nearby nails", "ZS3D2DFont2Smaller", 0, 200, COLOR_GREEN, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText("Grants 10% repair bonus", "ZS3D2DFont2Smaller", 0, 240, COLOR_GREEN, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText("ON BREAK: All humans alive will lose 75% of their points!", "ZS3D2DFont2Smaller", 0, 280, COLOR_RED, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            cam.IgnoreZ(false) -- Stop ignoring the Z-buffer
        cam.End3D2D()
    end
end

ENT.NextUpdate = 0.5
ENT.NextEmit = 0.5
ENT.NextEmitDelay = 0.5
ENT.Rotation = math.random(360)

function ENT:Think()
    local matGlow = Material("sprites/light_glow02_add")
    local cDraw = Color(48, 0, 100) -- Adjusted color for particles
    
    self:EmitSound("ambient/atmosphere/tunnel1.wav", 40, math.random(180, 200))
    self:RemoveAllDecals()
        
    local curtime = CurTime()
    local sat = math.abs(math.sin(curtime))
    local colsat = sat * 0.125
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
        dlight.DieTime = curtime + 1
    end
    
    r = r * healthperc
    g = g * healthperc
    b = b * healthperc
    render.SuppressEngineLighting(true)
    render.SetColorModulation(1, 1, 1)
    self:DrawModel()
    render.SuppressEngineLighting(false)
    
    render.SetColorModulation(r, g, b)
    render.SetBlend(0.1 * healthperc)
    self:DrawModel()
    render.SetColorModulation(r, g, b)
    render.SetBlend(1)
    
    self.Rotation = self.Rotation + FrameTime() * 5
    if self.Rotation >= 360 then
        self.Rotation = self.Rotation - 360
    end
    
    cDraw.r = r * 255
    cDraw.g = g * 255
    cDraw.b = b * 255
    
    render.SetMaterial(matGlow)
    render.DrawQuadEasy(spritepos, up, whiteradius, whiteradius, COLOR_WHITE, self.Rotation) -- Use COLOR_WHITE for the quad's color
    render.DrawQuadEasy(spritepos, up * -1, whiteradius, whiteradius, COLOR_WHITE, self.Rotation) -- Use COLOR_WHITE for the quad's color
    render.DrawQuadEasy(spritepos, up, radius, radius, cDraw, self.Rotation) -- Use cDraw for the quad's color
    render.DrawQuadEasy(spritepos, up * -1, radius, radius, cDraw, self.Rotation) -- Use cDraw for the quad's color
    render.DrawSprite(spritepos2, whiteradius, whiteradius * 1, COLOR_WHITE) -- Use COLOR_WHITE for the sprite's color
    render.DrawSprite(spritepos2, radius, radius * 2, cDraw) -- Use cDraw for the sprite's color
    
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
    particle:SetColor(cDraw.r, cDraw.g, cDraw.b) -- Use cDraw for particle's color
    particle:SetCollide(true)
    
    emitter:Finish()
end
