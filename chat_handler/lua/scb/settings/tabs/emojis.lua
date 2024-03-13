if SCB_LOADED then return end

local scb = scb
local SUI = scb.SUI
local language = scb.language

scb.emojis = include("scb/cl_emojis_data.lua")

do
	local set_material = surface.SetMaterial
	local i = 0
	for name in pairs(scb.emojis) do
		timer.Simple(i * 0.001, function()
			set_material(SUI.Material("scb/emojis/" .. name .. ".png"))
		end)
		i = i + 1
	end
end

net.Receive("SCB.SendEmojis", function()
	local emojis = net.ReadData(net.ReadUInt(17))
	emojis = util.Decompress(emojis)

	for k, v in pairs(scb.mp.unpack(emojis)) do
		scb.emojis[k] = v
	end

	hook.Call("SCB.EmojisModified")
end)

net.Receive("SCB.AddEmoji", function()
	local emoji = net.ReadString()
	local url = net.ReadString()
	scb.emojis[emoji] = url

	local old = net.ReadString()
	if old ~= "" then
		scb.emojis[old] = nil
	end

	hook.Call("SCB.EmojisModified")
end)

net.Receive("SCB.RemoveEmoji", function()
	scb.emojis[net.ReadString()] = nil
	hook.Call("SCB.EmojisModified")
end)

local emoji_menu = function(title, emoji_name, emoji_url)
	emoji_name = emoji_name or ""

	local options = sui.valid_options()

	local querybox = vgui.Create("SCB.QueryBox")
	querybox:SetTitle(title)
	querybox:SetWide(300)

	local name = querybox:Add("SCB.TextEntry")
	name:Dock(TOP)
	name:SetPlaceholder(language.emoji_name)
	name:SetValue(emoji_name)
	name:SetCheck(function(_name)
		if _name == "" or (scb.emojis[_name] and emoji_name ~= _name) then
			return false
		end
	end)

	function name:AllowInput(c)
		return not c:find("[%w_]")
	end

	options.Add(name)

	local url = querybox:Add("SCB.TextEntry")
	url:Dock(TOP)
	url:DockMargin(0, 4, 0, 0)
	url:SetPlaceholder(language.emoji_url)
	url:SetValue(emoji_url or "")
	url:SetCheck(function(_url)
		if not _url:find("^https?://") then
			_url = "http://" .. _url
		end

		if scb.find_url(_url) ~= 1 then
			return false
		end
	end)

	function url:AllowInput(c)
		return c:find("%s") and true or false
	end

	options.Add(url)

	querybox:SetCallback(function()
		local _name = name:GetText():lower()
		local _url = url:GetText()

		if not _url:find("^https?://") then
			_url = "http://" .. _url
		end

		net.Start("SCB.AddEmoji")
			net.WriteString(_name)
			net.WriteString(_url)
			net.WriteString(_name ~= emoji_name and emoji_name or "")
		net.SendToServer()
	end)

	querybox:Done()
	querybox.save:SetEnabled(true)

	function querybox.save:Think()
		self:SetEnabled(options.IsValid())
	end
end

return {
	title = language.emojis_title,
	pos = 3,
	func = function(parent)
		local body = parent:Add("Panel")
		body:Dock(FILL)
		body:DockMargin(0, 1, 0, 0)
		body:InvalidateParent(true)

		SUI.OnScaleChanged(body, function()
			body:Remove()
		end)

		local top_body = body:Add("Panel")
		top_body:Dock(FILL)
		top_body:InvalidateParent(true)

		local search_field = top_body:Add("SCB.TextEntry")
		search_field:Dock(TOP)
		search_field:SetPlaceholder(language.search)

		local emojis_list = top_body:Add("SCB.ThreeGrid")
		emojis_list:Dock(FILL)
		emojis_list:DockMargin(3, 3, 3, 3)
		emojis_list:InvalidateLayout(true)
		emojis_list:InvalidateParent(true)

		emojis_list:SetColumns(3)
		emojis_list:SetHorizontalMargin(2)
		emojis_list:SetVerticalMargin(2)

		top_body.Paint, emojis_list.Paint = emojis_list.Paint, nil

		local load_emojis = function(search_key)
			emojis_list:Clear()

			search_key = search_key:lower()

			for emoji_name, v in pairs(scb.emojis) do
				if not scb.is_custom_emoji(v) then
					continue
				end

				if not string.find(emoji_name:lower(), search_key, 1, true) then
					continue
				end

				local pnl = vgui.Create("DButton")
				pnl:SetText("")
				pnl:SetTall(SUI.Scale(30))
				pnl:SUI_TDLib()
					:ClearPaint()
					:FadeHover()

				function pnl:DoClick()
					emoji_menu(language.edit .. " '" .. emoji_name .. "'", emoji_name, v)
				end

				function pnl:DoRightClick()
					local d_menu = DermaMenu()

					d_menu:AddOption(language.remove, function()
						net.Start("SCB.RemoveEmoji")
							net.WriteString(emoji_name:lower())
						net.SendToServer()
					end)

					d_menu:Open()
					d_menu:MakePopup()

					function pnl:OnRemove()
						d_menu:Remove()
					end
				end

				local emoji = pnl:Add("SCB.ChatLine")
				emoji:Dock(NODOCK)
				emoji.x = 2

				emoji:NewEmoji(emoji_name, v, 26)
				emoji:Center()
				emoji:SetMouseInputEnabled(false)

				local name = pnl:Add("SCB.Label")
				name:Dock(FILL)
				name:DockMargin(SUI.ScaleEven(26) + 8, 0, 0, 0)
				name:SetFont(SCB_16)
				name:SetText(emoji_name)

				emojis_list:AddCell(pnl)
			end
		end
		load_emojis("")

		hook.Add("SCB.EmojisModified", emojis_list, function()
			load_emojis(search_field:GetValue())
		end)

		function search_field:OnValueChange(v)
			load_emojis(v)
		end

		local add_emoji = body:Add("SCB.Button")
		add_emoji:Dock(BOTTOM)
		add_emoji:DockMargin(0, 4, 0, 0)
		add_emoji:SetText(language.add_emoji:upper())

		add_emoji:On("DoClick", function()
			emoji_menu(language.add_emoji)
		end)

		return body
	end
}