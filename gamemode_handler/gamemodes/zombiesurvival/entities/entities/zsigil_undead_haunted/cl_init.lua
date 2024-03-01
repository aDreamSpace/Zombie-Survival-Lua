include("shared.lua")

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

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
            draw.SimpleText("Haunted Undead Sigil", "ZS3D2DFont2", 0, -10, COLOR_ORANGE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

            draw.RoundedBox(math.min(hpfrac * 542.5, 8), -275, 105, math.Round(542.5 * hpfrac), 40, Color(255 - 255 * hpfrac, 255 * hpfrac, 0))
            draw.SimpleText("Health: " .. math.Round(hpfrac * 100) .. "%", "ZS3D2DFont2Small", -135, 85, COLOR_PURPLE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText("Heals nearby zombies", "ZS3D2DFont2Smaller", 0, 200, COLOR_GREEN, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText("Destroy to stop the healing!", "ZS3D2DFont2Smaller", 0, 240, COLOR_RED, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            cam.IgnoreZ(false) -- Stop ignoring the Z-buffer
        cam.End3D2D()

        self:DrawParticles() -- Call the DrawParticles function to render the particles
    end
end

function ENT:DrawParticles()
    local curtime = CurTime()
    local sat = math.abs(math.sin(curtime))
    local colsat = sat * 0.125
    local healthperc = self:GetObjectHealth() / self:GetMaxObjectHealth()
    local r, g, b = 1, 0, 0 -- Set color to red
    local radius = 180 + math.cos(sat) * 40
    local whiteradius = 122 + math.sin(sat) * 32
    local up = self:GetUp()
    local spritepos = self:GetPos() + up
    local spritepos2 = self:WorldSpaceCenter()

    local emitter = ParticleEmitter(spritepos)
    emitter:SetNearClip(24, 32)

    local particle = emitter:Add("sprites/glow04_noz", spritepos)
    particle:SetDieTime(math.Rand(1.5, 2))
    particle:SetVelocity(Vector(0, 0, math.Rand(64, 128))) -- Increase velocity to make particles rise faster
    particle:SetStartAlpha(255) -- Start fully opaque
    particle:SetEndAlpha(0) -- Fade out
    particle:SetStartSize(math.Rand(8, 17))
    particle:SetEndSize(0)
    particle:SetRoll(math.Rand(0, 360))
    particle:SetRollDelta(math.Rand(-1, 1))
    particle:SetColor(r * 255, g * 255, b * 255)
    particle:SetCollide(true)

    emitter:Finish()
end