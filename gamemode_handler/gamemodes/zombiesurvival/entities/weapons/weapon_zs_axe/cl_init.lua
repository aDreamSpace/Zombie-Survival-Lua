include("shared.lua")

SWEP.VElements = {
    ["base"] = { type = "Model", model = "models/props/cs_militia/axe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 1.299, -4), angle = Angle(0, 0, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
    ["base"] = { type = "Model", model = "models/props/cs_militia/axe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 1.399, -4), angle = Angle(0, 0, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

net.Receive("ActivateAbility", function()
    local wep = net.ReadEntity()
    if not IsValid(wep) then return end
     wep:EmitSound("ambient/machines/teleport1.wav", 70, 70)
        
    wep.ParticleEmitter = ParticleEmitter(wep:GetPos())
    wep.ParticleTimer = timer.Create("AbilityParticles"..wep:EntIndex(), 0.1, 50, function()
        if not IsValid(wep) then return end

       
        local particle = wep.ParticleEmitter:Add("sprites/glow04_noz", wep:GetPos() + VectorRand() * 10)
        if particle then
            particle:SetVelocity(VectorRand() * 50)
            particle:SetLifeTime(0)
            particle:SetDieTime(math.Rand(0.5, 1))
            particle:SetStartAlpha(255)
            particle:SetEndAlpha(0)
            particle:SetStartSize(math.Rand(1, 3))
            particle:SetEndSize(0)
            particle:SetColor(255, 0, 0)
        end
    end)
end)

net.Receive("DeactivateAbility", function()
    local wep = net.ReadEntity()
    if not IsValid(wep) then return end

    if wep.ParticleEmitter then
        wep.ParticleEmitter:Finish()
        wep.ParticleEmitter = nil
    end
    timer.Remove("AbilityParticles"..wep:EntIndex())
end)

local prevState = nil

hook.Add("HUDPaint", "AbilityCooldown", function()
    local ply = LocalPlayer()
    local wep = ply:GetActiveWeapon()

    if IsValid(wep) and wep:GetClass() == "weapon_zs_axe" then
        local x, y = ScrW() / 2, ScrH() / 2
        local barWidth = 120
        local barHeight = 20
        local state = nil

        if wep:GetNWBool("AbilityActive") then
            state = "active"
            draw.SimpleText("IN PROGRESS", "ZSHUDFontSmaller", x, y + 30 + barHeight / 2, Color(255, 255, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        elseif CurTime() < wep:GetNWFloat("AbilityCooldown") then
            state = "cooldown"
            local cooldownProgress = 1 - ((wep:GetNWFloat("AbilityCooldown") - CurTime()) / 30)
            draw.RoundedBox(0, x - barWidth / 2, y + 30, barWidth * cooldownProgress, barHeight, Color(102, 0, 255))
        else
            state = "ready"
            draw.SimpleText("Ready to Activate", "ZSHUDFontSmaller", x, y + 30 + barHeight / 2, Color(0, 255, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        if state ~= prevState then
            if state == "active" then
                surface.PlaySound("buttons/button8.wav")
            elseif state == "cooldown" then
                surface.PlaySound("buttons/button6.wav")
            elseif state == "ready" then
                surface.PlaySound("buttons/button4.wav")
            end
            prevState = state
        end
    end
end)