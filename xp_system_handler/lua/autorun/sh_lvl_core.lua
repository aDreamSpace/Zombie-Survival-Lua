
local DEBUGMODE = false

local ModPower = 2
local ModMult = 30 * math.Clamp(SimpleXPConfig.LevelScale,0.01,100)

function SimpleXPCalculateXPToLevel(CurrentXP)
	return math.floor((CurrentXP^(1/ModPower))/ModMult)
end

function SimpleXPCalculateLevelToXP(CurrentLevel)
	if DEBUGMODE and SERVER then print("Calculating XP...") end
	return math.ceil(((CurrentLevel)*ModMult)^ModPower)
end

function SimpleXPGetXP(ply)
	if DEBUGMODE and SERVER then print("Getting XP...") end
	return ply:GetNWFloat("BurgerLevel",-1)
end

function SimpleXPGetLevel(ply)
	if DEBUGMODE and SERVER then print("Getting Level...") end
	return SimpleXPCalculateXPToLevel(SimpleXPGetXP(ply))
end


function SimpleXPCheckRank(level)
	if SimpleXPConfig.EnableCustomRanks then
	
		if SimpleXPConfig.LevelCap < level then
			level = SimpleXPConfig.LevelCap
		end
		
		if level > #SimpleXPConfig.CustomRanks then
			local LoopTimes = math.floor(level / #SimpleXPConfig.CustomRanks)
			local Mod = level % #SimpleXPConfig.CustomRanks		
			return SimpleXPConfig.CustomRanks[Mod] .. " Prestige " .. LoopTimes
		else
			return SimpleXPConfig.CustomRanks[level]
		end
		
	else
		return "Rank " .. level
	end
end

function SimpleXPGetKills()

	for i=1, 100 do
		local KillReward = 200
		local Kills = math.floor( SimpleXPCalculateLevelToXP(i) / KillReward )
		print("Rank: " .. i,Kills)
	end

end

--SimpleXPGetKills()




