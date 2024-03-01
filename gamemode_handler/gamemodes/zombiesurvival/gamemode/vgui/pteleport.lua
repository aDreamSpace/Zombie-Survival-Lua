local PANEL = {}

function PANEL:Init()
    self:SetSize(ScrW(), ScrH()) --should take up the entire screen.
	self:SetDraggable(false)
    self:Center()
    self:SetTitle("")
    self:ShowCloseButton(false)
    self:SetMenuTime(15)
    self.Teleporters = {}
	self.LabList = {}
    self.TeleportPanels = {}
	self:MakePopup()
	
	local title = vgui.Create("DLabel", self)
	self.Title = title
	title:SetText("Choose Your Destination")
	title:SetFont("ZSHUDFont")
	title:SizeToContents()
	title:SetPos(20, 0)
	title:CenterHorizontal()
	
	local time = vgui.Create("DLabel", self)
	self.Timer = time
	time:SetText("00:00")
	time:SetFont("ZSHUDFontSmall")
	time:SizeToContents()
	time:Center()
	time.Think = function(tt)
		local tnum = (self:GetMenuTime() - CurTime()) * 100
		local secs = math.floor(tnum / 100)
		local prt = math.Round(tnum - secs * 100)
		local z = secs < 10 and "0" or ""
		local z2 = prt < 10 and "0" or ""
		tt:SetText(z .. tostring(secs) .. ":" .. z2 .. tostring(prt))
		local mul = (math.sin(CurTime() * 8) + 1) / 2
		tt:SetColor(Color(220, 255 * mul, 255 * mul))
	end

	local warn = vgui.Create("DLabel", self)
	self.Warning = warn
	warn:SetText("[WARNING] Dimensional instability in:")
	warn:SetFont("ZSHUDFontSmall")
	warn:SetColor(Color(255, 40, 40))
	warn:SizeToContents()
	warn:MoveAbove(time)
	warn:CenterHorizontal()

    for k, v in pairs(ents.FindByClass("prop_teleporter")) do
        local tblData = {}
        tblData.pos = v:GetPos()
        tblData.ent = v
        self:AddTeleportItem(tblData, false)
    end
	
	self:UpdateTeleportItems()
	
	hook.Add("EntityRemoved", self, self.RemHook)
	hook.Add("OnEntityCreated", self, self.CreHook)
end  

local colMenu = Color(40, 40, 40, 255) --going for a smoky gray for the menu
function PANEL:Paint(w, h)
    surface.SetDrawColor(colMenu)
    surface.DrawRect(0, 0, w, h)
end

function PANEL:RemHook(ent)
	if ent and ent:IsValid() and ent:GetClass() == "prop_teleporter" then
		for k,v in pairs(self.Teleporters) do
			if v[3] == ent then
				table.remove(self.Teleporters, k)
			end
		end

		
		self:UpdateTeleportItems()
	end
end

function PANEL:CreHook(ent)
	timer.Simple(0.2, function()
		if ent and ent:IsValid() and ent:GetClass() == "prop_teleporter" then
			table.insert(self.Teleporters, {ent:GetObjectOwner(), ent:GetPos(), ent})
			
			self:UpdateTeleportItems()
		end
	end)
end

local strTele = "prop_teleporter"
function PANEL:AddTeleportItem(tblData, update)
	if update == nil then update = true end

	local entTele = tblData.ent
    tblData.owner = entTele:GetObjectOwner()

    table.insert(self.Teleporters, {tblData.owner, tblData.pos, tblData.ent})
	if update then
		self:UpdateTeleportItems()
	end
end

function PANEL:RemoveTeleportItem(index)
    self:UpdateTeleportItems()
end

matSprite = Material("sprites/glow04_noz")
colSprite = Color(40, 255, 40)
colSpritePrev = Color(255, 40, 40)

--precache some data above to save on GC
function PANEL:UpdateTeleportItems()
    local fCircleRadius = ScrH() / 3 --im pretty sure no one plays in tallscreen, this will ensure the ring of teleporters stays on screen and is an appropriate size
	
	for k,v in pairs(self.TeleportPanels) do
		if v and v:IsValid() then
			v:Remove()
		end
	end
	
	self.TeleportPanels = {}
	
	for k,v in pairs(self.LabList) do -- this should really be extracted into a parent panel but whatever
		if v and v:IsValid() then
			v:Remove()
		end
	end
	
	self.LabList = {}
	
	for i = 1, #self.Teleporters do  
		local selfTele = false
		local v = self.Teleporters[i]

		if v[3] == MySelf.StartingTeleport then
			selfTele = true
		end

		local img = vgui.Create("DButton", self)
		table.insert(self.TeleportPanels, img)
		img:SetSize(64, 64)
		img:SetText("")
		img.teleporter = v[3]
		img.Paint = function(s, w, h) end
		
		local ch = vgui.Create("DSprite", img)
		ch:SetSize(64,64)
		ch:SetPos(32,32)
		ch:SetMaterial(matSprite)
		ch:SetColor(selfTele and colSpritePrev or colSprite)
		
		img.DoClick = function(self) 
			RunConsoleCommand("zs_teleport", tostring(v[3]:EntIndex()))
		end
		
		local lab = vgui.Create("DLabel", self)
		table.insert(self.LabList, lab)
		lab:SetText(v[1]:IsValid() and v[1]:ClippedName() or "Unowned")
		lab:SizeToContents()
		img.lab = lab
	end
	
	local fFrac = 360 / #self.TeleportPanels --how many segments does a perfect circle get split up into
	local rFrac = math.rad(fFrac) --now we convert those segments to radians, something math.cos and math.sin can use
	for i = 1, #self.TeleportPanels do --now lets place all these segments
		local spr = self.TeleportPanels[i]
		spr:SetPos(ScrW() / 2 + math.cos(rFrac * i) * fCircleRadius - spr:GetWide() / 2, ScrH() / 2 + math.sin(rFrac * i) * fCircleRadius - spr:GetTall() / 2) --now they are placed perfectly at the edge of the circle where the segments should be
		local posx, posy = spr:GetPos()
		spr.lab:SetPos(posx + spr:GetWide() / 2 - spr.lab:GetWide() / 2, posy + spr:GetTall())
	end

end

function PANEL:SetMenuTime(fTime)
    self.m_MenuTime = CurTime() + fTime
end

function PANEL:GetMenuTime()
    return self.m_MenuTime
end

function PANEL:Think()
    local fTime = self:GetMenuTime()
    if fTime <= CurTime() then 
        self:Remove()
    end
	self.BaseClass.Think(self)
end

vgui.Register("DTeleportMenu", PANEL, "DFrame")
--[[
timer.Simple(0, function()
	if AAA and AAA:IsValid() then AAA:Remove() end
	AAA = vgui.Create("DTeleportMenu")
end)
--]]