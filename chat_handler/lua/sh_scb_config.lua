if SCB_LOADED then return end

local config = scb.config

--
-- Chatbox title!@!
-- SERVER_NAME will be replaced with your server name
-- PLAYER_COUNT will be replaced with your online player count
-- EG.
-- config.chatbox_title = "SERVER_NAME (PLAYER_COUNT)" -- > Srlion Gaming (1)
--
config.chatbox_title = "SERVER_NAME (PLAYER_COUNT)"

--
-- By default it uses 12h format, for 24h use "%H:%M:%S"
--
config.timestamps_format = "%I:%M:%S %p"

--
-- Allow parsing in chat print functions? (chat.AddText/Player:ChatPrint/Player:PrintMessage)
-- If it causes problems then disable it.
--
config.parse_in_chat = true

--
-- Hide language sign that appears behing emojis if you are typing in a non-English language
--
config.hide_language_sign = true

--
-- Enable the custom join messages
--
config.enable_custom_join_messages = true

--
-- Enable the custom leave messages
--
config.enable_custom_leave_messages = true

--
-- Enable avatars
--
config.enable_avatars = true

--
-- You can use SteamID/SteamID64/Ranks
-- If the first value is 'true' then anyone can use it
--
config.permissions = {
	--
	-- Who can add/remove/edit emojis & tags?
	--
	menu = {
		"superadmin",
		"76561198261855442",
		"STEAM_0:0:150794857",
	},

	--
	-- Who can use rainbow texts?
	-- Eg.
	-- hi there {* everyone}!
	--
	rainbow = {
		"superadmin",
		"admin",
		"vip",
		"vip+",
	},

	--
	-- Who can use flashing texts?
	-- Eg.
	-- hi there {! everyone}!
	--
	flashing = {
		true, -- anyone can use this!!!
	},

	--
	-- Who can use colored texts?
	-- Eg.
	-- hi there {red Srlion}!
	-- hi there {#ff0000 Srlion}!
	--
	colored_texts = {
		true, -- anyone can use this!!!
	},

	--
	-- Who can use custom emojis?
	--
	custom_emojis = {
		true, -- anyone can use this because true is the first value!!!
		"superadmin",
	}
}

--
-- You can add colors that can be used in chatbox, eg. {my_new_color hi there!}
-- Use something like https://www.hexcolortool.com to get hex codes!
--
config.colors = {
	red = "f44336",
	pink = "E91E63",
	purple = "9C27B0",
	blue = "1773c4",
	cyan = "00BCD4",
	green = "4CAF50",
	yellow = "FFEB3B",
	orange = "FF9800",
	brown = "7b5804",
	grey = "9E9E9E",
	white = "E0E0E0",
	black = "080808"
}

scb.language = {
	save = "SAVE",
	cancel = "CANCEL",
	edit = "Edit",
	search = "Search...",
	team = "TEAM",
	dead = "*DEAD* ",
	console = "Console",
	remove = "Remove",

	type_something = "type something...",

	settings_title = "Settings",

	client_title = "Client",
	tags_title = "Tags",
	emojis_title = "Emojis",

	show_avatars = "Show avatars",
	show_time = "Show timestapms",
	disable_rainbow = "Disable rainbow colors",
	disable_flashing = "Disable flashing texts",
	blur_theme = "Blur theme",
	join_messages = "Join/Disconnect messages",
	scale = "Scale",
	messages_fade = "Messages fade out time",
	max_messages = "Max messages",
	reset_size = "Reset chatbox size",
	reset_position = "Reset chatbox position",
	clear_reload = "Clear & Reload images (can fix problems if some images are outdated or not loading)",

	add_tag = "Add Tag",
	tag_owner = "SteamID/SteamID64/Rank",
	tag = "Tag",

	add_emoji = "Add Emoji",
	emoji_name = "Name",
	emoji_url = "URL",

	copy_text = "Copy Text",
	copy_message = "Copy Message",
	copy_steamid = "Copy Steamid",
	copy_steamid64 = "Copy Steamid64",
	show_profile = "Show Player Profile",
	copy_time = "Copy Message Time",
	copy_url = "Copy URL",

	bot_joined = "{#1773c4 NAME} joined the game",
	bot_left = "{#f44336 NAME} left the game",

	-- STEAMID gets replaced by the player steamid
	player_connecting = "{#1773c4 NAME} is connecting",
	player_left = "{#f44336 NAME} left the game: REASON",
}