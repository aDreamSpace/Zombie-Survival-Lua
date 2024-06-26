if SCB_LOADED then return end

local vgui = vgui

local ipairs = ipairs

local scb = scb
local SUI = scb.SUI
local language = scb.language

local toggle_convars = {
	{
		title = "show_time",
		convar = "scb_show_timestamps",
	},
	{
		title = "disable_rainbow",
		convar = "scb_disable_rainbow_colors",
		value = "0"
	},
	{
		title = "disable_flashing",
		convar = "scb_disable_flashing_texts",
		value = "0"
	},
	{
		title = "blur_theme",
		convar = "scb_blur_theme",
		value = SUI.current_theme == "Blur" and "1" or "0",
		on_change = function(value)
			SUI.SetTheme(value == "1" and "Blur" or "Dark")
		end
	},
	{
		title = "join_messages",
		convar = "scb_joindisconnect_message",
		value = "1"
	},
	{
		"number",
		title = "scale",
		convar = "scb_scale",
		value = "5",
		min = 1, max = 9,
		load = function(slider, convar)
			slider:GetParent():SetWide(110)

			slider:SetDecimals(0)
			slider:SetMinMax(1, 9)
			slider.Knob:SUI_TDLib()

			local on_mouse_released = function()
				convar:SetInt(slider:GetValue())
			end
			slider:On("OnMouseReleased", on_mouse_released)
			slider.Knob:On("OnMouseReleased", on_mouse_released)

			slider:SetValue(scb.to_new_range(SUI.GetScale(), 0.5, 1.5, 1, 9))
		end,
		on_change = function(value)
			SUI.SetScale(scb.to_new_range(value, 1, 9, 0.5, 1.5))
		end
	},
	{
		"number",
		title = "messages_fade",
		convar = "scb_message_fade_out_time",
		value = "6",
		min = 0, max = 60,
		load = function(slider, convar)
			slider:GetParent():SetWide(160)

			slider:SetDecimals(0)
			slider:SetMinMax(0, 60)

			slider:On("OnValueChanged", function(_, v)
				convar:SetInt(v)
			end)

			slider:SetValue(convar:GetInt())
		end
	},
	{
		"number",
		title = "max_messages",
		convar = "scb_max_messages",
		value = "200",
		min = 100, max = 400,
		load = function(slider, convar)
			slider:GetParent():SetWide(160)

			slider:SetDecimals(0)
			slider:SetMinMax(100, 400)

			slider:On("OnValueChanged", function(_, v)
				convar:SetInt(v)
			end)

			slider:SetValue(convar:GetInt())
		end
	}
}

if scb.config.enable_avatars then
	table.insert(toggle_convars, 1, {
		title = "show_avatars",
		convar = "scb_show_avatars",
	})
end

if not scb.config.enable_custom_join_messages and not scb.config.enable_custom_leave_messages then
	for k, v in ipairs(toggle_convars) do
		if v.convar == "scb_joindisconnect_message" then
			table.remove(toggle_convars, k)
			break
		end
	end
end

for _, v in ipairs(toggle_convars) do
	local convar = CreateClientConVar(v.convar, v.value or "1", true, false, "", v.min or 0, v.max or 1)

	if v.on_change then
		v.on_change(convar:GetString())
		cvars.AddChangeCallback(v.convar, function(_, _, value_new)
			v.on_change(value_new, v.panel)
		end)
	end
end

return {
	title = language.client_title,
	pos = 1,
	check = false,
	func = function(parent)
		local body = parent:Add("SCB.ScrollPanel")
		body:Dock(FILL)
		body:DockMargin(0, 1, 0, 0)

		local add_setting = function(title, pnl)
			local setting = body:Add("SCB.LabelPanel")
			setting:DockMargin(4, 4, 4, 0)
			setting:SetLabel(title)
			setting:SetPanel(pnl)
			return setting
		end

		for _, v in ipairs(toggle_convars) do
			local panel
			if v[1] == "number" then
				panel = vgui.Create("SCB.NumberSlider")

				v.panel = panel.slider
				v.load(panel.slider, v.convar and GetConVar(v.convar))
			else
				panel = vgui.Create("SCB.ToggleButton")
				panel:SetConVar(v.convar)
			end

			add_setting(language[v.title], panel)
		end

		local reset_size = vgui.Create("SCB.Button")
		reset_size:SetText("Reset")
		reset_size:SetSize(70, 24)
		reset_size:On("DoClick", function()
			scb.chatbox:SetSize(480, 220)
		end)
		add_setting(language.reset_size, reset_size)

		local reset_position = vgui.Create("SCB.Button")
		reset_position:SetText("Reset")
		reset_position:SetSize(70, 24)
		reset_position:On("DoClick", function()
			scb.chatbox:SetPos(sui.scale(18), ScrH() - scb.chatbox:GetTall() - sui.scale(170))
			scb.chatbox:OnPosChanged()
		end)
		add_setting(language.reset_position, reset_position)

		local clear_cache = vgui.Create("SCB.Button")
		clear_cache:SetText("Clear")
		clear_cache:SetSize(70, 24)

		clear_cache:On("DoClick", function()
			SUI.ClearImages()
		end)

		add_setting(language.clear_reload, clear_cache)

		return body
	end
}