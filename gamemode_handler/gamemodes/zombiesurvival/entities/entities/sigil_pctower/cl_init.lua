include("shared.lua")

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()
    self:EmitSound("ambient/atmosphere/tunnel1.wav", 40, math.random(180, 200))
end 

function ENT:DrawTranslucent()
    local h = LocalPlayer():Team() == TEAM_HUMAN
    self:DrawModel()

    if h then
        if not self.NextPoints then self.NextPoints = CurTime() + 20 end -- Initialize NextPoints if it's nil

        local dist = self:GetPos():DistToSqr(LocalPlayer():GetPos())
        if dist > 500 * 500 then return end -- Don't render if more than 500 units away

        local hpfrac = self:GetObjectHealth() / self:GetMaxObjectHealth()
        local nextPoints = math.max(0, self.NextPoints - CurTime()) -- Time until next points generation

        if nextPoints == 0 then
            self.NextPoints = CurTime() + 20 -- Reset the timer
        end

        local pos = self:GetPos() + Vector(0, 0, 40 * 1.7) -- Adjust this as needed, moved up by 70%
        local ang = (LocalPlayer():GetPos() - pos):Angle()
        ang:RotateAroundAxis(ang:Right(), -90)
        ang:RotateAroundAxis(ang:Up(), 90)

        cam.Start3D2D(pos, ang, 0.05)
            cam.IgnoreZ(true) -- Ignore the Z-buffer
            draw.SimpleText("Power Cell Sigil", "ZS3D2DFont2", 0, -10, COLOR_ORANGE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

            draw.RoundedBox(math.min(hpfrac * 542.5, 8), -275, 105, math.Round(542.5 * hpfrac), 40, Color(255 - 255 * hpfrac, 255 * hpfrac, 0))
            draw.SimpleText("Health: " .. math.Round(hpfrac * 100) .. "%", "ZS3D2DFont2Small", -135, 85, COLOR_PURPLE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText("Empowers nearby allies with power cells", "ZS3D2DFont2Smaller", 0, 200, COLOR_GREEN, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText("ON BREAK: All humans alive will lose 75% of their points!", "ZS3D2DFont2Smaller", 0, 280, COLOR_RED, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            cam.IgnoreZ(false) -- Stop ignoring the Z-buffer
        cam.End3D2D()

    end

    self:DrawParticles()
end

local matGlow = Material("effects/splashwake1")
local matGlow2 = Material("sprites/glow04_noz")
local vector_origin = vector_origin

function ENT:DrawParticles()
    local alt = self:GetDTBool(0)
    local spritepos = self:GetPos() + self:GetUp()

    -- Emit from matGlow2
    render.SetMaterial(matGlow2)
    render.DrawSprite(spritepos, alt and 25 or 50, alt and 25 or 50, Color(143, alt and 89 or 100, 240, 240))

    -- Emit from matGlow
    render.SetMaterial(matGlow)
    render.DrawSprite(spritepos, alt and 6 or 12, alt and 6 or 12, Color(143, alt and 88 or 240, 240))

    local emitter = ParticleEmitter(spritepos)
    emitter:SetNearClip(24, 32)

    local particle = emitter:Add("sprites/glow04_noz", spritepos)
    if particle then
        particle:SetDieTime(math.Rand(1.5, 2))
        particle:SetVelocity(Vector(0, 0, math.Rand(64, 128))) -- Increase velocity to make particles rise faster
        particle:SetStartAlpha(255) -- Start fully opaque
        particle:SetEndAlpha(0) -- Fade out
        particle:SetStartSize(math.Rand(8, 17))
        particle:SetEndSize(0)
        particle:SetRoll(math.Rand(0, 360))
        particle:SetRollDelta(math.Rand(-1, 1))
        particle:SetColor(0, 100, 0) -- Set color to dark green
        particle:SetCollide(true)
    end  

    emitter:Finish()
end
