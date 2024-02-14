local zombieBossClasses = {"Carni", "Spitter", "Puker", "Brute", "The Butcher"}
local maxBossesAllowed = 4
local minPlayersForBossSpawn = 26
local enableBossClassAssignment = CreateConVar("enable_boss_class_assignment", "1", FCVAR_ARCHIVE, "Enable/disable boss class assignment (1 = enabled, 0 = disabled)")

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

-- Console command to toggle boss class assignment
concommand.Add("toggleBossClassAssignment", function(ply, cmd, args)
    if not ply:IsAdmin() then
        ply:PrintMessage(HUD_PRINTCONSOLE, "You don't have permission to use this command.")
        return
    end

    -- Toggle the state of boss class assignment
    enableBossClassAssignment:SetBool(not enableBossClassAssignment:GetBool())

    -- Inform players about the state change
    if enableBossClassAssignment:GetBool() then
        PrintMessage(HUD_PRINTTALK, "Boss class assignment has been enabled.")
    else
        PrintMessage(HUD_PRINTTALK, "Boss class assignment has been disabled.")
    end
end)

-- Set zombie boss classes periodically
timer.Create("ZombieBossClassSetter", 30, 0, function()
    -- Check if boss class assignment is enabled
    if not enableBossClassAssignment:GetBool() then
        return
    end

    -- Check if it's not wave 0 and there are enough players for boss spawn
    if GetGlobalInt("Wave") == 0 or #player.GetAll() < minPlayersForBossSpawn then
        return
    end

    -- Get all players and bots
    local players = player.GetAll()

    -- Filter out dead players and those already bosses
    local alivePlayers = {}
    for _, ply in ipairs(players) do
        if ply:Alive() and not table.HasValue(zombieBossClasses, ply:GetZombieClass()) then
            table.insert(alivePlayers, ply)
        end
    end

    -- Check if there are enough alive players to set bosses
    if #alivePlayers <= maxBossesAllowed then
        return
    end

    -- Select three random players/bots as bosses
    local bossCount = 0
    while bossCount < 3 do
        local ply = table.Random(alivePlayers)
        setZombieBossClass(ply)
        bossCount = bossCount + 1
        if bossCount >= maxBossesAllowed then
            break
        end
    end
end)

-- Set zombie boss classes periodically
timer.Create("ZombieBossClassSetter", 30, 0, function()
    -- Check if boss class assignment is enabled
    if not enableBossClassAssignment then
        return
    end

    -- Check if it's not wave 0 and there are enough players for boss spawn
    if GetGlobalInt("Wave") == 0 or #player.GetAll() < minPlayersForBossSpawn then
        return
    end

    -- Get all players and bots
    local players = player.GetAll()

    -- Filter out dead players and those already bosses
    local alivePlayers = {}
    for _, ply in ipairs(players) do
        if ply:Alive() and not table.HasValue(zombieBossClasses, ply:GetZombieClass()) then
            table.insert(alivePlayers, ply)
        end
    end

    -- Check if there are enough alive players to set bosses
    if #alivePlayers <= maxBossesAllowed then
        return
    end

    -- Select three random players/bots as bosses
    local bossCount = 0
    while bossCount < 3 do
        local ply = table.Random(alivePlayers)
        setZombieBossClass(ply)
        bossCount = bossCount + 1
        if bossCount >= maxBossesAllowed then
            break
        end
    end
end)

-- Sigil Node system for randomizing spawn locations based on nodes we place on the ground
if SERVER then
    -- List of entity names
    local entities = {"sigil_barricadetower", "sigil_medicaltower", "sigil_ammotower", "sigil_pointstower"}

    -- Table to store the node locations
    local nodeLocations = {}

    -- Load the nodes from the file, named after the current map
    local function LoadNodes()
        if file.Exists(game.GetMap() .. "_nodes.txt", "DATA") then
            local str = file.Read(game.GetMap() .. "_nodes.txt", "DATA")
            nodeLocations = util.JSONToTable(str)
        end
    end

    -- Save the nodes to a file
    local function SaveNodes()
        -- Convert the table to a string
        local str = util.TableToJSON(nodeLocations)
        -- Save the string to a file, named after the current map
        file.Write(game.GetMap() .. "_nodes.txt", str)
    end

    -- Console command to create a node
    concommand.Add("sigil_createnode", function(ply, cmd, args)
        if ply:IsAdmin() then
            local pos = ply:GetPos()
            table.insert(nodeLocations, pos)
            print("Node created at " .. tostring(pos))
            SaveNodes() -- Save nodes after adding a new one
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
                    SaveNodes() -- Save nodes after deleting one
                    break
                end
            end
        end
    end)

    -- Console command to delete all nodes
    concommand.Add("sigil_deleteallnodes", function(ply, cmd, args)
        if ply:IsAdmin() then
            nodeLocations = {}
            print("All nodes deleted!")
            SaveNodes() -- Save nodes after deleting all
        end
    end)

    -- Console command to save the nodes
    concommand.Add("sigil_savenodes", function(ply, cmd, args)
        if ply:IsAdmin() then
            SaveNodes()
            print("Nodes saved!")
        end
    end)

    -- Spawn the entities and set up the spawn points
    local function SpawnEntities()
        LoadNodes()
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
                if IsValid(ent) then
                    ent:SetPos(location)
                    ent:Spawn()
                    -- Set the entity's location as a spawn point
                    local spawnPoint = ents.Create("info_player_human")
                    spawnPoint:SetPos(location)
                    spawnPoint:Spawn()
                end
            end
        end
    end

    hook.Add("InitPostEntity", "SpawnEntities", SpawnEntities)

    -- Set the player's spawn point to one of the sigil nodes or a regular spawn point
    hook.Add("PlayerSpawn", "SetSpawnPoint", function(ply)
        if ply:Team() == TEAM_HUMANS then
            -- Check if the player object is valid and has the SelectSpawn method
            if IsValid(ply) and ply.SelectSpawn then
                if #nodeLocations > 0 then
                    -- If there are sigil nodes, spawn the player at a random node
                    local spawnPoint = nodeLocations[math.random(#nodeLocations)]
                    ply:SetPos(spawnPoint)
                else
                    -- If there are no sigil nodes, spawn the player at a regular spawn point
                    ply:SetPos(ply:SelectSpawn():GetPos())
                end
            else
                -- If the player object is invalid or doesn't have SelectSpawn method, spawn at the default spawn point
                ply:SetPos(ply:GetPos())
            end
        end
    end)

    -- Load nodes on map initialization
    LoadNodes()

    -- Spawn entities on map initialization
    SpawnEntities()

    -- Reload nodes on round restart in Zombie Survival
    hook.Add("PreRestartRound", "ReloadNodesOnRoundRestart", function()
        LoadNodes()
        -- Spawn entities again after round restart
        SpawnEntities()
    end)
end

