
local zombieBossClasses = {"Carni", "Spitter", "Puker", "Brute", "The Butcher"}

-- Function to set a random zombie boss class to a player
local function setZombieBossClass(ply)
    if ply:Team() == TEAM_ZOMBIES then
        -- Check if the player is already one of the boss classes
        local currentClass = ply:GetZombieClass()
        if table.HasValue(zombieBossClasses, currentClass) then
            return
        end

        local bossClass = table.Random(zombieBossClasses)
        -- Set the player's class
        ply:KillSilent()
        ply:SetZombieClassName(bossClass)
        ply:UnSpectateAndSpawn()

        -- Display a notification
        PrintMessage(HUD_PRINTTALK, ply:Nick() .. " has become a " .. bossClass .. "!", COLOR_ORANGE)
    end
end

-- Set zombie boss classes every 30 seconds
timer.Create("ZombieBossClassSetter", 30, 0, function()
    -- Get all players and bots
    local players = player.GetAll()

    -- Check if there are more than 16 players
    if #players <= 16 then
        return
    end

    -- Select three random players/bots
    for i = 1, 3 do
        local ply = table.Random(players)
        setZombieBossClass(ply)
    end
end)

-- Sigil Node system for randomizing spawn locations based on nodes we place on the ground
  -- List of entity names
  if SERVER then
    -- List of entity names
    local entities = {"sigil_barricadetower", "sigil_medicaltower", "sigil_ammotower", "sigil_pointstower"}

    -- Table to store the node locations
    local nodeLocations = {}

    -- Console command to create a node
    concommand.Add("sigil_createnode", function(ply, cmd, args)
        if ply:IsAdmin() then
            local pos = ply:GetPos()
            table.insert(nodeLocations, pos)
            print("Node created at " .. tostring(pos))
        end
    end)

    -- Console command to delete a node
    concommand.Add("sigil_deletenode", function(ply, cmd, args)
        if ply:IsAdmin() then
            local pos = ply:GetPos()
            for i, nodePos in ipairs(nodeLocations) do
                if pos:DistToSqr(nodePos) < 10000 then -- Adjust this value as needed
                    table.remove(nodeLocations, i)
                    print("Node deleted at " .. tostring(nodePos))
                    break
                end
            end
        end
    end)

    -- Console command to delete all nodes
    concommand.Add("sigil_deleteallnodes", function(ply, cmd, args)
        if ply:IsAdmin() then
            for _, ent in ipairs(ents.GetAll()) do
                if table.HasValue(entities, ent:GetClass()) then
                    ent:Remove()
                end
            end
            nodeLocations = {}
            print("All nodes deleted!")
        end
    end)

    -- Console command to save the nodes
    concommand.Add("sigil_savenodes", function(ply, cmd, args)
        if ply:IsAdmin() then
            -- Convert the table to a string
            local str = util.TableToJSON(nodeLocations)

            -- Save the string to a file, named after the current map
            file.Write(game.GetMap() .. "_nodes.txt", str)
            print("Nodes saved!")
        end
    end)

    -- Spawn the entities and set up the spawn points
    hook.Add("InitPostEntity", "SpawnEntities", function()
        -- Load the nodes from the file, named after the current map
        if file.Exists(game.GetMap() .. "_nodes.txt", "DATA") then
            local str = file.Read(game.GetMap() .. "_nodes.txt", "DATA")
            nodeLocations = util.JSONToTable(str)

            -- Repeat the entities to match the number of nodes
            local repeatedEntities = {}
            for i = 1, #nodeLocations do
                table.insert(repeatedEntities, entities[(i - 1) % #entities + 1])
            end

            -- Spawn an entity at each node and set it as a spawn point
            for i, entityName in ipairs(repeatedEntities) do
                local location = nodeLocations[i]
                if location then
                    local ent = ents.Create(entityName)
                    if (IsValid(ent)) then
                        ent:SetPos(location)
                        ent:Spawn()

                        -- Set the entity's location as a spawn point
                        ents.Create("info_player_human"):SetPos(location)
                    end
                end
            end
        end
    end)

    -- Set the player's spawn point to one of the sigil nodes or a regular spawn point
    hook.Add("PlayerSpawn", "SetSpawnPoint", function(ply)
        if ply:Team() == TEAM_HUMANS then
            if #nodeLocations > 0 then
                -- If there are sigil nodes, spawn the player at a random node
                local spawnPoint = nodeLocations[math.random(#nodeLocations)]
                ply:SetPos(spawnPoint)
            else
                -- If there are no sigil nodes, spawn the player at a regular spawn point
                ply:SetPos(ply:SelectSpawn():GetPos())
            end
        end
    end)
end


