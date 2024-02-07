
function ULib.ZLIST( ply, time, reason, admin )
	if not time or type( time ) ~= "number" then
		time = 0
	end

	ULib.addZLIST( ply:SteamID(), time, reason, ply:Name(), admin )

	-- Load our currently ZLISTned users so we don't overwrite them
	if ULib.fileExists( "cfg/ZLISTed_user.cfg" ) then
		ULib.execFile( "cfg/ZLISTed_user.cfg" )
	end
end
ULib.kickZLIST = ULib.ZLIST

function ULib.addZLIST( steamid, time, reason, name, admin )
	if reason == "" then reason = nil end

	local admin_name
	if admin then
		admin_name = "(Console)"
		if admin:IsValid() then
			admin_name = string.format( "%s(%s)", admin:Name(), admin:SteamID() )
		end
	end

	local t = {}
	local timeNow = os.time()
	if ULib.ZLISTs[ steamid ] then
		t = ULib.ZLISTs[ steamid ]
		t.modified_admin = admin_name
		t.modified_time = timeNow
	else
		t.admin = admin_name
	end
	t.time = t.time or timeNow
	if time > 0 then
		t.unZLIST = ( ( time * 60 ) + timeNow )
	else
		t.unZLIST = 0
	end
	if reason then
		t.reason = reason
	end
	if name then
		t.name = name
	end
	ULib.ZLISTs[ steamid ] = t

	local strTime = time ~= 0 and time*60
	


	local longReason = shortReason
	--[[if reason or strTime or admin then -- If we have something useful to show
		longReason = "\n" .. ULib.getZLISTMessage( steamid ) .. "\n" -- Newlines because we are forced to show "Disconnect: <msg>."
	end]]

	local ply = player.GetBySteamID( steamid )
	
	if ply then
		ply.IsZlisted = true
		ply.NoObjectPickup=true
	end


	


	--game.ConsoleCommand( string.format( "kickid %s %s\n", steamid, shortReason or "" ) )
	--game.ConsoleCommand( string.format( "ZLISTid %f %s kick\n", time, steamid ) )
	--game.ConsoleCommand( string.format( "zlistid %f %s\n", time, steamid ) )
	--game.ConsoleCommand( "writeid\n" )

	ULib.fileWrite( ULib.ZLISTS_FILE, ULib.makeKeyValues( ULib.ZLISTs ) )
end

function ULib.unZLIST( steamid, admin )

	--Default ZLISTlist
	if ULib.fileExists( "cfg/ZLISTed_user.cfg" ) then
		ULib.execFile( "cfg/ZLISTed_user.cfg" )
	end
	--ULib.queueFunctionCall( game.ConsoleCommand, "removeid " .. steamid .. ";writeid\n" ) -- Execute after done loading ZLISTs
	local ply = player.GetBySteamID( steamid )
	if ply then
		ply.IsZlisted = false
		ply.NoObjectPickup= false
	end
	--ULib ZLISTlist
	ULib.ZLISTs[ steamid ] = nil
	ULib.fileWrite( ULib.ZLISTS_FILE, ULib.makeKeyValues( ULib.ZLISTs ) )
end

function ULib.refreshZLISTs()
	local err
	if not ULib.fileExists( ULib.ZLISTS_FILE ) then
		ULib.ZLISTs = {}
	else
		ULib.ZLISTs, err = ULib.parseKeyValues( ULib.fileRead( ULib.ZLISTS_FILE ) )
	end

	if err then
		Msg( "ZLISTs file was not formatted correctly. Attempting to fix and backing up original\n" )
		if err then
			Msg( "Error while reading ZLISTs file was: " .. err .. "\n" )
		end
		Msg( "Original file was backed up to " .. ULib.backupFile( ULib.ZLISTS_FILE ) .. "\n" )
		ULib.ZLISTs = {}
	end

	local default_ZLISTs = ""
	if ULib.fileExists( "cfg/ZLISTed_user.cfg" ) then
		ULib.execFile( "cfg/ZLISTed_user.cfg" )
		--ULib.queueFunctionCall( game.ConsoleCommand, "writeid\n" )
		default_ZLISTs = ULib.fileRead( "cfg/ZLISTed_user.cfg" )
	end

	--default_ZLISTs = ULib.makePatternSafe( default_ZLISTs )
	default_ZLISTs = string.gsub( default_ZLISTs, "ulx zlistid %d+ ", "" )
	default_ZLISTs = string.Explode( "\n", default_ZLISTs:gsub( "\r", "" ) )
	local ZLIST_set = {}
	for _, v in pairs( default_ZLISTs ) do
		if v ~= "" then
			ZLIST_set[ v ] = true
			if not ULib.ZLISTs[ v ] then
				ULib.ZLISTs[ v ] = { unZLIST = 0 }
			end
		end
	end

	for k, v in pairs( ULib.ZLISTs ) do
		if type( v ) == "table" and type( k ) == "string" then
			local time = ( v.unZLIST - os.time() ) / 60
			if time > 0 then
				game.ConsoleCommand( string.format( "ulx zlistid %s %f\n",k,time ) )
			elseif math.floor( v.unZLIST ) == 0 then -- We floor it because GM10 has floating point errors that might make it be 0.1e-20 or something dumb.
				game.ConsoleCommand( string.format( "ulx zlistid %s %f\n", k,time ) )
			else
				ULib.ZLISTs[ k ] = nil
			end
		else
			Msg( "Warning: Bad ZLIST data is being ignored, key = " .. tostring( k ) .. "\n" )
			ULib.ZLISTs[ k ] = nil
		end
	end

	-- We're queueing this because it will split the load out for VERY large ZLIST files
	ULib.queueFunctionCall( function() ULib.fileWrite( ULib.ZLISTS_FILE, ULib.makeKeyValues( ULib.ZLISTs ) ) end )
end
ULib.pcallError( ULib.refreshZLISTs )
hook.Add( "Initialize", "ULibLoadZLISTs", ULib.refreshZLISTs, HOOK_MONITOR_HIGH )



function ULib.VIP( ply, time, reason, admin )
	if not time or type( time ) ~= "number" then
		time = 0
	end
	
	ULib.addVIP( ply:SteamID(), time, reason, ply:Name(), admin )
	
	-- Load our currently VIPned users so we don't overwrite them
	if ULib.fileExists( "cfg/VIPed_user.cfg" ) then
		ULib.execFile( "cfg/VIPed_user.cfg" )
	end
	
end
ULib.kickVIP = ULib.VIP

function ULib.addVIP( steamid, time, reason, name, admin )
	if reason == "" then reason = nil end

	local admin_name
	if admin then
		admin_name = "(Console)"
		if admin:IsValid() then
			admin_name = string.format( "%s(%s)", admin:Name(), admin:SteamID() )
		end
	end

	local t = {}
	local timeNow = os.time()
	if ULib.VIPs[ steamid ] then
		t = ULib.VIPs[ steamid ]
		t.modified_admin = admin_name
		t.modified_time = timeNow
	else
		t.admin = admin_name
	end
	t.time = t.time or timeNow
	if time > 0 then
		t.unVIP = ( ( time * 60 ) + timeNow )
	else
		t.unVIP = 0
	end
	if reason then
		t.reason = reason
	end
	if name then
		t.name = name
	end
	ULib.VIPs[ steamid ] = t

	local strTime = time ~= 0 and time*60
	local shortReason = "VIPned for " .. (strTime or "eternity")


	local longReason = shortReason
	--[[if reason or strTime or admin then -- If we have something useful to show
		longReason = "\n" .. ULib.getVIPMessage( steamid ) .. "\n" -- Newlines because we are forced to show "Disconnect: <msg>."
	end]]

	--[[local ply = player.GetBySteamID( steamid )
	if ply then
		ULib.kick( ply, longReason )
	end]]

	-- Remove all semicolons from the reason to prevent command injection
	

	-- This redundant kick code is to ensure they're kicked -- even if they're joining
	--game.ConsoleCommand( string.format( "kickid %s %s\n", steamid, shortReason or "" ) )
	--game.ConsoleCommand( string.format( "VIPid %f %s kick\n", time, steamid ) )
	--game.ConsoleCommand( string.format( "ulx vipid %s %f \n",steamid,time ) )
	--game.ConsoleCommand( "writeid\n" )

	ULib.fileWrite( ULib.VIPS_FILE, ULib.makeKeyValues( ULib.VIPs ) )
end


function ULib.unVIP( steamid, admin )

	--Default VIPlist
	if ULib.fileExists( "cfg/VIPed_user.cfg" ) then
		ULib.execFile( "cfg/VIPed_user.cfg" )
	end
	ULib.queueFunctionCall( game.ConsoleCommand, "removeid " .. steamid .. ";writeid\n" ) -- Execute after done loading VIPs

	--ULib VIPlist
	ULib.VIPs[ steamid ] = nil
	ULib.fileWrite( ULib.VIPS_FILE, ULib.makeKeyValues( ULib.VIPs ) )
end

function ULib.refreshVIPs()
	local err
	if not ULib.fileExists( ULib.VIPS_FILE ) then
		ULib.VIPs = {}
	else
		ULib.VIPs, err = ULib.parseKeyValues( ULib.fileRead( ULib.VIPS_FILE ) )
	end

	if err then
		Msg( "VIPs file was not formatted correctly. Attempting to fix and backing up original\n" )
		if err then
			Msg( "Error while reading VIPs file was: " .. err .. "\n" )
		end
		Msg( "Original file was backed up to " .. ULib.backupFile( ULib.VIPS_FILE ) .. "\n" )
		ULib.VIPs = {}
	end

	local default_VIPs = ""
	if ULib.fileExists( "cfg/VIPed_user.cfg" ) then
		ULib.execFile( "cfg/VIPed_user.cfg" )
		--ULib.queueFunctionCall( game.ConsoleCommand, "writeid\n" )
		default_VIPs = ULib.fileRead( "cfg/VIPed_user.cfg" )
	end

	--default_VIPs = ULib.makePatternSafe( default_VIPs )
	default_VIPs = string.gsub( default_VIPs, "ulx vipid %d+ ", "" )
	default_VIPs = string.Explode( "\n", default_VIPs:gsub( "\r", "" ) )
	local VIP_set = {}
	for _, v in pairs( default_VIPs ) do
		if v ~= "" then
			VIP_set[ v ] = true
			if not ULib.VIPs[ v ] then
				ULib.VIPs[ v ] = { unVIP = 0 }
			end
		end
	end

	for k, v in pairs( ULib.VIPs ) do
		if type( v ) == "table" and type( k ) == "string" then
			local time = ( v.unVIP - os.time() ) / 60
			if time > 0 then
				game.ConsoleCommand( string.format( "ulx vipid %s %f\n",k,time) )
			elseif math.floor( v.unVIP ) == 0 then -- We floor it because GM10 has floating point errors that might make it be 0.1e-20 or something dumb.			
				game.ConsoleCommand( string.format( "ulx vipid %s %f\n",k,time ) )
			else
				ULib.VIPs[ k ] = nil
			end
		else
			Msg( "Warning: Bad VIP data is being ignored, key = " .. tostring( k ) .. "\n" )
			ULib.VIPs[ k ] = nil
		end
	end

	-- We're queueing this because it will split the load out for VERY large VIP files
	ULib.queueFunctionCall( function() ULib.fileWrite( ULib.VIPS_FILE, ULib.makeKeyValues( ULib.VIPs ) ) end )
end
ULib.pcallError( ULib.refreshVIPs )
hook.Add( "Initialize", "ULibLoadVIPs", ULib.refreshVIPs, HOOK_MONITOR_HIGH )

