PS.Config = {}

-- Edit below

PS.Config.CommunityName = "Anon Shop"

PS.Config.DataProvider = 'pdata'

PS.Config.Branch = '' -- Master is most stable, used for version checking.
PS.Config.CheckVersion = false -- Do you want to be notified when a new version of Pointshop is avaliable?

PS.Config.ShopKey = '' -- Any Uppercase key or blank to disable
PS.Config.ShopCommand = '' -- Console command to open the shop, set to blank to disable
PS.Config.ShopChatCommand = '!shop' -- Chat command to open the shop, set to blank to disable

PS.Config.NotifyOnJoin = false -- Should players be notified about opening the shop when they spawn?

PS.Config.PointsOverTime = true -- Should players be given points over time?
PS.Config.PointsOverTimeDelay = 2 -- If so, how many minutes apart?
PS.Config.PointsOverTimeAmount = 10 -- And if so, how many points to give after the time?

PS.Config.AdminCanAccessAdminTab = true -- Can Admins access the Admin tab?
PS.Config.SuperAdminCanAccessAdminTab = true -- Can SuperAdmins access the Admin tab?

PS.Config.CanPlayersGivePoints = true -- Can players give points away to other players?
PS.Config.DisplayPreviewInMenu = true -- Can players see the preview of their items in the menu?

PS.Config.PointsName = 'Anon Coins' -- What are the points called?
PS.Config.SortItemsBy = 'Name' -- How are items sorted? Set to 'Price' to sort by price.

-- Edit below if you know what you're doing

PS.Config.CalculateBuyPrice = function(ply, item)
	-- You can do different calculations here to return how much an item should cost to buy.
	-- There are a few examples below, uncomment them to use them.
	
	-- Everything half price for admins:
	-- if ply:IsAdmin() then return math.Round(item.Price * 0.5) end
	
	-- 25% off for the 'donators' group
	-- if ply:IsUserGroup('donators') then return math.Round(item.Price * 0.75) end
	
	return item.Price
end

local categoryPriceMultipliers = {}

-- Function to get the price multiplier for a category
function GetPriceMultiplier(category)
    return categoryPriceMultipliers[category] or 1 -- Default to 1 if the category is not in the table
end

PS.Config.CalculateSellPrice = function(ply, item)
    -- Get the price multiplier for the item's category
    local multiplier = GetPriceMultiplier(item.Category)

    -- Calculate the sell price
    local sellPrice = math.Round(item.Price * multiplier)

    -- Print the item's category, the price multiplier, the original price, and the calculated sell price
    print("Item category: " .. tostring(item.Category))
    print("Price multiplier: " .. multiplier)
    print("Original price: " .. item.Price)
    print("Calculated sell price: " .. sellPrice)

    return sellPrice
end