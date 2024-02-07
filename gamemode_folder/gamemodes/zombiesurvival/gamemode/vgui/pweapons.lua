local function WeaponButtonDoClick(self)
	local swep = self.SWEP
	if swep then
		pWeapons:SetWeaponViewerSWEP(self.SWEP)
	end
end

local Features = {
{"WalkSpeed", "Movement speed"},
{"MeleeDamage", "Damage"},
{"MeleeRange", "Range"},
{"MeleeSize", "Size"},

{"ClipSize", "Clip size", 0, 50, false, "Primary"},
{"Damage", "Damage", 2, 100, false, "Primary"},
{"NumShots", "Number of shots", 1, 12, false, "Primary"},
{"Delay", "Rate of fire", 0.05, 3, true, "Primary"},

{"ConeMax", "Minimum accuracy"},
{"ConeMin", "Maximum accuracy"},

--new one for CW 2.0, i guess
{"ClipSize", "Clip size", 0, 50, false},
{"Damage", "Damage", 2, 100, false},
{"Shots", "Number of shots", 1, 12},
{"FireDelay", "Rate of fire", 0.05, 3, true},

{"HipSpread", "Hip Spread"},
{"AimSpread", "Aim Spread"},
}

local function SetWeaponViewerSWEP(self, swep)
	if self.Viewer then
		if self.Viewer:Valid() then
			self.Viewer:Remove()
		end
		self.Viewer = nil
	end

	local wid, hei = self:GetWide() * 0.6 - 16, self:GetTall() - self.ViewerY - 8
	local halfwid = wid * 0.5

	local viewer = vgui.Create("DPanel", self)
	viewer:SetPaintBackground(false)
	viewer:SetSize(wid, hei)
	viewer:SetPos(self:GetWide() - viewer:GetWide() - 8, self.ViewerY)
	self.Viewer = viewer

	if not swep then return end
	local sweptable = weapons.GetStored(swep)
	if not sweptable then return end

	local title = EasyLabel(viewer, sweptable.PrintName or swep, "ZSHUDFontSmall", COLOR_GRAY)
	title:SetContentAlignment(8)
	title:Dock(TOP)

	if sweptable.WorldModel then
		local bg = vgui.Create("DPanel", viewer)
		bg:SetSize(92, 92)
		bg:Dock(TOP)
		bg:DockMargin(100, 0, 100, 0)

		local modelpanel = vgui.Create("DModelPanelEx", bg)
		modelpanel:SetModel(sweptable.WorldModel)
		modelpanel:AutoCam()
		modelpanel:Dock(FILL)
	end

	local text = ""

	if sweptable.Description then
		text = text..sweptable.Description
	end

	for i, featuretab in ipairs(Features) do
		local touse
		if featuretab[6] then
			touse = sweptable[ featuretab[6] ]
		else
			touse = sweptable
		end

		local value = touse[ featuretab[1] ]
		if value then
			text = text.."\n"..featuretab[2]..": "..tostring(value)
		end
	end

	local desc = vgui.Create("DLabel", viewer)
	desc:SetText(text)
	desc:SetMultiline(true)
	desc:SetWrap(true)
	desc:Dock(FILL)
end

local colBlack = Color(0, 0, 0)
function MakepWeapons(silent)
	if not silent then
		PlayMenuOpenSound()
	end

	if pWeapons then
		pWeapons:SetAlpha(0)
		pWeapons:AlphaTo(255, 0.5, 0)
		pWeapons:SetVisible(true)
		pWeapons:MakePopup()
		return
	end

	local added = {}

	local weps = {}
	for _, tab in pairs(GAMEMODE.Items) do
		if tab.SWEP and not added[tab.SWEP] then
			weps[#weps + 1] = tab.SWEP
		end
	end

	local wid, hei = 600, 400

	local frame = vgui.Create("DFrame")
	frame:SetDeleteOnClose(false)
	frame:SetSize(wid, hei)
	frame:SetTitle(" ")
	frame:Center()
	frame.SetWeaponViewerSWEP = SetWeaponViewerSWEP
	pWeapons = frame

	local y = 8

	local title = EasyLabel(frame, "Weapon Database", "ZSHUDFont", color_white)
	title:SetPos(wid * 0.5 - title:GetWide() * 0.5, y)
	y = y + title:GetTall() + 8

	frame.ViewerY = y

	local tree = vgui.Create("DTree", frame)
	tree:SetSize(wid * 0.4 - 8, hei - y - 8)
	tree:SetPos(8, y)
	tree:SetIndentSize(4)
	tree.Paint = function(self, w, h)
		surface.SetDrawColor(colBlack)
		surface.DrawRect(0, 0, w, h)
	 end
	frame.Tree = tree

	for _, wep in pairs(weps) do
		local enttab = weapons.GetStored(wep)
		local wepnode
		if enttab then
			wepnode = tree:AddNode(enttab.PrintName or wep, "icon16/gun.png")
		else
			wepnode = tree:AddNode(wep, "icon16/gun.png")
		end
		wepnode.SWEP = wep
		wepnode.DoClick = WeaponButtonDoClick
	end

	frame:SetWeaponViewerSWEP()

	MakepWeapons(true)
end
