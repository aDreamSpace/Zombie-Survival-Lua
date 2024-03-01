--VIPs module for ULX GUI -- by Stickly Man!
--Manages VIPned users and shows VIP details

xgui.prepareDataType( "VIPs" )

local xVIPs = xlib.makepanel{ parent=xgui.null }

xVIPs.VIPlist = xlib.makelistview{ x=5, y=30, w=572, h=310, multiselect=false, parent=xVIPs }
	xVIPs.VIPlist:AddColumn( "Name/SteamID" )
	xVIPs.VIPlist:AddColumn( "VIPed By" )
	xVIPs.VIPlist:AddColumn( "UnVIP Date" )
	xVIPs.VIPlist:AddColumn( "Reason" )
xVIPs.VIPlist.DoDoubleClick = function( self, LineID, line )
	xVIPs.ShowVIPDetailsWindow( xgui.data.VIPs.cache[LineID] )
end
xVIPs.VIPlist.OnRowRightClick = function( self, LineID, line )
	local menu = DermaMenu()
	menu:SetSkin(xgui.settings.skin)
	menu:AddOption( "Details...", function()
		if not line:IsValid() then return end
		xVIPs.ShowVIPDetailsWindow( xgui.data.VIPs.cache[LineID] )
	end )
	menu:AddOption( "Edit VIP...", function()
		if not line:IsValid() then return end
		xgui.ShowVIPWindow( nil, line:GetValue( 5 ), nil, true, xgui.data.VIPs.cache[LineID] )
	end )
	menu:AddOption( "Remove", function()
		if not line:IsValid() then return end
		xVIPs.RemoveVIP( line:GetValue( 5 ), xgui.data.VIPs.cache[LineID] )
	end )
	menu:Open()
end
-- Change the column sorting method to hook into our own custom sort stuff.
xVIPs.VIPlist.SortByColumn = function( self, ColumnID, Desc )
	local index =	ColumnID == 1 and 2 or	-- Sort by Name
					ColumnID == 2 and 4 or	-- Sort by Admin
					ColumnID == 3 and 6 or	-- Sort by UnVIP Date
					ColumnID == 4 and 5 or	-- Sort by Reason
									  1		-- Otherwise sort by Date
	xVIPs.sortbox:ChooseOptionID( index )
end

local searchFilter = ""
xVIPs.searchbox = xlib.maketextbox{ x=5, y=6, w=175, text="Search...", selectall=true, parent=xVIPs }
local txtCol = xVIPs.searchbox:GetTextColor() or Color( 0, 0, 0, 255 )
xVIPs.searchbox:SetTextColor( Color( txtCol.r, txtCol.g, txtCol.b, 196 ) ) -- Set initial color
xVIPs.searchbox.OnChange = function( pnl )
	if pnl:GetText() == "" then
		pnl:SetText( "Search..." )
		pnl:SelectAll()
		pnl:SetTextColor( Color( txtCol.r, txtCol.g, txtCol.b, 196 ) )
	else
		pnl:SetTextColor( Color( txtCol.r, txtCol.g, txtCol.b, 255 ) )
	end
end
xVIPs.searchbox.OnLoseFocus = function( pnl )
	if pnl:GetText() == "Search..." then
		searchFilter = ""
	else
		searchFilter = pnl:GetText()
	end
	xVIPs.setPage( 1 )
	xVIPs.retrieveVIPs()
	hook.Call( "OnTextEntryLoseFocus", nil, pnl )
end

local sortMode = 0
local sortAsc = false
xVIPs.sortbox = xlib.makecombobox{ x=185, y=6, w=150, text="Sort: Date (Desc.)", choices={ "Date", "Name", "Steam ID", "Admin", "Reason", "UnVIP Date", "VIP Length" }, parent=xVIPs }
function xVIPs.sortbox:OnSelect( i, v )
	if i-1 == sortMode then
		sortAsc = not sortAsc
	else
		sortMode = i-1
		sortAsc = false
	end
	self:SetValue( "Sort: " .. v .. (sortAsc and " (Asc.)" or " (Desc.)") )
	xVIPs.setPage( 1 )
	xVIPs.retrieveVIPs()
end

local hidePerma = 0
xlib.makebutton{ x=355, y=6, w=95, label="PermaVIPs: Show", parent=xVIPs }.DoClick = function( self )
	hidePerma = hidePerma + 1
	if hidePerma == 1 then
		self:SetText( "PermaVIPs: Hide" )
	elseif hidePerma == 2 then
		self:SetText( "PermaVIPs: Only" )
	elseif hidePerma == 3 then
		hidePerma = 0
		self:SetText( "PermaVIPs: Show" )
	end
	xVIPs.setPage( 1 )
	xVIPs.retrieveVIPs()
end

local hideIncomplete = 0
xlib.makebutton{ x=455, y=6, w=95, label="Incomplete: Show", parent=xVIPs, tooltip="Filters VIPs that are loaded by ULib, but do not have any metadata associated with them." }.DoClick = function( self )
	hideIncomplete = hideIncomplete + 1
	if hideIncomplete == 1 then
		self:SetText( "Incomplete: Hide" )
	elseif hideIncomplete == 2 then
		self:SetText( "Incomplete: Only" )
	elseif hideIncomplete == 3 then
		hideIncomplete = 0
		self:SetText( "Incomplete: Show" )
	end
	xVIPs.setPage( 1 )
	xVIPs.retrieveVIPs()
end


local function VIPUserList( doFreeze )
	local menu = DermaMenu()
	menu:SetSkin(xgui.settings.skin)
	for k, v in ipairs( player.GetAll() ) do
		menu:AddOption( v:Nick(), function()
			if not v:IsValid() then return end
			xgui.ShowVIPWindow( v, v:SteamID(), doFreeze )
		end )
	end
	menu:AddSpacer()
	if LocalPlayer():query("ulx vipid") then menu:AddOption( "VIP by STEAMID...", function() xgui.ShowVIPWindow() end ) end
	menu:Open()
end

xlib.makebutton{ x=5, y=340, w=70, label="VIP...", parent=xVIPs }.DoClick = function() VIPUserList( false ) end
--xVIPs.btnFreezeVIP = xlib.makebutton{ x=80, y=340, w=95, label="Freeze VIP...", parent=xVIPs }
--xVIPs.btnFreezeVIP.DoClick = function() VIPUserList( true ) end

xVIPs.infoLabel = xlib.makelabel{ x=204, y=344, label="Right-click on a VIP for more options", parent=xVIPs }


xVIPs.resultCount = xlib.makelabel{ y=344, parent=xVIPs }
function xVIPs.setResultCount( count )
	local pnl = xVIPs.resultCount
	pnl:SetText( count .. " results" )
	pnl:SizeToContents()

	local width = pnl:GetWide()
	local x, y = pnl:GetPos()
	pnl:SetPos( 475 - width, y )

	local ix, iy = xVIPs.infoLabel:GetPos()
	xVIPs.infoLabel:SetPos( ( 130 - width ) / 2 + 175, y )
end

local numPages = 1
local pageNumber = 1
xVIPs.pgleft = xlib.makebutton{ x=480, y=340, w=20, icon="icon16/arrow_left.png", centericon=true, disabled=true, parent=xVIPs }
xVIPs.pgleft.DoClick = function()
	xVIPs.setPage( pageNumber - 1 )
	xVIPs.retrieveVIPs()
end
xVIPs.pageSelector = xlib.makecombobox{ x=500, y=340, w=57, text="1", enableinput=true, parent=xVIPs }
function xVIPs.pageSelector:OnSelect( index )
	xVIPs.setPage( index )
	xVIPs.retrieveVIPs()
end
function xVIPs.pageSelector.TextEntry:OnEnter()
	pg = math.Clamp( tonumber( self:GetValue() ) or 1, 1, numPages )
	xVIPs.setPage( pg )
	xVIPs.retrieveVIPs()
end
xVIPs.pgright = xlib.makebutton{ x=557, y=340, w=20, icon="icon16/arrow_right.png", centericon=true, disabled=true, parent=xVIPs }
xVIPs.pgright.DoClick = function()
	xVIPs.setPage( pageNumber + 1 )
	xVIPs.retrieveVIPs()
end

xVIPs.setPage = function( newPage )
	pageNumber = newPage
	xVIPs.pgleft:SetDisabled( pageNumber <= 1 )
	xVIPs.pgright:SetDisabled( pageNumber >= numPages )
	xVIPs.pageSelector.TextEntry:SetText( pageNumber )
end


function xVIPs.RemoveVIP( ID, VIPdata )
	local tempstr = "<Unknown>"
	if VIPdata then tempstr = VIPdata.name or "<Unknown>" end
	Derma_Query( "Are you sure you would like to unVIP " .. tempstr .. " - " .. ID .. "?", "XGUI WARNING", 
		"Remove",	function()
						RunConsoleCommand( "ulx", "unVIP", ID ) 
						xVIPs.RemoveVIPDetailsWindow( ID )
					end,
		"Cancel", 	function() end )
end

xVIPs.openWindows = {}
function xVIPs.RemoveVIPDetailsWindow( ID )
	if xVIPs.openWindows[ID] then
		xVIPs.openWindows[ID]:Remove()
		xVIPs.openWindows[ID] = nil
	end
end

function xVIPs.ShowVIPDetailsWindow( VIPdata )
	local wx, wy
	if xVIPs.openWindows[VIPdata.steamID] then
		wx, wy = xVIPs.openWindows[VIPdata.steamID]:GetPos()
		xVIPs.openWindows[VIPdata.steamID]:Remove()
	end
	xVIPs.openWindows[VIPdata.steamID] = xlib.makeframe{ label="VIP Details", x=wx, y=wy, w=285, h=295, skin=xgui.settings.skin }

	local panel = xVIPs.openWindows[VIPdata.steamID]
	local name = xlib.makelabel{ x=50, y=30, label="Name:", parent=panel }
	xlib.makelabel{ x=90, y=30, w=190, label=( VIPdata.name or "<Unknown>" ), parent=panel, tooltip=VIPdata.name }
	xlib.makelabel{ x=36, y=50, label="SteamID:", parent=panel }
	xlib.makelabel{ x=90, y=50, label=VIPdata.steamID, parent=panel }
	xlib.makelabel{ x=33, y=70, label="VIP Date:", parent=panel }
	xlib.makelabel{ x=90, y=70, label=VIPdata.time and ( os.date( "%b %d, %Y - %I:%M:%S %p", tonumber( VIPdata.time ) ) ) or "<This VIP has no metadata>", parent=panel }
	xlib.makelabel{ x=20, y=90, label="UnVIP Date:", parent=panel }
	xlib.makelabel{ x=90, y=90, label=( tonumber( VIPdata.unVIP ) == 0 and "Never" or os.date( "%b %d, %Y - %I:%M:%S %p", math.min(  tonumber( VIPdata.unVIP ), 4294967295 ) ) ), parent=panel }
	xlib.makelabel{ x=10, y=110, label="Length of VIP:", parent=panel }
	xlib.makelabel{ x=90, y=110, label=( tonumber( VIPdata.unVIP ) == 0 and "Permanent" or xgui.ConvertTime( tonumber( VIPdata.unVIP ) - VIPdata.time ) ), parent=panel }
	xlib.makelabel{ x=33, y=130, label="Time Left:", parent=panel }
	local timeleft = xlib.makelabel{ x=90, y=130, label=( tonumber( VIPdata.unVIP ) == 0 and "N/A" or xgui.ConvertTime( tonumber( VIPdata.unVIP ) - os.time() ) ), parent=panel }
	xlib.makelabel{ x=26, y=150, label="VIPned By:", parent=panel }
	if VIPdata.admin then xlib.makelabel{ x=90, y=150, label=string.gsub( VIPdata.admin, "%(STEAM_%w:%w:%w*%)", "" ), parent=panel } end
	if VIPdata.admin then xlib.makelabel{ x=90, y=165, label=string.match( VIPdata.admin, "%(STEAM_%w:%w:%w*%)" ), parent=panel } end
	xlib.makelabel{ x=41, y=185, label="Reason:", parent=panel }
	xlib.makelabel{ x=90, y=185, w=190, label=VIPdata.reason, parent=panel, tooltip=VIPdata.reason ~= "" and VIPdata.reason or nil }
	xlib.makelabel{ x=13, y=205, label="Last Updated:", parent=panel }
	xlib.makelabel{ x=90, y=205, label=( ( VIPdata.modified_time == nil ) and "Never" or os.date( "%b %d, %Y - %I:%M:%S %p", tonumber( VIPdata.modified_time ) ) ), parent=panel }
	xlib.makelabel{ x=21, y=225, label="Updated by:", parent=panel }
	if VIPdata.modified_admin then xlib.makelabel{ x=90, y=225, label=string.gsub( VIPdata.modified_admin, "%(STEAM_%w:%w:%w*%)", "" ), parent=panel } end
	if VIPdata.modified_admin then xlib.makelabel{ x=90, y=240, label=string.match( VIPdata.modified_admin, "%(STEAM_%w:%w:%w*%)" ), parent=panel } end

	panel.data = VIPdata	-- Store data on panel for future reference.
	xlib.makebutton{ x=5, y=265, w=89, label="Edit VIP...", parent=panel }.DoClick = function()
		xgui.ShowVIPWindow( nil, panel.data.steamID, nil, true, panel.data )
	end

	xlib.makebutton{ x=99, y=265, w=89, label="UnVIP", parent=panel }.DoClick = function()
		xVIPs.RemoveVIP( panel.data.steamID, panel.data )
	end

	xlib.makebutton{ x=192, y=265, w=88, label="Close", parent=panel }.DoClick = function()
		xVIPs.RemoveVIPDetailsWindow( panel.data.steamID )
	end

	panel.btnClose.DoClick = function ( button )
		xVIPs.RemoveVIPDetailsWindow( panel.data.steamID )
	end

	if timeleft:GetValue() ~= "N/A" then
		function panel.OnTimer()
			if panel:IsVisible() then
				local VIPtime = tonumber( panel.data.unVIP ) - os.time()
				if VIPtime <= 0 then
					xVIPs.RemoveVIPDetailsWindow( panel.data.steamID )
					return
				else
					timeleft:SetText( xgui.ConvertTime( VIPtime ) )
				end
				timeleft:SizeToContents()
				timer.Simple( 1, panel.OnTimer )
			end
		end
		panel.OnTimer()
	end
end

function xgui.ShowVIPWindow( ply, ID, doFreeze, isUpdate, VIPdata )
	if not LocalPlayer():query( "ulx VIP" ) and not LocalPlayer():query( "ulx vipid" ) then return end

	local xgui_VIPwindow = xlib.makeframe{ label=( isUpdate and "Edit VIP" or "VIP Player" ), w=285, h=180, skin=xgui.settings.skin }
	xlib.makelabel{ x=37, y=33, label="Name:", parent=xgui_VIPwindow }
	xlib.makelabel{ x=23, y=58, label="SteamID:", parent=xgui_VIPwindow }
	xlib.makelabel{ x=28, y=83, label="Reason:", parent=xgui_VIPwindow }
	xlib.makelabel{ x=10, y=108, label="VIP Length:", parent=xgui_VIPwindow }
	local reason = xlib.makecombobox{ x=75, y=80, w=200, parent=xgui_VIPwindow, enableinput=true, selectall=true, choices=ULib.cmds.translatedCmds["ulx vip"].args[4].completes }
	local VIPpanel = ULib.cmds.NumArg.x_getcontrol( ULib.cmds.translatedCmds["ulx vip"].args[3], 2, xgui_VIPwindow )
	VIPpanel.interval:SetParent( xgui_VIPwindow )
	VIPpanel.interval:SetPos( 200, 105 )
	VIPpanel.val:SetParent( xgui_VIPwindow )
	VIPpanel.val:SetPos( 75, 125 )
	VIPpanel.val:SetWidth( 200 )

	local name
	if not isUpdate then
		name = xlib.makecombobox{ x=75, y=30, w=200, parent=xgui_VIPwindow, enableinput=true, selectall=true }
		for k,v in pairs( player.GetAll() ) do
			name:AddChoice( v:Nick(), v:SteamID() )
		end
		name.OnSelect = function( self, index, value, data )
			self.steamIDbox:SetText( data )
		end
	else
		name = xlib.maketextbox{ x=75, y=30, w=200, parent=xgui_VIPwindow, selectall=true }
		if VIPdata then
			name:SetText( VIPdata.name or "" )
			reason:SetText( VIPdata.reason or "" )
			if tonumber( VIPdata.unVIP ) ~= 0 then
				local btime = ( tonumber( VIPdata.unVIP ) - tonumber( VIPdata.time ) )
				if btime % 31536000 == 0 then
					if #VIPpanel.interval.Choices >= 6 then
						VIPpanel.interval:ChooseOptionID(6)
					else
						VIPpanel.interval:SetText( "Years" )
					end
					btime = btime / 31536000
				elseif btime % 604800 == 0 then
					if #VIPpanel.interval.Choices >= 5 then
						VIPpanel.interval:ChooseOptionID(5)
					else
						VIPpanel.interval:SetText( "Weeks" )
					end
					btime = btime / 604800
				elseif btime % 86400 == 0 then
					if #VIPpanel.interval.Choices >= 4 then
						VIPpanel.interval:ChooseOptionID(4)
					else
						VIPpanel.interval:SetText( "Days" )
					end
					btime = btime / 86400
				elseif btime % 3600 == 0 then
					if #VIPpanel.interval.Choices >= 3 then
						VIPpanel.interval:ChooseOptionID(3)
					else
						VIPpanel.interval:SetText( "Hours" )
					end
					btime = btime / 3600
				else
					btime = btime / 60
					if #VIPpanel.interval.Choices >= 2 then
						VIPpanel.interval:ChooseOptionID(2)
					else
						VIPpanel.interval:SetText( "Minutes" )
					end
				end
				VIPpanel.val:SetValue( btime )
			end
		end
	end

	local steamID = xlib.maketextbox{ x=75, y=55, w=200, selectall=true, disabled=( isUpdate or not LocalPlayer():query( "ulx vipid" ) ), parent=xgui_VIPwindow }
	name.steamIDbox = steamID --Make a reference to the steamID textbox so it can change the value easily without needing a global variable

	if doFreeze and ply then
		if LocalPlayer():query( "ulx freeze" ) then
			RunConsoleCommand( "ulx", "freeze", "$" .. ULib.getUniqueIDForPlayer( ply ) )
			steamID:SetDisabled( true )
			name:SetDisabled( true )
			xgui_VIPwindow:ShowCloseButton( false )
		else
			doFreeze = false
		end
	end
	xlib.makebutton{ x=165, y=150, w=75, label="Cancel", parent=xgui_VIPwindow }.DoClick = function()
		if doFreeze and ply and ply:IsValid() then
			RunConsoleCommand( "ulx", "unfreeze", "$" .. ULib.getUniqueIDForPlayer( ply ) )
		end
		xgui_VIPwindow:Remove()
	end
	xlib.makebutton{ x=45, y=150, w=75, label=( isUpdate and "Update" or "VIP!" ), parent=xgui_VIPwindow }.DoClick = function()
		if isUpdate then
			local function performUpdate(btime)
				RunConsoleCommand( "xgui", "updateVIP", steamID:GetValue(), btime, reason:GetValue(), name:GetValue() )
				xgui_VIPwindow:Remove()
			end
			btime = VIPpanel:GetMinutes()
			if btime ~= 0 and VIPdata and btime * 60 + VIPdata.time < os.time() then
				Derma_Query( "WARNING! The new VIP time you have specified will cause this VIP to expire.\nThe minimum time required in order to change the VIP length successfully is " 
						.. xgui.ConvertTime( os.time() - VIPdata.time ) .. ".\nAre you sure you wish to continue?", "XGUI WARNING",
					"Expire VIP", function()
						performUpdate(btime)
						xVIPs.RemoveVIPDetailsWindow( VIPdata.steamID )
					end,
					"Cancel", function() end )
			else
				performUpdate(btime)
			end
			return
		end

		if ULib.isValidSteamID( steamID:GetValue() ) then
			local isOnline = false
			for k, v in ipairs( player.GetAll() ) do
				if v:SteamID() == steamID:GetValue() then
					isOnline = v
					break
				end
			end
			if not isOnline then
				if name:GetValue() == "" then
					RunConsoleCommand( "ulx", "vipid", steamID:GetValue(), VIPpanel:GetValue(), reason:GetValue() )
				else
					RunConsoleCommand( "xgui", "updateVIP", steamID:GetValue(), VIPpanel:GetMinutes(), reason:GetValue(), ( name:GetValue() ~= "" and name:GetValue() or nil ) )
				end
			else
				RunConsoleCommand( "ulx", "VIP", "$" .. ULib.getUniqueIDForPlayer( isOnline ), VIPpanel:GetValue(), reason:GetValue() )
			end
			xgui_VIPwindow:Remove()
		else
			local ply, message = ULib.getUser( name:GetValue() )
			if ply then
				RunConsoleCommand( "ulx", "VIP", "$" .. ULib.getUniqueIDForPlayer( ply ), VIPpanel:GetValue(), reason:GetValue() )
				xgui_VIPwindow:Remove()
				return
			end
			Derma_Message( message )
		end
	end

	if ply then name:SetText( ply:Nick() ) end
	if ID then steamID:SetText( ID ) else steamID:SetText( "STEAM_0:" ) end
end

function xgui.ConvertTime( seconds )
	--Convert number of seconds remaining to something more legible (Thanks JamminR!)
	local years = math.floor( seconds / 31536000 )
	seconds = seconds - ( years * 31536000 )
	local weeks = math.floor( seconds / 604800 )
	seconds = seconds - ( weeks * 604800 )
	local days = math.floor( seconds / 86400 )
	seconds = seconds - ( days * 86400 )
	local hours = math.floor( seconds/3600 )
	seconds = seconds - ( hours * 3600 )
	local minutes = math.floor( seconds/60 )
	seconds = seconds - ( minutes * 60 )
	local curtime = ""
	if years ~= 0 then curtime = curtime .. years .. " year" .. ( ( years > 1 ) and "s, " or ", " ) end
	if weeks ~= 0 then curtime = curtime .. weeks .. " week" .. ( ( weeks > 1 ) and "s, " or ", " ) end
	if days ~= 0 then curtime = curtime .. days .. " day" .. ( ( days > 1 ) and "s, " or ", " ) end
	curtime = curtime .. ( ( hours < 10 ) and "0" or "" ) .. hours .. ":"
	curtime = curtime .. ( ( minutes < 10 ) and "0" or "" ) .. minutes .. ":"
	return curtime .. ( ( seconds < 10 and "0" or "" ) .. seconds )
end

---Update stuff
function xVIPs.VIPsRefreshed()
	xgui.data.VIPs.cache = {} -- Clear the VIPs cache

	-- Retrieve VIPs if XGUI is open, otherwise it will be loaded later.
	if xgui.anchor:IsVisible() then
		xVIPs.retrieveVIPs()
	end
end
xgui.hookEvent( "VIPs", "process", xVIPs.VIPsRefreshed, "VIPsRefresh" )

function xVIPs.VIPPageRecieved( data )
	xgui.data.VIPs.cache = data
	xVIPs.clearVIPs()
	xVIPs.populateVIPs()
end
xgui.hookEvent( "VIPs", "data", xVIPs.VIPPageRecieved, "VIPsGotPage" )

function xVIPs.checkCache()
	if xgui.data.VIPs.cache and xgui.data.VIPs.count ~= 0 and table.Count(xgui.data.VIPs.cache) == 0 then
		xVIPs.retrieveVIPs()
	end
end
xgui.hookEvent( "onOpen", nil, xVIPs.checkCache, "VIPsCheckCache" )

function xVIPs.clearVIPs()
	xVIPs.VIPlist:Clear()
end

function xVIPs.retrieveVIPs()
	RunConsoleCommand( "xgui", "getVIPs",
		sortMode,			-- Sort Type
		searchFilter,		-- Filter String
		hidePerma,			-- Hide permaVIPs?
		hideIncomplete,		-- Hide VIPs that don't have full ULX metadata?
		pageNumber,			-- Page number
		sortAsc and 1 or 0)	-- Ascending/Descending
end

function xVIPs.populateVIPs()
	if xgui.data.VIPs.cache == nil then return end
	local cache = xgui.data.VIPs.cache
	local count = cache.count or xgui.data.VIPs.count
	numPages = math.max( 1, math.ceil( count / 17 ) )

	xVIPs.setResultCount( count )
	xVIPs.pageSelector:SetDisabled( numPages == 1 )
	xVIPs.pageSelector:Clear()
	for i=1, numPages do
		xVIPs.pageSelector:AddChoice(i)
	end
	xVIPs.setPage( math.Clamp( pageNumber, 1, numPages ) )

	cache.count = nil

	for _, VIPinfo in pairs( cache ) do
		xVIPs.VIPlist:AddLine( VIPinfo.name or VIPinfo.steamID,
					( VIPinfo.admin ) and string.gsub( VIPinfo.admin, "%(STEAM_%w:%w:%w*%)", "" ) or "",
					(( tonumber( VIPinfo.unVIP ) ~= 0 ) and os.date( "%c", math.min( tonumber( VIPinfo.unVIP ), 4294967295 ) )) or "Never",
					VIPinfo.reason,
					VIPinfo.steamID,
					tonumber( VIPinfo.unVIP ) )
	end
end
xVIPs.populateVIPs() --For autorefresh

function xVIPs.xVIP( ply, cmd, args, dofreeze )
	if args[1] and args[1] ~= "" then
		local target = ULib.getUser( args[1] )
		if target then
			xgui.ShowVIPWindow( target, target:SteamID(), dofreeze )
		end
	else
		xgui.ShowVIPWindow()
	end
end
ULib.cmds.addCommandClient( "xgui xVIP", xVIPs.xVIP )

function xVIPs.fVIP( ply, cmd, args )
	xVIPs.xVIP( ply, cmd, args, true )
end
ULib.cmds.addCommandClient( "xgui fVIP", xVIPs.fVIP )


xgui.addModule( "VIPs", xVIPs, "icon16/star.png", "xgui_manageVIPs" )
