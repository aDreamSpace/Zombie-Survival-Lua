function GM:ForceDermaSkin()
	return "zombiesurvival"
end

local SKIN = {}

local colorVariables = {
    "bg_color",
    "bg_color_sleep",
    "bg_color_dark",
    "bg_color_bright",
    "Colors.Panel.Normal",
    "color_frame_background",
    "color_frame_border",
    "colTextEntryText",
    "colTextEntryTextHighlight",
    "colTextEntryTextBorder",
    "colPropertySheet",
    "colTab",
    "colTabInactive",
    "colTabShadow",
    "colTabText",
    "colTabTextInactive"
}

-- Create ConVars for the RGB values of each color variable
for _, var in ipairs(colorVariables) do
    CreateClientConVar(var .. "_r", 255, true, false)
    CreateClientConVar(var .. "_g", 255, true, false)
    CreateClientConVar(var .. "_b", 255, true, false)
end

-- Create a console command to open the color menu
concommand.Add("open_color_menu", function(ply, cmd, args)
    -- Create the menu
    local menu = vgui.Create("DFrame")
    menu:SetSize(700, 700)
    menu:Center()
    menu:SetTitle("Color Menu")
    menu:MakePopup()

    -- Create the color variable list
    local varList = vgui.Create("DListView", menu)
    varList:Dock(LEFT)
    varList:SetWidth(200)
    varList:SetMultiSelect(false)
    varList:AddColumn("Color Variable")

    -- Add the color variables to the list
    for _, var in ipairs(colorVariables) do
        varList:AddLine(var)
    end

    -- Create the color mixer
    local colorMixer = vgui.Create("DColorMixer", menu)
    colorMixer:Dock(FILL)
    colorMixer:SetPalette(true)
    colorMixer:SetAlphaBar(true)
    colorMixer:SetWangs(true)

    -- Update the color mixer when a color variable is selected
    varList.OnRowSelected = function(lst, index, pnl)
        local var = pnl:GetColumnText(1)
        colorMixer:SetColor(Color(GetConVarNumber(var .. "_r"), GetConVarNumber(var .. "_g"), GetConVarNumber(var .. "_b")))
    end

    -- Create the "Save" button
    local saveButton = vgui.Create("DButton", menu)
    saveButton:SetText("Save")
    saveButton:Dock(BOTTOM)
    saveButton.DoClick = function()
        -- Save the RGB values to the ConVars of the selected color variable
        local selectedLine = varList:GetSelectedLine()
        if selectedLine then
            local var = varList:GetLine(selectedLine):GetValue(1)
            local color = colorMixer:GetColor()
            RunConsoleCommand(var .. "_r", color.r)
            RunConsoleCommand(var .. "_g", color.g)
            RunConsoleCommand(var .. "_b", color.b)
        end
    end
end)

SKIN.PrintName = "Zombie Survival Derma Skin"
SKIN.Author = "William \"JetBoom\" Moodhe"
SKIN.DermaVersion = 1

SKIN.bg_color = Color(34, 0, 78)
SKIN.bg_color_sleep = Color(58, 0, 94)
SKIN.bg_color_dark = Color(35, 0, 68)
SKIN.bg_color_bright = Color(34, 0, 63)

SKIN.Colors = {}
SKIN.Colors.Panel = {}
SKIN.Colors.Panel.Normal = Color(0, 0, 0, 230)

function SKIN:PaintPanel(panel, w, h)
	if not panel.m_bBackground then return end

	surface.SetDrawColor(self.Colors.Panel.Normal)
	surface.DrawRect(0, 0, w, h)
end

--SKIN.tooltip = Color(190, 190, 190, 230)

local color_frame_background = Color(21, 0, 53, 250)



SKIN.color_frame_background = color_frame_background
SKIN.color_frame_border = Color(12, 246, 0)

SKIN.colTextEntryText = Color(252, 139, 0)
SKIN.colTextEntryTextHighlight = Color(30, 255, 0)
SKIN.colTextEntryTextBorder = Color(142, 86, 3)

SKIN.colPropertySheet = Color(0, 0, 0)
SKIN.colTab = SKIN.colPropertySheet
SKIN.colTabInactive = Color(0, 0, 0, 255)
SKIN.colTabShadow = Color(0, 219, 0)
SKIN.colTabText	= Color(0, 251, 247)
SKIN.colTabTextInactive	= Color(132, 0, 255, 120)

--[[SKIN.colTextEntryBG	= Color( 240, 240, 240, 255 )
SKIN.colTextEntryBorder	= Color( 20, 20, 20, 255 )
SKIN.colTextEntryText = Color( 20, 20, 20, 255 )
SKIN.colTextEntryTextHighlight = Color( 20, 200, 250, 255 )
SKIN.colTextEntryTextCursor	= Color( 0, 0, 100, 255 )]]

function SKIN:PaintPropertySheet(panel, w, h)
	local ActiveTab = panel:GetActiveTab()
	local Offset = 0
	if ActiveTab then Offset = ActiveTab:GetTall() - 8 end

	draw.RoundedBox(8, 0, 0, w, h, self.colTab)
end

function SKIN:PaintTab(panel, w, h)
	if panel:GetPropertySheet():GetActiveTab() == panel then
		return self:PaintActiveTab(panel, w, h)
	end

	draw.RoundedBox(8, 0, 0, w, h, self.colTabInactive)
end

function SKIN:PaintActiveTab(panel, w, h)
	draw.RoundedBox(8, 0, 0, w, h, self.colTab)
end

--[[SKIN.color_textentry_background = Color(40, 40, 40, 255)
SKIN.color_textentry_border = Color(70, 90, 70, 255)]]

local texCorner = surface.GetTextureID("zombiesurvival/circlegradient")
local texUpEdge = surface.GetTextureID("gui/gradient_up")
local texDownEdge = surface.GetTextureID("gui/gradient_down")
local texRightEdge = surface.GetTextureID("gui/gradient")
function PaintGenericFrame(panel, x, y, wid, hei, edgesize)
	edgesize = edgesize or math.ceil(math.min(hei * 0.1, math.min(16, wid * 0.1)))
	local dedgesize = edgesize * 4
	local hedgesize = edgesize * 0.5
	DisableClipping(true)
	surface.DrawRect(x, y, wid, hei)
	surface.SetTexture(texUpEdge)
	surface.DrawTexturedRect(x, y - edgesize, wid, edgesize)
	surface.SetTexture(texDownEdge)
	surface.DrawTexturedRect(x, y + hei, wid, edgesize)
	surface.SetTexture(texRightEdge)
	surface.DrawTexturedRect(wid, y, edgesize, hei)
	surface.DrawTexturedRectRotated(x + hedgesize * -1, y + hei * 0.5, edgesize, hei, 180)
	surface.SetTexture(texCorner)
	surface.DrawTexturedRect(x - edgesize, y - edgesize, edgesize, edgesize)
	surface.DrawTexturedRectRotated(x + wid + hedgesize, y - hedgesize, edgesize, edgesize, 270)
	surface.DrawTexturedRectRotated(x + wid + hedgesize, y + hei + hedgesize, edgesize, edgesize, 180)
	surface.DrawTexturedRectRotated(x - hedgesize, y + hei + hedgesize, edgesize, edgesize, 90)
	DisableClipping(false)
end

function SKIN:PaintFrame(panel, w, h)
	surface.SetDrawColor(panel.ColorOverride or color_frame_background)
	PaintGenericFrame(panel, 0, 0, w, h)
end

--[[function SKIN:DrawBorder(x, y, w, h, border)
	surface.SetDrawColor(border)
	surface.DrawOutlinedRect(x, y, w, h)
	surface.SetDrawColor(border.r * 0.75, border.g * 0.75, border.b * 0.5, border.a)
	surface.DrawOutlinedRect(x + 1, y + 1, w - 2, h - 2)
	surface.SetDrawColor(border.r * 0.5, border.g * 0.5, border.b * 0.5, border.a)
	surface.DrawOutlinedRect(x + 2, y + 2, w - 4, h - 4)
end

function SKIN:PaintTooltip(panel)
	local w, h = panel:GetSize()

	DisableClipping(true)

	self:DrawGenericBackground(0, 0, w, h, self.tooltip)
	panel:DrawArrow(0, 0)

	DisableClipping(false)
end

function SKIN:PaintButton(panel)
	local w, h = panel:GetSize()

	if panel.m_bBackground then
		local col = self.control_color
		if panel:GetDisabled() then
			col = self.control_color_dark
		elseif panel.Depressed then
			col = self.control_color_active
		elseif panel.Hovered then
			col = self.control_color_highlight
		end

		draw.RoundedBox(8, 0, 0, w, h, col)
	end
end]]

SKIN.Colours = {}

SKIN.Colours.Window = {}
SKIN.Colours.Window.TitleActive			= GWEN.TextureColor( 4 + 8 * 0, 508 );
SKIN.Colours.Window.TitleInactive		= GWEN.TextureColor( 4 + 8 * 1, 508 );

SKIN.Colours.Button = {}
SKIN.Colours.Button.Normal				= Color(115, 0, 255, 220)
SKIN.Colours.Button.Hover				= Color(115, 0, 255, 220)
SKIN.Colours.Button.Down				= Color(115, 0, 255, 220)
SKIN.Colours.Button.Disabled			=  Color(115, 0, 255, 220)

SKIN.Colours.Tab = {}
SKIN.Colours.Tab.Active = {}
SKIN.Colours.Tab.Active.Normal			= GWEN.TextureColor( 4 + 8 * 4, 508 );
SKIN.Colours.Tab.Active.Hover			= GWEN.TextureColor( 4 + 8 * 5, 508 );
SKIN.Colours.Tab.Active.Down			= GWEN.TextureColor( 4 + 8 * 4, 500 );
SKIN.Colours.Tab.Active.Disabled		= GWEN.TextureColor( 4 + 8 * 5, 500 );

SKIN.Colours.Tab.Inactive = {}
SKIN.Colours.Tab.Inactive.Normal		= GWEN.TextureColor( 4 + 8 * 6, 508 );
SKIN.Colours.Tab.Inactive.Hover			= GWEN.TextureColor( 4 + 8 * 7, 508 );
SKIN.Colours.Tab.Inactive.Down			= GWEN.TextureColor( 4 + 8 * 6, 500 );
SKIN.Colours.Tab.Inactive.Disabled		= GWEN.TextureColor( 4 + 8 * 7, 500 );

SKIN.Colours.Label = {}
SKIN.Colours.Label.Default				= GWEN.TextureColor( 4 + 8 * 8, 508 );
SKIN.Colours.Label.Bright				= GWEN.TextureColor( 4 + 8 * 9, 508 );
SKIN.Colours.Label.Dark					= GWEN.TextureColor( 4 + 8 * 8, 500 );
SKIN.Colours.Label.Highlight			= GWEN.TextureColor( 4 + 8 * 9, 500 );

SKIN.Colours.Tree = {}
SKIN.Colours.Tree.Lines					= GWEN.TextureColor( 4 + 8 * 10, 508 );		---- !!!
SKIN.Colours.Tree.Normal				= GWEN.TextureColor( 4 + 8 * 11, 508 );
SKIN.Colours.Tree.Hover					= GWEN.TextureColor( 4 + 8 * 10, 500 );
SKIN.Colours.Tree.Selected				= GWEN.TextureColor( 4 + 8 * 11, 500 );

SKIN.Colours.Properties = {}
SKIN.Colours.Properties.Line_Normal			= GWEN.TextureColor( 4 + 8 * 12, 508 );
SKIN.Colours.Properties.Line_Selected		= GWEN.TextureColor( 4 + 8 * 13, 508 );
SKIN.Colours.Properties.Line_Hover			= GWEN.TextureColor( 4 + 8 * 12, 500 );
SKIN.Colours.Properties.Title				= GWEN.TextureColor( 4 + 8 * 13, 500 );
SKIN.Colours.Properties.Column_Normal		= GWEN.TextureColor( 4 + 8 * 14, 508 );
SKIN.Colours.Properties.Column_Selected		= GWEN.TextureColor( 4 + 8 * 15, 508 );
SKIN.Colours.Properties.Column_Hover		= GWEN.TextureColor( 4 + 8 * 14, 500 );
SKIN.Colours.Properties.Border				= GWEN.TextureColor( 4 + 8 * 15, 500 );
SKIN.Colours.Properties.Label_Normal		= GWEN.TextureColor( 4 + 8 * 16, 508 );
SKIN.Colours.Properties.Label_Selected		= GWEN.TextureColor( 4 + 8 * 17, 508 );
SKIN.Colours.Properties.Label_Hover			= GWEN.TextureColor( 4 + 8 * 16, 500 );

SKIN.Colours.Category = {}
SKIN.Colours.Category.Header				= GWEN.TextureColor( 4 + 8 * 18, 500 );
SKIN.Colours.Category.Header_Closed			= GWEN.TextureColor( 4 + 8 * 19, 500 );
SKIN.Colours.Category.Line = {}
SKIN.Colours.Category.Line.Text				= GWEN.TextureColor( 4 + 8 * 20, 508 );
SKIN.Colours.Category.Line.Text_Hover		= GWEN.TextureColor( 4 + 8 * 21, 508 );
SKIN.Colours.Category.Line.Text_Selected	= GWEN.TextureColor( 4 + 8 * 20, 500 );
SKIN.Colours.Category.Line.Button			= GWEN.TextureColor( 4 + 8 * 21, 500 );
SKIN.Colours.Category.Line.Button_Hover		= GWEN.TextureColor( 4 + 8 * 22, 508 );
SKIN.Colours.Category.Line.Button_Selected	= GWEN.TextureColor( 4 + 8 * 23, 508 );
SKIN.Colours.Category.LineAlt = {}
SKIN.Colours.Category.LineAlt.Text				= GWEN.TextureColor( 4 + 8 * 22, 500 );
SKIN.Colours.Category.LineAlt.Text_Hover		= GWEN.TextureColor( 4 + 8 * 23, 500 );
SKIN.Colours.Category.LineAlt.Text_Selected		= GWEN.TextureColor( 4 + 8 * 24, 508 );
SKIN.Colours.Category.LineAlt.Button			= GWEN.TextureColor( 4 + 8 * 25, 508 );
SKIN.Colours.Category.LineAlt.Button_Hover		= GWEN.TextureColor( 4 + 8 * 24, 500 );
SKIN.Colours.Category.LineAlt.Button_Selected	= GWEN.TextureColor( 4 + 8 * 25, 500 );

SKIN.Colours.TooltipText	= GWEN.TextureColor( 4 + 8 * 26, 500 );

function SKIN:PaintButton(panel, w, h)
	if not panel.m_bBackground then return end

	local col

	if panel:GetDisabled() then
		col = Color(0, 0, 0, 90)
	elseif panel.Depressed or panel:IsSelected() or panel:GetToggle() then
		col = Color(0, 0, 0, 160)
	elseif panel.Hovered then
		col = Color(0, 0, 0, 160)
	else
		col = Color(0, 0, 0, 160)
	end

	local edgesize = math.min(math.ceil(w * 0.2), 24)
	surface.SetDrawColor(col)
	surface.DrawRect(edgesize, 0, w - edgesize * 2, h)
	surface.SetTexture(texRightEdge)
	surface.DrawTexturedRect(w - edgesize, 0, edgesize, h)
	surface.DrawTexturedRectRotated(math.ceil(edgesize * 0.5), math.ceil(h * 0.5), edgesize, h, 180)
end

derma.DefineSkin("zombiesurvival", "The default Derma skin for Zombie Survival", SKIN, "Default")