local function pointslabelThink(self)
	local points = MySelf:GetPoints()
	if self.m_LastPoints ~= points then
		self.m_LastPoints = points

		self:SetText("Points: "..points)
		self:SizeToContents()
	end
end

hook.Add("Think", "PointsShopThink", function()
	local pan = GAMEMODE.m_PointsShop
	if pan and pan:Valid() and pan:IsVisible() then
		local newstate = not GAMEMODE:GetWaveActive()
		if newstate ~= pan.m_LastNearArsenalCrate then
			pan.m_LastNearArsenalCrate = newstate

			if newstate then
				pan.m_DiscountLabel:SetText(GAMEMODE.ArsenalCrateDiscountPercentage.."% discount for buying between waves!")
				pan.m_DiscountLabel:SetTextColor(COLOR_GREEN)
			else
				pan.m_DiscountLabel:SetText("All sales are final!")
				pan.m_DiscountLabel:SetTextColor(COLOR_GRAY)
			end

			pan.m_DiscountLabel:SizeToContents()
			pan.m_DiscountLabel:AlignRight(8)
		end

		local mx, my = gui.MousePos()
		local x, y = pan:GetPos()
		if mx < x - 16 or my < y - 16 or mx > x + pan:GetWide() + 16 or my > y + pan:GetTall() + 16 then
			--pan:SetVisible(false)
			pan:Close()
			GAMEMODE.m_PointsShop:Close()
			surface.PlaySound("npc/dog/dog_idle3.wav")
		end
	end
end)

local function PointsShopCenterMouse(self)
	local x, y = self:GetPos()
	local w, h = self:GetSize()
	gui.SetMousePos(x + w * 0.5, y + h * 0.5)
end

local ammonames = GM.PointShopAmmoNames

local warnedaboutammo = CreateClientConVar("_zs_warnedaboutammo", "0", true, false)
local function PurchaseDoClick(self)
	if not warnedaboutammo:GetBool() then
		local itemtab = FindItem(self.ID)
		if itemtab and itemtab.SWEP then
			local weptab = weapons.GetStored(itemtab.SWEP)
			if weptab and weptab.Primary and weptab.Primary.Ammo and ammonames[weptab.Primary.Ammo] then
				RunConsoleCommand("_zs_warnedaboutammo", "1")
				Derma_Message("Be sure to buy extra ammo. Weapons purchased do not contain any extra ammo!", "Warning")
			end
		end
	end
	
	if self.att ~= nil then
		RunConsoleCommand("zs_pointsshopbuy", self.ID, self.att)
		return
	end

	RunConsoleCommand("zs_pointsshopbuy", self.ID)
end

local function BuyAmmoDoClick(self)
	RunConsoleCommand("zs_pointsshopbuy", "ps_"..self.AmmoType)
end

local function worthmenuDoClick()
	MakepWorth()
	GAMEMODE.m_PointsShop:Close()
end

local function purchasedDoClick()
end

local categoriesToShowStats = {
    ITEMCAT_GUNS,
    ITEMCAT_PISTOL,
    ITEMCAT_SMG,
    ITEMCAT_AR,
    ITEMCAT_SHOTGUN,
    ITEMCAT_RIFLE,
    ITEMCAT_BR,
    ITEMCAT_MG,
    ITEMCAT_MELEE,
    ITEMCAT_VANILLA,
    ITEMCAT_VMELEE,
    ITEMCAT_PULSE
}

local function ItemPanelThink(self)
    local itemtab = FindItem(self.ID)
    if itemtab then
        local newstate = MySelf:GetPoints() >= math.ceil((itemtab.Worth) * (GAMEMODE.m_PointsShop.m_LastNearArsenalCrate and GAMEMODE.ArsenalCrateMultiplier or 1)) and not (itemtab.NoClassicMode and GAMEMODE:IsClassicMode())
        if newstate ~= self.m_LastAbleToBuy then
            self.m_LastAbleToBuy = newstate
            if newstate then
                self:AlphaTo(255, 0.75, 0)
                self.m_NameLabel:SetTextColor(COLOR_WHITE)
                self.m_NameLabel:InvalidateLayout()
                self.m_BuyButton:SetImage("zombiesurvival/cwui/buy.png")
				self.m_BuyButton:SetSize(64, 64)
				self.m_BuyButton:SetPos(800, 10) -- Adjust the position of the button here
            else
					self:AlphaTo(90, 0.75, 0)
					self.m_NameLabel:SetTextColor(COLOR_RED)
					self.m_NameLabel:InvalidateLayout()
					self.m_BuyButton:SetImage("zombiesurvival/cwui/nobuy.png")
					self.m_BuyButton:SetSize(64, 64)
					self.m_BuyButton:SetPos(800, 0) -- Adjust the position of the button here
            end
        end

        -- Calculate space needed for description
        local descHeight = 0
        if itemtab.Description then
            local descLines = {}
            local maxLineLength = 40 -- Maximum characters per line
            for _, line in ipairs(string.Explode("\n", itemtab.Description)) do
                while #line > maxLineLength do
                    table.insert(descLines, line:sub(1, maxLineLength))
                    line = line:sub(maxLineLength + 1)
                end
                table.insert(descLines, line)
            end
            descHeight = #descLines * 16 -- Assuming each line takes 16 pixels of height
            itemtab.Description = table.concat(descLines, "\n")
        end

        -- Increase item panel size by 40%
        local originalHeight = 125
        local increasedHeight = originalHeight * 1.4
        self:SetTall(increasedHeight + descHeight)

        -- Create or update description label if not already set
        if not self.m_DescriptionLabel then
            self.m_DescriptionLabel = EasyLabel(self, "", "ZSHUDFontTiny", COLOR_WHITE)
            -- Set default position if not configured
            self.m_DescriptionLabel:SetPos(500, 150) -- Adjust position as needed
        end

        -- Set description text if it hasn't been set yet
        if itemtab.Description and self.m_DescriptionLabel:GetText() ~= itemtab.Description then
            self.m_DescriptionLabel:SetText(itemtab.Description)
            self.m_DescriptionLabel:SizeToContents()
        end

        -- Allow customization of the description label position
        if self.DescriptionLabelPosition then
            self.m_DescriptionLabel:SetPos(self.DescriptionLabelPosition.x, self.DescriptionLabelPosition.y)
        end

        -- Create or update model panel if not already set
        if not self.m_ModelPanel then
            self.m_ModelPanel = vgui.Create("DModelPanel", self)
            self.m_ModelPanel:SetSize(128, 128)
            self.m_ModelPanel:SetPos(150, 50) -- Adjust position as needed
        end

        -- Set model if it hasn't been set yet
        if self.m_ModelPanel:GetModel() ~= itemtab.Model then
            self.m_ModelPanel:SetModel(itemtab.Model) -- Assuming itemtab.Model contains the model path
        end
    end
end





local function PointsShopThink(self)
	if GAMEMODE:GetWave() ~= self.m_LastWaveWarning and not GAMEMODE:GetWaveActive() and CurTime() >= GAMEMODE:GetWaveStart() - 10 and CurTime() > (self.m_LastWaveWarningTime or 0) + 11 then
		self.m_LastWaveWarning = GAMEMODE:GetWave()
		self.m_LastWaveWarningTime = CurTime()

		surface.PlaySound("ambient/alarms/klaxon1.wav")
		timer.Simple(0.6, function() surface.PlaySound("ambient/alarms/klaxon1.wav") end)
		timer.Simple(1.2, function() surface.PlaySound("ambient/alarms/klaxon1.wav") end)
		timer.Simple(2, function() surface.PlaySound("vo/npc/Barney/ba_hurryup.wav") end)
	end
	
end

local activetab


local function propertysheetThink(self)
	if GAMEMODE.m_PointsShop and GAMEMODE.m_PointsShop:Valid() and GAMEMODE.m_PointsShop:IsVisible() then
		for x,obj in ipairs(self.Items) do
			if obj.Tab == self:GetActiveTab() then
				activetab = x
				break
			end
		end
	end
end

local function XPThink(self)
	local nearest = MySelf:NearestArsenalCrateOwnedByOther(true)
	if nearest then
		local xp = nearest.XPFraction
		--local lvl = nearest.level
		self:SetFraction(xp)
	end
end

local function labelThink(self)
	local nearest = MySelf:NearestArsenalCrateOwnedByOther(true)
	if nearest then
		local xp = nearest.XPFraction or 0
		local lvl = nearest.Level or 0
		self:SetText("Level: "..tostring(lvl).." | XP Amount: "..tostring(math.Round(xp * 100)).."%")
		self:SizeToContents()
	end
end

local AmmoBtnthink = function(self)
	if GAMEMODE:GetWaveActive() then
		self:SetText(self.Name.." ("..self.Price..")")
	else
		self:SetText(self.Name.." ("..math.ceil(self.Price * GAMEMODE.ArsenalCrateMultiplier).." "..GAMEMODE.ArsenalCrateDiscountPercentage.."% off!)")
	end
end

local AmmoBtnpaint = function(self, w, h)
	local outline
	if self.Hovered then
		outline = COLOR_GREEN
	else
		outline = COLOR_DARKGRAY
	end

	draw.RoundedBox(8, 0, 0, w, h, outline)
	draw.RoundedBox(4, 4, 4, w - 8, h - 8, color_black)
end

local AmmoBtnDoClick = function(self)

end

function GM:OpenPointsShop()
	if self.m_PointsShop and self.m_PointsShop:Valid() then
		return
	end

	local wid, hei = math.min(ScrW(), 1050), ScrH() * 0.85

	local frame = vgui.Create("DFrame")
	frame:SetSize(wid, hei)
	frame:Center()
	frame:SetDeleteOnClose(true)
	frame:SetTitle("")
	frame:SetDraggable(false)
	if frame.btnClose and frame.btnClose:Valid() then frame.btnClose:SetVisible(false) end
	if frame.btnMinim and frame.btnMinim:Valid() then frame.btnMinim:SetVisible(false) end
	if frame.btnMaxim and frame.btnMaxim:Valid() then frame.btnMaxim:SetVisible(false) end
	frame.CenterMouse = PointsShopCenterMouse
	frame.Think = PointsShopThink
	self.m_PointsShop = frame
	
	--AddSnowToPanel(self.m_PointsShop) --seasonal thingy
	
	local xpbar = vgui.Create("DProgress", frame)
	xpbar:SetPos(0, 0)
	xpbar:SetSize(frame:GetWide(), 64)
	xpbar:SetFraction(0)
	--xpbar:ShowCloseButton(false)
	xpbar.Think = XPThink
	xpbar:Dock(BOTTOM)
	
	local xplabel = EasyLabel(xpbar, "Level: 0, XP Amount: 0%", "ZSHUDFontSmall", COLOR_GRAY)		
	xplabel:SetPos(xpbar:GetWide() / 3, 0)
	xplabel.Think = labelThink

	local topspace = vgui.Create("DPanel", frame)
	topspace:SetWide(wid - 16)

	local title = EasyLabel(topspace, "The Points Shop", "ZSHUDFontSmall", COLOR_WHITE)
	title:CenterHorizontal()
	local subtitle = EasyLabel(topspace, "For all of your zombie apocalypse needs!", "ZSHUDFontTiny", COLOR_WHITE)
	subtitle:CenterHorizontal()
	subtitle:MoveBelow(title, 4)

	local _, y = subtitle:GetPos()
	topspace:SetTall(y + subtitle:GetTall() + 4)
	topspace:AlignTop(8)
	topspace:CenterHorizontal()

	local tt = vgui.Create("DImage", topspace)
	tt:SetImage("gui/info")
	tt:SizeToContents()
	tt:SetPos(8, 8)
	tt:SetMouseInputEnabled(true)
	tt:SetTooltip("This shop is armed with the QUIK - Anti-zombie backstab device.\nMove your mouse outside of the shop to quickly close it!")

	local wsb = EasyButton(topspace, "Worth Menu", 8, 4)
	wsb:AlignRight(8)
	wsb:AlignTop(8)
	wsb.DoClick = worthmenuDoClick


	local bottomspace = vgui.Create("DPanel", frame)
	bottomspace:SetWide(topspace:GetWide())

	local pointslabel = EasyLabel(bottomspace, "Points to spend: 0", "ZSHUDFontTiny", COLOR_GREEN)
	pointslabel:AlignTop(4)
	pointslabel:AlignLeft(8)
	pointslabel.Think = pointslabelThink

	local lab = EasyLabel(bottomspace, " ", "ZSHUDFontTiny")
	lab:AlignTop(4)
	lab:AlignRight(4)
	frame.m_DiscountLabel = lab

	local _, y = lab:GetPos()
	bottomspace:SetTall(y + lab:GetTall() + 4)
	bottomspace:AlignBottom(8)
	bottomspace:CenterHorizontal()

	local topx, topy = topspace:GetPos()
	local botx, boty = bottomspace:GetPos()

	local propertysheet = vgui.Create("DPropertySheet", frame)
	propertysheet:SetSize(wid - 8, boty - topy - 8 - topspace:GetTall())
	propertysheet:MoveBelow(topspace, 4)
	propertysheet:CenterHorizontal()
	propertysheet.Think = propertysheetThink

	local isclassic = GAMEMODE:IsClassicMode()
	local attTab
	if CustomizableWeaponry then
		--print("cw20 is registered")
		attTab = CustomizableWeaponry.registeredAttachmentsSKey
		--PrintTable(CustomizableWeaponry.registeredAttachmentsSKey)
		--setup master table if CW20 is installed
		--better than a manual table since this has to be registered when new attachments are added
		--advantages to this is easy control and balancing where values are queried instead of plugged in
	end
	
	for catid, catname in ipairs(GAMEMODE.ItemCategories) do
		local hasitems = false
		for i, tab in ipairs(GAMEMODE.Items) do
			if tab.Category == catid and tab.PointShop then
				hasitems = true
				break
			end
		end
		--[
		if catid == ITEMCAT_ATT and CustomizableWeaponry then
			--print("Attachement category now calculating!")
			local list = vgui.Create("DPanelList", propertysheet)
			list:SetPaintBackground(false)
			propertysheet:AddSheet(catname, list, GAMEMODE.ItemCategoryIcons[catid], false, false)
			list:EnableVerticalScrollbar(true)
			list:SetWide(propertysheet:GetWide() - 16)
			list:SetSpacing(2)
			list:SetPadding(2)
			local kek = false
			if !kek then
				local itempan = vgui.Create("DPanel")
				itempan:SetSize(list:GetWide(), 40)
				itempan.ID = "info"
				list:AddItem(itempan)

				local name = "Switch to a customizable weapon to purchase attachments!"
				local namelab = EasyLabel(itempan, name, "ZSHUDFontSmall", COLOR_WHITE)
				namelab:SetPos(42, itempan:GetTall() * 0.5 - namelab:GetTall() * 0.5)
				itempan.m_NameLabel = namelab

				kek = true
			end
			local ply = MySelf
			local wpn = ply:GetActiveWeapon() or weapons.GetStored("weapon_zs_fists")
			if !wpn:IsValid() then print("error loading player weapon") end
			local attMTbl = wpn.Attachments or {}
			local dependencies = wpn.AttachmentDependencies

			for index, tables in pairs(attMTbl) do
				if tables.header then
					local itempan = vgui.Create("DPanel")
					itempan:SetSize(list:GetWide(), 20)
					itempan:SetAlpha(255)
					itempan.ID = "info"
					list:AddItem(itempan)

					local name = tables.header..":"
					local namelab = EasyLabel(itempan, name, "ZSHUDFontSmall", team.GetColor(TEAM_HUMAN))
					namelab:SetPos(10, itempan:GetTall() * 0.5 - namelab:GetTall() * 0.5)
					itempan.m_NameLabel = namelab
				end
				for _, attname in pairs(tables.atts) do
					local tab = attTab[attname]
					if tab then
						local placeholderPrice = 10
						local placeholderModel = "models/items/battery.mdl" --placeholders in case attachments aren't setup
						local placeholderName = tab.name
						local itempan = vgui.Create("DPanel")
						itempan.ID = tab.name
						itempan.Think = ItemPanelThink
						itempan.cost = tab.price or tab.Worth or placeholderPrice
						list:AddItem(itempan)
				
						local mdlframe = vgui.Create("DPanel", itempan)
						mdlframe:SetSize(128, 128)
						mdlframe:SetPos(550, 100)
				
						local mdl = tab.model or placeholderModel
						if mdl then
							local mdlpanel = vgui.Create("DModelPanel", mdlframe)
							mdlpanel:SetSize(mdlframe:GetSize())
							mdlpanel:SetModel(mdl)
							local mins, maxs = mdlpanel.Entity:GetRenderBounds()
							mdlpanel:SetCamPos(mins:Distance(maxs) * Vector(0.75, 0.75, 0.5))
							mdlpanel:SetLookAt((mins + maxs) /2)
						end
				
						if tab.SWEP or tab.Countables then
							local counter = vgui.Create("ItemAmountCounter", itempan)
							counter:SetItemID(i)
						end
				
						local name = tab.displayNameShort or placeholderName
						if type(name) ~= "string" then
							name = "Invalid name: " .. tostring(tab.displayNameShort)
						end
				
						local namelab = EasyLabel(itempan, name, "ZSHUDFontSmall", COLOR_WHITE)
						namelab:SetPos(42, itempan:GetTall() * 0.5 - namelab:GetTall() * 0.5)
						itempan.m_NameLabel = namelab
				
						--dependency hell
						local depStart = " (Dependencies: "
						local depEnd = ")"
						if dependencies and dependencies[tab.name] then
							local info = dependencies[tab.name]
							if isstring(info) then
								local att = attTab[info]
								if att then
									name = name..depStart..att.displayNameShort..depEnd
								end
							else
								local first = true
								name = name..depStart
								for _, attN in pairs(info) do
									local att = attTab[attN]
									if att then
										if first then
											name = name..att.displayNameShort
											first = false
										else
											name = name..", "..att.displayNameShort
										end
									end
								end
								name = name..depEnd
							end
						end
				
						-- Create a label for the description
						local description = tab.description or "No description available"
						if type(description) == "table" then
							local descText = {}
							for _, desc in ipairs(description) do
								if desc.t then
									table.insert(descText, desc.t)
								end
							end
							description = table.concat(descText, "\n")
						elseif type(description) ~= "string" then
							description = "Invalid description: " .. tostring(tab.description)
						end
						local desclab = EasyLabel(itempan, description, "ZSHUDFontSmallest", COLOR_WHITE)
						desclab:SetPos(42, itempan:GetTall() * 0.5 - desclab:GetTall() * -0.5 + namelab:GetTall())
						itempan.m_DescLabel = desclab
				
						-- Adjust the size of the panel to fit the text
						local textHeight = desclab:GetTall()
						itempan:SetSize(list:GetWide(), textHeight + 150)  -- Add 50 for padding
				
						local button = vgui.Create("DImageButton", itempan)
						button:SetImage("zombiesurvival/cwui/buy.png")
						button:SizeToContents()
						button:SetPos(itempan:GetWide() - 90 - button:GetWide(), itempan:GetTall() - 140)
						button:SetTooltip("Purchase "..name)
						button.ID = itempan.ID
						button.att = placeholderName
						button.DoClick = PurchaseDoClick
						itempan.m_BuyButton = button
				
						if tab.NoClassicMode and isclassic or tab.NoZombieEscape and GAMEMODE.ZombieEscape then
							itempan:SetAlpha(120)
						end
				
						local pricelab = EasyLabel(itempan, tostring(tab.price or tab.cost or placeholderPrice).." Points", "ZSHUDFontSmallest", COLOR_GREEN)
						pricelab:SetPos(itempan:GetWide() - 170 - pricelab:GetWide(), 5)
						itempan.m_PriceLabel = pricelab
					end
				end
			end
		end
	
		if hasitems then
			local list = vgui.Create("DPanelList", propertysheet)
			list:SetPaintBackground(false)
			propertysheet:AddSheet(catname, list, GAMEMODE.ItemCategoryIcons[catid], false, false)
			list:EnableVerticalScrollbar(true)
			list:SetWide(propertysheet:GetWide() - 32)
			list:SetSpacing(25)
			list:SetPadding(25)
		
			for i, tab in ipairs(GAMEMODE.Items) do
				if tab.Category == catid and tab.PointShop and catid ~= ITEMCAT_ATT then
					if tab.SWEP and not tab.Stats then
						tab.Stats = {}
			
						-- Ensure WeaponStatBarVals is a table
						if not WeaponStatBarVals then
							WeaponStatBarVals = {}
						end
			
						for _, stat in pairs(WeaponStatBarVals) do
							local statKey, statName, minValue, maxValue, invert, statType = unpack(stat)
			
							-- Fetch the actual stat value from the SWEP
							local statValue = weapons.GetStored(tab.SWEP)
							for key in string.gmatch(statKey, "[^.]+") do
								statValue = statValue and statValue[key]
							end
			
							-- Only add the stat if it exists in the SWEP
							if statValue then
								tab.Stats[statKey] = {
									Name = statName,
									Value = statValue,
									Min = minValue,
									Max = maxValue,
									Invert = invert,
									Type = statType
								}
							end
						end
					end
		
					local itempan = vgui.Create("DPanel")
					itempan:SetSize(list:GetWide(), 225)
					itempan.ID = tab.Signature or i
					itempan.Think = ItemPanelThink
					itempan.cost = tab.price or tab.Worth
					list:AddItem(itempan)
		
					-- Add a label to the button for each stat
					if tab.Stats then
						local xPos = 200 -- Initial x position for the labels
						local yPos = 10 -- Initial y position for the labels
						for _, stat in pairs(tab.Stats) do
							local label = vgui.Create("DLabel", itempan)
							label:SetText(stat.Name .. ": " .. tostring(stat.Value))
							label:SetFont("ZSHUDFontSmall") -- Set the font of the label
							label:SizeToContents() -- Make the label only as wide as the text
							label:SetPos(xPos, yPos) -- Set the position of the label
							yPos = yPos + label:GetTall() + 5 -- Increase the y position for the next label
						end
					end
		
					local mdlframe = vgui.Create("DPanel", itempan)
					mdlframe:SetSize(128, 128)
					mdlframe:SetPos(550, 4)
		
					local iconTable = killicon.Get(tab.SWEP or tab.Name)
					if iconTable and iconTable[1] then
						local iconPanel = vgui.Create("DImage", mdlframe)
						iconPanel:SetSize(mdlframe:GetSize())
						iconPanel:SetImage(iconTable[1])  -- Use the first element of the table
					end
		
					if tab.SWEP or tab.Countables then
						local counter = vgui.Create("ItemAmountCounter", itempan)
						counter:SetItemID(i)
					end
		
					local name = tab.Name or ""
					local namelab = EasyLabel(itempan, name, "ZSHUDFontSmall", COLOR_WHITE)
					namelab:SetPos(22, itempan:GetTall() * 0.5 - namelab:GetTall() * 0.5)
					itempan.m_NameLabel = namelab
		
					local pricelab = EasyLabel(itempan, tostring(tab.Worth).." Points", "ZSHUDFontSmallest")
					pricelab:SetPos(52, itempan:GetTall() - pricelab:GetTall() - 52)
					
					local button = vgui.Create("DImageButton", itempan)
					button:SetImage("icon16/lorry_add.png")
					button:SizeToContents()
					button:SetPos(itempan:GetWide() - 80 - button:GetWide(), itempan:GetTall() - 95)
					button:SetTooltip("Purchase "..name)
					button.ID = itempan.ID
					button.DoClick = PurchaseDoClick
					itempan.m_BuyButton = button
		
					if weptab and weptab.Primary then
						local ammotype = weptab.Primary.Ammo
						if ammonames[ammotype] then
							local ammobutton = vgui.Create("DImageButton", itempan)
							ammobutton:SetImage("icon16/add.png")
							ammobutton:SizeToContents()
							ammobutton:CopyPos(button)
							ammobutton:MoveLeftOf(button, 6)
							ammobutton:SetTooltip("Purchase ammunition")
							ammobutton.AmmoType = ammonames[ammotype]
							ammobutton.DoClick = BuyAmmoDoClick
						end
					end
		
					if tab.NoClassicMode and isclassic or tab.NoZombieEscape and GAMEMODE.ZombieEscape then
						itempan:SetAlpha(120)
					end
				end
			end
		end
		if activetab then
			if propertysheet and propertysheet.Items and propertysheet.Items[activetab] then
				propertysheet:SetActiveTab(propertysheet.Items[activetab].Tab)
			else
				print("Error: propertysheet, propertysheet.Items, or propertysheet.Items[activetab] is nil")
			end
		end
		frame:MakePopup()
		frame:CenterMouse()
		
	end
end 

GM.OpenPointShop = GM.OpenPointsShop
