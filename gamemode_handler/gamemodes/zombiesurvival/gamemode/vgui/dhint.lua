--purpose: to create an easily customizable hint panel in order to make it so that i can easily draw this instead of messing with HUDPaint

local PANEL = {} --always need this...

function PANEL:Init()
	self:SetSize(ScrW() / 4, 100) --magic number 100 will be replaced with something that scales later
	self:SetPos(ScrW() / 2 - self:GetWide() / 2, ScrH() - 300) --if we arent using vectors for placement then we need it in the center/bottom
	self:SetTitle("")--and we dont want a title, since this is just a frame
	self:KillFocus()--since this should be purely visual
	self:SetVisible(false)
	self:ShowCloseButton(false)
	self:SetSizable(true)
	self.SetCloseTime = CurTime() + 10
end
--local strStressTest = "AAAAAAAAAAA AAAAAAAA AAAAAAAAAAAAAAAAAAA AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
function PANEL:Setup(strImg, strHint, fTime)
	local w, h = self:GetSize()
	local img = vgui.Create("DImage", self)
	img:SetSize(64, 64)
	img:SetImage(strImg)
	img:SetPos(0, 4)
	--[
	local hint = vgui.Create("DLabel", self)
	hint:SetFont("ZSHUDFontSmall")
	hint:SetText(strHint)
	hint:SetAutoStretchVertical(true)
	hint:SetWrap(true)
	hint:SetTextColor(Color(40, 255, 40))
	hint:SetWide(w - 64)
	local x, y = hint:GetPos()
	hint:SetPos(x + 64)
	
	--]]
	--[[
	local hint = vgui.Create("DTextEntry", self)--may even use rich text...
	hint:SetEditable(false)
	hint:SetMultiline(true)
	hint:SetValue(strHint)
	hint:SetDrawBackground(false)
	hint:SetFont("ZSHUDFontSmall")
	hint:SetTextColor(Color(40, 255, 40))
	--]]
	--[[
	local div = vgui.Create("DHorizontalDivider", self) --wanted to use this, turns out it screwed with textentry's autosize and sizetochildren
	div:Dock(FILL)
	div:SetLeft(img)
	div:SetRight(hint)
	div:SetDividerWidth(0)
	div:SetLeftMin(20)
	div:SetRightMin(20)
	div:SetLeftWidth(64)
	--]]
	self:InvalidateLayout(true)
end

function PANEL:Paint(w, h)
	draw.RoundedBoxEx(8, 0, 0, w, h, Color(20, 20, 20, 240), false, true, false, true)
end

function PANEL:Think()
end

function PANEL:PerformLayout(w, h)
		self:SizeToContentsY()
		self:SizeToChildren(false, true)
end

vgui.Register("DHint", PANEL, "DFrame")