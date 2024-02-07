--just some stuff to manage troublemakers, using persistent data to call on later

--playerdata is a custom SQL database setup in usefulfunctions that is better than PData
--why? because there are no conflicts as it stores steamid64
--this will make it easier to make a logging system later on
--it is safe to say this will be broken if not used in ZS

local CATEGORY_NAME = "ZS Utility"

--Hammerban
function ulx.hammerban(calling_ply, target_ply, minutes, reason) --format is ulx.functionnamehere(admin, player)
	if SERVER then
		Hammerban(target_ply:SteamID(), minutes, true, calling_ply:IsValid() and calling_ply:SteamID(), reason)
	end
	if minutes > 0 then
		ulx.fancyLogAdmin( calling_ply, "#A has hammerbanned #T for "..minutes.." minutes!", target_ply ) --prints in chat AND logs what has happened
	else
		ulx.fancyLogAdmin( calling_ply, "#A has hammerbanned #T permanently!", target_ply )
	end
end
--This code block below represents the actual command usage in the ULX menu. Defines chat, console, and menu commands to point to the function
local hammerban = ulx.command( CATEGORY_NAME, "ulx hammerban", ulx.hammerban, "!hammerban" ) --simplifies code
hammerban:addParam{ type=ULib.cmds.PlayerArg } --make it so you can only target one player at a time, ULib.cmds.PlayersArg, for multiple
hammerban:addParam{ type=ULib.cmds.NumArg, hint="Ban time (minutes)"}
hammerban:addParam{ type=ULib.cmds.StringArg, hint="Ban reason", ULib.cmds.takeRestOfLine, ULib.cmds.optional}
hammerban:defaultAccess(ULib.ACCESS_SUPERADMIN) --what groups can use this by default? should NEVER be user for admin commands
hammerban:help( "Hammerbans the target player for the given time." ) --description for anyone who doesn't know what this does

function ulx.unhammerban(calling_ply, target_ply)
	if SERVER then
		Hammerban(target_ply:SteamID(), minutes, false, calling_ply:IsValid() and calling_ply:SteamID())
	end
	ulx.fancyLogAdmin( calling_ply, "#A has unhammerbanned #T", target_ply )
end

local unhammerban = ulx.command( CATEGORY_NAME, "ulx unhammerban", ulx.unhammerban, "!unhammerban" )
unhammerban:addParam{ type=ULib.cmds.PlayerArg }
unhammerban:defaultAccess(ULib.ACCESS_SUPERADMIN)
unhammerban:help( "Unhammerbans the target player." )

--Ballpit

function ulx.ballpit(calling_ply, target_ply, minutes)
	if SERVER then
		Ballpit(target_ply:SteamID(), minutes, true, calling_ply:IsValid() and calling_ply:SteamID())
	end
	if minutes > 0 then
		ulx.fancyLogAdmin( calling_ply, "#A threw #T into the ballpit for "..minutes.." minutes!", target_ply ) --prints in chat AND logs what has happened
	else
		ulx.fancyLogAdmin( calling_ply, "#A threw #T into the ballpit permanently!", target_ply )
	end
end

local ballpit = ulx.command( CATEGORY_NAME, "ulx ballpit", ulx.ballpit, "!ballpit" )
ballpit:addParam{ type=ULib.cmds.PlayerArg }
ballpit:addParam{ type=ULib.cmds.NumArg, hint="Ban time (minutes)"}
ballpit:addParam{ type=ULib.cmds.StringArg, hint="Ban reason", ULib.cmds.takeRestOfLine, ULib.cmds.optional}
ballpit:defaultAccess(ULib.ACCESS_SUPERADMIN)
ballpit:help( "Ballpits the target player for the given time." )

function ulx.unballpit(calling_ply, target_ply)
	if SERVER then
		Ballpit(target_ply:SteamID(), minutes, false, calling_ply:IsValid() and calling_ply:SteamID())
	end
	ulx.fancyLogAdmin( calling_ply, "#A saved #T from the ballpit!", target_ply )
	
end

local unballpit = ulx.command( CATEGORY_NAME, "ulx unballpit", ulx.unballpit, "!unballpit" )
unballpit:addParam{ type=ULib.cmds.PlayerArg }
unballpit:defaultAccess(ULib.ACCESS_SUPERADMIN)
unballpit:help( "Unballpits the target player." )


--Noodle arms
function ulx.noodle(calling_ply, target_ply, minutes)
	if SERVER then
		Noodle(target_ply:SteamID(), minutes, true, calling_ply:IsValid() and calling_ply:SteamID())
	end
	if minutes > 0 then
		ulx.fancyLogAdmin( calling_ply, "#A has noodled #T for "..minutes.." minutes!", target_ply ) --prints in chat AND logs what has happened
	else
		ulx.fancyLogAdmin( calling_ply, "#A has noodled #T permanently!", target_ply )
	end
end

local noodle = ulx.command( CATEGORY_NAME, "ulx noodle", ulx.noodle, "!noodle" )
noodle:addParam{ type=ULib.cmds.PlayerArg }
noodle:addParam{ type=ULib.cmds.NumArg, hint="Ban time (minutes)"}
noodle:addParam{ type=ULib.cmds.StringArg, hint="Ban reason", ULib.cmds.takeRestOfLine, ULib.cmds.optional}
noodle:defaultAccess(ULib.ACCESS_SUPERADMIN)
noodle:help( "Noodles the target player for the given time." )

function ulx.unnoodle(calling_ply, target_ply)
	if SERVER then
		Noodle(target_ply:SteamID(), minutes, false, calling_ply:IsValid() and calling_ply:SteamID())
	end
	ulx.fancyLogAdmin( calling_ply, "#A saved #T from the ballpit!", target_ply )
	
end

local unnoodle = ulx.command( CATEGORY_NAME, "ulx unnoodle", ulx.unnoodle, "!unnoodle" )
unnoodle:addParam{ type=ULib.cmds.PlayerArg }
unnoodle:defaultAccess(ULib.ACCESS_SUPERADMIN)
unnoodle:help( "Unnoodles the target player." )

--one hit
function ulx.onehit(calling_ply, target_ply, minutes)
	if SERVER then
		OneHit(target_ply:SteamID(), minutes, true, calling_ply:IsValid() and calling_ply:SteamID())
	end
	if minutes > 0 then
		ulx.fancyLogAdmin( calling_ply, "#A has enabled 1HKO on #T for "..minutes.." minutes!", target_ply ) --prints in chat AND logs what has happened
	else
		ulx.fancyLogAdmin( calling_ply, "#A has enabled 1HKO on #T permanently!", target_ply )
	end
end

local onehit = ulx.command( CATEGORY_NAME, "ulx onehit", ulx.onehit, "!onehit" )
onehit:addParam{ type=ULib.cmds.PlayerArg }
onehit:addParam{ type=ULib.cmds.NumArg, hint="Ban time (minutes)"}
onehit:addParam{ type=ULib.cmds.StringArg, hint="Ban reason", ULib.cmds.takeRestOfLine, ULib.cmds.optional}
onehit:defaultAccess(ULib.ACCESS_SUPERADMIN)
onehit:help( "Onehits the target player for the given time." )

function ulx.unonehit(calling_ply, target_ply)
	if SERVER then
		OneHit(target_ply:SteamID(), minutes, false, calling_ply:IsValid() and calling_ply:SteamID())
	end
	ulx.fancyLogAdmin( calling_ply, "#A has enabled 1HKO on #T!", target_ply )
	
end

local unonehit = ulx.command( CATEGORY_NAME, "ulx unonehit", ulx.unonehit, "!unonehit" )
unonehit:addParam{ type=ULib.cmds.PlayerArg }
unonehit:defaultAccess(ULib.ACCESS_SUPERADMIN)
unonehit:help( "Unonehits the target player." )

--Givereturn
--[

--some returns dont take a boolean, so we need to exclude those
--or maybe not, it'll just mean that it cannot be undone later
--maybe there should be removal functions later...
--[[
local tExceptions = {
	["fit"] = true,
	["tough"] = true,
	["quick"] = true,
	["surged"] = true,
	["handy"] = true,
	["surgeon"] = true,
	["sadist"] = true,

	["weakness"] = true,
	["slowness"] = true,
	[""]
}
--]]

local tAttributes = {}

--we need to add traits/returns dynamically, so lets just fill a table with the necessary functions for each


function ulx.giveattribute(calling_ply, target_ply, att)
	if table.Count(tAttributes) < 1 then
		for i, item in ipairs(GAMEMODE.Items) do
			if item then
				local cat = item.Category
				local func = item.Callback
				local name = string.lower(item.Name)
		
				if cat == ITEMCAT_RETURNS or cat == ITEMCAT_TRAITS then
					tAttributes[name] = func
				end
			end
		end
	end

	local latt = string.lower(att)
	if tAttributes[latt] ~= nil then
		tAttributes[latt](target_ply)
		ulx.fancyLogAdmin(calling_ply, "#A gave #T the attributes: "..att.."!", target_ply)
	else
		ULib.tsayError( calling_ply, "Invalid attribute. Acceptable values include traits/returns listed in the worth menu")
	end
end

local giveattribute = ulx.command( CATEGORY_NAME, "ulx giveattribute", ulx.giveattribute, "!giveattribute")
giveattribute:addParam{ type=ULib.cmds.PlayerArg }
giveattribute:addParam{ type=ULib.cmds.StringArg, hint="Return (name in worth menu)", ULib.cmds.takeRestOfLine}
giveattribute:defaultAccess(ULib.ACCESS_SUPERADMIN)
giveattribute:help( "Gives a trait or debuff to the target, name is based on the worth menu." )

--[[ --Not applicable until there are remove functions
function ulx.removereturn(caller, target, debuff)
	local debuff = string.lower(debuff)
	if debuffsRemove[debuff] ~= nil then
		RunString(debuffsRemove[debuff], "RemoveReturnCompiler")
		ulx.fancyLogAdmin(calling_ply, "#A removed from #T the return: "..debuff.."!", target_ply)
	elseif debuff == "all" then
		for k, v in pairs(debuffsRemove) do
			RunString(v, "RemoveAllReturnsCompiler")
		end
		ulx.fancyLogAdmin(calling_ply, "#A removed all returns from #T!", target_ply)
	else
		ULib.tsayError( calling_ply, "Invalid return. Acceptable Returns include:\nnoodle, hemo, bfl, clumsy, palsy, wideload, or all")
	end
end

local removereturn = ulx.command(CATEGORY_NAME, "ulx removereturn", ulx.removereturn, "!removereturn")
removereturn:addParam{type=ULib.cmds.PlayerArg}
removereturn:addParam{type=ULib.cmds.StringArg, hint="Return (noodle, hemo, bfl, clumsy, palsy, wideload, or all)"}
removereturn:defaultAccess(ULib.ACCESS_SUPERADMIN)
removereturn:help("Removes a return from target. (noodle, hemo, bfl, clumsy, palsy, wideload)")
--]]
--spray ban

function ulx.sprayban(calling_ply, target_ply)
	if SERVER then
		target_ply:SetPlayerData("sprayban", true)
	end
	ulx.fancyLogAdmin( calling_ply, "#A banned #T from placing sprays!", target_ply )
end

local sprayban = ulx.command( CATEGORY_NAME, "ulx sprayban", ulx.sprayban, "!sprayban" )
sprayban:addParam{ type=ULib.cmds.PlayerArg }
sprayban:defaultAccess(ULib.ACCESS_SUPERADMIN)
sprayban:help( "Bans the player from placing sprays. Logged via file storage." )

function ulx.unsprayban(calling_ply, target_ply)
	if SERVER then
		target_ply:SetPlayerData("sprayban", false)
	end
	ulx.fancyLogAdmin(calling_ply, "#A unbanned #T from placing sprays!", target_ply)
end

local unsprayban = ulx.command( CATEGORY_NAME, "ulx unsprayban", ulx.unsprayban, "!unsprayban" )
unsprayban:addParam{ type=ULib.cmds.PlayerArg }
unsprayban:defaultAccess(ULib.ACCESS_SUPERADMIN)
unsprayban:help( "Unbans the player from placing sprays. Logged via file storage." )


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

function ulx.removenextbots(calling_ply)
	for k, v in pairs(ents.FindByClass("nz_*")) do
		SafeRemoveEntity(v)
	end
	ulx.fancyLogAdmin(calling_ply, "#A removed all spawned nextbots!")
end

local removenextbots = ulx.command( CATEGORY_NAME, "ulx removenextbots", ulx.removenextbots, "!removenextbots")
removenextbots:defaultAccess(ULib.ACCESS_SUPERADMIN)
removenextbots:help( "Removes all spawned nextbots.\nUseful for fixing glitched nextbots." )

function ulx.setnextbots(calling_ply, enable)
	if SERVER then RunConsoleCommand("gc_usenextbots", enable) end
	ulx.fancyLogAdmin(calling_ply, "#A changed nextbot spawning!")
end

local setnextbots = ulx.command( CATEGORY_NAME, "ulx setnextbots", ulx.setnextbots, "!setnextbots")
setnextbots:addParam{ type=ULib.cmds.StringArg, hint="State, 0 or 1"}
setnextbots:defaultAccess(ULib.ACCESS_SUPERADMIN)
setnextbots:help( "Set spawning of nextbots, 0 to disable, 1 to enable." )

function ulx.clearhint(calling_ply, target_plys, hint)
	local affected = {}
	if SERVER then
		if hint == "all" then
			for i=1, #target_plys do
				local ply = target_plys[i]
				ply:ClearHintData()
				table.insert(affected, ply)
			end
			ulx.fancyLogAdmin(calling_ply, "[DEBUG] #A cleared all of #T's hint cooldowns", affected)
			return
		end
	for i=1, #target_plys do
		local ply = target_plys[i]
		ply:RemoveHintData(hint)
		table.insert(affected, ply)
	end
	end
	ulx.fancyLogAdmin(calling_ply, "[DEBUG] #A cleared #T's hint cooldown of type #s", affected, hint)
end

local clearhint = ulx.command( CATEGORY_NAME, "ulx clearhint", ulx.clearhint, "!clearhint")
clearhint:addParam{ type=ULib.cmds.PlayersArg }
clearhint:addParam{ type=ULib.cmds.StringArg, hint="Hint type"}
clearhint:defaultAccess(ULib.ACCESS_SUPERADMIN)
clearhint:help( "[DEBUG] Clears the hint history, useful for testing." )

local commandList = {
	"!join - Opens the steam group page",
	"!changelog - Opens the changelog",
	"!results - Opens the endboard, if available",
	"!shop - Opens the pointshop",
	"!kill - Spawn back at spawn, useful as a zombie, not so useful as human",
	"!search - Search all humans for a specific item, such as arsenalcrate, hammer, medicalkit, etc",
	"!rules - Opens the server's ruleset",
	"!emotes - Opens the chat emote menu",
	"!zombie - Opens the menu to change zombie class"
}
function ulx.commands(calling_ply)
	timer.Simple(0, function()
	for k,v in pairs(commandList) do
		calling_ply:ChatPrint(v)
	end
	end)
end

local commands = ulx.command( CATEGORY_NAME, "ulx commands", ulx.commands, "!commands")
commands:defaultAccess(ULib.ACCESS_ALL)
commands:help( "Prints all useful commands to chat" )

function ulx.changelog(calling_ply)
	calling_ply:SendLua("gui.OpenURL(\"http://steamcommunity.com/groups/ProjectAnon/discussions/0/1470841715971170533/\")")
end

local changelog = ulx.command( CATEGORY_NAME, "ulx changelog", ulx.changelog, "!changelog")
changelog:defaultAccess(ULib.ACCESS_ALL)
changelog:help( "Opens the changelog for the server" )

function ulx.kill(calling_ply)
	if calling_ply:Alive() then
		calling_ply:Kill()
	else
		calling_ply:ChatPrint("Omae wa mou shindeiru.")
	end
end

local kill = ulx.command( CATEGORY_NAME, "ulx kill", ulx.kill, "!kill")
kill:defaultAccess(ULib.ACCESS_ALL)
kill:help( "Alias for kill console command" )


function ulx.remnails(calling_ply, target_plys)
local affected_plys = {}

for i=1, #target_plys do
local v = target_plys[ i ]
for _, k in pairs(ents.GetAll()) do
if k:GetClass() == "prop_nail" and player.GetByUniqueID(k:GetOwnerUID()) == v then
k:GetParent():RemoveNail(k, nil, v)
end
end
table.insert( affected_plys, v )
end

ulx.fancyLogAdmin( calling_ply, "#A removed the nails of #T.", affected_plys )

end
local remnails = ulx.command( CATEGORY_NAME, "ulx remnails", ulx.remnails, "!remnails")
remnails:defaultAccess( ULib.ACCESS_ADMIN )
remnails:addParam{ type=ULib.cmds.PlayersArg }
remnails:help("Removes a player's nails.")

--slay bots
function ulx.slaybots(calling_ply)
	local affected_plys = {}
	local targets = player.GetBots()

	for k, v in pairs(targets) do
		if ulx.getExclusive( v, calling_ply ) then
			ULib.tsayError( calling_ply, ulx.getExclusive( v, calling_ply ), true )
		elseif not v:Alive() then
			ULib.tsayError( calling_ply, v:Nick() .. " is already dead!", true )
		elseif v:IsFrozen() then
			ULib.tsayError( calling_ply, v:Nick() .. " is frozen!", true )
		else
			v:Kill()
			table.insert( affected_plys, v )
		end
	end
	ulx.fancyLogAdmin( calling_ply, "#A slayed #T", affected_plys )
end
local slaybots = ulx.command( CATEGORY_NAME, "ulx slaybots", ulx.slaybots, "!slaybots" )
slaybots:defaultAccess( ULib.ACCESS_ADMIN )
slaybots:help( "Slays all bots." )


--weapon searching, by MagicSwap
--TODO: make more efficient
--TODO: don't use chatprint, maybe network one string to print in chat
local SEARCH_PROP = 1
local SEARCH_WEAPONZS = 2
local SEARCH_WEAPONCW = 3
local possible = {
	[SEARCH_PROP] = "prop_",
	[SEARCH_WEAPONZS] = "weapon_zs_",
	[SEARCH_WEAPONCW] = "cw_",
	}
local responses = {
	[SEARCH_PROP] = "List of players who have this item deployed",
	[SEARCH_WEAPONZS] = "List of players who have this item in inventory",
	[SEARCH_WEAPONCW] = "",
}
local responses_noowner = {
	[SEARCH_PROP] = "This item is deployed somewhere but has no owner",
	[SEARCH_WEAPONZS] = "[ERROR]",
	[SEARCH_WEAPONCW] = "[ERROR]",
}
function ulx.search(calling_ply, strEnt)
	if calling_ply:Team() == TEAM_UNDEAD then
		ULib.tsayError(calling_ply, "You can't search while zombie!", true)
		return
	end
	
	local found = {
	[SEARCH_PROP] = {},
	[SEARCH_WEAPONZS] = {},
	[SEARCH_WEAPONCW] = {},
	}

	local found_noowner = {
	[SEARCH_PROP] = false,
	[SEARCH_WEAPONZS] = false,
	[SEARCH_WEAPONCW] = false,
	}
	local ltext = strEnt:lower()

	local tEntList = scripted_ents.GetList()
	local tWepList = weapons.GetList()

	--first we should see if there is actually an entity to be selected
	local foundEnt = false
	for key, text in pairs(possible) do
		if scripted_ents.GetStored(text..ltext) or weapons.GetStored(text..ltext) then
			foundEnt = true
		end
	end

	if not foundEnt then --lets try a partial string search
		for ent, info in pairs(tEntList) do --stored in string keys
			local lent = string.lower(ent)
			if string.find(lent, ltext) then
				for _, text in pairs(possible) do
					if string.StartWith(lent, text) then
						ltext = string.sub(lent, #text + 1)
						calling_ply:ChatPrint("Corrected partial input to "..ltext)
						foundEnt = true
						break
					end
				end
				break
			end
		end
	end

	if not foundEnt then --now lets search the weapons
		for i, info in pairs(tWepList) do
			if info.ClassName then
				local lent = string.lower(info.ClassName)
				if string.find(lent, ltext) then
					for _, text in pairs(possible) do
						if string.StartWith(lent, text) then
							ltext = string.sub(lent, #text + 1)
							calling_ply:ChatPrint("Corrected partial input to "..ltext)
							foundEnt = true
							break
						end
					end
					break
				end
			end
		end
	end


	if not foundEnt then
		ULib.tsayError(calling_ply, "Could not find an item with that name!", true)
		return
	end

	--First lets search through all entities and build our list of what we find.
	for _, ent in pairs(ents.GetAll()) do
		local class = ent:GetClass()
		for key, text in pairs(possible) do
			local ptext = text..ltext
			if class == ptext then
				local owner = ent:GetOwner()
				local propowner = ent.GetObjectOwner and ent:GetObjectOwner() or false
				if (owner and owner:IsValid()) or (propowner and propowner:IsValid()) then
					table.insert(found[key], ent)
				else
					found_noowner[key] = true
				end
			end
		end
	end

	--now we go through our found tables and build results
	for k, f in pairs(found) do
		local num = table.Count(f)
		if num < 1 then continue end
		calling_ply:ChatPrint(responses[k])
		for _, e in pairs(f) do
			local owner = e:GetOwner()
			local propowner = e.GetObjectOwner and e:GetObjectOwner() or false
			local oname = owner and owner:IsValid() and owner:Nick() or propowner and propowner:IsValid() and propowner:Nick() or "Unknown"
			calling_ply:ChatPrint(oname)
		end
	end

	--and now lets handle objects with no owner
	for k, b in pairs(found_noowner) do
		if b == true then
			calling_ply:ChatPrint(responses_noowner[k])
		end
	end
end

local search = ulx.command( CATEGORY_NAME, "ulx search", ulx.search, "!search")
search:addParam{ type=ULib.cmds.StringArg, hint="Item name (e.g arsenalcrate, hammerplank, medicalkit)"}
search:defaultAccess(ULib.ACCESS_ALL)
search:help( "Enter in an item name to search all humans for that item.\nSome example include:\narsenalcrate, hammer, medicalkit" )

--temp hammerban
function ulx.temphammerban(calling_ply, target_ply) 
	target_ply.TempHBanned = true
	ulx.fancyLogAdmin( calling_ply, "#A has hammerbanned #T for the round", target_ply ) 
end

local temphammerban = ulx.command( CATEGORY_NAME, "ulx temphammerban", ulx.temphammerban, "!temphammerban" ) 
temphammerban:addParam{ type=ULib.cmds.PlayerArg } 
temphammerban:defaultAccess(ULib.ACCESS_SUPERADMIN)
temphammerban:help( "Hammerbans the target player for the duration of the map" )

function ulx.untemphammerban(calling_ply, target_ply)
	target_ply.TempHBanned = false
	ulx.fancyLogAdmin( calling_ply, "#A has unhammerbanned #T for the round", target_ply )
end

local untemphammerban = ulx.command( CATEGORY_NAME, "ulx untemphammerban", ulx.untemphammerban, "!untemphammerban" )
untemphammerban:addParam{ type=ULib.cmds.PlayerArg }
untemphammerban:defaultAccess(ULib.ACCESS_SUPERADMIN)
untemphammerban:help( "Unhammerbans the target player for the duration of the map" )

--why didn't i do this earlier
--convienience function to grab the vector, angles, and model of a prop

function ulx.geteyetraceinfo(calling_ply)
	if calling_ply and calling_ply:IsValid() then
		local tr = calling_ply:GetEyeTraceNoCursor()
		if tr and tr.Entity then
			local ent = tr.Entity
			if ent and ent:IsValid() then
				calling_ply:ChatPrint("Printing Position Vector:")
				calling_ply:ChatPrint(util.TypeToString(ent:GetPos()))
				calling_ply:ChatPrint("Printing Angles:")
				calling_ply:ChatPrint(util.TypeToString(ent:GetAngles()))
				calling_ply:ChatPrint("Printing Model Name:")
				calling_ply:ChatPrint(ent:GetModel())
				calling_ply:ChatPrint("Printing Map ID:")
				calling_ply:ChatPrint(tostring(ent:MapCreationID()))
				calling_ply:ChatPrint("Successfully printed model details!")
			end
		end
	end
end

local geteyetraceinfo = ulx.command( CATEGORY_NAME, "ulx geteyetraceinfo", ulx.geteyetraceinfo, "!geteyetraceinfo" ) 
geteyetraceinfo:defaultAccess(ULib.ACCESS_SUPERADMIN)
geteyetraceinfo:help( "Grabs prop info, useful for getting details for permanent props." ) 

if SERVER then
	util.AddNetworkString("debug_netents")
end

function ulx.debugnetworkedents(calling_ply, strEnt)
	if not SERVER then return end
	local teles = ents.FindByClass(strEnt)
	if teles and strEnt then
		net.Start("debug_netents")
			net.WriteTable(teles)
			net.WriteString(strEnt)
		net.Send(calling_ply)
		calling_ply:ChatPrint("Details have been printed to your console.")
	end

end

local debugnetworkedents = ulx.command( CATEGORY_NAME, "ulx debugnetworkedents", ulx.debugnetworkedents, "!debugnetworkedents")
debugnetworkedents:addParam{ type=ULib.cmds.StringArg, hint="Entity name to get info of"}
debugnetworkedents:defaultAccess(ULib.ACCESS_ADMIN)
debugnetworkedents:help( "Enter in an entity name to see if clientside and serverside instances of these entities are in sync" )

if CLIENT then
	net.Receive("debug_netents", function(ln)
		local tbl = net.ReadTable()
		local entStr = net.ReadString()
		if tbl and entStr then
			print("Printing received serverside table:")
			PrintTable(tbl)

			print("Printing clientside table:")
			PrintTable(ents.FindByClass(entStr))
		end
	end)
end

--redeem only humans and NOT bots

function ulx.redeemnobot( calling_ply, target_plys )
	local affected_plys = {}

	for i=1, #target_plys do
		local v = target_plys[ i ]
		if v:IsBot() then continue end
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
local redeemnobot = ulx.command( CATEGORY_NAME, "ulx redeemnobot", ulx.redeemnobot, "!redeemnobot" )
redeemnobot:addParam{ type=ULib.cmds.PlayersArg }
redeemnobot:defaultAccess( ULib.ACCESS_ADMIN )
redeemnobot:help( "Redeems target(s), excludes bots." )

--emote menu command

if SERVER then util.AddNetworkString("zs_openemotemenu") end

function ulx.emotes(calling_ply)
	net.Start("zs_openemotemenu")
	net.Send(calling_ply)
end

local emotes = ulx.command( CATEGORY_NAME, "ulx emotes", ulx.emotes, "!emotes")
emotes:defaultAccess(ULib.ACCESS_ALL)
emotes:help( "Prints all useful commands to chat" )

--command to bring up rules
function ulx.rules(calling_ply)
	calling_ply:SendLua([[gui.OpenURL("https://steamcommunity.com/groups/ProjectAnon/discussions/0/3223871682619219665/")]])
end

local rules = ulx.command( CATEGORY_NAME, "ulx rules", ulx.rules, "!rules")
rules:defaultAccess(ULib.ACCESS_ALL)
rules:help( "Brings up the server rules" )

--command for zombie f3 menu
function ulx.zombie(calling_ply)
	if calling_ply:Team() == TEAM_UNDEAD then
		calling_ply:SendLua([[RunConsoleCommand("gm_showspare1")]])
	else
		calling_ply:ChatPrint("You must be a zombie to use this command!")
	end
end

local zombie = ulx.command( CATEGORY_NAME, "ulx zombie", ulx.zombie, "!zombie")
zombie:defaultAccess(ULib.ACCESS_ALL)
zombie:help( "Brings up the menu to change zombie class." )

function ulx.tempalltalk(calling_ply, enable)
	GAMEMODE.m_TempAllTalk = enable > 0 and true or false

	ulx.fancyLogAdmin(calling_ply, "#A temporairily changed alltalk to "..enable.."!")
end

local tempalltalk = ulx.command( CATEGORY_NAME, "ulx tempalltalk", ulx.tempalltalk, "!tempalltalk")
tempalltalk:addParam{ type=ULib.cmds.NumArg, hint="State, 0 or 1"}
tempalltalk:defaultAccess(ULib.ACCESS_SUPERADMIN)
tempalltalk:help("Enables/Disables alltalk for the current round.")

--[[
function ulx.alltalk(calling_ply, enable)
	if SERVER then RunConsoleCommand("sv_alltalk", enable) end
	ulx.fancyLogAdmin(calling_ply, "#A changed alltalk to "..enable.."!")
end

local alltalk = ulx.command( CATEGORY_NAME, "ulx alltalk", ulx.alltalk, "!alltalk")
alltalk:addParam{ type=ULib.cmds.StringArg, hint="State, 0 or 1"}
alltalk:defaultAccess(ULib.ACCESS_SUPERADMIN)
alltalk:help("Sets the value of the alltalk cvar from ulx")
--]]


--forcepack object, object is given to its rightful owner, if available
function ulx.forcepack(calling_ply, target_ply, item)
	local deployables = ents.FindByClass(item)

	local togive = {}
	for _, ent in pairs(deployables) do
		if ent.GetObjectOwner then
			local owner = ent:GetObjectOwner()
			if owner == target_ply then
				table.insert(togive, ent)
			end
		end
	end

	for _, v in pairs(togive) do
		if v.OnPackedUp and not v:OnPackedUp(target_ply) then
			gamemode.Call("ObjectPackedUp", v, calling_ply, target_ply)
		end
	end

	ulx.fancyLogAdmin( calling_ply, "#A packed #T's deployables of type "..item, affected_plys )
end
local forcepack = ulx.command( CATEGORY_NAME, "ulx forcepack", ulx.forcepack, "!forcepack" )
forcepack:addParam{ type=ULib.cmds.PlayerArg }
forcepack:addParam{ type=ULib.cmds.StringArg, hint="Deployable name"}
forcepack:defaultAccess( ULib.ACCESS_ADMIN )
forcepack:help( "Forcepacks all objects of that type and returns it to their original owner, if available." )

--destroy deployables of an owner
function ulx.destroydeployable(calling_ply, target_ply, item)
	local deployables = ents.FindByClass(item)

	local togive = {}
	for _, ent in pairs(deployables) do
		if ent.GetObjectOwner then
			local owner = ent:GetObjectOwner()
			if owner == target_ply then
				table.insert(togive, ent)
			end
		end
	end

	for _, v in pairs(togive) do
		v:Remove()
	end

	ulx.fancyLogAdmin( calling_ply, "#A destroyed #T's deployables of type "..item, affected_plys )
end
local destroydeployable = ulx.command( CATEGORY_NAME, "ulx destroydeployable", ulx.destroydeployable, "!destroydeployable" )
destroydeployable:addParam{ type=ULib.cmds.PlayerArg }
destroydeployable:addParam{ type=ULib.cmds.StringArg, hint="Deployable name"}
destroydeployable:defaultAccess( ULib.ACCESS_ADMIN )
destroydeployable:help( "Forcepacks all objects of that type and returns it to their original owner, if available." )

--we want to save added props easily, this will let us do that
local tSaveEnts = {}
function ulx.markentforinfo(calling_ply)
	if calling_ply and calling_ply:IsValid() then
		local tr = calling_ply:GetEyeTraceNoCursor()
		if tr and tr.Entity then
			local ent = tr.Entity
			if ent and ent:IsValid() then
				tSaveEnts[ent:GetCreationID()] = {pos = ent:GetPos(), ang = ent:GetAngles(), mdl = ent:GetModel(), mapid = ent:MapCreationID()}
				ent.BACKUPSAVECOLOR = ent:GetColor()
				ent:SetColor(Color(0, 255, 0))
			end
		end
	end
end

local markentforinfo = ulx.command( CATEGORY_NAME, "ulx markentforinfo", ulx.markentforinfo, "!markentforinfo" ) 
markentforinfo:defaultAccess(ULib.ACCESS_SUPERADMIN)
markentforinfo:help( "Grabs prop info, useful for getting details for permanent props." )

function ulx.unmarkentforinfo(calling_ply)
	if calling_ply and calling_ply:IsValid() then
		local tr = calling_ply:GetEyeTraceNoCursor()
		if tr and tr.Entity then
			local ent = tr.Entity
			if ent and ent:IsValid() then
				if tSaveEnts[ent:GetCreationID()] then
					tSaveEnts[ent:GetCreationID()] = nil
					ent:SetColor(ent.BACKUPSAVECOLOR or Color(255, 255, 255))
				end
			end
		end
	end
end

local unmarkentforinfo = ulx.command( CATEGORY_NAME, "ulx unmarkentforinfo", ulx.unmarkentforinfo, "!unmarkentforinfo" ) 
unmarkentforinfo:defaultAccess(ULib.ACCESS_SUPERADMIN)
unmarkentforinfo:help( "Grabs prop info, useful for getting details for permanent props." )

if SERVER then
	util.AddNetworkString("zs_permapropgenerate")
end

function ulx.generatepermapropcode(calling_ply)
	if calling_ply and calling_ply:IsValid() then
		local str = "START CODE GENERATION:"
		for ent, info in pairs(tSaveEnts) do
			local newstr = "\nlocal ent = ents.Create(\"prop_dynamic_override\")\nif ent and ent:IsValid() then"
			if info.mdl then
				newstr = newstr.."\n	ent:SetModel(\""..info.mdl.."\")"
			end
			if info.pos then
				newstr = newstr.."\n	ent:SetPos(Vector("..math.Round(info.pos.x, 2)..", "..math.Round(info.pos.y, 2)..", "..math.Round(info.pos.z, 2).."))"
			end
			if info.ang then
				newstr = newstr.."\n	ent:SetAngles(Angle("..math.Round(info.ang.p, 2)..", "..math.Round(info.ang.y, 2)..", "..math.Round(info.ang.r, 2).."))"
			end
			newstr = newstr.."\n	ent:SetColor(Color(0, 0, 0))"
			newstr = newstr.."\n	ent:SetKeyValue(\"solid\", \"6\")\n ent:Spawn()"
			str = str..newstr.."\nend"
		end
		if SERVER then
			net.Start("zs_permapropgenerate")
				local dCode = util.Compress(str)
				net.WriteData(dCode, #dCode)
			net.Send(calling_ply)
		end
	end
end
local generatepermapropcode = ulx.command( CATEGORY_NAME, "ulx generatepermapropcode", ulx.generatepermapropcode, "!generatepermapropcode" ) 
generatepermapropcode:defaultAccess(ULib.ACCESS_SUPERADMIN)
generatepermapropcode:help( "Generates code for permanent props" )

local netLimit = 64000 --net msgs can only be 64KB
if CLIENT then
	net.Receive("zs_permapropgenerate", function(ln, ply)
		print("PRINTING RECEIVED CODE")
		local dCode = net.ReadData(ln / 8)
		local str = util.Decompress(dCode)
		print(str)
		print("Message Length (bits/bytes)", ln, ln / 8)
		print("Message Length free (%):", ((netLimit - (ln / 8)) / netLimit) * 100)
		print("Uncompressed data length (bytes): ", #str)
	end)
end

--zs punishments menu
function ulx.zsmenu(calling_ply)
	OpenZSMenu(calling_ply)
end

local zsmenu = ulx.command( CATEGORY_NAME, "ulx zsmenu", ulx.zsmenu, "!zsmenu")
zsmenu:defaultAccess(ULib.ACCESS_ADMIN)
zsmenu:help( "View ZS punishment menu" )

--zs achievement menu
function ulx.achievements(calling_ply)
	OpenAchievementMenu(calling_ply)
end

local achievements = ulx.command( CATEGORY_NAME, "ulx achievements", ulx.achievements, "!achievements")
achievements:defaultAccess(ULib.ACCESS_ALL)
achievements:help( "View ZS achievements menu" )

--zs last human music menu
function ulx.lhmusic(calling_ply)
	OpenLHMenu(calling_ply)
end

local lhmusic = ulx.command( CATEGORY_NAME, "ulx lhmusic", ulx.lhmusic, "!lhmusic")
lhmusic:defaultAccess(ULib.ACCESS_ADMIN)
lhmusic:help( "View ZS Last Human music menu" )


--view nails on hud by looking at the prop
--shitty sendlua calls, will network it properly later maybe
function ulx.seenails(calling_ply)
	calling_ply:SendLua("MySelf.m_CanSeeNails = true")
end

local seenails = ulx.command( CATEGORY_NAME, "ulx seenails", ulx.seenails, "!seenails")
seenails:defaultAccess(ULib.ACCESS_ADMIN)
seenails:help( "View nails of props on HUD" )

function ulx.unseenails(calling_ply)
	calling_ply:SendLua("MySelf.m_CanSeeNails = false")
end

local unseenails = ulx.command( CATEGORY_NAME, "ulx unseenails", ulx.unseenails, "!unseenails")
unseenails:defaultAccess(ULib.ACCESS_ADMIN)
unseenails:help( "Unview nails of props on HUD" )
