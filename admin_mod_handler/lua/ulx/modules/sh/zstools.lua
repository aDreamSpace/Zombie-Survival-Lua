local CATEGORY_NAME = "ZS Tools"


function ulx.freezebots(calling_ply)
    for _, bot in pairs(player.GetBots()) do
        bot:Lock()
    end

    ulx.fancyLogAdmin(calling_ply, "#A froze all bots")
end
local freezebots = ulx.command(CATEGORY_NAME, "ulx freezebots", ulx.freezebots, "!freezebots")
freezebots:defaultAccess(ULib.ACCESS_ADMIN)
freezebots:help("Freeze all bots.")

function ulx.unfreezebots(calling_ply)
    for _, bot in pairs(player.GetBots()) do
        bot:UnLock()
    end

    ulx.fancyLogAdmin(calling_ply, "#A unfroze all bots")
end
local unfreezebots = ulx.command(CATEGORY_NAME, "ulx unfreezebots", ulx.unfreezebots, "!unfreezebots")
unfreezebots:defaultAccess(ULib.ACCESS_ADMIN)
unfreezebots:help("Unfreeze all bots.")


function ulx.toggleBossClassAssignment(calling_ply)
    local enableBossClassAssignment = GetConVar("toggleBossClassAssignment")

    -- Check if the ConVar exists
    if enableBossClassAssignment then
        -- Toggle the state of boss class assignment
        enableBossClassAssignment:SetBool(not enableBossClassAssignment:GetBool())

        -- Inform players about the state change
        if enableBossClassAssignment:GetBool() then
            ulx.fancyLogAdmin(calling_ply, "#A enabled boss class assignment.")
        else
            ulx.fancyLogAdmin(calling_ply, "#A disabled boss class assignment.")
        end
    else
        calling_ply:PrintMessage(HUD_PRINTCONSOLE, "ConVar 'enableBossClassAssignment' does not exist.")
    end
end

local toggleBossClassAssignment = ulx.command(CATEGORY_NAME, "ulx toggledemibosses", ulx.toggleBossClassAssignment, "!toggledemibosses")
toggleBossClassAssignment:defaultAccess(ULib.ACCESS_ADMIN)
toggleBossClassAssignment:help("Turns demi bosses on or off.")


-- Function to redeem all human players
local function redeemHumans(callingPlayer)
    -- Get all players
    local players = player.GetAll()

    -- Redeem each human player
    for _, player in ipairs(players) do
        if player:IsPlayer() and not player:IsBot() and player:Team() == TEAM_UNDEAD then
            player:Redeem()
        end
    end

    -- Send a message to the calling player
    ulx.fancyLogAdmin(callingPlayer, "#A redeemed all human players")
end

-- ULX command to redeem all human players
local cmd = ulx.command(CATEGORY_NAME, "ulx redeemhumans", redeemHumans, "!redeemhumans")
cmd:defaultAccess(ULib.ACCESS_ADMIN)
cmd:help("Redeem all human players.")


-- Function to teleport a team to the calling player
local function teleportTeamToMe(callingPlayer, targetTeam)
    -- Get the players in the target team
    local players = team.GetPlayers(targetTeam)

    -- Get the position of the calling player
    local destination = callingPlayer:GetPos()

    -- Teleport each player to the destination
    for _, player in ipairs(players) do
        player:SetPos(destination)
    end

    -- Send a message to the calling player
    ulx.fancyLogAdmin(callingPlayer, "#A teleported team #s to their location", team.GetName(targetTeam))
end

-- ULX command to teleport the undead team to the calling player
local cmd = ulx.command(CATEGORY_NAME, "ulx tpzombies", function(callingPlayer) teleportTeamToMe(callingPlayer, TEAM_UNDEAD) end, "!tpzombies")
cmd:addParam{type = ULib.cmds.PlayerArg} -- The player calling the command
cmd:defaultAccess(ULib.ACCESS_ADMIN)
cmd:help("Teleport the undead team to the calling player's location.")

-- ULX command to teleport the human team to the calling player
local cmd2 = ulx.command(CATEGORY_NAME, "ulx tphumans", function(callingPlayer) teleportTeamToMe(callingPlayer, TEAM_HUMAN) end, "!tphumans")
cmd2:addParam{type = ULib.cmds.PlayerArg} -- The player calling the command
cmd2:defaultAccess(ULib.ACCESS_ADMIN)
cmd2:help("Teleport the human team to the calling player's location.")


--forceclass
function ulx.forceclass(calling_ply, target_plys, class)
	local affected = {}
	local fclass = GAMEMODE.ZombieClasses[tostring(class)]
	for i=1, #target_plys do
		local ply = target_plys[i]
		local oclass = ply.DeathClass or ply:GetZombieClass()
		local fclass = GAMEMODE.ZombieClasses[tostring(class)]
		if ply:IsFrozen() then
			ULib.tsayError(calling_ply, ply:Nick() .. " is frozen!", true)
		elseif ply:Team() == TEAM_HUMAN then
			ULib.tsayError(calling_ply, ply:Nick() .. " is a human!", true)
		else
			local oldclass = ply.DeathClass or ply:GetZombieClass()
			ply:KillSilent()
			ply:SetZombieClassName(class)
			ply.DeathClass = nil
			ply:DoHulls(fclass.Index, TEAM_UNDEAD)
			ply:UnSpectateAndSpawn()
			ply.DeathClass = oclass
			table.insert(affected, ply)
		end
	end
	ulx.fancyLogAdmin(calling_ply, "#A forced #T to class #s", affected, class)
end

local forceclass = ulx.command( CATEGORY_NAME, "ulx forceclass", ulx.forceclass, "!forceclass")
forceclass:addParam{ type=ULib.cmds.PlayersArg }
forceclass:addParam{ type=ULib.cmds.StringArg, hint="Classname", ULib.cmds.takeRestOfLine}
forceclass:defaultAccess(ULib.ACCESS_SUPERADMIN)
forceclass:help( "Sets the selected players to a zombie class! This function is case sensitive." )


-- Set Wave --

if SERVER then 
    function ulx.setwave(calling_ply, wave)
        if wave then
            GAMEMODE:SetWave(wave)
            ulx.fancyLogAdmin(calling_ply, "#A set the wave to #s", wave)
        end
    end
    local setwave = ulx.command(CATEGORY_NAME, "ulx setwave", ulx.setwave, "!setwave")
    setwave:addParam{type=ULib.cmds.NumArg, min=0, default=0, hint="wave", ULib.cmds.round}
    setwave:defaultAccess(ULib.ACCESS_ADMIN)
    setwave:help("Set the wave in Zombie Survival.")



    function ulx.addwavetime(calling_ply, additional_time)
        if GAMEMODE:GetWave() == 0 then
            GAMEMODE:SetWaveStart(CurTime() + additional_time)
        else
            GAMEMODE:SetWaveEnd(GAMEMODE:GetWaveEnd() + additional_time)
        end
        ulx.fancyLogAdmin(calling_ply, "#A added #s seconds to the current wave", additional_time)
    end
    local addwavetime = ulx.command(CATEGORY_NAME, "ulx addwavetime", ulx.addwavetime, "!addwavetime")
    addwavetime:addParam{type=ULib.cmds.NumArg, min=0, default=0, hint="additional_time", ULib.cmds.round}
    addwavetime:defaultAccess(ULib.ACCESS_ADMIN)
    addwavetime:help("Add more time to the current wave or the start time of wave 0.")
end  


--Restart Map--

function ulx.restartmap(calling_ply)
	ulx.fancyLogAdmin( calling_ply, "#A restarted the map.")
	game.ConsoleCommand("changelevel "..string.format(game.GetMap(),".bsp").."\n")
end
local restartmap = ulx.command(CATEGORY_NAME, "ulx restartmap", ulx.restartmap, "!restartmap")
restartmap:defaultAccess( ULib.ACCESS_SUPERADMIN )
restartmap:help( "Reloads the level." )

--Give Ammo--

function ulx.giveammo(calling_ply, amount, ammotype, target_plys)
	local affected_plys = {}
	for i=1, #target_plys do
		local v = target_plys[ i ]
		if v:IsValid() and v:Team() == TEAM_HUMAN and v:Alive() then
			v:GiveAmmo(amount, ammotype)
		end
	end
end

local giveammo = ulx.command( CATEGORY_NAME, "ulx giveammo", ulx.giveammo, "!giveammo" )
giveammo:addParam{ type=ULib.cmds.NumArg, hint="Ammo Amount"}
giveammo:addParam{ type=ULib.cmds.StringArg, hint="Ammo Type"}
giveammo:addParam{ type=ULib.cmds.PlayersArg }
giveammo:defaultAccess(ULib.ACCESS_ADMIN)
giveammo:help( "Gives the specified ammo to the target player(s)." )

--Give Points--

function ulx.givepoints( calling_ply, target_plys, amount )
	for i=1, #target_plys do
		target_plys[ i ]:AddPoints( amount )
	end
	ulx.fancyLogAdmin( calling_ply, "#A gave #i points to #T", amount, target_plys )
end
local takepoints = ulx.command( CATEGORY_NAME, "ulx givepoints", ulx.givepoints, "!givepoints" )
takepoints:addParam{ type=ULib.cmds.PlayersArg }
takepoints:addParam{ type=ULib.cmds.NumArg, hint="points", ULib.cmds.round }
takepoints:defaultAccess( ULib.ACCESS_ADMIN )
takepoints:help( "Gives points to target(s)." )

--Give Weapon--

function ulx.giveweapon( calling_ply, target_plys, weapon )
	
	
	local affected_plys = {}
	for i=1, #target_plys do
		local v = target_plys[ i ]
		
		if not v:Alive() then
		ULib.tsayError( calling_ply, v:Nick() .. " is dead", true )
		
		else
		v:Give(weapon)
		table.insert( affected_plys, v )
		end
	end
	ulx.fancyLogAdmin( calling_ply, "#A gave #T weapon #s", affected_plys, weapon )
end
	
	
local giveweapon = ulx.command( CATEGORY_NAME, "ulx giveweapon", ulx.giveweapon, "!giveweapon" )
giveweapon:addParam{ type=ULib.cmds.PlayersArg }
giveweapon:addParam{ type=ULib.cmds.StringArg, hint="weapon_zs_swingflip" }
giveweapon:defaultAccess( ULib.ACCESS_ADMIN )
giveweapon:help( "Give a player a weapon - !giveweapon" )

--Redeem Player--

function ulx.redeem( calling_ply, target_plys )
	local affected_plys = {}

	for i=1, #target_plys do
		local v = target_plys[ i ]

		if ulx.getExclusive( v, calling_ply ) then
			ULib.tsayError( calling_ply, ulx.getExclusive( v, calling_ply ), true )
		elseif v:Team() != TEAM_UNDEAD then
			ULib.tsayError( calling_ply, v:Nick() .. " is human!", true )
		else
			v:Redeem()
			table.insert( affected_plys, v )
		end
	end

	ulx.fancyLogAdmin( calling_ply, "#A redeemed #T", affected_plys )
end
local redeem = ulx.command( CATEGORY_NAME, "ulx redeem", ulx.redeem, "!redeem" )
redeem:addParam{ type=ULib.cmds.PlayersArg }
redeem:defaultAccess( ULib.ACCESS_ADMIN )
redeem:help( "Redeems target(s)." )

--Fill Turrets--

function ulx.turretammo(calling_ply, amount)
	for _, ent in pairs(ents.FindByClass("prop_gunturret")) do
		ent:SetAmmo(ent:GetAmmo() + amount)
	end
end

local turretammo = ulx.command( CATEGORY_NAME, "ulx turretammo", ulx.turretammo, "!turretammo" )
turretammo:addParam{ type=ULib.cmds.NumArg, hint="Ammo Amount"}
turretammo:defaultAccess(ULib.ACCESS_ADMIN)
turretammo:help( "Gives the specified amount of ammo to all turrets in the game" )

--Wave Active--

function ulx.roundactive(calling_ply, state)
	GAMEMODE:SetWaveActive(state)
end

local roundactive = ulx.command( CATEGORY_NAME, "ulx roundactive", ulx.roundactive, "!roundactive" )
roundactive:addParam{ type=ULib.cmds.BoolArg, hint="Round State"}
roundactive:defaultAccess(ULib.ACCESS_ADMIN)
roundactive:help( "Sets the current wave to active or inactive" )


if SERVER then
    function ulx.setwave(calling_ply, wave)
        if wave then
            GAMEMODE:SetWave(wave)
            ulx.fancyLogAdmin(calling_ply, "#A set the wave to #s", wave)
        end
    end
    local setwave = ulx.command("Zombie Survival", "ulx setwave", ulx.setwave, "!setwave")
    setwave:addParam{type=ULib.cmds.NumArg, min=0, default=0, hint="wave", ULib.cmds.round}
    setwave:defaultAccess(ULib.ACCESS_ADMIN)
    setwave:help("Set the wave in Zombie Survival.")
end

if SERVER then
    function ulx.addwavetime(calling_ply, additional_time)
        if GAMEMODE:GetWave() == 0 then
            GAMEMODE:SetWaveStart(CurTime() + additional_time)
        else
            GAMEMODE:SetWaveEnd(GAMEMODE:GetWaveEnd() + additional_time)
        end
        ulx.fancyLogAdmin(calling_ply, "#A added #s seconds to the current wave", additional_time)
    end
    local addwavetime = ulx.command("Zombie Survival", "ulx addwavetime", ulx.addwavetime, "!addwavetime")
    addwavetime:addParam{type=ULib.cmds.NumArg, min=0, default=0, hint="additional_time", ULib.cmds.round}
    addwavetime:defaultAccess(ULib.ACCESS_ADMIN)
    addwavetime:help("Add more time to the current wave or the start time of wave 0.")
end

--Force Boss--

function ulx.forceboss( calling_ply, target_plys )
	local affected_plys = {}

	for i=1, #target_plys do
		local v = target_plys[ i ]

		if v:IsFrozen() then
			ULib.tsayError( calling_ply, v:Nick() .. " is frozen!", true )
		elseif v:Team() == TEAM_HUMAN then
			ULib.tsayError( calling_ply, v:Nick() .. " is a human!", true )
		else
			GAMEMODE:SpawnBossZombie(v)
			table.insert( affected_plys, v )
		end
	end

	ulx.fancyLogAdmin( calling_ply, "#A forced #T to be boss.", affected_plys )
end
local forceboss = ulx.command( CATEGORY_NAME, "ulx forceboss", ulx.forceboss, "!forceboss" )
forceboss:addParam{ type=ULib.cmds.PlayersArg }
forceboss:defaultAccess(ULib.ACCESS_ALL)
forceboss:help( "Sets target(s) as boss." )
