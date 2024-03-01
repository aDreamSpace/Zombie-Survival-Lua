--ZLISTs module for ULX GUI -- by Stickly Man!
--Manages ZLISTned users and shows ZLIST details

xgui.prepareDataType( "ZLISTs" )

local xZLISTs = xlib.makepanel{ parent=xgui.null }

xZLISTs.ZLISTlist = xlib.makelistview{ x=5, y=30, w=572, h=310, multiselect=false, parent=xZLISTs }
	xZLISTs.ZLISTlist:AddColumn( "Name/SteamID" )
	xZLISTs.ZLISTlist:AddColumn( "ZLISTed By" )
	xZLISTs.ZLISTlist:AddColumn( "UnZLIST Date" )
	xZLISTs.ZLISTlist:AddColumn( "Reason" )
xZLISTs.ZLISTlist.DoDoubleClick = function( self, LineID, line )
	xZLISTs.ShowZLISTDetailsWindow( xgui.data.ZLISTs.cache[LineID] )
end
xZLISTs.ZLISTlist.OnRowRightClick = function( self, LineID, line )
	local menu = DermaMenu()
	menu:SetSkin(xgui.settings.skin)
	menu:AddOption( "Details...", function()
		if not line:IsValid() then return end
		xZLISTs.ShowZLISTDetailsWindow( xgui.data.ZLISTs.cache[LineID] )
	end )
	menu:AddOption( "Edit ZLIST...", function()
		if not line:IsValid() then return end
		xgui.ShowZLISTWindow( nil, line:GetValue( 5 ), nil, true, xgui.data.ZLISTs.cache[LineID] )
	end )
	menu:AddOption( "Remove", function()
		if not line:IsValid() then return end
		xZLISTs.RemoveZLIST( line:GetValue( 5 ), xgui.data.ZLISTs.cache[LineID] )
	end )
	menu:Open()
end
-- Change the column sorting method to hook into our own custom sort stuff.
xZLISTs.ZLISTlist.SortByColumn = function( self, ColumnID, Desc )
	local index =	ColumnID == 1 and 2 or	-- Sort by Name
					ColumnID == 2 and 4 or	-- Sort by Admin
					ColumnID == 3 and 6 or	-- Sort by UnZLIST Date
					ColumnID == 4 and 5 or	-- Sort by Reason
									  1		-- Otherwise sort by Date
	xZLISTs.sortbox:ChooseOptionID( index )
end

local searchFilter = ""
xZLISTs.searchbox = xlib.maketextbox{ x=5, y=6, w=175, text="Search...", selectall=true, parent=xZLISTs }
local txtCol = xZLISTs.searchbox:GetTextColor() or Color( 0, 0, 0, 255 )
xZLISTs.searchbox:SetTextColor( Color( txtCol.r, txtCol.g, txtCol.b, 196 ) ) -- Set initial color
xZLISTs.searchbox.OnChange = function( pnl )
	if pnl:GetText() == "" then
		pnl:SetText( "Search..." )
		pnl:SelectAll()
		pnl:SetTextColor( Color( txtCol.r, txtCol.g, txtCol.b, 196 ) )
	else
		pnl:SetTextColor( Color( txtCol.r, txtCol.g, txtCol.b, 255 ) )
	end
end
xZLISTs.searchbox.OnLoseFocus = function( pnl )
	if pnl:GetText() == "Search..." then
		searchFilter = ""
	else
		searchFilter = pnl:GetText()
	end
	xZLISTs.setPage( 1 )
	xZLISTs.retrieveZLISTs()
	hook.Call( "OnTextEntryLoseFocus", nil, pnl )
end

local sortMode = 0
local sortAsc = false
xZLISTs.sortbox = xlib.makecombobox{ x=185, y=6, w=150, text="Sort: Date (Desc.)", choices={ "Date", "Name", "Steam ID", "Admin", "Reason", "UnZLIST Date", "ZLIST Length" }, parent=xZLISTs }
function xZLISTs.sortbox:OnSelect( i, v )
	if i-1 == sortMode then
		sortAsc = not sortAsc
	else
		sortMode = i-1
		sortAsc = false
	end
	self:SetValue( "Sort: " .. v .. (sortAsc and " (Asc.)" or " (Desc.)") )
	xZLISTs.setPage( 1 )
	xZLISTs.retrieveZLISTs()
end

local hidePerma = 0
xlib.makebutton{ x=355, y=6, w=95, label="PermaZLISTs: Show", parent=xZLISTs }.DoClick = function( self )
	hidePerma = hidePerma + 1
	if hidePerma == 1 then
		self:SetText( "PermaZLISTs: Hide" )
	elseif hidePerma == 2 then
		self:SetText( "PermaZLISTs: Only" )
	elseif hidePerma == 3 then
		hidePerma = 0
		self:SetText( "PermaZLISTs: Show" )
	end
	xZLISTs.setPage( 1 )
	xZLISTs.retrieveZLISTs()
end

local hideIncomplete = 0
xlib.makebutton{ x=455, y=6, w=95, label="Incomplete: Show", parent=xZLISTs, tooltip="Filters ZLISTs that are loaded by ULib, but do not have any metadata associated with them." }.DoClick = function( self )
	hideIncomplete = hideIncomplete + 1
	if hideIncomplete == 1 then
		self:SetText( "Incomplete: Hide" )
	elseif hideIncomplete == 2 then
		self:SetText( "Incomplete: Only" )
	elseif hideIncomplete == 3 then
		hideIncomplete = 0
		self:SetText( "Incomplete: Show" )
	end
	xZLISTs.setPage( 1 )
	xZLISTs.retrieveZLISTs()
end


local function ZLISTUserList( doFreeze )
	local menu = DermaMenu()
	menu:SetSkin(xgui.settings.skin)
	for k, v in ipairs( player.GetAll() ) do
		menu:AddOption( v:Nick(), function()
			if not v:IsValid() then return end
			xgui.ShowZLISTWindow( v, v:SteamID(), doFreeze )
		end )
	end
	menu:AddSpacer()
	if LocalPlayer():query("ulx zlistid") then menu:AddOption( "ZLIST by STEAMID...", function() xgui.ShowZLISTWindow() end ) end
	menu:Open()
end

xlib.makebutton{ x=5, y=340, w=70, label="ZLIST...", parent=xZLISTs }.DoClick = function() ZLISTUserList( false ) end
--xZLISTs.btnFreezeZLIST = xlib.makebutton{ x=80, y=340, w=95, label="Freeze ZLIST...", parent=xZLISTs }
--xZLISTs.btnFreezeZLIST.DoClick = function() ZLISTUserList( true ) end

xZLISTs.infoLabel = xlib.makelabel{ x=204, y=344, label="Right-click on a ZLIST for more options", parent=xZLISTs }


xZLISTs.resultCount = xlib.makelabel{ y=344, parent=xZLISTs }
function xZLISTs.setResultCount( count )
	local pnl = xZLISTs.resultCount
	pnl:SetText( count .. " results" )
	pnl:SizeToContents()

	local width = pnl:GetWide()
	local x, y = pnl:GetPos()
	pnl:SetPos( 475 - width, y )

	local ix, iy = xZLISTs.infoLabel:GetPos()
	xZLISTs.infoLabel:SetPos( ( 130 - width ) / 2 + 175, y )
end

local numPages = 1
local pageNumber = 1
xZLISTs.pgleft = xlib.makebutton{ x=480, y=340, w=20, icon="icon16/arrow_left.png", centericon=true, disabled=true, parent=xZLISTs }
xZLISTs.pgleft.DoClick = function()
	xZLISTs.setPage( pageNumber - 1 )
	xZLISTs.retrieveZLISTs()
end
xZLISTs.pageSelector = xlib.makecombobox{ x=500, y=340, w=57, text="1", enableinput=true, parent=xZLISTs }
function xZLISTs.pageSelector:OnSelect( index )
	xZLISTs.setPage( index )
	xZLISTs.retrieveZLISTs()
end
function xZLISTs.pageSelector.TextEntry:OnEnter()
	pg = math.Clamp( tonumber( self:GetValue() ) or 1, 1, numPages )
	xZLISTs.setPage( pg )
	xZLISTs.retrieveZLISTs()
end
xZLISTs.pgright = xlib.makebutton{ x=557, y=340, w=20, icon="icon16/arrow_right.png", centericon=true, disabled=true, parent=xZLISTs }
xZLISTs.pgright.DoClick = function()
	xZLISTs.setPage( pageNumber + 1 )
	xZLISTs.retrieveZLISTs()
end

xZLISTs.setPage = function( newPage )
	pageNumber = newPage
	xZLISTs.pgleft:SetDisabled( pageNumber <= 1 )
	xZLISTs.pgright:SetDisabled( pageNumber >= numPages )
	xZLISTs.pageSelector.TextEntry:SetText( pageNumber )
end


function xZLISTs.RemoveZLIST( ID, ZLISTdata )
	local tempstr = "<Unknown>"
	if ZLISTdata then tempstr = ZLISTdata.name or "<Unknown>" end
	Derma_Query( "Are you sure you would like to unZLIST " .. tempstr .. " - " .. ID .. "?", "XGUI WARNING", 
		"Remove",	function()
						RunConsoleCommand( "ulx", "unZLIST", ID ) 
						xZLISTs.RemoveZLISTDetailsWindow( ID )
					end,
		"Cancel", 	function() end )
end

xZLISTs.openWindows = {}
function xZLISTs.RemoveZLISTDetailsWindow( ID )
	if xZLISTs.openWindows[ID] then
		xZLISTs.openWindows[ID]:Remove()
		xZLISTs.openWindows[ID] = nil
	end
end

function xZLISTs.ShowZLISTDetailsWindow( ZLISTdata )
	local wx, wy
	if xZLISTs.openWindows[ZLISTdata.steamID] then
		wx, wy = xZLISTs.openWindows[ZLISTdata.steamID]:GetPos()
		xZLISTs.openWindows[ZLISTdata.steamID]:Remove()
	end
	xZLISTs.openWindows[ZLISTdata.steamID] = xlib.makeframe{ label="ZLIST Details", x=wx, y=wy, w=285, h=295, skin=xgui.settings.skin }

	local panel = xZLISTs.openWindows[ZLISTdata.steamID]
	local name = xlib.makelabel{ x=50, y=30, label="Name:", parent=panel }
	xlib.makelabel{ x=90, y=30, w=190, label=( ZLISTdata.name or "<Unknown>" ), parent=panel, tooltip=ZLISTdata.name }
	xlib.makelabel{ x=36, y=50, label="SteamID:", parent=panel }
	xlib.makelabel{ x=90, y=50, label=ZLISTdata.steamID, parent=panel }
	xlib.makelabel{ x=33, y=70, label="ZLIST Date:", parent=panel }
	xlib.makelabel{ x=90, y=70, label=ZLISTdata.time and ( os.date( "%b %d, %Y - %I:%M:%S %p", tonumber( ZLISTdata.time ) ) ) or "<This ZLIST has no metadata>", parent=panel }
	xlib.makelabel{ x=20, y=90, label="UnZLIST Date:", parent=panel }
	xlib.makelabel{ x=90, y=90, label=( tonumber( ZLISTdata.unZLIST ) == 0 and "Never" or os.date( "%b %d, %Y - %I:%M:%S %p", math.min(  tonumber( ZLISTdata.unZLIST ), 4294967295 ) ) ), parent=panel }
	xlib.makelabel{ x=10, y=110, label="Length of ZLIST:", parent=panel }
	xlib.makelabel{ x=90, y=110, label=( tonumber( ZLISTdata.unZLIST ) == 0 and "Permanent" or xgui.ConvertTime( tonumber( ZLISTdata.unZLIST ) - ZLISTdata.time ) ), parent=panel }
	xlib.makelabel{ x=33, y=130, label="Time Left:", parent=panel }
	local timeleft = xlib.makelabel{ x=90, y=130, label=( tonumber( ZLISTdata.unZLIST ) == 0 and "N/A" or xgui.ConvertTime( tonumber( ZLISTdata.unZLIST ) - os.time() ) ), parent=panel }
	xlib.makelabel{ x=26, y=150, label="ZLISTned By:", parent=panel }
	if ZLISTdata.admin then xlib.makelabel{ x=90, y=150, label=string.gsub( ZLISTdata.admin, "%(STEAM_%w:%w:%w*%)", "" ), parent=panel } end
	if ZLISTdata.admin then xlib.makelabel{ x=90, y=165, label=string.match( ZLISTdata.admin, "%(STEAM_%w:%w:%w*%)" ), parent=panel } end
	xlib.makelabel{ x=41, y=185, label="Reason:", parent=panel }
	xlib.makelabel{ x=90, y=185, w=190, label=ZLISTdata.reason, parent=panel, tooltip=ZLISTdata.reason ~= "" and ZLISTdata.reason or nil }
	xlib.makelabel{ x=13, y=205, label="Last Updated:", parent=panel }
	xlib.makelabel{ x=90, y=205, label=( ( ZLISTdata.modified_time == nil ) and "Never" or os.date( "%b %d, %Y - %I:%M:%S %p", tonumber( ZLISTdata.modified_time ) ) ), parent=panel }
	xlib.makelabel{ x=21, y=225, label="Updated by:", parent=panel }
	if ZLISTdata.modified_admin then xlib.makelabel{ x=90, y=225, label=string.gsub( ZLISTdata.modified_admin, "%(STEAM_%w:%w:%w*%)", "" ), parent=panel } end
	if ZLISTdata.modified_admin then xlib.makelabel{ x=90, y=240, label=string.match( ZLISTdata.modified_admin, "%(STEAM_%w:%w:%w*%)" ), parent=panel } end

	panel.data = ZLISTdata	-- Store data on panel for future reference.
	xlib.makebutton{ x=5, y=265, w=89, label="Edit ZLIST...", parent=panel }.DoClick = function()
		xgui.ShowZLISTWindow( nil, panel.data.steamID, nil, true, panel.data )
	end

	xlib.makebutton{ x=99, y=265, w=89, label="UnZLIST", parent=panel }.DoClick = function()
		xZLISTs.RemoveZLIST( panel.data.steamID, panel.data )
	end

	xlib.makebutton{ x=192, y=265, w=88, label="Close", parent=panel }.DoClick = function()
		xZLISTs.RemoveZLISTDetailsWindow( panel.data.steamID )
	end

	panel.btnClose.DoClick = function ( button )
		xZLISTs.RemoveZLISTDetailsWindow( panel.data.steamID )
	end

	if timeleft:GetValue() ~= "N/A" then
		function panel.OnTimer()
			if panel:IsVisible() then
				local ZLISTtime = tonumber( panel.data.unZLIST ) - os.time()
				if ZLISTtime <= 0 then
					xZLISTs.RemoveZLISTDetailsWindow( panel.data.steamID )
					return
				else
					timeleft:SetText( xgui.ConvertTime( ZLISTtime ) )
				end
				timeleft:SizeToContents()
				timer.Simple( 1, panel.OnTimer )
			end
		end
		panel.OnTimer()
	end
end

function xgui.ShowZLISTWindow( ply, ID, doFreeze, isUpdate, ZLISTdata )
	if not LocalPlayer():query( "ulx ZLIST" ) and not LocalPlayer():query( "ulx zlistid" ) then return end

	local xgui_ZLISTwindow = xlib.makeframe{ label=( isUpdate and "Edit ZLIST" or "ZLIST Player" ), w=285, h=180, skin=xgui.settings.skin }
	xlib.makelabel{ x=37, y=33, label="Name:", parent=xgui_ZLISTwindow }
	xlib.makelabel{ x=23, y=58, label="SteamID:", parent=xgui_ZLISTwindow }
	xlib.makelabel{ x=28, y=83, label="Reason:", parent=xgui_ZLISTwindow }
	xlib.makelabel{ x=10, y=108, label="ZLIST Length:", parent=xgui_ZLISTwindow }
	local reason = xlib.makecombobox{ x=75, y=80, w=200, parent=xgui_ZLISTwindow, enableinput=true, selectall=true, choices=ULib.cmds.translatedCmds["ulx zlist"].args[4].completes }
	local ZLISTpanel = ULib.cmds.NumArg.x_getcontrol( ULib.cmds.translatedCmds["ulx zlist"].args[3], 2, xgui_ZLISTwindow )
	ZLISTpanel.interval:SetParent( xgui_ZLISTwindow )
	ZLISTpanel.interval:SetPos( 200, 105 )
	ZLISTpanel.val:SetParent( xgui_ZLISTwindow )
	ZLISTpanel.val:SetPos( 75, 125 )
	ZLISTpanel.val:SetWidth( 200 )

	local name
	if not isUpdate then
		name = xlib.makecombobox{ x=75, y=30, w=200, parent=xgui_ZLISTwindow, enableinput=true, selectall=true }
		for k,v in pairs( player.GetAll() ) do
			name:AddChoice( v:Nick(), v:SteamID() )
		end
		name.OnSelect = function( self, index, value, data )
			self.steamIDbox:SetText( data )
		end
	else
		name = xlib.maketextbox{ x=75, y=30, w=200, parent=xgui_ZLISTwindow, selectall=true }
		if ZLISTdata then
			name:SetText( ZLISTdata.name or "" )
			reason:SetText( ZLISTdata.reason or "" )
			if tonumber( ZLISTdata.unZLIST ) ~= 0 then
				local btime = ( tonumber( ZLISTdata.unZLIST ) - tonumber( ZLISTdata.time ) )
				if btime % 31536000 == 0 then
					if #ZLISTpanel.interval.Choices >= 6 then
						ZLISTpanel.interval:ChooseOptionID(6)
					else
						ZLISTpanel.interval:SetText( "Years" )
					end
					btime = btime / 31536000
				elseif btime % 604800 == 0 then
					if #ZLISTpanel.interval.Choices >= 5 then
						ZLISTpanel.interval:ChooseOptionID(5)
					else
						ZLISTpanel.interval:SetText( "Weeks" )
					end
					btime = btime / 604800
				elseif btime % 86400 == 0 then
					if #ZLISTpanel.interval.Choices >= 4 then
						ZLISTpanel.interval:ChooseOptionID(4)
					else
						ZLISTpanel.interval:SetText( "Days" )
					end
					btime = btime / 86400
				elseif btime % 3600 == 0 then
					if #ZLISTpanel.interval.Choices >= 3 then
						ZLISTpanel.interval:ChooseOptionID(3)
					else
						ZLISTpanel.interval:SetText( "Hours" )
					end
					btime = btime / 3600
				else
					btime = btime / 60
					if #ZLISTpanel.interval.Choices >= 2 then
						ZLISTpanel.interval:ChooseOptionID(2)
					else
						ZLISTpanel.interval:SetText( "Minutes" )
					end
				end
				ZLISTpanel.val:SetValue( btime )
			end
		end
	end

	local steamID = xlib.maketextbox{ x=75, y=55, w=200, selectall=true, disabled=( isUpdate or not LocalPlayer():query( "ulx zlistid" ) ), parent=xgui_ZLISTwindow }
	name.steamIDbox = steamID --Make a reference to the steamID textbox so it can change the value easily without needing a global variable

	if doFreeze and ply then
		if LocalPlayer():query( "ulx freeze" ) then
			RunConsoleCommand( "ulx", "freeze", "$" .. ULib.getUniqueIDForPlayer( ply ) )
			steamID:SetDisabled( true )
			name:SetDisabled( true )
			xgui_ZLISTwindow:ShowCloseButton( false )
		else
			doFreeze = false
		end
	end
	xlib.makebutton{ x=165, y=150, w=75, label="Cancel", parent=xgui_ZLISTwindow }.DoClick = function()
		if doFreeze and ply and ply:IsValid() then
			RunConsoleCommand( "ulx", "unfreeze", "$" .. ULib.getUniqueIDForPlayer( ply ) )
		end
		xgui_ZLISTwindow:Remove()
	end
	xlib.makebutton{ x=45, y=150, w=75, label=( isUpdate and "Update" or "ZLIST!" ), parent=xgui_ZLISTwindow }.DoClick = function()
		if isUpdate then
			local function performUpdate(btime)
				RunConsoleCommand( "xgui", "updateZLIST", steamID:GetValue(), btime, reason:GetValue(), name:GetValue() )
				xgui_ZLISTwindow:Remove()
			end
			btime = ZLISTpanel:GetMinutes()
			if btime ~= 0 and ZLISTdata and btime * 60 + ZLISTdata.time < os.time() then
				Derma_Query( "WARNING! The new ZLIST time you have specified will cause this ZLIST to expire.\nThe minimum time required in order to change the ZLIST length successfully is " 
						.. xgui.ConvertTime( os.time() - ZLISTdata.time ) .. ".\nAre you sure you wish to continue?", "XGUI WARNING",
					"Expire ZLIST", function()
						performUpdate(btime)
						xZLISTs.RemoveZLISTDetailsWindow( ZLISTdata.steamID )
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
					RunConsoleCommand( "ulx", "zlistid", steamID:GetValue(), ZLISTpanel:GetValue(), reason:GetValue() )
				else
					RunConsoleCommand( "xgui", "updateZLIST", steamID:GetValue(), ZLISTpanel:GetMinutes(), reason:GetValue(), ( name:GetValue() ~= "" and name:GetValue() or nil ) )
				end
			else
				RunConsoleCommand( "ulx", "ZLIST", "$" .. ULib.getUniqueIDForPlayer( isOnline ), ZLISTpanel:GetValue(), reason:GetValue() )
			end
			xgui_ZLISTwindow:Remove()
		else
			local ply, message = ULib.getUser( name:GetValue() )
			if ply then
				RunConsoleCommand( "ulx", "ZLIST", "$" .. ULib.getUniqueIDForPlayer( ply ), ZLISTpanel:GetValue(), reason:GetValue() )
				xgui_ZLISTwindow:Remove()
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
function xZLISTs.ZLISTsRefreshed()
	xgui.data.ZLISTs.cache = {} -- Clear the ZLISTs cache

	-- Retrieve ZLISTs if XGUI is open, otherwise it will be loaded later.
	if xgui.anchor:IsVisible() then
		xZLISTs.retrieveZLISTs()
	end
end
xgui.hookEvent( "ZLISTs", "process", xZLISTs.ZLISTsRefreshed, "ZLISTsRefresh" )

function xZLISTs.ZLISTPageRecieved( data )
	xgui.data.ZLISTs.cache = data
	xZLISTs.clearZLISTs()
	xZLISTs.populateZLISTs()
end
xgui.hookEvent( "ZLISTs", "data", xZLISTs.ZLISTPageRecieved, "ZLISTsGotPage" )

function xZLISTs.checkCache()
	if xgui.data.ZLISTs.cache and xgui.data.ZLISTs.count ~= 0 and table.Count(xgui.data.ZLISTs.cache) == 0 then
		xZLISTs.retrieveZLISTs()
	end
end
xgui.hookEvent( "onOpen", nil, xZLISTs.checkCache, "ZLISTsCheckCache" )

function xZLISTs.clearZLISTs()
	xZLISTs.ZLISTlist:Clear()
end

function xZLISTs.retrieveZLISTs()
	RunConsoleCommand( "xgui", "getZLISTs",
		sortMode,			-- Sort Type
		searchFilter,		-- Filter String
		hidePerma,			-- Hide permaZLISTs?
		hideIncomplete,		-- Hide ZLISTs that don't have full ULX metadata?
		pageNumber,			-- Page number
		sortAsc and 1 or 0)	-- Ascending/Descending
end

function xZLISTs.populateZLISTs()
	if xgui.data.ZLISTs.cache == nil then return end
	local cache = xgui.data.ZLISTs.cache
	local count = cache.count or xgui.data.ZLISTs.count
	numPages = math.max( 1, math.ceil( count / 17 ) )

	xZLISTs.setResultCount( count )
	xZLISTs.pageSelector:SetDisabled( numPages == 1 )
	xZLISTs.pageSelector:Clear()
	for i=1, numPages do
		xZLISTs.pageSelector:AddChoice(i)
	end
	xZLISTs.setPage( math.Clamp( pageNumber, 1, numPages ) )

	cache.count = nil

	for _, ZLISTinfo in pairs( cache ) do
		xZLISTs.ZLISTlist:AddLine( ZLISTinfo.name or ZLISTinfo.steamID,
					( ZLISTinfo.admin ) and string.gsub( ZLISTinfo.admin, "%(STEAM_%w:%w:%w*%)", "" ) or "",
					(( tonumber( ZLISTinfo.unZLIST ) ~= 0 ) and os.date( "%c", math.min( tonumber( ZLISTinfo.unZLIST ), 4294967295 ) )) or "Never",
					ZLISTinfo.reason,
					ZLISTinfo.steamID,
					tonumber( ZLISTinfo.unZLIST ) )
	end
end
xZLISTs.populateZLISTs() --For autorefresh

function xZLISTs.xZLIST( ply, cmd, args, dofreeze )
	if args[1] and args[1] ~= "" then
		local target = ULib.getUser( args[1] )
		if target then
			xgui.ShowZLISTWindow( target, target:SteamID(), dofreeze )
		end
	else
		xgui.ShowZLISTWindow()
	end
end
ULib.cmds.addCommandClient( "xgui xZLIST", xZLISTs.xZLIST )

function xZLISTs.fZLIST( ply, cmd, args )
	xZLISTs.xZLIST( ply, cmd, args, true )
end
ULib.cmds.addCommandClient( "xgui fZLIST", xZLISTs.fZLIST )



xgui.addModule( "ZLISTs", xZLISTs, "icon16/add.png", "xgui_manageZLISTs" )

