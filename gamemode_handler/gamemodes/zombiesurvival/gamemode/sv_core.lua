--[[Here's a brief overview of the main functionalities:

    Spray Cooldown: Prevents players from spamming sprays.
    Hammer Damage Handler: Adjusts damage taken by entities when attacked by specified hammers.
    Bot Adjustment: Modifies the number of bots in the game based on player points and frags.
    Physgun Pickup: Allows players to pick up both humans and zombies using the Physgun.
    Class Health Regeneration: Regenerates health for players based on their zombie class.
    Award Points for Killing Zombies: Gives players points when they kill zombies.
    Class Damage Handler: Adjusts damage taken by players based on their zombie class.
    Demi Boss Classes: Randomly assigns boss classes to zombies under certain conditions.
    Sigil Node System: Handles spawning of entities based on predefined node locations.
    NPC Reward System: Rewards players with points for killing specific NPCs.
    Zombie Abilities & Powers: Implements various abilities and powers for zombies, such as speed reduction for humans near specific zombie classes.
    Soundtrack System: Plays random soundtracks for players upon joining.
    
]]



// Spray Cooldown
// Prevent people from spamming sprays
local sprayCooldown = {}

hook.Add("PlayerSpray", "LimitSprayUsage", function(ply)
    if not IsValid(ply) then return end

    local curTime = CurTime()
    if sprayCooldown[ply] and sprayCooldown[ply] > curTime then
        return true
    end

    sprayCooldown[ply] = curTime + 10
end)



-- Configuration: points required to add bots
local pointsToBots = {
    [100] = 1,
    [300] = 2,
    [500] = 3,
    [700] = 4,
    [1500] = 5,
    [3000] = 7,
    [4000] = 10,
    [6000] = 15,
    [12000] = 25 
}

-- Function to adjust bots based on total points
local function adjustBotsBasedOnPoints()
    local totalPoints = 0

    -- Calculate total points for human players
    for _, ply in ipairs(player.GetAll()) do
        if ply:Team() == TEAM_HUMAN then
            totalPoints = totalPoints + ply:Frags()
        end
    end

    -- Find the threshold closest to totalPoints
    local maxThreshold = nil
    for threshold, _ in pairs(pointsToBots) do
        if threshold <= totalPoints and (not maxThreshold or threshold > maxThreshold) then
            maxThreshold = threshold
        end
    end

    -- Adjust bots if a threshold was found
    if maxThreshold then
        local desiredBotCount = pointsToBots[maxThreshold]
        local currentBotCount = #player.GetBots()

        if desiredBotCount > currentBotCount then
            RunConsoleCommand("botmod", desiredBotCount)
        end
    end
end

-- Function to adjust bots based on frags
local function adjustBotsBasedOnFrags()
    local totalFrags = 0

    -- Calculate total frags for human players
    for _, ply in ipairs(player.GetAll()) do
        if ply:Team() == TEAM_HUMAN then
            totalFrags = totalFrags + ply:Frags()
        end
    end

    -- Find the threshold closest to totalFrags
    local maxThreshold = nil
    for threshold, _ in pairs(pointsToBots) do
        if threshold <= totalFrags and (not maxThreshold or threshold > maxThreshold) then
            maxThreshold = threshold
        end
    end

    -- Adjust bots if a threshold was found
    if maxThreshold then
        local desiredBotCount = pointsToBots[maxThreshold]
        local currentBotCount = #player.GetBots()

        if desiredBotCount > currentBotCount then
            RunConsoleCommand("botmod", desiredBotCount)
        end
    end
end

-- Timer to adjust bots every 10 seconds based on points
timer.Create("AdjustBotsBasedOnPointsTimer", 10, 0, adjustBotsBasedOnPoints)

-- Timer to adjust bots every 10 seconds based on frags
timer.Create("AdjustBotsBasedOnFragsTimer", 10, 0, adjustBotsBasedOnFrags)

-- Adjust bots when a player kills another player
hook.Add("PlayerDeath", "AdjustBotsOnPlayerKill", function(victim, inflictor, attacker)
    if attacker:IsPlayer() and attacker:Team() == TEAM_HUMAN then
        adjustBotsBasedOnPoints()
        adjustBotsBasedOnFrags()
    end
end)



// Physgun Pick up for Zombies + Humans
hook.Add("PhysgunPickup", "AllowHumanUndeadPickup", function(ply, target)
    if target:IsPlayer() and (target:Team() == TEAM_UNDEAD or target:Team() == TEAM_HUMAN) then
        return true
    end
end)



//Class Health Handler
hook.Add("PlayerSpawn", "HandleHealthRegen", function(player)
    -- Get the player's zombie class
    local classname = player:GetZombieClass()
    local classtab = GAMEMODE.ZombieClasses[classname]

    -- Check if the class has a HealthRegenRate
    if classtab and classtab.HealthRegenRate then
        -- Create a timer that regenerates health
        timer.Create(player:EntIndex() .. "HealthRegen", 7, 0, function()
            if IsValid(player) then
                local maxHealth = player:GetMaxHealth()
                if player:Health() < maxHealth then
                    player:SetHealth(math.min(player:Health() + classtab.HealthRegenRate , maxHealth))
                end
            else
                -- Player is no longer valid, remove the timer
                timer.Remove(player:EntIndex() .. "HealthRegen")
            end
        end)
    end
end)

hook.Add("PlayerDeath", "AwardPointsForKill", function(victim, inflictor, attacker)
    -- Check if the victim is a player and on TEAM_UNDEAD
    if IsValid(victim) and victim:IsPlayer() and victim:Team() == TEAM_UNDEAD then
        -- Check if the attacker is a player
        if IsValid(attacker) and attacker:IsPlayer() then
            -- Award 1 PointShop point to the attacker
            attacker:PS_GivePoints(2)
           -- attacker:PS_Notify("You've earned 1 point for killing a zombie!")
        end
    end
end)

//  Damage handler 
hook.Add("EntityTakeDamage", "HandleDamage", function(target, dmg)
    -- Handle damage resistance for players
    if target:IsPlayer() then
        local classname = target:GetZombieClass()
        local classtab = GAMEMODE.ZombieClasses[classname]
        if classtab and classtab.DamageResistance then
            local reduction = 1 - classtab.DamageResistance
            dmg:ScaleDamage(reduction)
        end

        -- Handle damage multiplier for zombie classes
        local class = target:GetZombieClassTable()
        if class and class.DamageMultiplier then
            local reducedDamage = dmg:GetDamage() * class.DamageMultiplier
            dmg:SetDamage(reducedDamage)
        end

        -- Handle damage buff for marked players
        local attacker = dmg:GetAttacker()
        if attacker:IsValid() and attacker:IsPlayer() and attacker:Team() == TEAM_UNDEAD and attacker.m_MarkedPlayer == target and target.m_MarkedBySkeletor == attacker and attacker:GetZombieClassTable().Name == "Skeleton" then
            dmg:SetDamage(dmg:GetDamage() * 3)
        end

        -- Handle one hit damage
        if target["1HKO"] and attacker and attacker:IsValid() and attacker:IsPlayer() and attacker ~= target then
            print(target, "one hit by", attacker)
            dmg:SetDamage(4000)
        end
    end

    -- Handle Self Explosive Damage to humans
    if TEAM_HUMAN then -- IF ZOMBIE SURVIVAL
        if target:IsPlayer() then
            if target:Team() == TEAM_HUMAN  and dmg:IsDamageType(64) then return true end
        end
    end

    if target:GetClass() then
        if dmg:IsDamageType(DMG_BLAST) and table.HasValue({"prop_physics", "prop_physics_multiplayer", "prop_arsenalcrate", "prop_resupplybox", "prop_constructor", "prop_medstation", "prop_teleporter", "prop_nail"}, target:GetClass()) then
            return true
        end
    end

    -- Check if the attacker is a player
    local attacker = dmg:GetAttacker()
    if not attacker:IsPlayer() then return end

    -- Check if the attacker's weapon is one of the specified hammers
    local weapon = attacker:GetActiveWeapon()
    if not weapon:IsValid() then return end
    local weaponClass = weapon:GetClass()
    if weaponClass ~= "cw_tool_hammer" and weaponClass ~= "weapon_zs_hammer" and weaponClass ~= "weapon_zs_hammerplank" then return end

    -- Check if the target is not a player
    if target:IsPlayer() then return end

    -- Set the damage to 500
    dmg:SetDamage(500)
end)

local zombieBossClasses = {"Carni", "Spitter", "Puker", "Brute", "The Butcher"}
local maxBossesAllowed = 9
local minPlayersForBossSpawn = 26
local enableBossClassAssignment = CreateConVar("enable_boss_class_assignment", "1", FCVAR_ARCHIVE, "Enable/disable boss class assignment (1 = enabled, 0 = disabled)")

util.AddNetworkString("PlayerBecomeBoss")

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

        -- Send a notification to the client
        net.Start("PlayerBecomeBoss")
        net.WriteString(ply:Nick() .. " has become " .. bossClass .. "!")
        net.Broadcast()
    end
end

hook.Add("EndRound", "SlayBotsOnRoundEnd", function(winningTeam)
    for _, player in ipairs(player.GetAll()) do
        if player:IsBot() then
            player:Kill()
        end
    end
end)

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
timer.Create("ZombieBossClassSetter", 45, 0, function()
    -- Check if boss class assignment is enabled
    if not enableBossClassAssignment:GetBool() then
        return
    end

    -- Check if it's wave 3, not wave 0 and there are enough players for boss spawn
    local wave = GAMEMODE:GetWave()
    if wave == 3 or wave == 0 or #player.GetAll() < minPlayersForBossSpawn then
        return
    end

    -- Check if it's wave intermission
    if not GAMEMODE:GetWaveActive() then
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
        -- If the selected player is already a boss, continue with the next iteration
        if table.HasValue(zombieBossClasses, ply:GetZombieClass()) then
            continue
        end
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
    local entities = {
        {name = "sigil_barricadetower", chance = 0.35},
        {name = "sigil_medicaltower", chance = 0.3},
        {name = "sigil_ammotower", chance = 0.2},
        {name = "sigil_pointstower", chance = 0.2},
        {name = "sigil_pctower", chance = 0.2}
     --   {name = "zsigil_undead_haunted", chance = 0.1}
    }

    -- We have big maps, so we twice the amount of sigils
    local mapExceptions = {
        ["zs_abandoned_mall_v10"] = 6,
        ["zs_abandoned_mallmart_b4"] = 7,
        ["zs_damiens_house_v2c"] = 8,
        ["zs_onett_v6"] = 6, 
        ["zs_krusty_krab_large_v5"] = 6, 
        ["zs_resistance_rising_v1"] = 5,
        
    }

    local evilentities = {"zsigil_undead_haunted"}
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

    concommand.Add("sigil_reloadnodes", function(ply, cmd, args)
        if ply:IsAdmin() then
            -- Clear the current node locations
            nodeLocations = {}

            -- Load nodes from the file
            LoadNodes()

            -- Spawn entities on the nodes
            SpawnEntities()

            print("Nodes reloaded and entities spawned!")
        end
    end)

    local function selectEntity()
        local totalChance = 0
        for _, entity in ipairs(entities) do
            totalChance = totalChance + entity.chance
        end
    
        local rand = math.random() * totalChance
        for _, entity in ipairs(entities) do
            if rand < entity.chance then
                return entity.name
            end
            rand = rand - entity.chance
        end
    end

    local function shuffleTable(t)
        for i = #t, 2, -1 do
            local j = math.random(i)
            t[i], t[j] = t[j], t[i]
        end
    end

-- Function to spawn entities

local function SpawnEntities()
    LoadNodes()

    -- Shuffle the node locations
    shuffleTable(nodeLocations)

    -- Determine the number of entities to spawn
    local mapName = game.GetMap()
    local numEntitiesToSpawn = mapExceptions[mapName] or math.min(#nodeLocations, 3)

    -- Spawn an entity at each node
    for i = 1, numEntitiesToSpawn do
        local location = nodeLocations[i]
        if location then
            local entityName = selectEntity()
            local ent = ents.Create(entityName)
            if IsValid(ent) then
                ent:SetPos(location)
                ent:Spawn()
            end
        end
    end
end


hook.Add("InitPostEntity", "SpawnEntities", SpawnEntities)

    -- Handle entity destruction
    hook.Add("EntityRemoved", "HandleEntityDestruction", function(ent)
        if table.HasValue(entities, ent:GetClass()) or table.HasValue(evilentities, ent:GetClass()) then
            local newEntityName
            if table.HasValue(evilentities, ent:GetClass()) then
                -- If the entity that was removed is an evil entity, spawn a new entity from the entities table
                newEntityName = entities[math.random(#entities)].name
            else
                -- If the entity that was removed is not an evil entity, spawn a new entity from the evilentities table
                newEntityName = evilentities[math.random(#evilentities)].name
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

-- NPC Reward System
local zombieNPCs = {
    "npc_zombie",
    "npc_fastzombie",
    "npc_poisonzombie",
    "npc_zombine"
  }
  
  -- Function to add points to a player
  local function AddPoints(ply, points)
    -- Assuming you have a function or method to add points to a player
    ply:AddPoints(points)
  end
  
  -- Function to determine points awarded for each NPC class
  local function GetPointsForNPC(npcClass)
    -- Define points and health/damage data for each NPC class in a table
    local npcData = {
      ["npc_zombie"] = {
        points = 3,
        damage = 30,
        health = 300,
      },
      ["npc_fastzombie"] = {
        points = 5,
        damage = 8,
        health = 225,
      },
      ["npc_poisonzombie"] = {
        points = 7,
        damage = 45,
        health = 425,
        poisonDamage = 5,
      },
      ["npc_zombine"] = {
        points = 10,
        damage = 20,
        health = 200,
      },
    }
    
    -- Return the points and data based on the NPC class, or defaults if not found
    return npcData[npcClass] or { points = 1, damage = 10, health = 100 }
  end

-- Store the initial health of NPCs in a table
-- Store the initial health of NPCs in a table
local npcInitialHealth = {}

-- Hook into the NPC spawn event
hook.Add("NPCSpawned", "SetNPCHPDamage", function(npc)
    -- Check if the NPC is in the zombie list
    if table.HasValue(zombieNPCs, npc:GetClass()) then
        -- Get NPC data based on its class
        local npcData = GetPointsForNPC(npc:GetClass())
      
        if npcData then
            -- Store the NPC's initial health
            npcInitialHealth[npc] = npcData.health
            -- Set the NPC's health
            npc:SetHealth(npcData.health)
        end
    end
end)

-- Hook into the ScaleNPCDamage event
hook.Add("ScaleNPCDamage", "ControlNPCHP", function(npc, hitgroup, dmginfo)
    -- Check if the NPC's initial health is stored
    if npcInitialHealth[npc] then
        -- Calculate the NPC's current health
        local health = npcInitialHealth[npc] - dmginfo:GetDamage()

        -- If the NPC's health is less than or equal to 0, kill the NPC
        if health <= 0 then
            dmginfo:SetDamage(npc:Health())
        else
            -- Otherwise, scale the damage so that the NPC's health is correct
            dmginfo:SetDamage(dmginfo:GetDamage() * (npc:Health() / health))
            -- Update the NPC's initial health
            npcInitialHealth[npc] = health
        end
    end
end)
  
  -- Hook into the NPC death event
  hook.Add("OnNPCKilled", "AddPointsOnZombieDeath", function(npc, attacker, inflictor)
    -- Check if the attacker is a player
    if attacker:IsPlayer() then
      -- Get NPC data based on its class
      local npcData = GetPointsForNPC(npc:GetClass())
  
      -- Check if data exists and award points
      if npcData then
        AddPoints(attacker, npcData.points)
        
    
        
      end
    end
  end)



-- ZOMBIE ABILITIES & POWERS


-- Nightmare Slow Speed Ability 

local originalWalkSpeeds = {}

hook.Add("Think", "AncientNightmareSpeedReduction", function()
    -- Get all "Ancient Nightmare" players
    local nightmares = {}
    for _, ply in ipairs(player.GetAll()) do
        if ply:Alive() and ply:GetZombieClassTable().Name == "Ancient Nightmare" then
            table.insert(nightmares, ply)
        end
    end

    -- Check each human player
    for _, ply in ipairs(team.GetPlayers(TEAM_HUMAN)) do
        if ply:Alive() then
            -- Get the closest "Ancient Nightmare"
            local closestDist = math.huge
            for _, nightmare in ipairs(nightmares) do
                local dist = ply:GetPos():Distance(nightmare:GetPos())
                if dist < closestDist then
                    closestDist = dist
                end
            end

            -- If within range, reduce walk speed
            if closestDist <= 1000 then  -- Change this to your desired range
                if not originalWalkSpeeds[ply] then
                    originalWalkSpeeds[ply] = ply:GetWalkSpeed()
                end
                -- Increase the divisor for a more significant speed reduction
                ply:SetWalkSpeed(math.max(originalWalkSpeeds[ply] - closestDist / 2, 100))  -- Change these numbers as desired
            -- If out of range, restore original walk speed
            elseif originalWalkSpeeds[ply] then
                ply:SetWalkSpeed(originalWalkSpeeds[ply])
                originalWalkSpeeds[ply] = nil
            end
        end
    end
end)




util.AddNetworkString("NPCDeathPoints")

-- Hook into the NPC death event
hook.Add("OnNPCKilled", "AddPointsOnZombieDeath", function(npc, attacker, inflictor)
    -- Check if the attacker is a player
    if attacker:IsPlayer() then
        -- Get NPC data based on its class
        local npcData = GetPointsForNPC(npc:GetClass())

        -- Check if data exists and award points
        if npcData then
            AddPoints(attacker, npcData.points)

            -- Send a network message to the client with the points and the NPC's position
            net.Start("NPCDeathPoints")
            net.WriteInt(npcData.points, 16)
            net.WriteVector(npc:GetPos())
            net.Send(attacker)
        end
    end
end)

-- This does work, but it's not good to use it in a gamemode like Zombie Survival

--[[
-- Soundtrack System
-- SUCH a headache 
-- Define the soundtracks
local soundtracks = {
    "soundtrack/hl2/track01.mp3",
    "soundtrack/hl2/track02.mp3",
    "soundtrack/hl2/track03.mp3",
    "soundtrack/hl2/track04.mp3",
    "soundtrack/hl2/track05.mp3",
    "soundtrack/hl2/track06.mp3",
    "soundtrack/hl2/track07.mp3",
    "soundtrack/hl2/track08.mp3",
    "soundtrack/hl2/track09.mp3",
    "soundtrack/hl2/track10.mp3",
    "soundtrack/hl2/track11.mp3",
    "soundtrack/hl2/track12.mp3",
    "soundtrack/hl2/track13.mp3",
    "soundtrack/hl2/track14.mp3",
    "soundtrack/hl2/track15.mp3",
    "soundtrack/hl2/track16.mp3",
    "soundtrack/hl2/track17.mp3",
    "soundtrack/hl2/track18.mp3",
    "soundtrack/hl2/track19.mp3",
    "soundtrack/hl2/track20.mp3",
    "soundtrack/hl2/track21.mp3",
    "soundtrack/hl2/track22.mp3",
    "soundtrack/hl2/track23.mp3",
    "soundtrack/hl2/track24.mp3",
    "soundtrack/hl2/track25.mp3",
}

util.AddNetworkString("PlaySoundtrack")

hook.Add("PlayerInitialSpawn", "PlayInitialSoundtrack", function(ply)
    net.Start("PlaySoundtrack")
    net.WriteString(soundtracks[math.random(#soundtracks)])
    net.Send(ply)

    timer.Simple(320, function() -- 320 seconds (Over 5 minutes) -- Was too lazy to put sound durations in
        if IsValid(ply) then
            net.Start("PlaySoundtrack")
            net.WriteString(soundtracks[math.random(#soundtracks)])
            net.Send(ply)
        end
    end)
end)
]]

