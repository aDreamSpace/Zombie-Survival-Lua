local SimpleXP_Red = CreateClientConVar( "cl_lvl_color_r", tostring(SimpleXPConfig.DefaultRed), true, false )
local SimpleXP_Green =CreateClientConVar( "cl_lvl_color_g", tostring(SimpleXPConfig.DefaultGreen), true, false )
local SimpleXP_Blue =CreateClientConVar( "cl_lvl_color_b", tostring(SimpleXPConfig.DefaultBlue), true, false )
local SimpleXP_Alpha =CreateClientConVar( "cl_lvl_color_a", tostring(SimpleXPConfig.DefaultAlpha), true, false )

function OnSucessfullyLoaded()
	if SimpleXPConfig.DisplayTargetXP == true then
		function GAMEMODE:HUDDrawTargetID()
		end
	end
end

hook.Add("OnGamemodeLoaded","Gamemode Loaded",OnSucessfullyLoaded)

local TargetFade = 0
local LastTarget = LocalPlayer()

function CustomTargetID()
	if SimpleXPConfig.DisplayTargetXP == true then
	
		local x = ScrW()
		local y = ScrH()	
		
		local TraceData = {
			start = EyePos(),
			endpos = EyePos() + EyeAngles():Forward()*1000000,
			filter = LocalPlayer(),
			mask = MASK_SHOT,
			ignoreworld = false,
		}
		
		local Trace = util.TraceLine(TraceData)
		
		local Target = Trace.Entity

		if Target and Target:IsPlayer() then
			LastTarget = Target
			TargetFade = math.Clamp(TargetFade + FrameTime()*10,0,1)
		else
			TargetFade = math.Clamp(TargetFade - FrameTime()*10,0,1)
		end
		
	end
end

hook.Add("HUDDrawTargetID","Custom Target ID",CustomTargetID)

local XPTable = {}
local NextRemoveXP = 0
local NextRemoveLVL = 0

net.Receive( "SimpleXPSendInfo", function( len )

	local ply = LocalPlayer()
	local Data = net.ReadTable()

	for k,v in pairs(Data) do
	
		local FoundID = nil
		
		for l,b in pairs(XPTable) do
			if v.message == b.message then
				--print("FOUND")
				FoundID = l
			end
		end
		
		if FoundID then
			XPTable[FoundID].xp = XPTable[FoundID].xp + v.xp
		else
			table.Add(XPTable,{v})
		end
		
	end
		


	NextRemoveXP = RealTime() + (10 / #XPTable)
	
end )

net.Receive( "SimpleXPSendLevelChange", function( len )

	local PlayerThatLeveled = net.ReadEntity()
	local PlayerOldLevel = net.ReadInt(32)
	local PlayerNewLevel = net.ReadInt(32)

	if PlayerThatLeveled == LocalPlayer() then
		LocalPlayer():EmitSound("garrysmod/save_load4.wav")
		NextRemoveLVL = RealTime() + 5
	end

end )

function SimpleXPGetHUDColor()
	return  Color(SimpleXP_Red:GetFloat(),SimpleXP_Green:GetFloat(),SimpleXP_Blue:GetFloat(),SimpleXP_Alpha:GetFloat())
end

local StoredXP = nil

local BarFade = 0
local NotificationsFade = 0

function SimpleXPDrawHUD()

	local ply = LocalPlayer()
	local HudColor = SimpleXPGetHUDColor()
	if not SimpleXPConfig.UseFixedColors then
		HudColor = team.GetColor(ply:Team())
	end
	local Delay = math.min(1 + (1 / #XPTable),1)
	if not StoredXP then
		StoredXP = SimpleXPGetXP(ply)
	end
	
	local Mul = 1
	local CurrentXP = SimpleXPGetXP(ply) or 0
	local CurrentLevel = SimpleXPCalculateXPToLevel(StoredXP)
	local NextXP = SimpleXPCalculateLevelToXP(CurrentLevel + 1)
	local LastXP = SimpleXPCalculateLevelToXP(CurrentLevel)
	local Number01 = math.floor(StoredXP - LastXP)
	local Number02 = NextXP - LastXP
	local CalcPercent = (CurrentXP - LastXP) / Number02
	local Percent = Number01 / Number02
	local bottom = SimpleXPConfig.HUD_Flip or false
	local xscale = SimpleXPConfig.HUD_Length or 1
	local yscale = SimpleXPConfig.HUD_Pos or 1
	local xsize = ScrW() * xscale
	local ysize = 8
	local x = ScrW() * (1 - xscale) * 0.5
	local y = ScrH()*yscale - ysize
	local BottomMul = 1
	if bottom then 
		BottomMul = -0.5
	end
	
	local ShouldHideTarget = hook.Call("SimpleXPShouldHideTarget")
	local ShouldHideBar = hook.Call("SimpleXPShouldHideBar")
	local ShouldHideNotifications = hook.Call("SimpleXPShouldHideNotifications")
	
	if not ShouldHideTarget then
		BarFade = math.Clamp(BarFade + FrameTime(),0,1)
	else
		BarFade = math.Clamp(BarFade - FrameTime(),0,1)
	end
	
	if BarFade > 0 and TargetFade > 0 then
		if IsValid(LastTarget) and LastTarget:IsPlayer() then
			local Name = LastTarget:Nick()
		
			local TeamColor = team.GetColor(LastTarget:Team())
			local TargColor = Color(TeamColor.r,TeamColor.g,TeamColor.b,TargetFade*BarFade*255)
			
			draw.DrawText(Name, "TargetID", ScrW() * 0.5, ScrH() * 0.50 + 40, TargColor, TEXT_ALIGN_CENTER )
			draw.DrawText(math.max(0,LastTarget:Health()) .."%", "TargetID", ScrW() * 0.5, ScrH() * 0.50 + 60, TargColor, TEXT_ALIGN_CENTER )
			draw.DrawText(SimpleXPCheckRank(SimpleXPGetLevel(LastTarget)), "TargetID", ScrW() * 0.5, ScrH() * 0.50 + 80, TargColor, TEXT_ALIGN_CENTER )
		end
	end

	if !ShouldHideNotifications then
		NotificationsFade = math.Clamp(NotificationsFade + FrameTime(),0,1)
	else
		NotificationsFade = math.Clamp(NotificationsFade - FrameTime(),0,1)
	end
	
	if NotificationsFade > 0 and #XPTable > 0 then
		for k,v in pairs(XPTable) do
	
			local GlobalTimer = math.Clamp( ((NextRemoveXP - RealTime())*4)/Delay,0,1)
		
			local Mul = 1
		
			if k == 1 then
				local Math = GlobalTimer
				Mul = Math
			end
			
			Mul = Mul * NotificationsFade
			
			local FullMessage = v.message ..  ": " .. v.xp .. " XP"
		
			-- Change the position here:
			draw.DrawText(FullMessage, "TargetID", ScrW() - 100, (ScrH() * 0.85) + (k+(GlobalTimer))*(20), Color( HudColor.r, HudColor.g, HudColor.b, (255 - k*HudColor.a*0.1)*Mul ), TEXT_ALIGN_RIGHT )
		end
	end

	if NextRemoveXP <= RealTime() then
		if #XPTable > 0 then
			table.remove(XPTable,1)
		end
		
		NextRemoveXP = RealTime() + Delay
	end

	--[[
	if CurrentXP > StoredXP then
		if CurrentXP - StoredXP >= 500 then
			Mul = (CurrentXP - StoredXP) * 0.01
		end
		StoredXP = math.min(CurrentXP,StoredXP + (FrameTime() * 200 * Mul))
	elseif CurrentXP < StoredXP then
		if StoredXP - CurrentXP >= 500 then
			Mul = (StoredXP - CurrentXP) * 0.01
		end
		StoredXP = math.max(CurrentXP,StoredXP - (FrameTime() * 200 * Mul))
	end
	--]]
	
	StoredXP = StoredXP + (CurrentXP - StoredXP)*FrameTime()
	
	if CurrentLevel >= SimpleXPConfig.LevelCap then
		Percent = 1
	end
	
	if !ShouldHideBar then
		BarFade = math.Clamp(BarFade + FrameTime(),0,1)
	else
		BarFade = math.Clamp(BarFade - FrameTime(),0,1)
	end
	
	if BarFade > 0 then
	
		local HudColor = Color(HudColor.r,HudColor.g,HudColor.b,HudColor.a*BarFade)
	
		draw.RoundedBox(0,x,y,xsize,ysize,Color(HudColor.r,HudColor.g,HudColor.b,HudColor.a*0.2))
		draw.RoundedBox(0,x,y,xsize*CalcPercent,ysize,Color(HudColor.r,HudColor.g,HudColor.b,HudColor.a*0.2))
		draw.RoundedBox(0,x,y,xsize*Percent,ysize,Color(HudColor.r,HudColor.g,HudColor.b,HudColor.a))
	
		if CurrentLevel < SimpleXPConfig.LevelCap then
			draw.DrawText(Number01.. "XP / " .. Number02 .. "XP" , "TargetID", ScrW() * 0.5, y - 20*BottomMul, HudColor, TEXT_ALIGN_CENTER )
		else
			draw.DrawText(SimpleXPCheckRank(CurrentLevel) , "TargetID", ScrW() * 0.5, y - 20*BottomMul, HudColor, TEXT_ALIGN_CENTER )
		end

		if CurrentLevel < SimpleXPConfig.LevelCap then
			draw.DrawText(SimpleXPCheckRank(CurrentLevel), "TargetID", x, y - 20*BottomMul, HudColor, TEXT_ALIGN_LEFT )
			draw.DrawText(SimpleXPCheckRank(CurrentLevel + 1), "TargetID", x + xsize, y - 20*BottomMul, HudColor, TEXT_ALIGN_RIGHT)
		end
	end
		
	if NextRemoveLVL > RealTime() then
		draw.DrawText("RANK UP:", "TargetID", ScrW() * 0.5, ScrH() * 0.4, HudColor, TEXT_ALIGN_CENTER )
		draw.DrawText(SimpleXPCheckRank(SimpleXPGetLevel(ply)), "TargetID", ScrW() * 0.5, ScrH() * 0.4 + 20, HudColor, TEXT_ALIGN_CENTER )
	end
	
end

hook.Add("HUDPaintBackground","Burger Level Draw HUD",SimpleXPDrawHUD)

function SimpleXPPrintLevelsTo(level)

	local Start = 1
	local Count = SimpleXPConfig.LevelCap
	
	if Count > 100 then
		Start = math.max(1,SimpleXPGetLevel(LocalPlayer()) - 50)
		Count = 100
	end
	
	print("----------------------------------------------------------------------")
	for i=1, SimpleXPConfig.LevelCap do
		local Calc = SimpleXPCalculateLevelToXP(i)
		print("Level " .. i .. ", ",Calc .. "xp, ",SimpleXPCheckRank(i))
	end
	print("----------------------------------------------------------------------")
	
end

function SimpleXPPlayerChat(ply,text,teamChat,isDead)

	if ply == LocalPlayer() then

		local Explode = string.Explode(" ",text)

		if #Explode > 0 then
			if Explode[1] == "!levels" then
				chat.AddText(Color(255,255,255,255),"Information printed to console.")
				SimpleXPPrintLevelsTo(100)
				return true
			elseif Explode[1] == "!xphud" then
				SimpleXPShowDerma()
				return true
			elseif Explode[1] == "!xp" then
			
				local White = Color(255,255,255,255)
				local Yellow = Color(255,255,0,255)
			
				for k,v in pairs(player.GetAll()) do			
					local TeamColor = team.GetColor(v:Team())				
					chat.AddText(TeamColor,v:Nick(),White," is ",TeamColor,SimpleXPCheckRank(SimpleXPGetLevel(v)),White,"(",tostring(SimpleXPGetXP(v)),"XP)")
				end

				return true
			end
		end
		
	end

end

hook.Add("OnPlayerChat","Burger Level Player Chat",SimpleXPPlayerChat)

function SimpleXPLeaderboards()

	local XSize = ScrW()*0.5
	local YSize = ScrH()*0.5
	
	local YOffset = 25
	
	local BaseFrame = vgui.Create("DFrame")
	BaseFrame:SetSize(XSize,YSize + YOffset*2)
	BaseFrame:Center()
	BaseFrame:MakePopup()
	
	local ScrollBar = vgui.Create("DScrollPanel",BaseFrame)
	ScrollBar:SetPos(0,0)
	ScrollBar:StretchToParent( 0, 25, 0, 0 )
	
	local Players = {}
	
	for i,ply in pairs(player.GetAll()) do
		Players[ply] = SimpleXPGetXP(ply)
	end
	
	table.SortByKey(Players)
	
	local Num = 0
	
	for k,v in pairs(Players) do
	
		local BasePanel = vgui.Create("DPanel",ScrollBar)
		BasePanel:SetPos(YOffset + 0,YOffset + Num*(128+5))
		BasePanel:SetSize(XSize - YOffset*2,128)

		if k then
		
			local Name = vgui.Create( "DLabel", BasePanel)
			Name:SetPos(128 + 10, 0)
			Name:SetText( k:Name() )
			Name:SetFont("DermaLarge")
			Name:SetDark(true)
			Name:SizeToContents()

			local Avatar = vgui.Create( "AvatarImage", BasePanel )
			Avatar:SetSize( 128, 128 )
			Avatar:SetPos( 0, 0 )
			Avatar:SetPlayer( k, 128 )
			 
		end
		
		Num = Num + 1
		
	end

end

local NextAnnoy  = 0

function SimpleXPChatThink()

	if NextAnnoy <= RealTime() then
	
		if SimpleXPConfig.DisplayHints == true then
			local White = Color(255,255,255,255)
			local Green = Color(0,255,0,255)
		
			chat.AddText(White,"This server has ",Green,"Simple XP ",White,"Installed.")
			chat.AddText(White,"Type ",Green,"!xp ",White,"in chat to view all player's current XP.")
			chat.AddText(White,"Type ",Green,"!xphud ",White,"in chat to edit the current XP hud color.")
		end
	
		NextAnnoy = RealTime() + 1200
	end


end

hook.Add("Think","Burger Level Chat Annoy",SimpleXPChatThink)

function SimpleXPShowDerma()

	local MenuBase = vgui.Create("DFrame")
		MenuBase:SetSize(270,360)
		MenuBase:SetPos(0,0)
		MenuBase:SetTitle("SimpleXP Colors")
		MenuBase:SetDeleteOnClose(false)
		MenuBase:SetDraggable( true )
		MenuBase:SetBackgroundBlur(false)
		MenuBase:Center(true)
		MenuBase:SetVisible( true )
		MenuBase.Paint = function()
			draw.RoundedBox( 8, 0, 0, MenuBase:GetWide(), MenuBase:GetTall(), SimpleXPGetHUDColor() )
		end
		MenuBase:MakePopup()	
	
	local Mixer = vgui.Create( "DColorMixer", MenuBase )
		Mixer:SetPos( 5,30 )
		Mixer:SizeToContents()
		Mixer:SetPalette( true )
		Mixer:SetAlphaBar( true )
		Mixer:SetWangs( true )
		Mixer:SetColor( SimpleXPGetHUDColor() )
	
	local ColorButton = vgui.Create( "DButton", MenuBase )
		ColorButton:SetPos( 10, 290 )
		ColorButton:SetSize( 250, 30 )
		ColorButton:SetText( "Apply Color" )
		ColorButton.DoClick = function()
			local col = Mixer:GetColor()
			RunConsoleCommand("cl_lvl_color_r",col.r)
			RunConsoleCommand("cl_lvl_color_g",col.g)
			RunConsoleCommand("cl_lvl_color_b",col.b)
			RunConsoleCommand("cl_lvl_color_a",col.a)
		end

	MenuBase:SizeToContents()
		
end

concommand.Add("lvl_color", SimpleXPShowDerma)