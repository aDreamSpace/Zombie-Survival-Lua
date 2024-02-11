
-- Sigil Client End 
-- Load the sprite
local sigilSprite = Material("zombiesurvival/sigils/sigil.png") -- Change this to the path of your PNG file

-- Variable to control whether the nodes should be rendered
local renderNodes = false

-- Console command to toggle the rendering of the nodes
concommand.Add("sigil_rendernodes", function()
    renderNodes = not renderNodes
end)

-- Hook to draw the sprite and the node platform
hook.Add("PostDrawOpaqueRenderables", "DrawSigilSprites", function()
    -- Loop over all entities
    for _, ent in ipairs(ents.GetAll()) do
        -- Check if the entity is a sigil
        if ent:GetClass() == "sigil_barricadetower" or ent:GetClass() == "sigil_medicaltower" or ent:GetClass() == "sigil_ammotower" then
            -- Draw the sprite at the entity's position
            render.SetMaterial(sigilSprite)
            local pos = ent:GetPos() + Vector(0, 0, 50) -- Offset the position above the entity

            -- Calculate the distance to the player
            local distance = pos:Distance(EyePos())

            -- Calculate the size of the sprite based on the distance
            local size = math.Clamp(distance / 10, 16, 128) -- Adjust these values as needed

            cam.Start3D(EyePos(), EyeAngles())
                cam.IgnoreZ(true)
                render.DrawSprite(pos, size, size, Color(255, 255, 255))

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
end)