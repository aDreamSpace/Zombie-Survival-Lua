local ScoreBoard
function GM:ScoreboardShow()
	gui.EnableScreenClicker(true)
	PlayMenuOpenSound()

	if not ScoreBoard then
		ScoreBoard = vgui.Create("ZSScoreBoard")
	end

	ScoreBoard:SetSize(math.min(ScrW(), ScrH()) * 1.3, ScrH() * 0.8)
	ScoreBoard:AlignTop(ScrH() * 0.05)
	ScoreBoard:CenterHorizontal()
	ScoreBoard:SetVisible(true)
end

function GM:ScoreboardHide()
	gui.EnableScreenClicker(false)

	if ScoreBoard then
		PlayMenuCloseSound()
		ScoreBoard:SetVisible(false)
	end
end

local PANEL = {}

PANEL.RefreshTime = 3
PANEL.NextRefresh = 0
PANEL.m_MaximumScroll = 0

local function BlurPaint(self)
	draw.SimpleTextBlur(self:GetValue(), self.Font, 0, 0, self:GetTextColor())

	return true
end
local function emptypaint(self)
	return true
end

function PANEL:Init()
	self.NextRefresh = RealTime() + 0.1

	self.m_TitleLabel = vgui.Create("DLabel", self)
	self.m_TitleLabel.Font = "ZSScoreBoardTitle"
	self.m_TitleLabel:SetFont(self.m_TitleLabel.Font)
	self.m_TitleLabel:SetText(GAMEMODE.Name)
	self.m_TitleLabel:SetTextColor(COLOR_ORANGE)
	self.m_TitleLabel:SizeToContents()
	self.m_TitleLabel:NoClipping(true)
	self.m_TitleLabel.Paint = BlurPaint

	self.m_ServerNameLabel = vgui.Create("DLabel", self)
	self.m_ServerNameLabel.Font = "ZSScoreBoardSubTitle"
	self.m_ServerNameLabel:SetFont(self.m_ServerNameLabel.Font)
	self.m_ServerNameLabel:SetText(GetHostName())
	self.m_ServerNameLabel:SetTextColor(COLOR_ORANGE)
	self.m_ServerNameLabel:SizeToContents()
	self.m_ServerNameLabel:NoClipping(true)
	self.m_ServerNameLabel.Paint = BlurPaint

	--self.m_AuthorLabel = EasyLabel(self, "by "..GAMEMODE.Author.." ("..GAMEMODE.Email..")", "DefaultFontSmall", COLOR_GRAY)
	--self.m_ContactLabel = EasyLabel(self, GAMEMODE.Website, "DefaultFontSmall", COLOR_GRAY)

	self.m_HumanHeading = vgui.Create("DTeamHeading", self)
	self.m_HumanHeading:SetTeam(TEAM_HUMAN)

	self.m_ZombieHeading = vgui.Create("DTeamHeading", self)
	self.m_ZombieHeading:SetTeam(TEAM_UNDEAD)

	self.ZombieList = vgui.Create("DScrollPanel", self)
	self.ZombieList.Team = TEAM_UNDEAD
	self.ZombieList.Paint = function() end

	self.HumanList = vgui.Create("DScrollPanel", self)
	self.HumanList.Team = TEAM_HUMAN
	self.HumanList.Paint = function() end
	self:InvalidateLayout()
end

function PANEL:PerformLayout()
	--self.m_AuthorLabel:MoveBelow(self.m_TitleLabel)
	--self.m_ContactLabel:MoveBelow(self.m_AuthorLabel)
	self.m_TitleLabel:SetPos(self.m_TitleLabel:GetWide() / 2, 16)
	self.m_ServerNameLabel:SetPos(math.min(self:GetWide() - self.m_ServerNameLabel:GetWide(), self:GetWide() * 0.75 - self.m_ServerNameLabel:GetWide() * 0.5), 32 - self.m_ServerNameLabel:GetTall() / 2)

	self.m_HumanHeading:SetSize(self:GetWide() / 2 - 32, 40) -- Increase the height to 40
	self.m_HumanHeading:SetPos(self:GetWide() * 0.25 - self.m_HumanHeading:GetWide() * 0.5, 110 - self.m_HumanHeading:GetTall())

	self.m_ZombieHeading:SetSize(self:GetWide() / 2 - 32, 40) -- Increase the height to 40
	self.m_ZombieHeading:SetPos(self:GetWide() * 0.75 - self.m_ZombieHeading:GetWide() * 0.5, 110 - self.m_ZombieHeading:GetTall())

	local humanListWidth = self:GetWide() / 2 - 24
	local humanListHeight = self:GetTall() - 150
	self.HumanList:SetSize(humanListWidth, humanListHeight)
	self.HumanList:AlignBottom(16)
	self.HumanList:AlignLeft(8)

	local zombieListWidth = self:GetWide() / 2 - 24
	local zombieListHeight = self:GetTall() - 150
	self.ZombieList:SetSize(zombieListWidth, zombieListHeight)
	self.ZombieList:AlignBottom(16)
	self.ZombieList:AlignRight(8)
end

function PANEL:Think()
	if RealTime() >= self.NextRefresh then
		self.NextRefresh = RealTime() + self.RefreshTime
		self:Refresh()
	end
end

local texRightEdge = surface.GetTextureID("gui/gradient")
local texCorner = surface.GetTextureID("zombiesurvival/circlegradient")
local texDownEdge = surface.GetTextureID("gui/gradient_down")
function PANEL:Paint()
	local wid, hei = self:GetSize()
	local barw = 64

	surface.SetDrawColor(61, 0, 90, 180)
	--surface.DrawRect(0, 64, wid, hei - 64)
	surface.SetDrawColor(61, 0, 90, 180)
	--surface.DrawOutlinedRect(0, 64, wid, hei - 64)

	surface.SetDrawColor(46, 1, 66, 250)
	--PaintGenericFrame(self, 0, 0, wid, 64, 32)
	surface.DrawRect(0, 0, wid, 64)

	--surface.SetDrawColor(5, 5, 5, 160)
	--surface.DrawRect(wid * 0.5 - 16, 64, 32, hei - 128)
	--surface.SetTexture(texRightEdge)
	--surface.DrawTexturedRect(wid * 0.5 + 16, 64, barw, hei - 128)
	--surface.DrawTexturedRectRotated(wid * 0.5 - 16 - barw / 2, 64 + (hei - 128) / 2, barw, hei - 128, 180)
	--surface.SetTexture(texCorner)
	--surface.DrawTexturedRectRotated(wid * 0.5 - 16 - barw / 2, hei - 32, barw, 64, 90)
	--surface.DrawTexturedRectRotated(wid * 0.5 + 16 + barw / 2, hei - 32, barw, 64, 180)
	--surface.SetTexture(texDownEdge)
	--surface.DrawTexturedRect(wid * 0.5 - 16, hei - 64, 32, 64)
end

function PANEL:GetPlayerPanel(pl)
	for _, panel in pairs(self.PlayerPanels) do
		if panel:Valid() and panel:GetPlayer() == pl then
			return panel
		end
	end
end

function PANEL:CreatePlayerPanel(pl)
	local curpan = self:GetPlayerPanel(pl)
	if curpan and curpan:Valid() then return curpan end

	if pl:Team() == TEAM_SPECTATOR then return end

	local panel = vgui.Create("ZSPlayerPanel", pl:Team() == TEAM_UNDEAD and self.ZombieList or self.HumanList)
	panel:SetPlayer(pl)
	panel:Dock(TOP)
	panel:DockMargin(8, 2, 8, 2)

	self.PlayerPanels[pl] = panel

	return panel
end

function PANEL:Refresh()
	self.m_ServerNameLabel:SetText(GetHostName())
	self.m_ServerNameLabel:SizeToContents()
	self.m_ServerNameLabel:SetPos(math.min(self:GetWide() - self.m_ServerNameLabel:GetWide(), self:GetWide() * 0.75 - self.m_ServerNameLabel:GetWide() * 0.5), 32 - self.m_ServerNameLabel:GetTall() / 2)

	if self.PlayerPanels == nil then self.PlayerPanels = {} end

	for pl, panel in pairs(self.PlayerPanels) do
		if not panel:Valid() or pl:IsValid() and pl:IsSpectator() then
			self:RemovePlayerPanel(panel)
		end
	end

	for _, pl in pairs(player.GetAllActive()) do
		self:CreatePlayerPanel(pl)
	end
end

function PANEL:RemovePlayerPanel(panel)
	if panel:Valid() then
		self.PlayerPanels[panel:GetPlayer()] = nil
		panel:Remove()
	end
end

vgui.Register("ZSScoreBoard", PANEL, "Panel")

local PANEL = {}

PANEL.RefreshTime = 1

PANEL.m_Player = NULL
PANEL.NextRefresh = 0

local function MuteDoClick(self)
	local pl = self:GetParent():GetPlayer()
	if pl:IsValid() then
		--pl:SetMuted(not pl:IsMuted())
		if pl.m_TabMuted == nil then pl.m_TabMuted = false end

		local newstate = not pl.m_TabMuted
		net.Start("zs_servertabmute")
			net.WriteString(pl:SteamID())
			net.WriteBool(newstate)
		net.SendToServer()
		pl.m_TabMuted = newstate

		self:GetParent().NextRefresh = RealTime()
	end
end

local function AvatarDoClick(self)
	local pl = self.PlayerPanel:GetPlayer()
	if pl:IsValid() and pl:IsPlayer() then
		pl:ShowProfile()
	end
end

local function empty() end

function PANEL:Init()
	self:SetTall(64)

	self.m_AvatarButton = self:Add("DButton", self)
	self.m_AvatarButton:SetText(" ")
	self.m_AvatarButton:SetSize(64, 64)
	self.m_AvatarButton:Center()
	self.m_AvatarButton.DoClick = AvatarDoClick
	self.m_AvatarButton.Paint = empty
	self.m_AvatarButton.PlayerPanel = self

	self.m_Avatar = vgui.Create("AvatarImage", self.m_AvatarButton)
	self.m_Avatar:SetSize(64, 64)
	self.m_Avatar:SetVisible(false)
	self.m_Avatar:SetMouseInputEnabled(false)

	self.m_SpecialImage = vgui.Create("DImage", self)
	self.m_SpecialImage:SetSize(32, 32)
	self.m_SpecialImage:SetMouseInputEnabled(true)
	self.m_SpecialImage:SetVisible(false)

	self.m_ClassImage = vgui.Create("DImage", self)
	self.m_ClassImage:SetSize(44, 44)
	self.m_ClassImage:SetMouseInputEnabled(false)
	self.m_ClassImage:SetVisible(false)

	self.m_PlayerLabel = EasyLabel(self, " ", "ZSScoreBoardPlayer", COLOR_WHITE)
	self.m_PlayerLabel:SetFont("ZSScoreBoardPlayer")
	self.m_PlayerLabel:SetSize(128, 32)

	self.m_ScoreLabel = EasyLabel(self, " ", "ZSScoreBoardPlayerSmall", COLOR_WHITE)
	self.m_ScoreLabel:SetFont("ZSScoreBoardPlayerSmall")
	self.m_ScoreLabel:SetSize(128, 32)

	self.m_PingMeter = vgui.Create("DPingMeter", self)
	self.m_PingMeter.PingBars = 5

	self.m_Mute = vgui.Create("DImageButton", self)
	self.m_Mute:SetSize(32, 32)
	self.m_Mute.DoClick = MuteDoClick
end

local colTemp = Color(44, 0, 64, 220)
function PANEL:Paint(w, h)
	local col = color_black_alpha220
	local mul = 0.5
	local pl = self:GetPlayer()
	if pl:IsValid() then
		col = team.GetColor(pl:Team())

		if self.m_Flash then
			mul = 0.6 + math.abs(math.sin(RealTime() * 6)) * 0.4
		elseif pl == MySelf then
			mul = 0.8
		end
	end

	if self.Hovered then
		mul = math.min(1, mul * 1.5)
	end

	colTemp.r = col.r * mul
	colTemp.g = col.g * mul
	colTemp.b = col.b * mul
	--draw.RoundedBox(8, 0, 0, self:GetWide(), self:GetTall(), colTemp)
	surface.SetDrawColor(colTemp)
	surface.DrawRect(0, 0, w, h)
	return true
end

function PANEL:DoClick()
	local pl = self:GetPlayer()
	if pl:IsValid() then
		gamemode.Call("ClickedPlayerButton", pl, self)
	end
end

function PANEL:PerformLayout()
	self.m_AvatarButton:AlignLeft(16)
	self.m_AvatarButton:CenterVertical()

	self.m_PlayerLabel:SizeToContents()
	self.m_PlayerLabel:MoveRightOf(self.m_AvatarButton, 4)
	self.m_PlayerLabel:CenterVertical()

	self.m_ScoreLabel:SizeToContents()
	self.m_ScoreLabel:SetPos(self:GetWide() * 0.666 - self.m_ScoreLabel:GetWide() / 2, 0)
	self.m_ScoreLabel:CenterVertical()

	self.m_SpecialImage:CenterVertical()

	self.m_ClassImage:SetSize(self:GetTall(), self:GetTall())
	self.m_ClassImage:SetPos(self:GetWide() * 0.75 - self.m_ClassImage:GetWide() * 0.5, 0)
	self.m_ClassImage:CenterVertical()

	local pingsize = self:GetTall() - 4

	self.m_PingMeter:SetSize(pingsize, pingsize)
	self.m_PingMeter:AlignRight(8)
	self.m_PingMeter:CenterVertical()

	self.m_Mute:SetSize(16, 16)
	self.m_Mute:MoveLeftOf(self.m_PingMeter, 8)
	self.m_Mute:CenterVertical()
end

local tEmotes = {":)", ":c", ":C", ";n;", ";_;", ":P", ":D", ":d", ":U", ":3", "'д'", ":<", ":X", ":#", ":/", ":O", ":>", ":]"}
function PANEL:Refresh()
	local pl = self:GetPlayer()
	if not pl:IsValid() then
		self:Remove()
		return
	end

	local name = pl:Name()
	if #name > 26 then
		name = string.sub(name, 1, 24)..".."
	end

	-- Get the player's level and append it to their name
	local level = SimpleXPGetLevel(pl)
	name = name .. " (Level " .. level .. ")"

	if pl:IsBot() then
		name = name.." "..tEmotes[math.random(#tEmotes)]
	end

	self.m_PlayerLabel:SetText(name)
	self.m_ScoreLabel:SetText(pl:Frags())

	if pl:Team() == TEAM_UNDEAD and pl:GetZombieClassTable().Icon then
		self.m_ClassImage:SetVisible(true)
		self.m_ClassImage:SetImage(pl:GetZombieClassTable().Icon)
	else
		self.m_ClassImage:SetVisible(false)
	end

	if pl == MySelf then
		self.m_Mute:SetVisible(false)
	else
		if pl.m_TabMuted then
			self.m_Mute:SetImage("icon16/sound_mute.png")
		else
			self.m_Mute:SetImage("icon16/sound.png")
		end
	end

	self:SetZPos(-pl:Frags())

	if pl:Team() ~= self._LastTeam then
		self._LastTeam = pl:Team()
		self:SetParent(self._LastTeam == TEAM_HUMAN and ScoreBoard.HumanList or ScoreBoard.ZombieList)
	end

	self:InvalidateLayout()
end

function PANEL:Think()
	if RealTime() >= self.NextRefresh then
		self.NextRefresh = RealTime() + self.RefreshTime
		self:Refresh()
	end
end

local bBotsUseAvatars = true
function PANEL:SetPlayer(pl)
	self.m_Player = pl or NULL

	if pl:IsValid() and pl:IsPlayer() then
		if not pl:IsBot() or not bBotsUseAvatars then
			self.m_Avatar:SetPlayer(pl)
		else
			local name = pl:Nick()
			local rng = math.Round(util.SharedRandom(name, 1, 200000000)) --generate a unique avatar for this specific bot name
			self.m_Avatar:SetSteamID("7656119"..tostring(7960265728 + rng))
		end
		self.m_Avatar:SetVisible(true)

		if gamemode.Call("IsSpecialPerson", pl, self.m_SpecialImage) then
			self.m_SpecialImage:SetVisible(true)
		else
			self.m_SpecialImage:SetTooltip()
			self.m_SpecialImage:SetVisible(false)
		end

		self.m_Flash = pl:SteamID() == "STEAM_0:1:22042053"
	else
		self.m_Avatar:SetVisible(false)
		self.m_SpecialImage:SetVisible(false)
	end

	self.m_PingMeter:SetPlayer(pl)

	self:Refresh()
end

function PANEL:GetPlayer()
	return self.m_Player
end

vgui.Register("ZSPlayerPanel", PANEL, "Button")
