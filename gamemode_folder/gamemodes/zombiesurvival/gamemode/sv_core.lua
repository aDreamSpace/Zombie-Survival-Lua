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
    local evilentities = {"zsigil_undead_haunted"}
    -- Table to store the node locations
    local nodeLocations = {}

-- Load the nodes from the file, named after the current map
local function LoadNodes()
    local filePath = "sigil_nodes/" .. game.GetMap() .. "_nodes.txt"
    if file.Exists(filePath, "DATA") then
        local str = file.Read(filePath, "DATA")
        nodeLocations = util.JSONToTable(str)
    end
end

-- Save the nodes to a file
local function SaveNodes()
    -- Convert the table to a string
    local str = util.TableToJSON(nodeLocations)
    -- Save the string to a file, named after the current map
    local filePath = "sigil_nodes/" .. game.GetMap() .. "_nodes.txt"
    file.Write(filePath, str)
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
-- Spawn the entities and set up the spawn points
local function SpawnEntities()
    LoadNodes()
    -- Repeat the entities to match the number of nodes
    local repeatedEntities = {}
    for i = 1, #nodeLocations do
        local entityName
        if math.random() < 0.7 then -- 70% chance to spawn an evil entity
            entityName = evilentities[math.random(#evilentities)]
        else
            entityName = entities[(i - 1) % #entities + 1]
        end
        table.insert(repeatedEntities, entityName)
    end

    -- Spawn an entity at each node and set it as a spawn point
    for i, entityName in ipairs(repeatedEntities) do
        local location = nodeLocations[i]
        if location then
            local ent = ents.Create(entityName)
            if IsValid(ent) then
                ent:SetPos(location)
                ent:Spawn()
            end
        end
    end
end
hook.Add("InitPostEntity", "SpawnEntities", SpawnEntities)



-- Set the player's spawn point to one of the sigil nodes or a regular spawn point
hook.Add("PlayerSpawn", "SetSpawnPoint", function(ply)
    if ply:Team() == TEAM_HUMANS then
        -- Human spawn logic...
    elseif ply:Team() == TEAM_ZOMBIES then
        -- Get all zombie spawn points
        local zombieSpawns = ents.FindByClass("info_player_zombie")
        if #zombieSpawns > 0 then
            -- If there are zombie spawn points, spawn the player at a random point
            local spawnPoint = zombieSpawns[math.random(#zombieSpawns)]
            ply:SetPos(spawnPoint:GetPos())
        else
            -- If there are no zombie spawn points, spawn the player at a regular spawn point
            ply:SetPos(ply:SelectSpawn():GetPos())
        end
    end
end)
    
    -- Handle entity destruction
    hook.Add("EntityRemoved", "HandleEntityDestruction", function(ent)
        if table.HasValue(entities, ent:GetClass()) or table.HasValue(evilentities, ent:GetClass()) then
            local newEntityName
            if table.HasValue(entities, ent:GetClass()) then
                newEntityName = evilentities[math.random(#evilentities)]
            else
                newEntityName = entities[math.random(#entities)]
            end
            local newEnt = ents.Create(newEntityName)
            if IsValid(newEnt) then
                newEnt:SetPos(ent:GetPos())
                newEnt:Spawn()
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

-- Server-side code
if SERVER then
    -- Define a table of NPCs to spawn
    local npcsToSpawn = {
        "npc_zombie",
        "npc_fastzombie",
        "npc_poisonzombie"
        -- Add more NPCs here...
    }

    -- Define a table of point rewards for each NPC
    local npcPointRewards = {
        npc_zombie = 3,
        npc_fastzombie = 3,
        npc_poisonzombie = 4
        -- Add more NPCs and their point rewards here...
    }

    -- Maximum number of NPCs that can be alive at once
    local maxNPCs = 25

    -- Spawn delay in seconds
    local spawnDelay = 5

    timer.Create("NPCSpawner", spawnDelay, 0, function()
        -- Check if the current wave is 0
        if GAMEMODE:GetWave() == 1 then
            -- Count the number of NPCs that are currently alive
            local npcCount = 0
            for _, npc in pairs(ents.GetAll()) do
                if npc:IsNPC() and table.HasValue(npcsToSpawn, npc:GetClass()) then
                    npcCount = npcCount + 1
                end
            end

            -- Only spawn new NPCs if the maximum has not been reached
            if npcCount < maxNPCs then
                -- Find all info_player_zombie entities
                for _, ent in pairs(ents.FindByClass("info_player_zombie")) do
                    -- Check if the area is clear before spawning a new NPC
                    local tr = util.TraceHull({
                        start = ent:GetPos(),
                        endpos = ent:GetPos(),
                        mins = Vector(-16, -16, 0),
                        maxs = Vector(16, 16, 72)
                    })

                    if not tr.Hit then
                        -- Choose a random NPC to spawn
                        local npcClass = table.Random(npcsToSpawn)

                        -- Create the NPC
                        local npc = ents.Create(npcClass)
                        if IsValid(npc) then
                            -- Set the NPC's position to the info_player_zombie entity's position
                            npc:SetPos(ent:GetPos())

                            -- Spawn the NPC
                            npc:Spawn()

                            -- Make the NPC hostile towards all players
                            for _, ply in pairs(player.GetAll()) do
                                npc:AddEntityRelationship(ply, D_HT, 99)
                            end

                            -- Set the NPC's collision group to COLLISION_GROUP_DEBRIS
                            npc:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
                        end
                    end
                end
            end
        end
    end)

    -- Hook to detect when an NPC is killed
    hook.Add("EntityTakeDamage", "NPCDamage", function(target, dmginfo)
        -- Check if the target is an NPC and the attacker is a player
        if target:IsNPC() and dmginfo:GetAttacker():IsPlayer() then
            -- Check if the damage will kill the NPC
            if target:Health() <= dmginfo:GetDamage() then
                -- Award points to the player who killed the NPC
                local attacker = dmginfo:GetAttacker()
                local points = npcPointRewards[target:GetClass()] or 1 -- Default to 1 point if the NPC's class is not in the table
                attacker:AddPoints(points)
            end
        end
    end)
end


-- Error Models bypass
if SERVER then
    timer.Create("RemoveErrorModels", 1, 0, function()
        for _, ent in pairs(ents.GetAll()) do
            if ent:GetModel() == "models/error.mdl" then
                ent:Remove()
            end
        end
    end)
end