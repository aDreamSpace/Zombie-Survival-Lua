local pairs = pairs
local CurTime = CurTime
local player_GetAll = player.GetAll
local hook_Add = hook.Add
local math_Clamp = math.Clamp

D3bot.NodeMetadata = D3bot.NodeMetadata or {}
D3bot.LinkMetadata = D3bot.LinkMetadata or {}

local nodeMetadata = D3bot.NodeMetadata
local linkMetadata = D3bot.LinkMetadata

hook_Add("PreRestartRound", D3bot.BotHooksId.."MetadataReset", function()
    D3bot.NodeMetadata = {}
    D3bot.LinkMetadata = {}
    nodeMetadata = D3bot.NodeMetadata
    linkMetadata = D3bot.LinkMetadata
end)

local nextNodeMetadataReduce = CurTime()
local nextNodeMetadataIncrease = CurTime()
hook_Add("Think", D3bot.BotHooksId.."NodeMetadataThink", function()
    -- If survivor bots are disabled, ignore capturing team metadata
    if not D3bot.SurvivorsEnabled then return end

    local curTime = CurTime()

    -- Reduce values over time
    if nextNodeMetadataReduce < curTime then
        nextNodeMetadataReduce = curTime + 5
        
        for k, v in pairs(nodeMetadata) do
            if v.ZombieDeathFactor then
                v.ZombieDeathFactor = v.ZombieDeathFactor * 0.85
                if v.ZombieDeathFactor <= 0.1 then v.ZombieDeathFactor = nil end
            end
            if v.PlayerFactorByTeam then
                for team, _ in pairs(v.PlayerFactorByTeam) do
                    v.PlayerFactorByTeam[team] = v.PlayerFactorByTeam[team] * 0.85
                    if v.PlayerFactorByTeam[team] <= 0.1 then v.PlayerFactorByTeam[team] = nil end
                end
                if #v.PlayerFactorByTeam == 0 then v.PlayerFactorByTeam = nil end
            end
        end
    end
    
    -- Increase counts over time -- TODO: Check if that is a resource hog
    local mapNavMesh = D3bot.MapNavMesh
    if nextNodeMetadataIncrease < curTime then
        nextNodeMetadataIncrease = curTime + 1
        local players = D3bot.RemoveObsDeadTgts(player_GetAll())
        for _, player in pairs(players) do
            if IsValid(player) then
                local team = player:Team()
                local node = mapNavMesh:GetNearestNodeOrNil(player:GetPos())
                if node then
                    if not nodeMetadata[node] then nodeMetadata[node] = {} end
                    local metadata = nodeMetadata[node]
                    if not metadata.PlayerFactorByTeam then metadata.PlayerFactorByTeam = {} end
                    metadata.PlayerFactorByTeam[team] = math_Clamp((metadata.PlayerFactorByTeam[team] or 0) + 1/15 * (player.D3bot_Mem and 0.25 or 1), 0, 1)
                end
            end
        end
    end
end)

function D3bot.LinkMetadata_ZombieDeath(link, raiseCost)
    if not linkMetadata[link] then linkMetadata[link] = {} end
    local metadata = linkMetadata[link]
    metadata.ZombieDeathCost = (metadata.ZombieDeathCost or 0) + raiseCost
end

function D3bot.NodeMetadata_ZombieDeath(node)
    if not nodeMetadata[node] then nodeMetadata[node] = {} end
    local metadata = nodeMetadata[node]
    metadata.ZombieDeathFactor = math_Clamp((metadata.ZombieDeathFactor or 0) + 0.1, 0, 1)
end

if not D3bot.UsingSourceNav then return end

function D3bot.LinkMetadata_ZombieDeath(link, raiseCost)
    local metadata = link:GetMetaData()
    metadata.ZombieDeathCost = (metadata.ZombieDeathCost or 0) + raiseCost
end

function D3bot.NodeMetadata_ZombieDeath(node)
    local metadata = node:GetMetaData()
    metadata.ZombieDeathFactor = math_Clamp((metadata.ZombieDeathFactor or 0) + 0.1, 0, 1)
end