if SCB_LOADED then return end

local scb = scb
local SUI = scb.SUI
local language = scb.language

scb.tags = scb.tags or {}

net.Receive("SCB.SendTags", function()
	local tags = net.ReadData(net.ReadUInt(17))
	tags = util.Decompress(tags)
	scb.tags = scb.mp.unpack(tags)
end)

net.Receive("SCB.AddTag", function()
	local key = net.ReadString()
	local tag = net.ReadString()
	scb.tags[key] = tag

	local old = net.ReadString()

	if old ~= "" then
		scb.tags[old] = nil
	end

	hook.Call("SCB.TagsModified")
end)

net.Receive("SCB.RemoveTag", function()
	scb.tags[net.ReadString()] = nil
	hook.Call("SCB.TagsModified")
end)

local tags_menu = function(title, key, key_tag)
	key = key or ""

	local options = sui.valid_options()

	local querybox = vgui.Create("SCB.QueryBox")
	querybox:SetTitle(title)
	querybox:SetWide(300)

	local name = querybox:Add("SCB.TextEntry")
	name:Dock(TOP)
	name:SetPlaceholder(language.tag_owner)
	name:SetValue(key)

	name:SetCheck(function(_name)
		if _name == "" or (scb.tags[_name] and key ~= _name) then
			return false
		end
	end)

	options.Add(name)

	local tag = querybox:Add("SCB.TextEntry")
	tag:Dock(TOP)
	tag:DockMargin(0, 4, 0, 0)
	tag:SetPlaceholder(language.tag)
	tag:SetValue(key_tag or "")

	tag:SetCheck(function(_tag)
		return _tag ~= ""
	end)

	options.Add(tag)

	local preview = querybox:Add("SCB.ChatLine")
	preview:DockMargin(0, 6, 0, 0)
	preview.x = 3
	preview.emoji_size = 18

	preview:ScaleChanged()
	preview:Parse(tag:GetValue())
	preview:SetMouseInputEnabled(false)

	tag:On("OnValueChange", function(s, v)
		preview.added = {}
		preview:ScaleChanged()
		preview:Parse(v)
		querybox:size_to_children()
	end)

	querybox:SetCallback(function()
		net.Start("SCB.AddTag")
			net.WriteString(name:GetText())
			net.WriteString(tag:GetText())
			net.WriteString(name:GetText() ~= key and key or "")
		net.SendToServer()
	end)

	querybox:Done()
	querybox.save:SetEnabled(true)

	function querybox.save:Think()
		self:SetEnabled(options.IsValid())
	end
end

return {
	title = language.tags_title,
	pos = 2,
	func = function(parent)
		local body = parent:Add("Panel")
		body:Dock(FILL)
		body:DockMargin(0, 1, 0, 0)
		body:InvalidateParent(true)

		SUI.OnScaleChanged(body, function()
			body:Remove()
		end)

		local tags_list = body:Add("SCB.ThreeGrid")
		tags_list:Dock(FILL)
		tags_list:InvalidateLayout(true)
		tags_list:InvalidateParent(true)

		tags_list:SetColumns(2)
		tags_list:SetHorizontalMargin(2)
		tags_list:SetVerticalMargin(2)

		local load_tags = function()
			tags_list:Clear()

			for key, tag in SortedPairs(scb.tags) do
				local pnl = vgui.Create("DButton")
				pnl:SetText("")
				pnl:SetTall(SUI.Scale(560))
				pnl:SUI_TDLib()
					:ClearPaint()
					:FadeHover()

				function pnl:DoClick()
					tags_menu(language.edit .. " '" .. key .. "'", key, tag)
				end

				function pnl:DoRightClick()
					local d_menu = DermaMenu()

					d_menu:AddOption(language.remove, function()
						net.Start("SCB.RemoveTag")
							net.WriteString(key)
						net.SendToServer()
					end)

					d_menu:Open()
					d_menu:MakePopup()

					function pnl:OnRemove()
						d_menu:Remove()
					end
				end
				tags_list:AddCell(pnl)

				local name = pnl:Add("SCB.Label")
				name:Dock(TOP)
				name:SetFont(SCB_16)
				name:SetText(key)
				name:SetTextInset(3, 0)
				name:SetExpensiveShadow(1, color_black)
				name:SizeToContentsY(3)

				local _tag = pnl:Add("SCB.ChatLine")
				_tag:DockMargin(3, 0, 0, 0)
				_tag:SetFont(SCB_16)

				_tag.emoji_size = 16
				_tag:Parse(tag)
				_tag:SetMouseInputEnabled(false)

				pnl:SizeToChildren(false, true)
			end

			for k, v in ipairs(tags_list.Rows) do
				tags_list:CalculateRowHeight(v)
			end
		end
		load_tags()

		hook.Add("SCB.TagsModified", tags_list, load_tags)

		local add = body:Add("SCB.Button")
		add:Dock(BOTTOM)
		add:DockMargin(0, 4, 0, 0)
		add:SetText(language.add_tag:upper())

		add:On("DoClick", function()
			tags_menu(language.add_tag)
		end)

		return body
	end
}