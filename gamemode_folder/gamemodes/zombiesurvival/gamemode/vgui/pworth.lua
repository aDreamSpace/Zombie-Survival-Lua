hook.Add("SetWave", "CloseWorthOnWave1", function(wave)
	if wave > 0 then
		if pWorth and pWorth:Valid() then
			pWorth:Close()
		end

		hook.Remove("SetWave", "CloseWorthOnWave1")
	end
end)

local cvarDefaultCart = CreateClientConVar("zs_defaultcart", "", true, false)

local function DefaultDoClick(btn)
	if cvarDefaultCart:GetString() == btn.Name then
		RunConsoleCommand("zs_defaultcart", "")
		surface.PlaySound("buttons/button11.wav")
	else
		RunConsoleCommand("zs_defaultcart", btn.Name)
		surface.PlaySound("buttons/button14.wav")
	end

	timer.Simple(0.1, MakepWorth)
end

local WorthRemaining = 0
local WorthButtons = {}
local AttButtons = {}
local function CartDoClick(self, silent, force)
	local id = self.ID
	local tab = FindStartingItem(id)
	if not tab then return end

	if self.On then
		self.On = nil
		self:SetImage("icon16/cart_add.png")
		if not silent then
			surface.PlaySound("buttons/button18.wav")
		end
		self:SetTooltip("Add to cart")
		WorthRemaining = WorthRemaining + tab.Worth
	else
		if WorthRemaining < tab.Worth and not force then
			surface.PlaySound("buttons/button8.wav")
			return
		end
		self.On = true
		self:SetImage("icon16/cart_delete.png")
		if not silent then
			surface.PlaySound("buttons/button17.wav")
		end
		self:SetTooltip("Remove from cart")
		WorthRemaining = WorthRemaining - tab.Worth
	end

	pWorth.WorthLab:SetText("Worth: ".. WorthRemaining)
	if WorthRemaining <= 0 then
		pWorth.WorthLab:SetTextColor(COLOR_RED)
		pWorth.WorthLab:InvalidateLayout()
	elseif WorthRemaining <= GAMEMODE.StartingWorth * 0.25 then
		pWorth.WorthLab:SetTextColor(COLOR_YELLOW)
		pWorth.WorthLab:InvalidateLayout()
	else
		pWorth.WorthLab:SetTextColor(COLOR_PURPLE)
		pWorth.WorthLab:InvalidateLayout()
	end
	pWorth.WorthLab:SizeToContents()
end

local function Checkout(tobuy, atts)
	if tobuy and #tobuy > 0 then
		gamemode.Call("SuppressArsenalUpgrades", 1)
		if (atts and #atts > 0) then table.Add(tobuy, atts) end

		
		RunConsoleCommand("worthcheckout", unpack(tobuy))

		if pWorth and pWorth:Valid() then
			pWorth:Close()
		end
	else
		surface.PlaySound("buttons/combine_button_locked.wav")
	end
end

local function CheckoutDoClick(self)
	local tobuy = {}
	for _, btn in pairs(WorthButtons) do
		if btn and btn.On and btn.ID then
			table.insert(tobuy, btn.ID)
		end
	end

	local atts = {}
	for _, btn in pairs(AttButtons) do
		if btn and btn.ID then
			table.insert(atts, btn.ID)
		end
	end

	Checkout(tobuy, atts)
end

local function RandDoClick(self)
	gamemode.Call("SuppressArsenalUpgrades", 1)

	RunConsoleCommand("worthrandom")

	if pWorth and pWorth:Valid() then
		pWorth:Close()
	end
end

--MagicSwap
--Added a bunch of changes to Pworth to allow for default loadouts
--Gotta store the file loadout separately so default loadouts dont get saved with people's files!
GM.FileLoadout = {}

GM.SavedCarts = {
	[1] = {
		[1] = "Barricading Class",
		[2] = {"crphmr", "6nails", "bfmusc", "bfhandy", "nanite", "cryogas", "bfresist", "arscrate"}
	},

	[2] = {
		[1] = "Medic Class",
		[2] = {"cz75", "3pcp", "2pcp", "medkit", "150mkit", "10spd", "50spd", "bfsurgeon"}
	},

	[3] = {
		[1] = "Assault Class",
		[2] = {"blstr", "3sgcp", "2sgcp", "weapon_zs_axe", "100hp"}
	},
}

hook.Add("Initialize", "LoadCarts", function()
	if file.Exists(GAMEMODE.CartFile, "DATA") then
		GAMEMODE.FileLoadout = util.JSONToTable(file.Read(GAMEMODE.CartFile)) or {}

		for k, v in pairs(GAMEMODE.FileLoadout) do
			table.insert(GAMEMODE.SavedCarts, v)
		end
		--GAMEMODE.SavedCarts = util.JSONToTable(file.Read(GAMEMODE.CartFile)) or {}
		--GAMEMODE.SavedCarts = Deserialize(file.Read(GAMEMODE.CartFile)) or {}
	end
end)

local paint = function(self, w, h)
	local outline
	if self.Hovered then
		outline = self.On and COLOR_PURPLE or COLOR_GRAY
	else
		outline = self.On and COLOR_PURPLE or COLOR_DARKGRAY
	end

	draw.RoundedBox(8, 0, 0, w, h, outline)
	draw.RoundedBox(4, 4, 4, w - 8, h - 8, color_black)

end

local function AttBtnDoClick(self, silent, force)
	if self.On then
		self.On = nil
		table.RemoveByValue(AttButtons, self)
		if not silent then
			surface.PlaySound("buttons/button18.wav")
		end
		WorthRemaining = WorthRemaining + self.worth
	else
		if WorthRemaining < self.worth and not force then
			surface.PlaySound("buttons/button8.wav")
			return
		end
		if not silent then
			surface.PlaySound("buttons/button17.wav")
		end
		self.On = true
		table.insert(AttButtons, self)
		WorthRemaining = WorthRemaining - self.worth
	end

	pWorth.WorthLab:SetText("Worth: ".. WorthRemaining)

end

local function GenerateAttachmentBtn(info, attlist, parent, att)
	local btn = vgui.Create("DButton")
	btn:SetText(info.displayNameShort.." ("..(info.worth or "N/A").." Worth)")
	btn:SetFont("ZSHUDFontSmallest")
	btn.ID = att
	attlist[att] = btn
	attlist:Add(btn)
	
	btn:Dock(TOP)
	btn:SetTall(50)
	btn.DoClick = AttBtnDoClick
	btn.ActivatedBy = {parent}
	btn.Paint = paint
	btn.worth = info.worth or 5

	return btn
end

local function ClearCartDoClick()
	for _, btn in ipairs(WorthButtons) do
		if btn.On then
			btn:DoClick(true, true)
		end
	end

	surface.PlaySound("buttons/button11.wav")
end

local function LoadCart(cartid, silent)
	local cart = GAMEMODE.SavedCarts[cartid]
	if cart then
		MakepWorth()
		--we need to keep track of attachment inheritence or else parenting won't work
		--we don't really need this but we'll get wonky results if we don't atleast try
		--this is probably the messiest part of this implementation
		local attlist = pWorth.AttFrame.List
		local attTab = CustomizableWeaponry.registeredAttachmentsSKey
		for _, id in pairs(cart[2]) do
			for __, btn in pairs(WorthButtons) do
				if btn and (btn.ID == id or GAMEMODE.Items[id] and GAMEMODE.Items[id].Signature == btn.ID) then
					btn:DoClick(true, true)
				end
			end
		end

		if cart[3] then
			for _, att in pairs(cart[3]) do
				for _, btn in pairs(attlist:GetCanvas():GetChildren()) do
					print(att)
					print(btn.ID)
					if att == btn.ID then
						btn:DoClick(true, true)
					end
				end
			end
		end

		if not silent then
			surface.PlaySound("buttons/combine_button1.wav")
		end
	end
end

local function LoadDoClick(self)
	LoadCart(self.ID)
end

local function SaveCurrentCart(name)
	local tobuy = {}
	for _, btn in pairs(WorthButtons) do
		if btn and btn.On and btn.ID then
			table.insert(tobuy, btn.ID)
		end
	end
	local atts = {}
	for i, btn in pairs(AttButtons) do
		if btn and btn.ID then --only activated buttons exist in the AttButtons table!
			table.insert(atts, btn.ID)
		end
	end

	for i, cart in ipairs(GAMEMODE.FileLoadout) do
		if string.lower(cart[1]) == string.lower(name) then
			cart[1] = name
			cart[2] = tobuy
			cart[3] = atts

			file.Write(GAMEMODE.CartFile, util.TableToJSON(GAMEMODE.FileLoadout))
			print("Saved cart "..tostring(name))

			LoadCart(i + 3, true) --another dumb offset needed here...
			return
		end
	end

	GAMEMODE.SavedCarts[#GAMEMODE.SavedCarts + 1] = {name, tobuy, atts}
	GAMEMODE.FileLoadout[#GAMEMODE.FileLoadout + 1] = {name, tobuy, atts}

	file.Write(GAMEMODE.CartFile, util.TableToJSON(GAMEMODE.FileLoadout))
	print("Saved cart "..tostring(name))

	LoadCart(#GAMEMODE.SavedCarts, true)
end

local function SaveDoClick(self)
	local frame = vgui.Create("DFrame")
	frame:SetSize(300, 200)
	frame:Center()
	frame:SetTitle("Save cart")

	local label = vgui.Create("DLabel", frame)
	label:SetText("Enter a name for this cart")
	label:SetPos(10, frame:GetTall() / 2 - 50)
	label:SizeToContents()

	local text = vgui.Create("DTextEntry", frame)
	text:SetDrawBackground(false)
	text:SetDrawBorder(true)
	text:SetFont("ZSHUDFontTiny")
	text:SetValue("Enter name here")
	text:SetTextColor(color_white)
	text:SetSize(frame:GetWide() - 20, 40)
	text:SetPos(10, frame:GetTall() / 2 - 40)
	text:SetCursorColor(color_white)
	text.OnGetFocus = function() text:SetValue("") end

	local btn1 = vgui.Create("DButton", frame)
	btn1:Dock(BOTTOM)
	btn1:SetText("Cancel")
	btn1.DoClick = function() frame:Close() end

	local btn2 = vgui.Create("DButton", frame)
	btn2:Dock(BOTTOM)
	btn2:SetText("Save Cart")
	btn2.DoClick = function() SaveCurrentCart(text:GetValue()) frame:Close() end

	frame:MakePopup()

end

local function DeleteDoClick(self)
	if GAMEMODE.FileLoadout[self.ID - 3] then --HACK, HACK, really dumb offset to accomodate default loadouts
		table.remove(GAMEMODE.SavedCarts, self.ID)
		table.remove(GAMEMODE.FileLoadout, self.ID - 3)
		file.Write(GAMEMODE.CartFile, util.TableToJSON(GAMEMODE.FileLoadout))
		surface.PlaySound("buttons/button19.wav")
		MakepWorth()
	end
end

local function QuickCheckDoClick(self)
	local cart = GAMEMODE.SavedCarts[self.ID]
	if cart then
		Checkout(cart[2], cart[3])
	end
end

local return30 = function() return 30 end
local tabfont = "ZSHUDFontSmallest"

function MakepWorth()
	if pWorth and pWorth:Valid() then
		pWorth:OnClose() --prevents errors
		pWorth:Remove()
		pWorth = nil
	end

	local maxworth = GAMEMODE.StartingWorth
	WorthRemaining = maxworth

	local wid, hei = math.min(ScrW(), 850), ScrH() * 0.9

	local frame = vgui.Create("DFrame")
	pWorth = frame
	frame:SetSize(wid, hei)
	frame:SetDeleteOnClose(true)
	frame:SetKeyboardInputEnabled(false)
	frame:SetTitle(" ")


	local propertysheet = vgui.Create("DPropertySheet", frame)
	propertysheet:StretchToParent(4, 24, 4, 50)
	propertysheet.Paint = function() end
	--propertysheet.tabScroller:DockMargin( 3, 0, 3, 0 )

	local list = vgui.Create("DPanelList", propertysheet)
	local sheet = propertysheet:AddSheet("Favorites", list, "icon16/heart.png", false, false)
	sheet.Tab:SetFont(tabfont)
	sheet.Tab.GetTabHeight = return30
	list:EnableVerticalScrollbar(true)
	list:SetWide(propertysheet:GetWide() - 16)
	list:SetSpacing(2)
	list:SetPadding(2)

	local savebutton = EasyButton(nil, "Save the current cart", 0, 10)
	savebutton:SetFont("ZSHUDFontSmall")
	savebutton.DoClick = SaveDoClick
	list:AddItem(savebutton)

	local panfont = "ZSHUDFontSmall"
	local panhei = 40

	local defaultcart = cvarDefaultCart:GetString()

	for i, savetab in ipairs(GAMEMODE.SavedCarts) do
		local cartpan = vgui.Create("DEXRoundedPanel")
		cartpan:SetCursor("pointer")
		cartpan:SetSize(list:GetWide(), panhei)
		cartpan:SetColorAlpha(255)

		local cartname = savetab[1]

		local x = 8

		if defaultcart == cartname then
			local defimage = vgui.Create("DImage", cartpan)
			defimage:SetImage("icon16/heart.png")
			defimage:SizeToContents()
			defimage:SetMouseInputEnabled(true)
			defimage:SetTooltip("This is your default cart.\nIf you join the game late then you'll spawn with this cart.")
			defimage:SetPos(x, cartpan:GetTall() * 0.5 - defimage:GetTall() * 0.5)
			x = x + defimage:GetWide() + 4
		end

		local cartnamelabel = EasyLabel(cartpan, cartname, panfont)
		cartnamelabel:SetPos(x, cartpan:GetTall() * 0.5 - cartnamelabel:GetTall() * 0.5)

		x = cartpan:GetWide() - 20

		local checkbutton = vgui.Create("DImageButton", cartpan)
		checkbutton:SetImage("icon16/accept.png")
		checkbutton:SizeToContents()
		checkbutton:SetTooltip("Purchase this saved cart.")
		x = x - checkbutton:GetWide() - 8
		checkbutton:SetPos(x, cartpan:GetTall() * 0.5 - checkbutton:GetTall() * 0.5)
		checkbutton.ID = i
		checkbutton.DoClick = QuickCheckDoClick

		local loadbutton = vgui.Create("DImageButton", cartpan)
		loadbutton:SetImage("icon16/folder_go.png")
		loadbutton:SizeToContents()
		loadbutton:SetTooltip("Load this saved cart.")
		x = x - loadbutton:GetWide() - 8
		loadbutton:SetPos(x, cartpan:GetTall() * 0.5 - loadbutton:GetTall() * 0.5)
		loadbutton.ID = i
		loadbutton.DoClick = LoadDoClick

		local defaultbutton = vgui.Create("DImageButton", cartpan)
		defaultbutton:SetImage("icon16/heart.png")
		defaultbutton:SizeToContents()
		if cartname == defaultcart then
			defaultbutton:SetTooltip("Remove this cart as your default.")
		else
			defaultbutton:SetTooltip("Make this cart your default.")
		end
		x = x - defaultbutton:GetWide() - 8
		defaultbutton:SetPos(x, cartpan:GetTall() * 0.5 - defaultbutton:GetTall() * 0.5)
		defaultbutton.Name = cartname
		defaultbutton.DoClick = DefaultDoClick

		local deletebutton = vgui.Create("DImageButton", cartpan)
		deletebutton:SetImage("icon16/bin.png")
		deletebutton:SizeToContents()
		deletebutton:SetTooltip("Delete this saved cart.")
		x = x - deletebutton:GetWide() - 8
		deletebutton:SetPos(x, cartpan:GetTall() * 0.5 - loadbutton:GetTall() * 0.5)
		deletebutton.ID = i
		deletebutton.DoClick = DeleteDoClick

		list:AddItem(cartpan)
	end

	for catid, catname in ipairs(GAMEMODE.ItemCategories) do
		local hasitems = false
		for i, tab in ipairs(GAMEMODE.Items) do
			if tab.Category == catid and tab.WorthShop then
				hasitems = true
				break
			end
		end
		
		if hasitems then
			local list = vgui.Create("DPanelList", propertysheet)
			list:SetPaintBackground(false)
			local sheet = propertysheet:AddSheet(catname, list, GAMEMODE.ItemCategoryIcons[catid], false, false)
			sheet.Tab:SetFont(tabfont)
			sheet.Tab.GetTabHeight = return30
			list:EnableVerticalScrollbar(true)
			list:SetWide(propertysheet:GetWide() - 16)
			list:SetSpacing(2)
			list:SetPadding(2)

			for i, tab in ipairs(GAMEMODE.Items) do
			local hasitems = false
				if tab.Category == catid and tab.WorthShop then
					local button = vgui.Create("ZSWorthButton")
					button:SetWorthID(tab.Signature or i, i) --pass i as a second argument so that the counters work
					list:AddItem(button)
					WorthButtons[i] = button
				end
			end
		end
	end

	local worthlab = EasyLabel(frame, "Worth: "..tostring(WorthRemaining), "ZSHUDFontSmall", COLOR_PURPLE)
	worthlab:SetPos(8, frame:GetTall() - worthlab:GetTall() - 8)
	frame.WorthLab = worthlab

	local checkout = vgui.Create("DButton", frame)
	checkout:SetFont("ZSHUDFontSmall")
	checkout:SetText("Checkout")
	checkout:SizeToContents()
	checkout:SetSize(130, 30)
	checkout:AlignBottom(8)
	checkout:CenterHorizontal()
	checkout.DoClick = CheckoutDoClick

	local randombutton = vgui.Create("DButton", frame)
	randombutton:SetText("Random")
	randombutton:SetSize(64, 16)
	randombutton:AlignBottom(8)
	randombutton:AlignRight(8)
	randombutton.DoClick = RandDoClick

	local clearbutton = vgui.Create("DButton", frame)
	clearbutton:SetText("Clear")
	clearbutton:SetSize(64, 16)
	clearbutton:AlignRight(8)
	clearbutton:MoveAbove(randombutton, 8)
	clearbutton.DoClick = ClearCartDoClick

	--[[
	--rules appear at the end of the list
	local rules = vgui.Create("HTML", propertysheet)
	local rSheet = propertysheet:AddSheet("Rules", rules, "icon16/contrast.png", false, false)
	rSheet.Tab:SetFont(tabfont)
	rSheet.Tab:SetColor(COLOR_RED)
	rSheet.Tab.GetTabHeight = return30
	rules:SetWide(propertysheet:GetWide() - 16)
	rules:SetTall(propertysheet:GetTall() - 16)
	rules:OpenURL([[https://steamcommunity.com/groups/gentclubzs/discussions/0/3160848559784741776/]]

--
	--[[
	if #GAMEMODE.SavedCarts == 0 then
		propertysheet:SetActiveTab(propertysheet.Items[math.min(2, #propertysheet.Items)].Tab)
	end
	--]]

	if #GAMEMODE.SavedCarts == 3 then
		propertysheet:SetActiveTab(propertysheet.Items[#propertysheet.Items].Tab)
	end

	frame:Center()
	frame:SetAlpha(0)
	frame:AlphaTo(255, 0, 0)
	frame:MakePopup()

	local attframe = vgui.Create("DFrame")
	attframe:SetSize(200, frame:GetTall() / 2) -- Half the height of the menu
	attframe:SetTitle("")
	attframe:ShowCloseButton(false)
	attframe:SetAlpha(255)
	attframe:AlphaTo(255, 0, 0)
	attframe:SetDraggable(true) -- Make the vgui box movable
	attframe:SetSizable(true) -- Make the vgui box resizable
	attframe.Think = function(self)
		local x, y = pWorth:GetPos()
		self:SetPos(x - self:GetWide() - 50, y)
	end
	
	frame.OnClose = function() attframe:Close() end
	pWorth.AttFrame = frame
	local scroll = vgui.Create("DScrollPanel", attframe)
	scroll:Dock(FILL)
	
	pWorth.AttFrame.List = scroll
	
	local lab = EasyLabel(scroll, "Attachments ", "ZSHUDFontSmall")
	scroll:Add(lab)
	lab:Dock(TOP)
	
	AddSnowToPanel(pWorth) --seasonal
	
	return frame
end

local PANEL = {}
PANEL.m_ItemID = 0
PANEL.RefreshTime = 1
PANEL.NextRefresh = 0

function PANEL:Init()
	self:SetFont("DefaultFontSmall")
end

function PANEL:Think()
	if CurTime() >= self.NextRefresh then
		self.NextRefresh = CurTime() + self.RefreshTime
		self:Refresh()
	end
end

function PANEL:Refresh()
	local count = GAMEMODE:GetCurrentEquipmentCount(self:GetItemID())
	if count == 0 then
		self:SetText(" ")
	else
		self:SetText(count)
	end

	self:SizeToContents()
end

function PANEL:SetItemID(id) self.m_ItemID = id end
function PANEL:GetItemID() return self.m_ItemID end

vgui.Register("ItemAmountCounter", PANEL, "DLabel")

PANEL = {}

function PANEL:Init()
	self:SetText("")

	self:DockPadding(4, 4, 4, 4)
	self:SetTall(88)

	local mdlframe = vgui.Create("DEXRoundedPanel", self)
	mdlframe:SetWide(self:GetTall() - 8)
	mdlframe:Dock(LEFT)
	mdlframe:DockMargin(0, 0, 20, 0)

	self.ModelPanel = vgui.Create("DModelPanel", mdlframe)
	self.ModelPanel:Dock(FILL)
	self.ModelPanel:DockPadding(0, 0, 0, 0)
	self.ModelPanel:DockMargin(0, 0, 0, 0)

	self.NameLabel = EasyLabel(self, "", "ZSHUDFontSmall")
	self.NameLabel:SetContentAlignment(4)
	self.NameLabel:Dock(FILL)

	self.PriceLabel = EasyLabel(self, "", "ZSHUDFontTiny")
	self.PriceLabel:SetWide(80)
	self.PriceLabel:SetContentAlignment(6)
	self.PriceLabel:Dock(RIGHT)
	self.PriceLabel:DockMargin(8, 0, 4, 0)

	self.ItemCounter = vgui.Create("ItemAmountCounter", self)

	self:SetWorthID(nil)
end

function PANEL:SetWorthID(id, id2)
	self.ID = id
	
	local tab = FindStartingItem(id)

	if not tab then
		self.ModelPanel:SetVisible(false)
		self.ItemCounter:SetVisible(false)
		self.NameLabel:SetText("")
		return
	end

	local mdl = tab.Model or (weapons.GetStored(tab.SWEP) or tab).WorldModel
	if mdl then
		self.ModelPanel:SetModel(mdl)
		local mins, maxs = self.ModelPanel.Entity:GetRenderBounds()
		self.ModelPanel:SetCamPos(mins:Distance(maxs) * Vector(0.75, 0.75, 0.5))
		self.ModelPanel:SetLookAt((mins + maxs) / 2)
		self.ModelPanel:SetVisible(true)
	else
		self.ModelPanel:SetVisible(false)
	end

	if tab.SWEP or tab.Countables then
		self.ItemCounter:SetItemID(id2 or id) --id2 is passed as a number, if thats not there use the original id
		self.ItemCounter:SetVisible(true)
	else
		self.ItemCounter:SetVisible(false)
	end

	if tab.Worth then
		self.PriceLabel:SetText(tostring(tab.Worth).." Worth")
	else
		self.PriceLabel:SetText("")
	end

	self:SetTooltip(tab.Description)

	if tab.NoClassicMode and GAMEMODE:IsClassicMode() or tab.NoZombieEscape and GAMEMODE.ZombieEscape then
		self:SetAlpha(120)
	else
		self:SetAlpha(255)
	end

	self.NameLabel:SetText(tab.Name or "")
end



PANEL.Paint = paint


function PANEL:DoClick(silent, force)
	local id = self.ID
	local tab = FindStartingItem(id)
	if not tab then return end
	local attlist = pWorth.AttFrame.List
	local attTab = CustomizableWeaponry.registeredAttachmentsSKey
	local atts = {}
	
	if tab.SWEP then
		local wep = weapons.GetStored(tab.SWEP)
		if wep and wep.Attachments then
			for index, tables in pairs(wep.Attachments) do
				for name, attname in pairs(tables.atts) do
					local info = attTab[attname]
					if info.worth then
						table.insert(atts, attname)
					end
				end
			end
		end
	end


	if self.On then
		self.On = nil
		if not silent then
			surface.PlaySound("buttons/button18.wav")
		end
		WorthRemaining = WorthRemaining + tab.Worth

		for i = 1, #atts do
			local att = atts[i]
			if attlist[att] then
				local btn = attlist[att]
				table.RemoveByValue(btn.ActivatedBy, self)
				if #btn.ActivatedBy == 0 then
					if btn.On then
						btn:DoClick(true, true)
					end
					attlist[att]:Remove()
					attlist[att] = nil
				end
			end
		end 
	else
		if WorthRemaining < tab.Worth and not force then
			surface.PlaySound("buttons/button8.wav")
			return
		end
		self.On = true
		if not silent then
			surface.PlaySound("buttons/button17.wav")
		end
		WorthRemaining = WorthRemaining - tab.Worth
		for i = 1, #atts do
			local att = atts[i]
			if not attlist[att] then
				local info = attTab[att]
				if info then
					local btn = GenerateAttachmentBtn(info, attlist, self, att)
				end
			else
				local btn = attlist[att]
				table.insert(btn.ActivatedBy, self)
			end
		end

	end

	pWorth.WorthLab:SetText("Worth: ".. WorthRemaining)
	if WorthRemaining <= 0 then
		pWorth.WorthLab:SetTextColor(COLOR_RED)
		pWorth.WorthLab:InvalidateLayout()
	elseif WorthRemaining <= GAMEMODE.StartingWorth * 0.25 then
		pWorth.WorthLab:SetTextColor(COLOR_YELLOW)
		pWorth.WorthLab:InvalidateLayout()
	else
		pWorth.WorthLab:SetTextColor(COLOR_PURPLE)
		pWorth.WorthLab:InvalidateLayout()
	end
	pWorth.WorthLab:SizeToContents()
end

vgui.Register("ZSWorthButton", PANEL, "DButton")
