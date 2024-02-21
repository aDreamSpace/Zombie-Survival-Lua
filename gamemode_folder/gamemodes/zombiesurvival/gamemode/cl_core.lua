-- Client 
local sigilSprite = Material("zombiesurvival/sigils/sigil.png") -- Change this to the path of your PNG file
local evilSigilSprite = Material("zombiesurvival/sigils/sigilenemy.png") -- Sprite for evil sigils
local npcSprite = Material("zombiesurvival/seethroughs/npcs.png") -- Sprite for NPCs

-- Variable to control whether the nodes should be rendered
local renderNodes = false

local sigilClasses = {
    "sigil_barricadetower",
    "sigil_medicaltower",
    "sigil_ammotower",
    "sigil_pointstower",
    "sigil_pctower"
}

local evilSigils = {
    "zsigil_undead_haunted",
}

-- Console command to toggle the rendering of the nodes
concommand.Add("sigil_rendernodes", function()
    renderNodes = not renderNodes
end)

local sigilLetters = {}

-- Hook to draw sigil sprites and world hints
hook.Add("PostDrawOpaqueRenderables", "DrawSigilSpritesAndHints", function()
    -- Loop over all entities
    for _, ent in ipairs(ents.GetAll()) do
        local isSigil = table.HasValue(sigilClasses, ent:GetClass())
        local isEvilSigil = table.HasValue(evilSigils, ent:GetClass())
        local isNPC = ent:IsNPC()

        -- Check if the entity is a sigil, an evil sigil, or an NPC
        if isSigil or isEvilSigil or isNPC then
            -- Perform a trace from the player's eye position to the entity's position
            local trace = util.TraceLine({
                start = EyePos(),
                endpos = ent:GetPos(),
                filter = LocalPlayer() -- Ignore the local player
            })

            -- Check if the trace hit the entity
            if trace.Entity == ent then
                -- Choose the sprite based on the type of the entity
                local sprite
                if isEvilSigil then
                    sprite = evilSigilSprite
                elseif isSigil then
                    sprite = sigilSprite
                elseif isNPC then
                    sprite = npcSprite
                end

                -- Draw the sprite at the entity's position
                render.SetMaterial(sprite)
                local pos = ent:GetPos() + Vector(0, 0, isNPC and 100 or 50) -- Offset the position above the entity

                -- Calculate the distance to the player
                local distance = pos:Distance(EyePos())

                -- Calculate the size of the sprite based on the distance
                local size = math.Clamp(distance / 10, 16, 128) -- Adjust these values as needed

                cam.Start3D(EyePos(), EyeAngles())
                    cam.IgnoreZ(true)
                    render.DrawSprite(pos, size, size, Color(255, 255, 255))

                    -- Draw the world hint
                    local hintPos = ent:GetPos() + Vector(0, 0, 70) -- Offset the position above the entity
                    local hintText = sigilLetters[ent:GetClass()] or "Unknown"
                    surface.SetFont("ZSHUDFontSmall")
                    local textWidth, textHeight = surface.GetTextSize(hintText)
                    local textX = hintPos:ToScreen().x - textWidth / 2
                    local textY = hintPos:ToScreen().y - textHeight / 2
                    draw.DrawText(hintText, "ZSHUDFontSmall", textX, textY, Color(255, 255, 255), TEXT_ALIGN_LEFT)

                    -- Draw the node platform if renderNodes is true
                    if renderNodes then
                        local nodePos = ent:GetPos()
                        local nodeSize = Vector(25, 25, 1) -- Adjust this value as needed

                        render.SetColorMaterial()
                        render.DrawBox(nodePos, Angle(0, 0, 0), -nodeSize / 2, nodeSize / 2, Color(255, 0, 0, 100), true)
                    end
                    cam.IgnoreZ(false)
                cam.End3D()
            end
        end
    end
end)