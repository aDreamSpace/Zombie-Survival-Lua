--This file contains custom changes to the ZS gamemode by MagicSwap
--All code here is usually for serverside tracking and utility
--Some functions are here to complement other features elsewhere in the gamemode
-- Table to store the node locations

-- Sigil Node system for randomizing spawn locations based on nodes we place on the ground
  -- List of entity names
  if SERVER then
    -- List of entity names
    local entities = {"sigil_barricadetower", "sigil_medicaltower", "sigil_ammotower"}

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

            -- Save the string to a file
            file.Write("nodes.txt", str)
            print("Nodes saved!")
        end
    end)

    -- Spawn the entities and set up the spawn points
    hook.Add("InitPostEntity", "SpawnEntities", function()
        -- Load the nodes from the file
        if file.Exists("nodes.txt", "DATA") then
            local str = file.Read("nodes.txt", "DATA")
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

--credit system
local RewardHKill = 30
local RewardZKill = 1
local HSBonus = 2
local LastBiteBonus = 100

util.AddNetworkString("statUpdate")
util.AddNetworkString("statRefresh")
util.AddNetworkString("statEffect")

--first lets load our data on spawn
hook.Add("PlayerInitialSpawn", "StatDataInit", function(ply)
	local data
	if not ply:IsBot() then
		data = ply:GetZSStats({"zkills", "hkills", "theals"})
	end
	--these values are just for visuals
	ply._ZKills = tonumber(data and data.zkills) or 0
	ply._HKills = tonumber(data and data.hkills) or 0
	ply._THealed = tonumber(data and data.theals) or 0

	--these values are deltas to be saved and added to visuals
	ply.ZKills = 0
	ply.HKills = 0
	ply.THealed = 0
end)

--human kills a zombie, gives them an addition to their stat, and update their stats
hook.Add("HumanKilledZombie", "zkillTracker", function(victim, attacker, inflictor, dmginfo, hs, suicide)
	if victim:IsValid() and victim:IsPlayer() and attacker:IsValid() and attacker:IsPlayer() and !suicide then
		attacker.ZKills = attacker.ZKills + 1
		RefreshStats(attacker)
	end
end)

--zombie kills a human, gives them an addition to their stat, and update their stats
hook.Add("ZombieKilledHuman", "hkillTracker", function(victim, attacker, inflictor, dmginfo, hs, suicide)
	if victim:IsValid() and victim:IsPlayer() and attacker:IsValid() and attacker:IsPlayer() and !suicide then
		attacker.HKills = attacker.HKills + 1
		RefreshStats(attacker)
	end
end)

hook.Add("PlayerHealedTeamMember", "thealTracker", function(ply, healed, amt, inf)
	ply.THealed = math.Round(ply.THealed + amt)
	RefreshStats(ply)
end)

--this gets called every kill, but its not that taxing so it should be fine
function RefreshStats(ply)
	if ply:IsValid() and ply:IsPlayer() then
		net.Start("statUpdate")
			net.WriteUInt(ply._HKills + ply.HKills, 24)
			net.WriteUInt(ply._ZKills + ply.ZKills, 24)
			net.WriteUInt(ply._THealed + ply.THealed, 24)

			--we'll send our current amount of points as well in this
			--net.WriteUInt(ply._ZKills + ply._HKills * 50 + ply._THealed * 0.15, 24)
		net.Send(ply)
	end
end

--we should initialize stuff for clients to
hook.Add("PlayerReady", "statsrefresh", function(ply)
	RefreshStats(ply)
end)

--easy save function
function SaveAllStats()
	local plys = player.GetHumans()
	for i = 1, #plys do
		ply = plys[i]
		ply:AddZSStats({hkills = (ply.HKills or 0), zkills = (ply.ZKills or 0), theals = (ply.THealed or 0)})
		
		--update our visuals with our deltas after we send them to be saved
		ply._HKills = ply._HKills + (ply.HKills or 0)
		ply._ZKills = ply._ZKills + (ply.ZKills or 0)
		ply._THealed = ply._THealed + (ply.THealed or 0)

		--and then reinitialize the deltas
		ply.HKills = 0
		ply.ZKills = 0
		ply.THealed = 0
	end
end

--we need a somewhat reliable way to save all this stuff, so lets just do it every wave
hook.Add("SetWave", "StatSaving", function(iWave)
	SaveAllStats()
end)

--and save it when map changes
hook.Add("ShutDown", "StatSavingEnd", function()
	SaveAllStats()
end)

--]
--database and utility functions
--so it turns out table.FindNext and table.FindPrev are super unreliable and shitty so I rewrote them here!
function table.NextVal(tbl, val)
	if !table.IsSequential(tbl) then
		print("WARNING! Table is NOT sequential. This function will not work correctly!")
	end
	local current = 0
	local nextval = false
	for i, v in ipairs(tbl) do
		if(v == val) then
			current = i
			break
		end
	end
	
	current = current + 1
	nextval = tbl[current]
	if current > #tbl then
		nextval = tbl[1]
	end
	
	return nextval
end

function table.PrevVal(tbl, val)
	if !table.IsSequential(tbl) then
		print("WARNING! Table is NOT sequential. This function will not work correctly!")
	end
	local current = 0
	local prevval = false
	for i, v in ipairs(tbl) do
		if(v == val) then
			current = i
			break
		end
	end
	
	
	prevval = tbl[current - 1]
	if prevval == 0 then
		nextval = tbl[#tbl]
	end
	
	return prevval
end

--uses SQL instead of filesystem files because less lag and more control
if not sql.TableExists("PlayerData") then
	sql.Query("CREATE TABLE IF NOT EXISTS PlayerData (infoid TEXT NOT NULL PRIMARY KEY, value TEXT)")
end

if not sql.TableExists("zsplayerstats") then
	sql.Query("CREATE TABLE IF NOT EXISTS zsplayerstats (playerid INTEGER NOT NULL PRIMARY KEY, hkills INTEGER DEFAULT 0, zkills INTEGER DEFAULT 0, theals INTEGER DEFAULT 0)")
end
local ply = FindMetaTable("Player")
local SQLZSTables = {
	["hkills"] = true,
	["zkills"] = true,
	["theals"] = true,
}

function ply:TestDatabase()
	self:SetZSStats({hkills = 1, zkills = 1, theals = 2, bpit = 0, hban = 1})
	self:AddZSStats({hkills = 1, zkills = 1, theals = 2})
end

function GetZSStats(key, tReq, defaults)
	local strQuery = "SELECT "
	local count = table.Count(tReq)
	for _, req in pairs(tReq) do
		if SQLZSTables[req] then
			local spacer = count > 1 and ", " or " "
			strQuery = strQuery..req..spacer
			count = count - 1
		end
	end

	strQuery = strQuery.."FROM zsplayerstats WHERE playerid = "..SQLStr(key)
	local r = sql.Query(strQuery)
	if r and r[1] then
		return r[1]
	else
		return defaults
	end
end

function ply:GetZSStats(tReq, defaults)
	return GetZSStats(self:SteamID64(), tReq, defaults)
end

function ply:AddZSStats(tAdd)
	local key = self:SteamID64()

	local strInsQuery = "INSERT OR IGNORE INTO zsplayerstats (playerid, "
	local strUpdQuery = "UPDATE OR IGNORE zsplayerstats SET "

	local strValues = "("..SQLStr(key)..", "
	local count = table.Count(tAdd)
	for set, val in pairs(tAdd) do
		if SQLZSTables[set] then
			local spacer = count > 1 and ", " or " "
			strValues = strValues..SQLStr(val)..spacer
			strInsQuery = strInsQuery..set..spacer
			strUpdQuery = strUpdQuery..set.." = "..set.." + "..SQLStr(val)..spacer
			count = count - 1
		end
	end
	strValues = strValues..")"
	strInsQuery = strInsQuery..") VALUES "..strValues
	strUpdQuery = strUpdQuery.."WHERE playerid = "..SQLStr(key)

	local strQuery = strUpdQuery.."; "..strInsQuery
	sql.Query(strQuery)
end

function SetZSStats(key, tSet)
	local strInsQuery = "INSERT OR IGNORE INTO zsplayerstats (playerid, "
	local strUpdQuery = "UPDATE OR IGNORE zsplayerstats SET "

	local strValues = "("..SQLStr(key)..", "
	local count = table.Count(tSet)
	for set, val in pairs(tSet) do
		if SQLZSTables[set] then
			local spacer = count > 1 and ", " or " "
			strValues = strValues..SQLStr(val)..spacer
			strInsQuery = strInsQuery..set..spacer
			strUpdQuery = strUpdQuery..set.." = "..SQLStr(val)..spacer
			count = count - 1
		end
	end
	strValues = strValues..")"
	strInsQuery = strInsQuery..") VALUES "..strValues
	strUpdQuery = strUpdQuery.."WHERE playerid = "..SQLStr(key)

	local strQuery = strUpdQuery.."; "..strInsQuery
	sql.Query(strQuery)
end

function ply:SetZSStats(tSet)
	SetZSStats(self:SteamID64(), tSet)
end

function ply:SetPlayerData(key, value)
	key = Format("%s[%s]", self:SteamID64(), key)
	sql.Query("REPLACE INTO PlayerData (infoid, value) VALUES ("..SQLStr(key)..", "..SQLStr(value)..")")
end

function ply:RemovePlayerData(key)
	key = Format("%s[%s]", self:SteamID64(), key)
	sql.Query("DELETE FROM PlayerData WHERE infoid = "..SQLStr(key))
end

function ply:GetPlayerData(key, default)
	key = Format("%s[%s]", self:SteamID64(), key)
	local value = sql.QueryValue("SELECT value FROM PlayerData WHERE infoid = "..SQLStr(key).." LIMIT 1")
	if value == nil then return default or "0" end
	
	return value
end

function util.GetPlayerData(steamid, key, default, sid)
	if !sid then
		steamid = util.SteamIDTo64(steamid)
	end
	key = Format("%s[%s]", steamid, key)
	local value = sql.QueryValue("SELECT value FROM PlayerData WHERE infoid = "..SQLStr(key).." LIMIT 1")
	if value == nil then return default or "0" end
	
	return value
end

function util.SetPlayerData(steamid, key, value, sid)
	if !sid then
		steamid = util.SteamIDTo64(steamid)
	end
	key = Format("%s[%s]", steamid, key)
	sql.Query("REPLACE INTO PlayerData (infoid, value) VALUES ("..SQLStr(key)..", "..SQLStr(value)..")")

end

function util.RemovePlayerData(steamid, key, sid)
	if !sid then
		steamid = util.SteamIDTo64(steamid)
	end
	key = Format("%s[%s]", steamid, key)
	sql.Query("DELETE FROM PlayerData WHERE infoid = "..SQLStr(key))
end

--remove/set some entities for fps boost

hook.Add("InitPostEntity", "fpsbooster", function()
	local sc = ents.FindByClass("shadow_control") or {}
	if #sc >= 1 then
		for k, v in pairs(sc) do
			v:SetKeyValue("disableallshadows", "1")
			print("modified shadow controller successfully")
		end
	else
		local shadow = ents.Create("shadow_control")
		if shadow:IsValid() then
			shadow:SetKeyValue("disableallshadows", "1")
			print("No shadow controller on map, created default one")
		else
			print("No shadow controller on map, and created one failed")
		end
	end
	
	local precip = ents.FindByClass("func_precipitation") or {}
	if #precip >= 1 then
		for k, v in pairs(precip) do
			local entval = v:GetKeyValues()
			if entval["preciptype"] == 0 then
				v:Remove()
			end
		end
	end
end)

--sprayban ulx insert
function spraylogic(ply)
	if tobool(ply:GetPlayerData("sprayban")) == true then
		ply:ChatPrint("You can't use sprays because you're spray banned!")
		return true
	end

	--local tr = ply:GetEyeTraceNoCursor()
end
hook.Add("PlayerSpray", "playerspraylogic", spraylogic)

--ballpit and radio silence

local ballpitSpeak, ballpitListen
local r = debug.getregistry()
local CIsValid = r.Entity.IsValid
local CTeam = r.Player.Team

hook.Add("PlayerCanHearPlayersVoice", "BallpitAndRadioSilence", function(listener, speaker)
	if CIsValid(speaker) and CIsValid(listener) then
		if CTeam(speaker) == CTeam(listener) then
			ballpitSpeak, ballpitListen = (speaker.Ballpit or false), (listener.Ballpit or false)
			if ballpitSpeak and !ballpitListen then
				return false
			end
		end
		--[[
		if speaker:Team() == TEAM_HUMAN and listener:Team() == TEAM_HUMAN then
			local noradio = listener.m_RadioDebuff or speaker.m_RadioDebuff or false
			if noradio then
				return true, false
			end
		end
		--]]
	end
end)

--broken flashlight
--prevent cheeky people from turning on their flashlight THEN getting the perk
hook.Add("SetWave", "TurnOffFlashlights", function(wave)
	if wave == 1 then
		local plys = team.GetPlayers(TEAM_HUMAN)
		for _, ply in pairs(plys) do
			if ply.m_FlashDebuff and ply:FlashlightIsOn() then
				ply:Flashlight(false)
			end
		end
	end
end)

hook.Add("PlayerSwitchFlashlight", "BrokenFlashlightLogic", function(ply, state)
	if ply.m_FlashDebuff and state == true and ply:Team() == TEAM_HUMAN then
		return false
	end
end)

--hammerban
hook.Add("CanPlaceNail", "HammerbanPlaceNail", function(ply, ent)
	local hb = ply.Hammerban or ply.TempHBanned
	if hb then
		if ply.notifyCooldown == nil then ply.notifyCooldown = 0 end
		if ply.notifyCooldown > CurTime() then return false end

		ply:CenterNotify(COLOR_RED, "You cannot manipulate nails or barricades. You are hammerbanned!")
		ply.notifyCooldown = CurTime() + 0.5
		return false
	end
end)

hook.Add("CanRemoveNail", "HammebanRemoveNail", function(ply, trace)
	local hb = ply.Hammerban or ply.TempHBanned
	if hb then
		if ply.notifyCooldown == nil then ply.notifyCooldown = 0 end
		if ply.notifyCooldown > CurTime() then return false end

		ply:CenterNotify(COLOR_RED, "You cannot manipulate nails or barricades. You are hammerbanned!")
		ply.notifyCooldown = CurTime() + 0.5
		return false
	end
end)

--weapon jamming

hook.Add("EntityFireBullets", "WeaponJamLogic", function(ply, buldata)
	ply.nextJamCalc = ply.nextJamCalc or 0
	if ply:IsValid() and ply:IsPlayer() and ply:Alive() and ply:Team() == TEAM_HUMAN and (ply.nextJamCalc and ply.nextJamCalc <= CurTime()) then
		local wep = ply:GetActiveWeapon()
		if wep.CW20Weapon then
		ply.nextJamCalc = CurTime() + 0.05
		if ply.notifyLimit == nil then ply.notifyLimit = 0 end
		local rng = math.random(1, 100) --probably a dumb way to do this but meh, gets the job done

		if rng <= 4 and ply.m_GunDebuff == true then --number after rng is the chance a bullet will jam the weapon

			local curammo = wep:Clip1()
			local ammoname = game.GetAmmoName(wep:GetPrimaryAmmoType())
			wep:SetClip1(0)
			ply:GiveAmmo(curammo, ammoname, true)
			if ply.notifyLimit < 6 then
				ply:CenterNotify(COLOR_RED, "Your weapon has jammed. You have to reload.")
				ply.notifyLimit = ply.notifyLimit + 1
			end
		end
		end
	end
end)

--[
--special rounds
util.AddNetworkString("SpecialRoundRules")
util.AddNetworkString("SpecialRoundIncoming")


--prelim. setups
--config
GM.SpecialRoundPlayerLimit = true
GM.SpecialRoundReqPlayers = 16 -- if there are more than this many players, special rounds will be enabled
GM.SpecialRoundChance = 0 --	1 = 100%, 0 = 0%


--special round calc
GM.SelectedSpecialRound = math.Rand(0, 1)
print(GM.SelectedSpecialRound)
if GM.SelectedSpecialRound < GM.SpecialRoundChance then
	GM.SpecialRound = true
end

function SpecialRoundSetup()
	if GAMEMODE.SpecialRound == true then
		hook.Add("SetWave", "SpecialRoundRuleDisplay", SpecialRoundRules)
		SpecialRoundIncoming()
	end
end
hook.Add("PostGamemodeLoaded", "SpecialRoundInit", SpecialRoundSetup)

function SpecialRoundIncoming()
	timer.Create("IncomingNotification", GAMEMODE.SpecialRoundIncomingDelay, 10, function()
		net.Start("SpecialRoundIncoming")
		net.Broadcast()
	end)
end

function SpecialRoundRules()
	local iSelected = math.random(#SpecialRounds)
	SpecialRounds[iSelected]() --serverside funcs
	if GAMEMODE:GetWave() == 0 then
		net.Start("SpecialRoundRules")
			net.WriteUInt(iSelected, 8) --i doubt we'll have this many functions but w/e
		net.Broadcast()
	end
end

--antispawnkill
--[
util.AddNetworkString("Skeletor")
util.AddNetworkString("SkeletorEnd")

GM.AntiSpawncampTime = 8
GM.MarkedTime = 8

hook.Add("PlayerSpawn", "antiSpawnKillInfo", function(ply)
	if ply:IsValid() and ply:IsPlayer() and ply:Team() == TEAM_UNDEAD then
		if ply.m_MarkedPlayer ~= false and ply.m_fuck then
			ply.m_fuck = false
			ply.m_MarkedPlayer = false
			ply.m_MarkedPly = false
			net.Start("SkeletorEnd")
				net.WriteBool(true)
			net.Send(ply)
		end
		
		if ply.SpawnedOnSpawnPoint and not ply.DidntSpawnOnSpawnPoint and not ply.Revived and not ply:GetZombieClassTable().NeverAlive then
			if GAMEMODE.ZombieClasses[ply:GetZombieClass()].Name == "Zombie" then
				ply.m_MarkedForSkeletor = CurTime() + GAMEMODE.AntiSpawncampTime
				ply.m_ZombieID = ply:GetZombieClass()
			end
		end
	end
end)

hook.Add("DoPlayerDeath", "antispawnkill", function(ply, attacker, dmginfo)
	if not ply.m_MarkedBySkeletor then ply.m_MarkedBySkeletor = 0 end
	if not ply.m_MarkedForSkeletor then ply.m_MarkedForSkeletor = 0 end
	if ply:IsValid() and attacker:IsValid() and ply:IsPlayer() and attacker:IsPlayer() then
		if ply:Team() == TEAM_UNDEAD and attacker:Team() == TEAM_HUMAN then
			if ply.m_MarkedBySkeletor ~= nil and ply.m_MarkedForSkeletor >= CurTime() and ply:GetZombieClass() == 1 then
				if ply:GetStatus("feigndeath") then return end
				ply.m_MarkedForRespawn = true
				attacker.m_MarkedBySkeletor = ply
				ply.m_MarkedPlayer = attacker
			end
		end
	end
end)

hook.Add("PostPlayerDeath", "SetClassAssister", function(ply)
if ply.m_MarkedForRespawn == true and !game.GetMap():StartWith("zs_obj") then
	timer.Simple(0.3, function() 
	if ply:IsValid() then
	if !ply:IsFrozen() then
	ply:RemoveAllStatus(true, true)

	ply.m_MarkedForRespawn = false
	ply.m_MarkedForSkeletor = CurTime()
	
	ply.m_MarkedPly = true
	--[[
	local pos = ply:GetPos()
	local ang = ply:EyeAngles()
	for i=1, 4 do
		local ent = ents.CreateLimited("prop_playergib")
		if ent:IsValid() then
			ent:SetPos(pos + VectorRand() * 12 + Vector(0, 0, 30))
			ent:SetAngles(VectorRand():Angle())
			ent:SetGibType(math.random(3, #GAMEMODE.HumanGibs))
			ent:Spawn()
		end
	end
	--]]
	local oldclass = ply.m_ZombieID
	ply:SetZombieClassName("Skeleton")
	ply:UnSpectateAndSpawn()
	ply.DeathClass = oldclass
	--ply:SetPos(pos)
	--ply:SetEyeAngles(ang)
	net.Start("Skeletor")
		net.WriteEntity(ply.m_MarkedPlayer)
		ply.m_fuck = true
	net.Send(ply)
	end
	end
	end)
end
end)

hook.Add("EntityTakeDamage", "dmgBuff", function(ply, dmginfo)
	if ply:IsValid() and ply:IsPlayer() and ply:Team() == TEAM_HUMAN then
		local attacker = dmginfo:GetAttacker()
		if attacker:IsValid() and attacker:IsPlayer() and attacker:Team() == TEAM_UNDEAD and attacker.m_MarkedPlayer == ply and ply.m_MarkedBySkeletor == attacker and attacker:GetZombieClassTable().Name == "Skeleton" then
			dmginfo:SetDamage(dmginfo:GetDamage() * 3)
		end
	end
end)

--anti resupply launch and source machine disabler
local bIncludeNailedProps = true
hook.Add("EntityTakeDamage", "NoPropTeamDamage", function(ply, dmginfo)
	if ply:IsValid() and ply:IsPlayer() and ply:Team() == TEAM_HUMAN then
		local prop = dmginfo:GetInflictor()
		local attacker = dmginfo:GetAttacker()
		if IsEntity(prop) and prop:GetMoveType() == MOVETYPE_VPHYSICS and not string.StartWith(prop:GetClass(), "func_") then --Allow func_ entites to deal damage since they are KINO on nysc
			if bIncludeNailedProps or not prop:IsNailed() then --add an optional check for nailed props
				if not (attacker:IsValid() and attacker:IsPlayer() and attacker:Team() == TEAM_UNDEAD) and attacker ~= ply then --prevent expl. barrels from not causing suicide
					local pPhysAttacker = prop:GetPhysicsAttacker()
					if not (pPhysAttacker:IsValid() and pPhysAttacker:IsPlayer() and pPhysAttacker:Team() == TEAM_UNDEAD) then --prevent propkills from doing no damage
						return true
					end
				end
			end
		end
	end
end)

--antiafk glitch
hook.Add("PlayerCanCheckout", "AntiAFKExploit", function(ply)
	ply.LastNotAFK = CurTime() + 30
end)

--better fog
function SetupFog(data)
	local ent = ents.FindByClass("env_fog_controller")
	if #ent == 0 then
		local fog = ents.Create("env_fog_controller")
		if fog:IsValid() then
			for k, v in pairs(data) do
				fog:SetKeyValue(k, v)
			end
			print("No fog controller found, created and set a new fog controller.")
			return
		end
	else
		local fog = ent[1]
		if fog:IsValid() then
			for k, v in pairs(data) do
				fog:SetKeyValue(k, v)
			end
		end
		print("Found and modified fog controller successfully.")
	end
end

function GetFogData()
	local ent = ents.FindByClass("env_fog_controller")
	if #ent == 0 then
		print("No fog controller found.")
		return false
	else
		local fog = ent[1]
		if fog:IsValid() then
			return fog:GetKeyValues()
		end
	end
end

--hints
--now held as clientside info
util.AddNetworkString("gc_hint")

local ply = FindMetaTable("Player")
if not ply then return end

--nailed prop barricade hint
function NailedHintDispatcher(ent, data)
	if !ent:IsNailed() then return end
	local ply = data.HitEntity
	if not (ply:IsValid() and ply:IsPlayer() and not ply:IsBot()) then return end
	local pos = ent:WorldSpaceCenter()
	local id = id or GAMEMODE:GetHintByType("barricadephase")
	ply:DispatchHint(id, pos)
end

hook.Add("InitPostEntity", "collisionNailedData", function()
	local entTbl = ents.FindByClass("prop_phys*")
	for _, v in pairs(entTbl) do
		if v:IsValid() then
			v:AddCallback("PhysicsCollide", NailedHintDispatcher)
		end
	end
end)

local zVec = Vector(0, 0, 0)
hook.Add("SetWaveActive", "AmmoWeaponHint", function(bActive)
	if bActive or GAMEMODE:GetWave() > 2 then return end
	
	local vecArsenalPos = zVec
	local tblPotentialArsenals = ents.FindByClass("prop_arsenalcrate")
	if #tblPotentialArsenals > 0 then
		local entArsenal = table.Random(tblPotentialArsenals)
		vecArsenalPos = entArsenal:WorldSpaceCenter()
	end

	local id = id or GAMEMODE:GetHintByType("wepammo")
	local tPlys = player.GetHumans()
	for i = 1, #tPlys do
		tPlys[i]:DispatchHint(id, vecArsenalPos)
	end
end)

hook.Add("OnNailCreated", "Prop2PropHint", function(ent1, ent2, nail)
	if ent2:IsValid() then
		local owner = nail:GetOwner()
		if owner and owner:IsValid() and owner:IsPlayer() and owner:Team() == TEAM_HUMAN then
			local id = id or GAMEMODE:GetHintByType("prop2prop")
			owner:DispatchHint(id, nail:WorldSpaceCenter())
		end
	end
end)

hook.Add("PlayerDeath", "F3Hint", function(ply, inf, att)
	if ply:Team() == TEAM_UNDEAD and att and att:IsValid() and att:IsPlayer() and att:Team() == TEAM_HUMAN then
		ply.F3HintTimer = (ply.F3HintTimer or 0) + 1
		if ply.F3HintTimer % 3 == 0 then
			local id = id or GAMEMODE:GetHintByType("f3menu")
			ply:DispatchHint(id)
		end
	end
end)

--player destroys ents (nests etc)
hook.Add("NestDestroyed", "NestKillicon", function(ent, attacker)
	net.Start("zs_pl_kill_ent")
		net.WriteEntity(ent)
		net.WriteEntity(attacker)
	net.Broadcast()
end)

--convert prop_physics to prop_physics_multiplayer
--[[
hook.Add("InitPostEntity", "BetterPhysics", function()
	local ST = SysTime()
	local props = ents.FindByClass("prop_physics")
	local converted = 0
	local failed = 0
	if #props > 0 then
		for _, ent in pairs(props) do
			local keyvals = ent:GetKeyValues()
			local prop = ents.Create("prop_physics_multiplayer")
			if !prop:IsValid() then failed = failed + 1 return end
			prop:SetPos(ent:GetPos())
			prop:SetAngles(ent:GetAngles())
			prop:SetModel(ent:GetModel())
			for k, v in pairs(keyvals) do --apply custom key values the old props might've had
				prop:SetKeyValue(k, v)
			end
			SafeRemoveEntity(ent)
			prop:Spawn()
			converted = converted + 1
		end
	else
		print("No prop_physics found to optimize. None converted.\n")
	end
	print("Finished optimizations of prop_physics entities on map\nConverted to prop_physics_multiplayer: "..tostring(converted).." - Failed: "..tostring(failed).."\n")
	local physb = ents.FindByClass("func_physbox")
	local converted = 0
	local failed = 0
	if #physb > 0 then
		for _, phys in pairs(physb) do
			phys:SetKeyValue("classname", "func_physbox_multiplayer")
			if phys:GetClass() == "func_physbox_multiplayer" then
				converted = converted + 1
			else
				failed = failed + 1
			end
		end
	else
		print("No func_physbox entities found to optimize. None converted.")
	end
	print("Finished optimizations of func_physbox entities on map\nConverted to func_physbox_multiplayer: "..tostring(converted).." - Failed: "..tostring(failed).."\n")

	print("This operation took: "..tostring(SysTime() - ST).." seconds to complete.\n")
end)
--]]

--player drop points 
hook.Add("DoPlayerDeath", "DropPoints", function(ply)
	if ply:IsValid() and ply:IsPlayer() then
		if ply:Team() == TEAM_HUMAN and ply:GetPoints() > 0 then
			local point = ents.Create("prop_points")
			if point and point:IsValid() then
				point:SetPos(ply:WorldSpaceCenter())
				point:SetPointValue(ply:GetPoints() or 0)
				point:SetPointOwner(ply)
				point:Spawn()
			end
		end
	end
end)

--zombie points stuff
--Basic premise:
--Zombie players gets points overtime for playing
--Then points are spent on specific zombie classes
--On the player object there is a table containing all the traits they have and stuff for the zombie classes

--So first lets build the table where we'll store our data on the player, doesn't matter what team they're on, it can be persistent
hook.Add("PlayerInitialSpawn", "ZombieDataTable", function(ply)
	--time to setup the player trait tracker!
	if not ply:IsBot() then
		ply.ZDataTable = {}
	end
	--...amazing isn't it?

	--point data stuff
	ply.ZPoints = 0
end)

--z point acquire system
local PointZKilled = 1
local BarricadeDmgPerPoint = 45

util.AddNetworkString("pointBuy")
util.AddNetworkString("pointUpdate")
util.AddNetworkString("pointRefresh")
util.AddNetworkString("pointEffect")

function RefreshPoints(ply)
	if ply:IsValid() and ply:IsPlayer() then
		net.Start("pointUpdate")
			net.WriteUInt(ply.ZPoints, 16)
		net.Send(ply)
	end
end

net.Receive("pointRefresh", function(ln, ply)
	RefreshPoints(ply)
end)

hook.Add("PlayerReady", "pointrefresh", function(ply)
	RefreshPoints(ply)
end)

function PointCalc(ply, reward, pos)
	if ply:IsValid() and ply:IsPlayer() then
		ply.ZPoints = (ply.ZPoints or 0) + reward
		RefreshPoints(ply)
		if reward > 0 then
			net.Start("pointEffect")
				net.WriteUInt(reward, 8)
				if pos then
					net.WriteVector(pos)
				end
			net.Send(ply)
		end
	end
end

--boring z point networking backend
net.Receive("pointBuy", function(ln, ply)
	if ply and ply:IsValid() and ply:IsPlayer() and ply:Team() == TEAM_UNDEAD then
		local bought = false
		local class = net.ReadCString()
		local purchase = net.ReadCString()
		if class and purchase then
			if ply:GetZTrait(class, purchase) then return end --we already got it, dont do anything more
			local cost = GetZTraitInfo(class, purchase).cost
			if cost then
				if cost <= ply.ZPoints then
					PointCalc(ply, cost * -1)
					local t = GetZTraitInfo(class, purchase)
					if t.callback then
						t.callback(ply)
					end
					if not t.temp then -- we unlock it if it isn't temporary
						ply:SetZTrait(class, purchase, true)
					end
					bought = true
				end
			end
		end
		net.Start("pointBuy")
			net.WriteBool(bought)
			if bought then
				net.WriteCString(class)
				net.WriteCString(purchase)
			end
		net.Send(ply)
	end
end)


--teleporter helper stuff
util.AddNetworkString("zs_teleport_init")
util.AddNetworkString("zs_teleport_final")

GM.TeleportingPlayers = {}

hook.Add("Think", "TeleportTracker", function()
	for k, v in pairs(GAMEMODE.TeleportingPlayers) do
		if v[1] <= CurTime() then
			local ply = player.GetBySteamID64(k)
			if ply and ply:IsValid() then
				GAMEMODE.TeleportingPlayers[ply:SteamID64()] = nil
				ply:SetPos(v[2])
				ply:Kill()
			else
				GAMEMODE.TeleportingPlayers[k] = nil
			end
		end
	end
end)

--sometimes people attempt to join when a password is set, i wanna know who they are tho
hook.Add("CheckPassword", "CheckPasswordID", function(sid64, ip, password, clpassword, name)
	if not password or password == "" then return end
	if password == clpassword then return end
	print("[PASSWORD FAILURE]")
	print("User with name: "..name.." and ip: "..ip.." tried connecting with password: "..clpassword)
	print("Their 64-Bit SteamID is "..sid64)
end)

--lua knockback fix, doesnt work the entire time, zombies still somehow get frozen in some cases

hook.Add("ScalePlayerDamage", "AntiKnockbackPre", function(ply, hitgroup, dmginfo)
	if ply:IsValid() and ply:IsPlayer() and ply:Team() == TEAM_UNDEAD then
		if GAMEMODE.ZombieClasses[ply:GetZombieClass()].Name == "Shade" then return end
		if dmginfo:GetDamage() <= 0 then return end
		local att = dmginfo:GetAttacker()
		local wep = att:GetActiveWeapon()
		if wep and wep:IsValid() and wep.CW20Weapon then
			ply.PrevVel = ply:GetVelocity()
			ply:SetMoveType(MOVETYPE_NONE) --HACK HACK, I really dont want to do this but there is no other way to reliably get rid of knockback
		end
	end
end)

hook.Add("PlayerHurt", "AntiKnockbackPost", function(ply, attacker, remainingHealth, takenHealth)
	if ply:IsValid() and ply:IsPlayer() and ply:Team() == TEAM_UNDEAD and ply.PrevVel then
		ply:SetMoveType(MOVETYPE_WALK)
		ply:SetLocalVelocity(ply.PrevVel)
		ply.PrevVel = nil
	end
end)


--afk library
--------------------------------------------------
local AFK_TIME = 120
--local AFK_WARN_TIME = 600 not used
--------------------------------------------------

hook.Add("PlayerInitialSpawn", "MakeAFKVar", function(ply)
	ply.NextAFK = CurTime() + AFK_TIME
end)

local nextThink = 0
hook.Add("Think", "HandleAFKPlayers", function()
	if nextThink > CurTime() then return end
	nextThink = CurTime() + 1

	for _, ply in pairs (player.GetAll()) do
		if ( ply:IsConnected() and ply:IsFullyAuthenticated() ) then
			if (!ply.NextAFK) then
				ply.NextAFK = CurTime() + AFK_TIME
			end
			
			if not ply.MarkedAsAFK then
				ply.MarkedAsAFK = false
			end
		
			local afktime = ply.NextAFK
			if (CurTime() >= afktime) then
				ply.MarkedAsAFK = true
			end
		end
	end
end)

hook.Add("KeyPress", "PlayerMoved", function(ply, key)
	ply.NextAFK = CurTime() + AFK_TIME
	ply.MarkedAsAFK = false
end)

--Experimental bot names tbl
--[[
GM.BotNames = {
	"Test",
	"TestName",
	"TestName2",
	"Experiment",
	"Testing",
	"Does this work?",
	"Experimenting"
}
--]]

--map specific winrate statistics
hook.Add("EndRound", "WinrateCalc", function(team)
	local mapname = game.GetMap()
	local mapnameCookie = mapname.."Winrate"
	local plys = player.GetHumans()
	local record = #plys >= 12
	if not GAMEMODE.RoundEnded then
		if record then
			local mapdata = util.JSONToTable(cookie.GetString(mapnameCookie) or "")

			if not mapdata then
				mapdata = {}
				mapdata.Wins = 0
				mapdata.Total = 0
				cookie.Set(mapnameCookie, util.TableToJSON(mapdata))
			else
				if team == TEAM_HUMAN then
					mapdata.Wins = mapdata.Wins + 1
				end
				mapdata.Total = mapdata.Total + 1
				cookie.Set(mapnameCookie, util.TableToJSON(mapdata))
			end

			for _, ply in pairs(plys) do
				ply:ChatPrint("This map has been played "..mapdata.Total.." times and has been won "..math.Round((mapdata.Wins / mapdata.Total) * 100).."% of the time!")
			end
		else
			for _, ply in pairs(plys) do
				ply:ChatPrint("Not enough players for winrate statistics to be saved. Skipping calculations...")
			end
		end
	end
end)

--remove func_physbox on ze maps to fix some of them
hook.Add("InitPostEntity", "FixZEMaps", function()
	if game.GetMap():StartWith("ze_") then
		util.RemoveAll("func_physbox*")
	end
end)

--bot shittalking
hook.Add("ZombieKilledHuman", "botshittalk", function(victim, attacker, inflictor, dmginfo, hs, suicide)
	if attacker:IsBot() and AzBot and AzBot.BotInsults then
		attacker:Say(AzBot.BotInsults[math.random(#AzBot.BotInsults)])
	end
end)

--debug stuff, to find out what is causing io hangs
local debugmode = false

if debugmode then
	GM.HangTimes = {}
	local sqlcalls = 0
	local writecalls = 0
	local readcalls = 0


	function PrintIOCalls()
		print("SQL calls:", sqlcalls)
		print("Write calls:", writecalls)
		print("Read calls:", readcalls)
	end

	local margin = 0.005
	--detour sql query
	local oldSqlQ = sql.Query
	function sql.Query(...)
		local t = SysTime()
		print("SqlQuery called!")
		debug.Trace()

		local r = oldSqlQ(...)
		local time = SysTime() - t
		print("SQL Query Time: ", time)

		sqlcalls = sqlcalls + 1

		if time > margin then
			print("Abnormally long fetch time for sql.Query!")
			table.insert(GAMEMODE.HangTimes, {"SqlQuery", debug.traceback(), time})
		end

		return r
	end

	local oldFWrite = file.Write
	local oldFRead = file.Read
	function file.Write(...)
		local t = SysTime()
		print("FileWrite called!")
		debug.Trace()

		local r = oldFWrite(...)
		local time = SysTime() - t
		print("File Write Time: ", time)

		writecalls = writecalls + 1

		if time > margin then
			print("Abnormally long fetch time for file.Write!")
			table.insert(GAMEMODE.HangTimes, {"FileWrite", debug.traceback(), time})
		end

		return r
	end

	function file.Read(...)
		local t = SysTime()
		print("FileRead called!")
		debug.Trace()

		local r = oldFRead(...)
		local time = SysTime() - t
		print("File Read Time: ", time)

		readcalls = readcalls + 1

		if time > margin then
			print("Abnormally long fetch time for file.Read!")
			table.insert(GAMEMODE.HangTimes, {"FileRead", debug.traceback(), time})
		end

		return r
	end
end


--antispawncamp with turrets
--turrets do 0 damage to zombies 12 seconds after they spawn from a real spawnpoint
GM.NoTurretDmgTime = 6

hook.Add("PlayerSpawn", "AntiTurretHelper", function(ply)
	if ply and ply:IsValid() and ply:Team() == TEAM_UNDEAD then
		if ply.SpawnedOnSpawnPoint and not ply.DidntSpawnOnSpawnPoint and not ply.Revived and not ply:GetZombieClassTable().NeverAlive then
			ply.NoTurretDmgTime = CurTime() + GAMEMODE.NoTurretDmgTime or 12
		end
	end
end)


--make tab mute serversided
util.AddNetworkString("zs_servertabmute")
net.Receive("zs_servertabmute", function(ln, ply)
	if ply and ply:IsValid() then
		local sid = net.ReadString()
		local mute = net.ReadBool()
		if sid then
			ply.tblMutedPlayers = ply.tblMutedPlayers or {}
			ply.tblMutedPlayers[sid] = mute
		end
	end
end)

local CSteamID = r.Player.SteamID
hook.Add("PlayerCanHearPlayersVoice", "FixTabMute", function(listener, talker)
	if CIsValid(listener) and CIsValid(talker) then
		if CTeam(listener) == CTeam(talker) then
			local tsid = CSteamID(talker)
			if tsid and listener.tblMutedPlayers then
				if listener.tblMutedPlayers[tsid] then
					return false
				end
			end
		end
	end
end)

--custom ammo hook so that we can hook into this easily
hook.Add("PlayerGetAmmo", "HandleAmmoMsg", function(pPly, iAmt, strType, pFrom)
	local strEnd = " ammo!"
	if pFrom and pFrom:IsValid() and pFrom:IsPlayer() then
		strEnd = " ammo from "..pFrom:Nick().."!"
	end
	pPly:CenterNotify(COLOR_GREEN, "You've acquired "..iAmt.." "..strType..strEnd)
end)

--delete useless entities we dont need
hook.Add("InitPostEntity", "Cleanup", function()
	local strClass
	local iToDelete = 0
	for _, v in pairs(ents.GetAll()) do
		strClass = v:GetClass()
		if strClass == "info_node" or string.StartWith(strClass, "aiscripted_")
		or string.StartWith(strClass, "npc_") or string.StartWith(strClass, "point_sigil") then
			iToDelete = iToDelete + 1
			v:Remove()
		end
	end

	print("Number of entities nominated for deletion: ", iToDelete)
end)

--purpose: hook to cause zombies to drop items occasionally
--this function was rewritten to allow different types of drops with difference chances of dropping
--items are lumped


local ITEMCHANCE_AMMO = 0.04
local ITEMCHANCE_WORTHGUN = 0.01
local ITEMCHANCE_WORTHMELEE = 0.018
local ITEMCHANCE_GUN = 0.005
local ITEMCHANCE_TOOL = 0.02

local tDrops = {
	[ITEMCHANCE_AMMO] = {"ar2", "pistol", "smg1", "357", "alyxgun", "gravity", "buckshot", "battery"},
	[ITEMCHANCE_WORTHGUN] = {},
	[ITEMCHANCE_WORTHMELEE] = {},
	[ITEMCHANCE_GUN] = {},
	[ITEMCHANCE_TOOL] = {"weapon_zs_arsenalcrate", "weapon_zs_resupplybox", "weapon_zs_medicalkit"},
}
local function DropItem(zombie,human,dmginfo,hs,sui) --This is for random ammo drops, possibly more in the future
	local checkLuck = math.Rand(0, 1)
	local tPotential = nil
	local bAmmo = false

	if GAMEMODE:GetWave() >= 3 then
		checkLuck = checkLuck * 2
	end

	for chance, drops in pairs(tDrops) do
		if checkLuck <= chance then
			tPotential = drops
			if chance == ITEMCHANCE_AMMO then
				bAmmo = true
			else
				bAmmo = false
			end
		end
	end

	if tPotential then
		local zombieVector = zombie:WorldSpaceCenter()
		local item = tPotential[math.random(#tPotential)]
		local bSuccess = false
		local ent = NULL
		

		if bAmmo then
			local iAmmoAmt = math.ceil((GAMEMODE.AmmoCache[item] or 12) * 2)

			ent = ents.Create("prop_ammo")
			if ent and ent:IsValid() then --sometimes the entity doesn't actually get created...
				ent:SetAmmoType(item)
				ent:SetAmmo(iAmmoAmt)
				ent:SetPos(zombieVector)
				ent:Spawn()
				bSuccess = true
			end
		else
			ent = ents.Create("prop_weapon")
			if ent and ent:IsValid() then
				ent:SetWeaponType(item)
				ent:SetPos(zombieVector)
				ent:Spawn()
				bSuccess = true
			end
		end
	
		if bSuccess then
			local effectdata = EffectData()
			effectdata:SetOrigin(zombieVector)
			effectdata:SetMagnitude(5)
			effectdata:SetScale(5)
			effectdata:SetRadius(768)
			effectdata:SetEntity(ent)
			for i = 1, 12 do
				util.Effect("TeslaHitboxes", effectdata)
			end

			ent:EmitSound("beams/beamstart5.wav")
		end
	end
end

hook.Add("HumanKilledZombie", "dropTest", DropItem) --called on event HumanKilledZombie, facilitates dropItem function
--]]

--purpose: keep track of all players and team counts, a potentially cheaper way of doing player.GetAll()
--[[
GLOBAL_ALL_PLAYERS = {}
GLOBAL_ALL_ZOMBIES = {}
GLOBAL_ALL_HUMANS = {}

GLOBAL_ALL_PLAYERCOUNT = 0
GLOBAL_ALL_ZOMBIECOUNT = 0
GLOBAL_ALL_HUMANCOUNT = 0


hook.Add("PlayerInitialSpawn", "PlayerTracker", function(ply)
	table.insert(GLOBAL_ALL_PLAYERS, ply)
	GLOBAL_ALL_PLAYERCOUNT = GLOBAL_ALL_PLAYERCOUNT + 1
	if ply:Team() == TEAM_HUMAN then
		table.insert(GLOBAL_ALL_HUMANS, ply)
		GLOBAL_ALL_HUMANCOUNT = GLOBAL_ALL_HUMANCOUNT + 1
	else
		table.insert(GLOBAL_ALL_ZOMBIES, ply)
		GLOBAL_ALL_ZOMBIECOUNT = GLOBAL_ALL_ZOMBIECOUNT + 1
	end
end)

local pPly
hook.Add("OnPlayerChangedTeam", "TeamTracker", function(ply, prevTeam, newTeam)
	--print("called", team.GetName(prevTeam), team.GetName(newTeam)) --testing to see if this is called during initial spawn
	if newTeam == TEAM_UNDEAD then
		if prevTeam == TEAM_HUMAN then
			for i = 1, GLOBAL_ALL_HUMANCOUNT do
				pPly = GLOBAL_ALL_HUMANS[i]
				if pPly == ply then
					table.remove(GLOBAL_ALL_HUMANS, i)
					GLOBAL_ALL_HUMANCOUNT = GLOBAL_ALL_HUMANCOUNT - 1

					table.insert(GLOBAL_ALL_ZOMBIES, ply)
					GLOBAL_ALL_ZOMBIECOUNT = GLOBAL_ALL_ZOMBIECOUNT + 1
					break
				end
			end
		end
	else
		if prevTeam == TEAM_UNDEAD then
			for i = 1, GLOBAL_ALL_ZOMBIECOUNT do
				pPly = GLOBAL_ALL_ZOMBIES[i]
				if pPly == ply then
					table.remove(GLOBAL_ALL_ZOMBIES, i)
					GLOBAL_ALL_ZOMBIECOUNT = GLOBAL_ALL_ZOMBIECOUNT - 1

					table.insert(GLOBAL_ALL_HUMANS, ply)
					GLOBAL_ALL_HUMANCOUNT = GLOBAL_ALL_HUMANCOUNT + 1
					break
				end
			end
		end
	end
end)

local pPly2
gameevent.Listen("player_disconnect")
hook.Add("player_disconnect", "PlayerDisconnectTracker", function(data)
	pPly = Player(data.userid or 0)
	if pPly and pPly:IsValid() then
		if pPly:Team() == TEAM_HUMAN then
			for i = 1, GLOBAL_ALL_HUMANCOUNT do
				pPly2 = GLOBAL_ALL_HUMANS[i]
				if pPly == pPly2 then
					table.remove(GLOBAL_ALL_HUMANS, i)
					GLOBAL_ALL_HUMANCOUNT = GLOBAL_ALL_HUMANCOUNT - 1
					break
				end
			end
		else
			for i = 1, GLOBAL_ALL_ZOMBIECOUNT do
				pPly2 = GLOBAL_ALL_ZOMBIES[i]
				if pPly == pPly2 then
					table.remove(GLOBAL_ALL_ZOMBIES, i)
					GLOBAL_ALL_ZOMBIECOUNT = GLOBAL_ALL_ZOMBIECOUNT - 1
					break
				end
			end
		end

		for i = 1, GLOBAL_ALL_PLAYERCOUNT do
			pPly2 = GLOBAL_ALL_PLAYERS[i]
			if pPly == pPly2 then
				table.remove(GLOBAL_ALL_PLAYERS, i)
				GLOBAL_ALL_PLAYERCOUNT = GLOBAL_ALL_PLAYERCOUNT - 1
				break
			end
		end
	end
end)

function CheckPlayerSync()
	print("STARTING SYNC CHECK: ")

	print("Printing lua managed players...\n")
	print("Lua tracked players: ", GLOBAL_ALL_PLAYERCOUNT)
	print("Lua tracked players length: ", #GLOBAL_ALL_PLAYERS)
	local valid = true
	for _, v in pairs(GLOBAL_ALL_PLAYERS) do
		if not v or not v:IsValid() then
			print("Invalid player entry found!")
			valid = false
		end
	end
	if valid then
		print("Lua players passed validity check")
	end

	print("Lua tracked zombies: ", GLOBAL_ALL_ZOMBIECOUNT)
	print("Lua tracked zombies length: ", #GLOBAL_ALL_ZOMBIES)
	local valid = true
	for _, v in pairs(GLOBAL_ALL_ZOMBIES) do
		if not v or not v:IsValid() then
			print("Invalid zombie entry found!")
			valid = false
		end
	end
	if valid then
		print("Lua zombies passed validity check")
	end

	print("Lua tracked humans: ", GLOBAL_ALL_HUMANCOUNT)
	print("Lua tracked humans length: ", #GLOBAL_ALL_HUMANS)

	local valid = true
	for _, v in pairs(GLOBAL_ALL_PLAYERS) do
		if not v or not v:IsValid() then
			print("Invalid human entry found!")
			valid = false
		end
	end
	if valid then
		print("Lua humans passed validity check")
	end

	print("Printing C++ player values...")

	print("PlayerGetCount", player.GetCount())
	print("PlayerGetAllLength", #player.GetAll())

	print("TEAMNUMZOMBIE", team.NumPlayers(TEAM_UNDEAD))
	print("TEAMNUMHUMAN", team.NumPlayers(TEAM_HUMAN))

	print("END SYNC CHECK")
end

function BenchmarkLuaPlayers()
	print("Storing player.GetAll() in a variable 100 times...")
	local t = SysTime()
	for i = 1, 100 do
		local v = player.GetAll()
	end
	print("Time taken: ", SysTime() - t)

	
	print("Storing GlobalLuaTable in a variable 100 times...")
	local t = SysTime()
	for i = 1, 100 do
		local g = GLOBAL_ALL_PLAYERS
	end
	print("Time taken: ", SysTime() - t)
end
--]]
--achievement system
--purpose: system that rewards players for doing certain tasks, should be easy to add new achievements
util.AddNetworkString("zs_achievements") --to be continued in cl_custom


--achievement hooks that can be done here
hook.Add("HumanKilledZombie", "ahtrack", function(victim, attacker, inflictor, dmginfo, hs, suicide)
	if victim:IsValid() and victim:IsPlayer() and attacker:IsValid() and attacker:IsPlayer() and !suicide then
		PushAchievementProgress(attacker, "Zombie Slayer")
		if victim:GetZombieClassTable().Boss then
			PushAchievementProgress(attacker, "The bigger they are...")
			PushAchievementProgress(attacker, "...The harder they fall")
		end

		if hs then
			PushAchievementProgress(attacker, "Headhunter")
		end

		if inflictor and inflictor:IsValid() then
			if inflictor.CW20Melee then
				PushAchievementProgress(attacker, "Melee Mayhem")
			end
			
			if string.sub(inflictor:GetClass(), -1, -5) == "stone" then
				PushAchievementProgress(attacker, "Stoner")
			elseif string.sub(inflictor:GetClass(), -1, -5) == "fists" then
				PushAchievementProgress(attacker, "Fister")
			elseif string.find(inflictor:GetClass(), "manhack") then
				PushAchievementProgress(attacker, "Pilot")
			end

		end
	end
end)

hook.Add("EndRound", "aroundtrack", function(winner)
	if winner == TEAM_HUMAN then
		local tPlys = player.GetHumans()
		for i = 1, #tPlys do
			local ply = tPlys[i]
			if ply:Team() == TEAM_HUMAN then
				PushAchievementProgress(ply, "Survivalist")
			end
		end
	end
end)

--zombie kills a human, gives them an addition to their stat, and update their stats
hook.Add("ZombieKilledHuman", "aztrack", function(victim, attacker, inflictor, dmginfo, hs, suicide)
	if victim:IsValid() and victim:IsPlayer() and attacker:IsValid() and attacker:IsPlayer() and !suicide then
		PushAchievementProgress(attacker, "Zombie Master")
	end
end)

hook.Add("PlayerSay", "AchievementTest", function(ply, text, team)
	if ply and ply:IsValid() then
		PushAchievementProgress(ply, "First words...")
		PushAchievementProgress(ply, "Chat Master", 1)
	end
end)

hook.Add("PlayerHealedTeamMember", "ahtrack", function(ply, healed, amt, inf)
	PushAchievementProgress(ply, "Medical Training", math.Round(amt or 0))
end)


--below is achievement saving logic
hook.Add("PlayerInitialSpawn", "AchievementInit", function(ply)
	if not ply:IsBot() then
		ply.Achievements = LoadAchievementData(ply) or {}
	end
end)

gameevent.Listen("player_disconnect")
hook.Add("player_disconnect", "SaveAchievements", function(data)
	local id = data.userid
	local ply = Player(id or 0)

	if ply and ply:IsValid() and not ply:IsBot() then
		SaveAchievementData(ply)
	end
end)

hook.Add("ShutDown", "SaveAchievements", function()
	local tPlys = player.GetHumans()
	for i = 1, #tPlys do
		local ply = tPlys[i]
		if ply and ply:IsValid() then
			SaveAchievementData(ply)
		end
	end
end)

function LoadAchievementData(ply)
	local sid = ply:SteamID64()
	local data = sqlite.GetData(sid, {"achievements"})
	if data then
		return util.JSONToTable(data.achievements)
	else
		return {}
	end
end

function SaveAchievementData(ply)
	local sid = ply:SteamID64()
	local data = util.TableToJSON(ply.Achievements)
	sqlite.SetData(sid, {achievements = data})
end

function PushAchievementProgress(ply, name, amt)
	if ply and ply:IsValid() then
		if ply:IsBot() then return end
		local db = GAMEMODE.Achievements[name]
		if not db then
			print("Achievement "..name.." is not initalized. Skipping all calculations!")
			return
		end
		local itype = db.type
		if not amt then amt = 1 end


		if not ply.Achievements[name] then
			if itype then
				ply.Achievements[name] = {type = itype, unlocked = false}
				ProgressAchievement(ply, name, amt)
				return
			end
		end

		if ply.Achievements[name].unlocked then return end --if we already got it, dont do anything

		ProgressAchievement(ply, name, amt)
	end
end

function ProgressAchievement(ply, name, amt)
	local a = ply.Achievements[name]

	if a then
		if a.type == ACHIEVEMENT_ACTION then --actions are typically one time things that are completed, so just push the award now
			AwardAchievement(ply, name)
		elseif a.type == ACHIEVEMENT_PROGRESS then --this is usually things that are linear, so lets add more info
			a.progress = (a.progress or 0) + amt
			local limit = GAMEMODE.Achievements[name].limit
			if a.progress >= limit then
				AwardAchievement(ply, name)
			end
		elseif a.type == ACHIEVEMENT_TIERED_PROGRESS then
			local db = GAMEMODE.Achievements[name] --load the info for this achievement
			--lets go through our data to see if we can add anything to this achievement
			if not a.tiers then a.tiers = {} end
			a.tiers.progress = (a.tiers.progress or 0) + amt
			for i = 1, #db.tiers do --we use the serverside copy since it is the best source of info
				if not a.tiers[i] then
					a.tiers[i] = {}
				end

				if a.tiers[i].unlocked == nil then
					a.tiers[i].unlocked = false
				end

				if not a.tiers[i].unlocked then
					local l = db.tiers[i].limit
					if a.tiers.progress >= l then
						AwardTieredAchievement(ply, name, db.tiers[i].name, i)
					end
				end
			end
		end
	end
end

function AwardAchievement(ply, name)
	ply.Achievements[name].unlocked = true

	ply:EmitSound(Sound("garrysmod/save_load"..math.random(4)..".wav"), 50, 100, 0.8)
	net.Start("zs_achievements")
		net.WriteUInt(ply.Achievements[name].type, 2)
		net.WriteEntity(ply)
		net.WriteCString(name)
	net.Broadcast()
end

function AwardTieredAchievement(ply, name, tname, tier)
	local at = ply.Achievements[name]
	local db = GAMEMODE.Achievements[name]
	at.tiers[tier].unlocked = true
	--check if all of our tiers are unlocked, then unlock the main achievement
	local bAllUnlocked = true
	for i = 1, #db.tiers do
		if at.tiers[i] and not at.tiers[i].unlocked then
			bAllUnlocked = false
		end
	end
	if bAllUnlocked then
		at.unlocked = true
	end
	ply:EmitSound(Sound("garrysmod/save_load"..math.random(4)), 50, 100, 0.8)
	net.Start("zs_achievements")
		net.WriteUInt(ply.Achievements[name].type, 2)
		net.WriteEntity(ply)
		net.WriteCString(name)
		net.WriteCString(tname)
		net.WriteBool(bAllUnlocked)
	net.Broadcast()
end

util.AddNetworkString("zs_achievements_menu")

function OpenAchievementMenu(ply)
	--first lets decide what data we're going to send the client
	--we're just going to network the entire thing
	ply.ADATANextRequest = ply.ADATANextRequest or 0
	if ply.ADATANextRequest > CurTime() then return end --prevent flooding
	net.Start("zs_achievements_menu")
		net.WriteDataTable(ply.Achievements, true)
	net.Send(ply)

	ply.ADATANextRequest = CurTime() + 1
end


--converts items from PlayerData table to the new zsplayerstats table, only needs to be run once
function ConvertSQLData()
	local t = {}
	local r = sql.Query("SELECT * FROM PlayerData")

	for i, tbl in pairs(r) do
		local sid64 = tbl.infoid:sub(1, 17)
		local keyname = (string.gfind(tbl.infoid, '%[(.+)%]')())
		print(sid64, keyname, tbl.value)
		if not t[sid64] then
			t[sid64] = {}
		end
		t[sid64][keyname] = tonumber(tbl.value)
	end

	PrintTable(t)

	for sid64, info in pairs(t) do
		local tSend = {}
		for key, val in pairs(info) do
			if SQLZSTables[key] then
				tSend[key] = math.Round(val)
			else
				print("Invalid key: ", key)
			end
		end
		SetZSStats(sid64, tSend)
	end
end

--better hammerban/ballpit system
ZSINFO_DELETE = 0
ZSINFO_MODIFY = 1
ZSINFO_ADD = 2
ZSINFO_COMMENT = 3
ZSINFO_COMMENT_VIEW = 4

ZSINFO_HAMMERBAN = 0
ZSINFO_BALLPIT = 1
ZSINFO_NOODLE = 2
ZSINFO_1HKO = 3

if file.Exists("zs/punishments.txt", "DATA") then
	GM.Punishments = util.JSONToTable(file.Read("zs/punishments.txt"))
else
	GM.Punishments = {}
end

hook.Add("ShutDown", "SaveZSPunishments", function()
	file.Write("zs/punishments.txt", util.TableToJSON(GAMEMODE.Punishments))
end)

hook.Add("SetWave", "SaveZSPunishments", function()
	file.Write("zs/punishments.txt", util.TableToJSON(GAMEMODE.Punishments))
end)

local tZSINFOTypes = {
	"Hammerban",
	"Ballpit",
	"NoObjectPickup",
	"1HKO",
}

--we should scan all the bans just once to see if we need to delete any
for sid, tData in pairs(GM.Punishments) do
	for _, strBan in pairs(tZSINFOTypes) do
		if tData[strBan] then
			local time = tData[strBan][1]
			if time and time ~= true and time < os.time() then
				tData[strBan] = nil
				if table.Count(tData) == 0 then GM.Punishments[sid] = nil end
			end
		end
	end
end

--check players who join against the table
--[ --this is better since it uses a table and a loop to easily add ban types
hook.Add("PlayerInitialSpawn", "ApplyZSPunishment", function(ply)
	if not ply:IsBot() then
		if GAMEMODE.Punishments[ply:SteamID()] then
			local b = GAMEMODE.Punishments[ply:SteamID()]
			if b then
				for _, strBan in ipairs(tZSINFOTypes) do
					if b[strBan] then
						local tBan = b[strBan]
						if tBan[1] and (tBan[1] == true or tBan[1] > os.time()) then
							ply[strBan] = true
						end
					end
				end
			end
		end
	end
end)

--first we only loop through bans for online players only
timer.Create("PunishmentChecker", 120, 0, function()
	local tPlys = player.GetHumans()
	for i = 1, #tPlys do
		local ply = tPlys[i]
		if ply and ply:IsValid() then
			local tBan = GAMEMODE.Punishments[ply:SteamID()]
			if tBan then
				for ban, data in pairs(tBan) do
					--we need to update the player's name
					--TODO: store this in the main table or somewhere so we don't need to make so many copies per type

					data[3] = ply:Nick()

					local time = data[1]
					if time ~= true and time < os.time() then
						tBan[ban] = nil
						ply[ban] = nil
					end
				end
				if table.Count(tBan) == 0 then GAMEMODE.Punishments[ply:SteamID()] = nil end --clear some memory if we're out of punishments to track
			end
		end
	end
end)
--[
function ChangePunishment(sid, time, ban, asid, type, initcomment)
	if not sid or not type then return end

	local ply = player.GetBySteamID(sid)
	local admin = player.GetBySteamID(asid or "")
	local strPlyNameCache

	if ply then
		ply[type] = ban and true or false
		strPlyNameCache = ply:Nick()
	end

	if ban then
		if not GAMEMODE.Punishments[sid] then GAMEMODE.Punishments[sid] = {} end

		local strAdminInfo = "CONSOLE"

		if admin and admin:IsValid() and admin:IsPlayer() then
			strAdminInfo = admin:Nick().." ("..admin:SteamID()..")"
		end

		if time then
			local sec = math.Round(time * 60)
			local ctime = os.time()
			local bantime = ctime + sec
			GAMEMODE.Punishments[sid][type] = {bantime, strAdminInfo, strPlyNameCache}
		else
			GAMEMODE.Punishments[sid][type] = {true, strAdminInfo, strPlyNameCache}
		end
		
		if initcomment then
			AddComment(sid, asid, type, initcomment)
		end
	else
		GAMEMODE.Punishments[sid][type] = nil
	end
end

function AddComment(sid, asid, type, comment)
	if not sid or not type or not asid or not comment then return end
	local tBan = GAMEMODE.Punishments[sid][type]
	local admin = player.GetBySteamID(asid)
	local strAdminInfo = "CONSOLE"
	if admin and admin:IsValid() and admin:IsPlayer() then
		strAdminInfo = admin:Nick().." ("..admin:SteamID()..")"
	end

	if tBan then
		if not tBan.comments then tBan.comments = {} end
		table.insert(tBan.comments, {strAdminInfo, comment})
	end
end

function Hammerban(ply, time, ban, aply)
	ChangePunishment(ply, time, ban, aply, "Hammerban")
end

function Ballpit(ply, time, ban, aply)
	ChangePunishment(ply, time, ban, aply, "Ballpit")
end

function Noodle(ply, time, ban, aply)
	ChangePunishment(ply, time, ban, aply, "NoObjectPickup")
end

function OneHit(ply, time, ban, aply)
	ChangePunishment(ply, time, ban, aply, "1HKO")
end

hook.Add("EntityTakeDamage", "OneHitDamageHandler", function(ply, dmginfo)
	local attacker = dmginfo:GetAttacker()
	if ply["1HKO"] and attacker and attacker:IsValid() and attacker:IsPlayer() and attacker ~= ply then
		print(ply, "one hit by", attacker)
		dmginfo:SetDamage(4000)
	end
end)


util.AddNetworkString("zs_playerinfo")
util.AddNetworkString("zs_playerinfo_comments")

function OpenZSMenu(ply)
	if ply and ply:IsValid() then
		net.Start("zs_playerinfo")
			net.WriteDataTable(GAMEMODE.Punishments, true)
		net.Send(ply)
	end
end

net.Receive("zs_playerinfo_comments", function(ln, ply)
	if ply and ply:IsValid() then
		if ply:query("ulx zsmenu") then
			local reqPly = net.ReadCString()
			local reqBan = net.ReadCString()
			if reqPly and reqBan then
				local tBan = GAMEMODE.Punishments[reqPly][reqBan]
				if tBan then
					net.Start("zs_playerinfo_comments")
						net.WriteDataTable(tBan.comments, true)
					net.Send(ply)
				end
			end
		end
	end

end)


net.Receive("zs_playerinfo", function(ln, ply)
	if ply and ply:IsValid() then
		if ply:query("ulx zsmenu") then --do they have access?
			--if so, start doing logic
			local type = net.ReadUInt(4)
			local sid = net.ReadCString()
			if type == ZSINFO_MODIFY then
				local ntype = net.ReadUInt(4)
				local num = net.ReadCString()
				if sid and num and type then
					local newmins = tonumber(num)
					if newmins then
						ChangePunishment(sid, newmins, true, ply, tZSINFOTypes[ntype])
					end
				end
			elseif type == ZSINFO_DELETE then
				local strBan = net.ReadCString()
				ChangePunishment(sid, 0, false, ply:SteamID(), strBan)
			end
		end
	end
end)

--purpose: create a better SQL library to make managing SQL databases painless
--written by MagicSwap
--to be used serverside only
--TODO: Redo for MySqloo
--some options
sqlite = {}
sqlite.DBName = "zsdb" --name of database in sv.db
sqlite.DefaultColumns = {
	["hintdata"] = "TEXT",
	["achievements"] = "TEXT"
}
sqlite.CachedColumns = table.Copy(sqlite.DefaultColumns)

function sqlite.PrecacheColumn(name, type)
	if not (type and name) then return end
	sqlite.CachedColumns[name] = type
end

--precache columns we're going to use
--for reference on data types use: https://www.sqlite.org/datatypes.html
--NOTE: you MUST convert your data when it is returned manually, e.g. use tonumber() on expected INT results since SQL only returns strings
sqlite.PrecacheColumn("hintdata", "TEXT")
sqlite.PrecacheColumn("achievements", "TEXT")
sqlite.PrecacheColumn("lhmusic", "INT")

--create our table
if not sql.TableExists(sqlite.DBName) then
	local strQuery = "CREATE TABLE IF NOT EXISTS "..sqlite.DBName.." (playerid INTEGER NOT NULL PRIMARY KEY, "
	local len = table.Count(sqlite.CachedColumns)
	for col, info in pairs(sqlite.CachedColumns) do
		local spacer = len > 1 and ", " or " "
		strQuery = strQuery..col.." "..info..spacer
		len = len - 1
	end
	strQuery = strQuery..")"
	sql.Query(strQuery)
end

--verify that our database has all the columns that are cached
--no type checking implemented
sqlite.CurrentColumns = sql.Query("PRAGMA table_info ("..sqlite.DBName..")")
function sqlite.ColumnExists(column)
	for _, info in pairs(sqlite.CurrentColumns) do
		if info.name == column then
			return true
		end
	end
	return false
end

for col, info in pairs(sqlite.CachedColumns) do
	local found = sqlite.ColumnExists(col)
	if not found then
		sql.Query("ALTER TABLE "..sqlite.DBName.." ADD COLUMN "..col.." "..info)
		print("Added orphaned column:", col, info)
	end
end

--set function, with update support
--use: key = steamid64, tSet = {["dataname"] = data}
function sqlite.SetData(key, tSet)
	local strInsQuery = "INSERT OR IGNORE INTO "..sqlite.DBName.." (playerid, "
	local strUpdQuery = "UPDATE OR IGNORE "..sqlite.DBName.." SET "

	local strValues = "("..SQLStr(key)..", "
	local count = table.Count(tSet)
	for set, val in pairs(tSet) do
		if sqlite.CachedColumns[set] then
			local spacer = count > 1 and ", " or " "
			strValues = strValues..SQLStr(val)..spacer
			strInsQuery = strInsQuery..set..spacer
			strUpdQuery = strUpdQuery..set.." = "..SQLStr(val)..spacer
			count = count - 1
		else
			print("No cached column, precache columns using sqlite.PrecacheColumn(name, type)")
		end
	end
	strValues = strValues..")"
	strInsQuery = strInsQuery..") VALUES "..strValues
	strUpdQuery = strUpdQuery.."WHERE playerid = "..SQLStr(key)

	local strQuery = strUpdQuery.."; "..strInsQuery
	sql.Query(strQuery)
end

--playermetatable utility
function ply:SQLiteSetData(tSet)
	sqlite.SetData(self:SteamID64(), tSet)
end

--get function
--use: key = steamid64, tReq = {"dataname"}, defaults = {defaultvalues}
function sqlite.GetData(key, tReq, defaults)
	local strQuery = "SELECT "
	local count = table.Count(tReq)
	for _, req in pairs(tReq) do
		if sqlite.CachedColumns[req] then
			local spacer = count > 1 and ", " or " "
			strQuery = strQuery..req..spacer
			count = count - 1
		else
			print("No cached column, precache columns using sqlite.PrecacheColumn(name, type)")
		end
	end

	strQuery = strQuery.."FROM "..sqlite.DBName.." WHERE playerid = "..SQLStr(key)
	local r = sql.Query(strQuery)
	if r and r[1] then
		return r[1]
	else
		return defaults
	end
end

--playermetatable utility
function ply:SQLiteGetData(tReq, defaults)
	return sqlite.GetData(self:SteamID64(), tReq, defaults)
end

--purpose: add functionality to custom nails
local bleed
hook.Add("CanDamageNail", "CustomNailHandler", function(ent, attacker, inflictor, dmg, dmginfo)
	if attacker and attacker:IsValid() and attacker:IsPlayer() and attacker:Team() == TEAM_UNDEAD then
		if ent.NailType == NAILTYPE_BARBED then
			bleed = attacker:GiveStatus("zbleed")
			if bleed and bleed:IsValid() then
				bleed:AddDamage(math.Round(dmg))
				bleed.Damager = ent:GetNails()[1]:GetDeployer()
			end
		end
	end
end)

--purpose: emote backend, moved from sh_custom to here
hook.Add("PlayerSay", "EmoteBackend", function(ply, text, tc)
	if ply and ply:IsValid() then
		if not ply.NextEmoteDelay then ply.NextEmoteDelay = 0 end
		local emotes = GAMEMODE.TextEmotes
		local ltext = text:lower()

		if emotes[ltext] then
			local sound = emotes[ltext][1]
			local cooldown = emotes[ltext][2] or 0
			local hideFromChat = emotes[ltext][3]

			if ply.NextEmoteDelay <= CurTime() then
				ply.NextEmoteDelay = CurTime() + cooldown
				if ply:Team() == TEAM_HUMAN then
					ply:EmitSound(sound, 75, 100, 1)
				else
					local pitchMult = ply:GetZombieClassTable().VoicePitch or 0.75
					local pitch = 100 * pitchMult
					ply:EmitSound(sound, 75, pitch, 1)
				end

				if hideFromChat then return "" end
			else
				ply:ChatPrint("Quit spamming the emotes.")
				return ""
			end
		end
	end
end)

--purpose: handle last human music backend
util.AddNetworkString("zs_lhmusic")
util.AddNetworkString("zs_lhmusic_menu")

function OpenLHMenu(ply)
	if ply and ply:IsValid() then
		net.Start("zs_lhmusic_menu")
		net.Send(ply)
	end
end

net.Receive("zs_lhmusic", function(ln, ply)
	if ply:query("ulx lhmusic") then
		local track = net.ReadUInt(8)
		if track then
			--save it immediately
			sqlite.SetData(ply:SteamID64(), {lhmusic = track})
			--save it in lua state
			ply.LastHumanTrack = track
		end
	end
end)

hook.Add("PlayerInitialSpawn", "LoadLHTrack", function(ply)
	ply.LastHumanTrack = 0
	if not ply:IsBot() and ply:query("ulx lhmusic") then
		local data = sqlite.GetData(ply:SteamID64(), {"lhmusic"})
		if data then
			data = tonumber(data["lhmusic"])
			ply.LastHumanTrack = data
		end
	end
end)

--since i want to know who has what track
function PrintLHTracks()
	for _, v in pairs(player.GetHumans()) do
		if GAMEMODE.LHMusic[v.LastHumanTrack] then
			print(v:Nick(), v.LastHumanTrack)
			print(GAMEMODE.LHMusic[v.LastHumanTrack][1])
			print("")
		end
	end
end

--testing experimental ZS points system, this will print their calculated value

function PrintZSPoints()
	for _, v in pairs(player.GetHumans()) do
		local points = (v._THealed * 0.15) + (v._ZKills) + (v._HKills * 50)
		print(v:Nick(), print(points))
		print("Estimated Playtime (hours): ", math.Round(points / 60))
		print("")
	end
end

--and something for large scale viewing of our internal database

function GetAverageZSPlaytime(cutoff)
	local t = SysTime()
	local data = sql.Query("SELECT * FROM zsplayerstats")
	local amt = 0
	local playtime = 0
	local total = 0
	if data then
		for id, info in pairs(data) do
			local points = (tonumber(info.zkills) or 0) + (tonumber(info.hkills) or 0) * 50 + (tonumber(info.theals) or 0) * 0.15
			if cutoff and points > cutoff then
				playtime = playtime + (points / 60) --hours
				total = total + points
				amt = amt + 1
				
			end
		end

		print("Average amount of ZS points of all players in database:", total / amt)
		print("Estimated average playtime of all players in database (hours): ", playtime / amt)
		print("Indexed players: ", amt)
		print("Time taken to run: ", SysTime() - t)
	else
		print(sql.LastError())
	end
end

function GetMedianZSPlaytime(cutoff)
	local t = SysTime()
	local data = sql.Query("SELECT * FROM zsplayerstats")
	local temptbl = {}
	if data then
		for id, info in pairs(data) do
			local points = (tonumber(info.zkills) or 0) + (tonumber(info.hkills) or 0) * 50 + (tonumber(info.theals) or 0) * 0.15
			if cutoff and points > cutoff then
				table.insert(temptbl, points)
			end
		end
		table.sort(temptbl, function(a, b) return a < b end)

		local median = temptbl[math.floor(#temptbl / 2)]
		print("Median total points: ", median)
		print("Estimated median hours of playtime: ", median / 60)
		print("Indexed players: ", #temptbl)
		print("Time taken to run: ", SysTime() - t)
	else
		print(sql.LastError())
	end
end

--[ --might be causing crashes
--purpose: serverside portion of trail hiding
util.AddNetworkString("zs_entnotifyclient")
net.Receive("zs_entnotifyclient", function(length, ply)
	local ent = net.ReadEntity()
	local transmit = net.ReadBool()
	if ent and ent:IsValid() and ent:GetClass() == "env_spritetrail" then
		ent:SetPreventTransmit(ply, transmit)
	end
end)
--]]

--purpose: serverside portion of not allowing others to place nails in your props.

hook.Add("CanPlaceNail", "NoNailPlaceNail", function(ply, ent)
	local pFirstNailOwner = NULL

	if ent.Nails then
		local nail = ent.Nails[1] --we need the absolute first nail, GetFirstNail prioritizes world nails
		if nail and nail:IsValid() then
			local owner = nail:GetDeployer()
			if owner and owner:IsValid() and owner:IsPlayer() and owner:Alive() and owner:Team() == TEAM_HUMAN then
				pFirstNailOwner = owner
			end
		end
	end

	if pFirstNailOwner:IsValid() and pFirstNailOwner ~= ply and pFirstNailOwner:GetInfoNum("zs_nonail", 0) ~= 0 then
		if ply.notifyCooldown == nil then ply.notifyCooldown = 0 end
		if ply.notifyCooldown > CurTime() then return false end

		ply:CenterNotify(COLOR_RED, "You cannot place nails in this person's props at this time!")
		ply.notifyCooldown = CurTime() + 0.5
		return false
	end
end)

--purpose: serverside protection against prop snakes
hook.Add("OnNailCreated", "AntiPropSnake", function(newprop, target, newnail)
	if target and target:IsValid() then
		local tAllNails = ents.FindByClass("prop_nail")
		local iProps = 0
		local tQueue = {newprop}
		local tProcessed = {newprop = true}
		
		while #tQueue > 0 do
			local ent = table.remove(tQueue)
			iProps = iProps + 1
			if iProps > 8 then
				--we hit our limit, break and undo the nail
				newnail:GetParent():RemoveNail(newnail, nil, newnail:GetDeployer())
				break
			end
			
			--loop through all existing nails
			--if the base entity or attached entity matches us, and we havent evaluated it yet, then add it to the queue
			for i = 1, #tAllNails do
				local nail = tAllNails[i]
				local base = nail:GetBaseEntity()
				local attach = nail:GetAttachEntity()
				
				--if we need to add more to the queue, continue to track them to prevent redoing any props
				if base == ent and attach:IsValid() and not tProcessed[attach] then
					tQueue[#tQueue+1] = attach
					tProcessed[attach] = true
				elseif attach == ent and base:IsValid() and not tProcessed[base] then
					tQueue[#tQueue+1] = base
					tProcessed[base] = true
				end
			end
		end
	end
end)

--purpose: give extra buffs to the last human
--[
hook.Add("LastHuman", "BuffLH", function(pLH)
	if pLH and pLH:IsValid() and #player.GetHumans() > 16 and not pLH.m_Buffed then
		pLH:Give("cw_misc_rpg7")
		pLH:GiveAmmo(1, "rpg_round", true)
		pLH:SetHealth(200)
		pLH:SetMaxHealth(200)
		pLH:SetModel("models/giant/giant.mdl")
		pLH.m_Buffed = true
	end
end)
--]]

--purpose: add additional logging to nails, printing to ULX
hook.Add("OnNailRemoved", "LogUnnails", function(nail, ent, ent2, remover)
	if remover and remover:IsValid() and remover:IsPlayer() then
		local owner = nail:GetDeployer()
		if owner and owner:IsValid() and owner ~= remover and owner:Team() == TEAM_HUMAN then
			ulx.logString("[UNNAIL] "..remover:Nick().." removed a nail belonging to "..owner:Nick(), true)
			local id = id or GAMEMODE:GetHintByType("unnail")
			local pos = nail:GetPos()

			remover:DispatchHint(id, pos)
		end
	end
end)

--purpose: reward humans with additional points at the end of waves
hook.Add("SetWaveActive", "EndWavePointReward", function(bActive)
	if not bActive then
		local iWave = GAMEMODE:GetWave()
		local iHumans = 0
		local iZombies = 0
		local iTotalPts = 0
		--we award points based on a simple formula
		--later wave + more humans on zombie team = more points

		--we also do not give as many points to top players on the team, using Z Scores as our reference

		--enumerate the humans/zombies, the team functions call player.GetAll() multiple times
		local tPlys = player.GetHumans() --we don't want to include bots
		local iPlys = #tPlys

		for i = 1, iPlys do
			local ply = tPlys[i]
			if ply and ply:IsValid() then
				if ply:Team() == TEAM_HUMAN then
					iHumans = iHumans + 1

					--we'll need to calculate z scores to limit points given to high-ranking players
					iTotalPts = iTotalPts + ply:GetPoints()
				else
					iZombies = iZombies + 1
				end
			end
		end

		local iPoints = math.ceil((5 * iWave) * math.Clamp(iZombies / iHumans, 0.25, 4))
		--formula is: Flat Point Amount * CurrentWave * Ratio of Zombies to Humans
		--examples:
		--max = 5 * 6 * 4 = 120 points
		--min = 5 * 1 * 0.25 = 1 rounded to 2 points
		--real-world amount = 5 * wave 4 * ratio 1.8 = 36 points

		local flPointAvg = iTotalPts / iHumans
		flPointAvg = flPointAvg * 1.2 --increase the average by a small amount as a fudge factor
		--we will diminish the amount of points that someone gets based on their current points
		--if they have a lot more than the average then we start reducing points awarded
		--TODO: Find a better way to do this		

		for i = 1, iPlys do
			local ply = tPlys[i]
			if ply and ply:IsValid() and ply:Team() == TEAM_HUMAN then
				local iReward = iPoints
				local iCurPoints = ply:GetPoints()
				if iCurPoints > flPointAvg then
					iReward = math.ceil(iPoints / math.min(iCurPoints / flPointAvg, 3))
				end

				ply:AddPoints(iReward)
				ply:CenterNotify(COLOR_GREEN, "You have been awarded "..iReward.." points for surviving the wave!")
			end
		end
	end
end)


--[[
--purpose: prevent lag from net message spamming, overrides net.Receive
local tNetPlys = {}
timer.Create("NetLogCleaner", 1, 0, function()
	table.Empty(tNetPlys)
end)

local fIncoming = fIncoming or net.Incoming
--using net.ReadHeader may mess up the read order for further net structures, so lets just log the amount of times called
function net.Incoming(ln, ply)
	if ply and ply:IsValid() then
		if not tNetPlys[ply] then tNetPlys[ply] = 0 end

		tNetPlys[ply] = tNetPlys[ply] + 1

		if tNetPlys[ply] >= 100 and not ply.m_bNetMarked then
			ply.m_bNetMarked = true
			ulx.logString("[NET] "..ply:Nick().." has sent more than 100 net messages in a second!", true)
			ULib.ban(ply, 10080, "Exploitative Net Flooding, please contact MagicSwap if you believe this is a mistake.")
		end
	end

	return fIncoming(ln, ply)
end
]] 