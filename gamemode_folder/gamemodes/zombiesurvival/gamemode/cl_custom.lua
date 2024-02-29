--credit system

local creditConVar = CreateClientConVar("zs_displaycredits", 1, true, false, "Displays credits if nonzero")
local statConVar = CreateClientConVar("zs_displaystats", 1, true, false, "Displays stats if nonzero")
local healConVar = CreateClientConVar("zs_displaystats_heal", 1, true, false, "Displays heal stats if nonzero")

local creditCookie = creditConVar:GetInt() or 0
local statCookie = statConVar:GetInt() or 0
local healCookie = healConVar:GetInt() or 0

--TODO: Use this cache function to setup proper Y offsets for the stat HUD
local function CFontSize(font) --for use when caching text sizes
	surface.SetFont(font)
	return surface.GetTextSize("W")
end

net.Receive("statUpdate", function(ln)
	ply = MySelf
	ply.statHKills = net.ReadUInt(24)
	ply.statZKills = net.ReadUInt(24)
	ply.statTHealed = net.ReadUInt(24)
	--ply.statSPoints = net.ReadUInt(24)
end)

net.Receive("statEffect", function(ln)
	local amt = net.ReadUInt(8) or 0
	local pos = net.ReadVector() or Vector(0,0,0)
	local effect = EffectData()
	effect:SetOrigin(pos)
	effect:SetMagnitude(amt)
	util.Effect("floatingscore_credits", effect)
end)

local function valRefresh()
	creditCookie = creditConVar:GetInt() or 1
	statCookie = statConVar:GetInt() or 1
	healCookie = healConVar:GetInt() or 1
end

cvars.AddChangeCallback("zs_displaycredits", function()
	valRefresh()
end)

cvars.AddChangeCallback("zs_displaystats", function()
	valRefresh()
end)

cvars.AddChangeCallback("zs_displaystats_heal", function()
	valRefresh()
end)

--minor optimization defining all these strings outside of the paint hook
local font = "ZSHUDFontSmaller"
local colStat = Color(128, 0, 255)
local colOutline = Color(147, 0, 205, 255)
local strKaH = "Kills as Human: "
local strKaZ = "Kills as Zombie: "
local strTHealed = "Total Healed: "
local strNA = "N/A"
local strNewLine = "\n"
local hkills
local zkills
local theals
local wid2, hei2 = 300, 150
local colBG2 = Color(27, 0, 43, 190)
local x2, y2 = wid2 * 0, hei2 * 2.4


--local tKaZ = {strKaZ, nil}
--local tKaH = {strKaH, nil}
--local tTHealed = {strTHealed, nil}

hook.Add("HUDPaint", "creditAmount", function()
    hkills = MySelf.statHKills or strNA
    zkills = MySelf.statZKills or strNA
    theals = MySelf.statTHealed or strNA

    draw.RoundedBox(4, x2, y2, wid2, hei2, colBG2)
    draw.SimpleText("Metro Account", font, wid2 * 0.25, hei2 * 2.5, Color(255, 255, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    if statCookie == 1 then
        draw.SimpleText(strKaZ..hkills, font, 10, 400, colStat, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        draw.SimpleText(strKaH..zkills, font, 10, 425, colStat, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        if healCookie == 1 then
            draw.SimpleText(strTHealed..theals, font, 10, 450, colStat, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        end
    end

    -- Always display PointShop points
    if MySelf.PS then
        local points = MySelf:PS_GetPoints()
        draw.SimpleText("Anon Coins: "..points, font, 10, 475, colStat, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    end
end)

--settings

hook.Add("AddExtraOptions", "StatOptions", function(list, Window)
	local check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Display stats")
	check:SetConVar("zs_displaystats")
	check:SizeToContents()
	
	list:AddItem(check)

	local check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Display heal stats")
	check:SetConVar("zs_displaystats_heal")
	check:SizeToContents()
	
	list:AddItem(check)
	
	local check = vgui.Create("DCheckBoxLabel", Window) 
		  check:SetText("HD Effects")
		  check:SetConVar("cl_new_impact_effects")
		  check:SizeToContents() 
		  
    list:AddItem(check) 
	
end)




--z fullbright
local LightingModeChanged = false
hook.Add("PreRender", "fullbright", function()
	if GAMEMODE.m_ZombieVision and ply:IsValid() and ply:Team() == TEAM_UNDEAD then
		render.SetLightingMode(2)
		LightingModeChanged = true
	end
end)

local function EndOfLightingMod()
	if LightingModeChanged then
		render.SetLightingMode(0)
		LightingModeChanged = false
	end
end
hook.Add( "PostRender", "fullbright", EndOfLightingMod )
hook.Add( "PreDrawHUD", "fullbright", EndOfLightingMod )

--some player optimizations, nodraw, flashlight
hook.Add("PrePlayerDraw", "noFlashlight", function(ply)
	if ply:IsEffectActive(EF_DIMLIGHT) and ply ~= MySelf then
		ply:RemoveEffects(EF_DIMLIGHT)
	end
end)

--special rounds

--credit to Moat (https://facepunch.com/member.php?u=634709)
local function m_AlignText(text, font, x, y, xalign, yalign)
    surface.SetFont(font)
    local textw, texth = surface.GetTextSize(text)

    if (xalign == TEXT_ALIGN_CENTER) then
        x = x - (textw / 2)
    elseif (xalign == TEXT_ALIGN_RIGHT) then
        x = x - textw
    end

    if (yalign == TEXT_ALIGN_BOTTOM) then
        y = y - texth
    end

    return x, y
end

function GlowColor(col1, col2, mod)
    local newr = col1.r + ((col2.r - col1.r) * (mod))
    local newg = col1.g + ((col2.g - col1.g) * (mod))
    local newb = col1.b + ((col2.b - col1.b) * (mod))

    return Color(newr, newg, newb)
end

function DrawEnchantedText(speed, text, font, x, y, color, glow_color, xalign, yalign)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    local glow_color = glow_color or Color(127, 0, 255)
    local texte = string.Explode("", text)
    local x, y = m_AlignText(text, font, x, y, xalign, yalign)
    surface.SetFont(font)
    local chars_x = 0

    for i = 1, #texte do
        local char = texte[i]
        local charw, charh = surface.GetTextSize(char)
        local color_glowing = GlowColor(glow_color, color, math.abs(math.sin((RealTime() - (i * 0.08)) * speed)))
        draw.SimpleText(char, font, x + chars_x, y, color_glowing, xalign, yalign)
        chars_x = chars_x + charw
    end
end

local next_electric_effect = CurTime() + 0
local electric_effect_a = 0

function DrawElectricText(intensity, text, font, x, y, color, xalign, yalign)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    local charw, charh = surface.GetTextSize(text)
    draw.SimpleText(text, font, x, y, color, xalign, yalign)

    if (electric_effect_a > 0) then
        electric_effect_a = electric_effect_a - (1000 * FrameTime())
    end

    surface.SetDrawColor(102, 255, 255, electric_effect_a)
	local charwcorrection
    for i = 1, math.random(5) do
		if xalign == TEXT_ALIGN_CENTER then
			charwcorrection = charw / 2
		end
		
        line_x = math.random(charw)
        line_y = math.random(charh)
        line_x2 = math.random(charw)
        line_y2 = math.random(charh)
        surface.DrawLine(x - line_x, y + line_y, x + line_x2, y + line_y2)
    end

    local effect_min = 0.5 + (1 - intensity)
    local effect_max = 1.5 + (1 - intensity)

    if (next_electric_effect <= CurTime()) then
        next_electric_effect = CurTime() + math.Rand(effect_min, effect_max)
        electric_effect_a = 255
    end
end

local drawIncomingText = 0
local drawInfo = 0
local rules = ""
local title = ""

local strIncoming = "INCOMING SPECIAL ROUND!"
local strFont = "ZSHUDFont"
local colBlue = Color(51, 204, 255)
local colGold = Color(218,165,32)
hook.Add("HUDPaint", "SpecialRoundInfo", function()
	if drawIncomingText > CurTime() then
		DrawElectricText(2, strIncoming, strFont, ScrW() / 2, ScrH() / 2 - 200, colBlue, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
	
	if drawInfo > CurTime() then
		DrawEnchantedText(2, GAMEMODE.SpecialRoundTitle, strFont, ScrW() / 2, ScrH() / 2 - 300, colBlue, colGold, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		DrawEnchantedText(2, GAMEMODE.SpecialRoundRules, strFont, ScrW() / 2, ScrH() / 2 - 200, color_white, colGold, TEXT_ALIGN_CENTER)
	end
end)

local plySnd = Sound("ambient/alarms/warningbell1.wav")

net.Receive("SpecialRoundIncoming", function(ln)
	if GAMEMODE:GetWave() == 0 then
		drawIncomingText = CurTime() + GAMEMODE.SpecialRoundIncomingHoldTime
		surface.PlaySound(plySnd)
	end
end)

net.Receive("SpecialRoundRules", function(ln)
	local func = net.ReadUInt(8)
	if SpecialRounds[func] then
		SpecialRounds[func]() --this will set all the shared strings necessary for drawInfo to work
		drawInfo = CurTime() + GAMEMODE.SpecialRoundRuleHoldTime
	end
end)


--antispawncamp, client extension

hook.Add("PreDrawHalos", "targetHalo", function()
	local lp = MySelf
	if istable(lp.m_MarkedTarget) and IsTableOfEntitiesValid(lp.m_MarkedTarget) and lp.m_MarkedTarget[1]:IsPlayer() and lp.m_MarkedTarget[1]:Team() == TEAM_HUMAN and lp:Team() == TEAM_UNDEAD then
		halo.Add(lp.m_MarkedTarget, Color(255, 10, 10), 7, 7, 2)
	end
end)

net.Receive("Skeletor", function(ln)
	local attacker = net.ReadEntity()
	local self = MySelf
	if self:Team() == TEAM_UNDEAD then
		self.m_MarkedTarget = {[1] = attacker}
	end
	print(self.m_MarkedTarget)
end)

net.Receive("SkeletorEnd", function(ln)
	local lp = MySelf
	local boll = net.ReadBool()
	lp.m_MarkedTarget = nil
	lp.m_MarkedTarget = false
	print(lp.m_MarkedTarget)
end)

--close endingmenu at mapvote
net.Receive("CloseEndingMenu", function(ln)
	if pEndBoard and pEndBoard:IsValid() then
		pEndBoard:Remove()
	end
end)

--thirdperson

function SetThirdPerson(ply, cmd, tblArgs, strArgs)
	ply.m_3p = ply.m_3p ~= 2 and 2 or 0
end

concommand.Add("zs_togglethirdperson", SetThirdPerson)

hook.Add("CalcView", "thirdperson", function(ply, ori, ang, fov, nz, fz)
	--gotta use case structure eventually cause this will lose frames
	if ply.m_3p == 1 and ply:Team() == TEAM_HUMAN then --default behind view
		local angvec = ang:Forward()
		local tracedata = {}
		tracedata.start = ori
		tracedata.endpos = ori + Vector(0,0,10) + angvec * -50
		local data = util.TraceLine(tracedata)
		
		
		local view = {}
		if data.Hit and data.HitWorld or data.HitSky then
			view.origin = data.HitPos
		else
			view.origin = ori + Vector(0,0,10) + angvec * -50
		end
		
		view.angles = ang
		view.drawviewer = true
		view.fov = fov
		return view
	elseif ply.m_3p == 2 and ply:Team() == TEAM_HUMAN then --over weapon shoulder
		local angvec = ang:Forward()
		local fixvec = Vector(0,-8,0)
		local tracedata = {}
		tracedata.start = ori
		tracedata.endpos = ori + Vector(0,0,10)+fixvec + angvec * -50
		local data = util.TraceLine(tracedata)

		local view = {}

		fixvec:Rotate(ang)
		if data.Hit and data.HitWorld or data.HitSky then
			view.origin = data.HitPos
		else
			view.origin = ori + Vector(0,0,10)+fixvec + angvec * -50
		end
		view.angles = ang
		view.drawviewer = true
		view.fov = fov
		return view
	end
end)
--]]

--buy from arsenalcrate
CreateClientConVar("gc_quickammomethod", 1, true, false, "Method to buy ammo from the arsenal using the +menu key (Q by default)\n0 is 1 box, 1 is 3 boxes")

local ammoMethodConVar = GetConVar("gc_quickammomethod")
local ammoMethodCookie = ammoMethodConVar:GetInt() or 1

hook.Add("AddExtraOptions", "ammoMethodOptions", function(list, Window)
	list:AddItem(EasyLabel(Window, "QuickBuy Ammo Method", "DefaultFontSmall", color_white))

	local dropdown = vgui.Create("DComboBox", Window)
	dropdown:SetMouseInputEnabled(true)
	dropdown:AddChoice("1 Ammo Box")
	dropdown:AddChoice("3 Ammo Boxes")
	dropdown.OnSelect = function(me, index, value, data)
		RunConsoleCommand("gc_quickammomethod", value == "3 Ammo Boxes" and 1 or 0)
	end
	dropdown:SetText(ammoMethodCookie == 1 and "3 Ammo Boxes" or "1 Ammo Box")
	list:AddItem(dropdown)
end)


hook.Add("PlayerButtonDown", "ArsenalQuickBuy", function(ply, key)
	local nextbuy = nextbuy or 0
	if nextbuy < CurTime() and IsFirstTimePredicted() then
		if input.LookupKeyBinding(key) == "+menu" then
			if ply:IsValid() and ply:IsPlayer() and ply:Team() == TEAM_HUMAN then
				if not ply:GetActiveWeapon() or not ply:GetActiveWeapon():IsValid() then return end
				local ammo = game.GetAmmoName(ply:GetActiveWeapon():GetPrimaryAmmoType())
				if ammo == nil then return end
				ammo = GAMEMODE.PointShopAmmoNames[string.lower(ammo)]
				if ammo == nil then return end
				if ammoMethodConVar:GetInt() == 1 then
					ammo = "3"..ammo
				end

				nextbuy = CurTime() + 0.3
				RunConsoleCommand("zs_pointsshopbuy", "ps_"..ammo)
			end
		end
	end
end)

--3d/2d HUD option s
CreateClientConVar("gc_3dhud", 0, true, false, "Enables the ZS 3D health system, but may reduce FPS\n0 = Use 2D HUD\n1 = Use 3D HUD") 
CreateClientConVar("gc_3dhud_ammo", 1, true, false, "Enables the CW 3D ammo system, but may reduce FPS\n0 = Use 2D HUD\n1 = Use 3D HUD") 

hook.Add("AddExtraOptions", "healthOptions", function(list, Window)
	local check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Use 3D health HUD (lower FPS)")
	check:SetConVar("gc_3dhud")
	check:SizeToContents()
	list:AddItem(check)
end)

local gradient = surface.GetTextureID("cw2/gui/gradient")
hook.Add("HookGetLocal", "HUDColor Instancing", function(ply)
	MySelf.HUDColors = {white = Color(255, 255, 255),
	red = Color(255, 150, 150, 255),
	deepRed = Color(255, 110, 110, 255),
	black = Color(0, 0, 0),
	green = Color(200, 255, 200, 255)}
end)

local cwhud24 = "CW_HUD24"
local cwhud22 = "CW_HUD22"
local cwhud20 = "CW_HUD20"
local cwhud16 =	"CW_HUD16"
local cwhud14 = "CW_HUD14"

local function GetPoisonValue()
	local dmg = MySelf:GetPoisonDamage()
	if dmg > 0 then
		return dmg
	end
end

local function GetBleedValue()
	local dmg = MySelf:GetBleedDamage()
	if dmg > 0 then
		return dmg
	end
end

local function GetGhoulTouchValue()
	local entStatus = MySelf:GetStatus("ghoultouch")
	if entStatus and entStatus:IsValid() then
		if math.max(entStatus.DieTime - CurTime(), 0) > 0 then
			return math.max(entStatus.DieTime - CurTime(), 0)
		end
	end
end

local function GetBurnValue()
	if MySelf:GetFireDamage() > 0 then
		return MySelf:GetFireDamage()
	end
end

local function GetRegenValue()
	if MySelf:GetRegenLife() > 0 then
		return MySelf:GetRegenLife()
	end
end

statusTbl = {
	--format: color of status bar, text to display, max amount of status units (like poison dmg), and last is a function for method of retrieval of information
	[1] = {Color(247, 237, 42), "POISONED!", 50, GetPoisonValue},
	[2] = {Color(255, 0, 0), "BLEED!", 50, GetBleedValue},
	[3] = {Color(255, 140, 0), "GHOUL TOUCH!", 10, GetGhoulTouchValue},
	[4] = {Color(255, 125, 0), "BURN!", 250, GetBurnValue},
	[5] = {Color(0, 255, 0), "HEAL!", 40, GetRegenValue},
}

local STATUS_POISON = 1
local STATUS_BLEED = 2
local STATUS_GHOULTOUCH = 3
local STATUS_FIRE = 4
local STATUS_LIFE = 5

local strHealth = "HEALTH: "
local strLB = " ["
local strRB = "]"
local strFontHealth = "ZSHUDFontSmaller"
local strHA = "ZSHealthArea"
local strCvar = "gc_3dhud"
local step = 20
local DEBUGStatHUDTime = "Time to draw status HUD: "
local DEBUGHealthHUDTime = "Time to draw ENTIRE health HUD: "
local DEBUGTotalTime = "Total time: "
hook.Add("HUDPaint", "HealthHUDValidate", function()
	if GetConVarNumber(strCvar) == 1 then
		if not GAMEMODE.HealthHUD then
			GAMEMODE.HealthHUD = vgui.Create(strHA)
		end
	else
	if GAMEMODE.HealthHUD then
		GAMEMODE.HealthHUD:Remove()
		GAMEMODE.HealthHUD = nil
	end
	--START health HUD generation
	if not MySelf:Alive() then return end
	local FT = FrameTime()
	
	local x, y = ScrW(), ScrH()
	
	MySelf.HUDColors.white.a = 255
	MySelf.HUDColors.black.a = 255
	local baseX, baseY = 90, y - 125
	
	surface.SetDrawColor(24,0,69)
	surface.SetTexture(gradient)
	surface.DrawTexturedRect(baseX - 5, baseY - 15, 500, 105)

	-- draw the bottom-left part of the HUD; aka health and armor
	draw.ShadowText(strHealth, cwhud24, baseX, baseY, MySelf.HUD_HealthTextColor, COLOR_GREEN, 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.ShadowText("POWER CELL: ", cwhud24, baseX, baseY + 60, MySelf.HUD_HealthTextColor, COLOR_CYAN, 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	
	local hp = MySelf:Health() or 0
	local maxhp = MySelf:GetMaxHealthEx() or 0
	local pipWorth = maxhp / 20
	local arm = MySelf:Armor() or 0
	
	-- approach the health and armor values rather than snapping, so that the pips fill up gradually
	MySelf.HUD_LastHealth = math.Approach(MySelf.HUD_LastHealth or hp, hp, FT * 100)
	MySelf.HUD_LastArmor = math.Approach(MySelf.HUD_LastArmor or 0, arm, FT * 100)
	
	-- draw the health and armor text
	draw.ShadowText(hp, cwhud24, baseX + 100, baseY, MySelf.HUD_HealthTextColor, COLOR_GREEN, 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.ShadowText(arm .. "%", cwhud24, baseX + 140, baseY + 60, MySelf.HUDColors.white, COLOR_CYAN, 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

	local healthPips = math.Clamp(math.floor(MySelf.HUD_LastHealth / pipWorth), 1, 20)
	local armorPips = math.Clamp(math.floor(MySelf.HUD_LastArmor / 5), 0, 20)
	
	-- black health and armor pips (to avoid unnecessary SetDrawColor calls)
	surface.SetDrawColor(45, 0, 72)
	
	for i = 1, healthPips do
		surface.DrawRect(baseX + (i - 1) * 12 + 2, baseY + 16, 5, 10)
	end
	
	for i = 1, armorPips do
		surface.DrawRect(baseX + (i - 1) * 12 + 2, baseY + 36, 5, 10)
	end

	-- colored health pips
	for i = 1, healthPips do
		surface.SetDrawColor(240 - i * 10, i * 12.75, i * 4, 255)
		surface.DrawRect(baseX + (i - 1) * 12 + 1, baseY + 15, 5, 10)
	end

	-- colored armor pips
	for i = 1, armorPips do
		surface.SetDrawColor(0, 125 + i * 6.5, 200 + i * 2.75, 255)
		surface.DrawRect(baseX + (i - 1) * 12 + 1, baseY + 35, 5, 10)
	end

	--now we should account for all the things zs does in terms of statuses
	local t2 = SysTime()
	local status = {}
	--now lets check for possible statuses
	for stat, val in ipairs(statusTbl) do
		status[stat] = val[4]()
	end
	--and then process them!
	if table.Count(status) == 0 then return end
	
	local YOffset = 35
	for status, val in pairs(status) do
		local info = statusTbl[status]
		local max = info[3]
		surface.SetDrawColor(info[1])
		surface.DrawOutlinedRect(baseX - 5, baseY - YOffset, 300, 15)
		surface.DrawRect(baseX - 5, baseY - YOffset, 300 * math.Clamp(val / max, 0, 1), 15)
		draw.SimpleText(info[2]..strLB..math.Round(val)..strRB, strFontHealth, baseX + 300, baseY - YOffset + 7, info[1], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		YOffset = YOffset + step
	end

	end
end)
--CW muzzleflash effect options 
CreateClientConVar("cw_muzzlelighting", 2, true, false, "Sets how muzzleflash light will be handled.\n0 = Disabled, best performance\n1 = Enabled, no model lighting, better performance\n2 = Enabled, full lighting")
CreateClientConVar("cw_muzzleflash", 1, true, false, "Sets whether or not to draw muzzleflashes.\n0 = Disabled\n1 = Enabled")

hook.Add("AddExtraOptions", "MuzzleOptions", function(list, Window)
	local check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Display muzzleflashes")
	check:SetConVar("cw_muzzleflash")
	check:SizeToContents()
	list:AddItem(check)

	local check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Display muzzleflash projected texture")
	check:SetConVar("cw_muzlight")
	check:SizeToContents()
	list:AddItem(check)

	list:AddItem(EasyLabel(Window, "Muzzleflash lighting style", "DefaultFontSmall", color_white))

	local dropdown = vgui.Create("DComboBox", Window)
	dropdown:SetMouseInputEnabled(true)
	dropdown:AddChoice("Full lighting")
	dropdown:AddChoice("Lighting, no lit models")
	dropdown:AddChoice("No light")
	dropdown.OnSelect = function(me, index, value, data)
		RunConsoleCommand("cw_muzzlelighting", value == "Full lighting" and 2 or value == "Lighting, no lit models" and 1 or 0)
		timer.Simple(0.1, ThirdpersonCacheRefresher)
	end

	local num = cvars.Number("cw_muzzlelighting", 2)
	dropdown:SetText(num == 2 and "Full lighting" or num == 1 and "Lighting, no lit models" or "No light")

	list:AddItem(dropdown)
end)

--zpoint system - clientside module, by MagicSwap
net.Receive("pointUpdate", function(ln)
	local ply = MySelf
	ply.ZPoints = net.ReadUInt(12) --honestly if someone could get more than 4000 zpoints that would be amazing in of itself
end)

--blood gain effect
net.Receive("pointEffect", function(ln)
	local amt = net.ReadUInt(8) or 0
	local pos = net.ReadVector() or Vector(0,0,0)
	local effect = EffectData()
	effect:SetOrigin(pos)
	effect:SetMagnitude(amt)
	util.Effect("floatingscore_blood", effect)
end)

--minor optimization defining all these strings outside of the paint hook
local font = "ZSHUDFont"
local hintfont = "ZSHUDFontSmall"
local colPoint = team.GetColor(TEAM_UNDEAD)
local colOutline = Color(0, 0, 0)
local strPointText = "Blood (mL): "
local strNA = "N/A"
local pts
--local strPointHint = "Use the F3 menu to upgrade zombie classes!"
hook.Add("HUDPaint", "pointAmount", function()
	if MySelf:Team() ~= TEAM_UNDEAD then return end --of course, this will only be shown as a zombie

	pts = MySelf.ZPoints or strNA
	draw.SimpleText(strPointText..pts, font, ScrW() - 100, ScrH() - 100, colPoint, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
	--draw.SimpleTextOutlined(strPointHint, hintfont, ScrW() - 40, ScrH() - 50, colPoint, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
end)

--Teleporter clientside helper
net.Receive("zs_teleport_init", function(ln)
	MySelf.StartingTeleport = net.ReadEntity()
	GAMEMODE.TeleportMenu = vgui.Create("DTeleportMenu")
end)

net.Receive("zs_teleport_final", function(ln)
	GAMEMODE.TeleportMenu:Close()
	MySelf.HasTeleported = true
end)

--teleporteffect working function
hook.Add("RenderScreenspaceEffects", "TeleEffect", function()
	local ply = MySelf
	if ply.HasTeleported then
		DrawMaterialOverlay("effects/tp_eyefx/tpeye", 1)
		timer.Simple(3, function()
			ply.HasTeleported = nil
		end)
	end
end)

--CW20 reload move option, uses the edits MagicSwap made to the base (didn't want to use hooks to modify every weapon)
CreateClientConVar("gc_viewmove", 1, true, false, "Controls the view movement when reload CW 2.0 weapons.\n0 = No movement\n1 = Movement")
hook.Add("AddExtraOptions", "shootOptions", function(list, Window)
	local check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Enable view movement during reload")
	check:SetConVar("gc_viewmove")
	check:SizeToContents()
	list:AddItem(check)
end)

--funny stuff
function PartyTrickURLMenu(onoff, url)
    if PARTYTRICK_URL_PANEL and PARTYTRICK_URL_PANEL:IsValid() then
        if onoff == true then
			print("Panicked, returned in menu function")
            return
        else
            PARTYTRICK_URL_PANEL:Remove()
			return
        end
    end
    
	if not onoff then return end
    if not url then return end

    PARTYTRICK_URL_PANEL = vgui.Create("HTML")
    PARTYTRICK_URL_PANEL:SetSize(ScrW() - 200, ScrH() - 300)
    PARTYTRICK_URL_PANEL:Center()
    PARTYTRICK_URL_PANEL:OpenURL(url)
end

--custom wavestate hud element, rewritten into HUD Paint because it is faster
--[
local iHumans
local iZombies
local function RefreshTeamCounts()
	iHumans = team.NumPlayers(TEAM_HUMAN)
	iZombies = team.NumPlayers(TEAM_UNDEAD)
end

local strH = " H: "
local strZ = " Z: "
local strNewLine = "\n"
local colHumans = team.GetColor(TEAM_HUMAN)
local colZombies = team.GetColor(TEAM_UNDEAD)
local colOutline = Color(0,0,0)
local prepare = translate.Get("prepare_yourself")
local zescape = translate.Get("zombie_escape")
local inter = translate.Get("intermission")
local escapez = "prop_obj_exit_z"
local escapeh = "prop_obj_exit_h"
local strXofY = "wave_x_of_y"
local strDash = " - "
local strHUDOverride1 = "hudoverride"
local strEmpty = ""
local strFontSmall = "ZSHUDFontSmaller"
local strFontSmaller = "ZSHUDFontSmaller"
local zinvstr = "zombie_invasion_in_x"
local waveEnd = "wave_ends_in_x"
local nextwave = "next_wave_in_x"
local brainseaten = "brains_eaten_x"
local points = "points_x"
local points2 = "Score: "
local strSlash = " / "
local nextRefresh = 0
local t --debug var

--Need these variables setup when the paint hook is first called, setting it up here sometimes causes errors
local bFontsSetup = false
local w, h
local w2, h2
local text
local override
local wave
local maxwaves
local glow
local col = Color(255, 0, 0)
local timeleft
local waveend
local wavestart
local toredeem

local wid, hei = 150, 150
local colBG = Color(16, 16, 16, 200)
local x, y = wid * 0, hei * 0.6


hook.Add("HUDPaint", "WavestateHUD", function()
	--t = SysTime()
	if nextRefresh < RealTime() then
		RefreshTeamCounts()
		nextRefresh = RealTime() + 1
		if not bFontsSetup then
			w, h = CFontSize(strFontSmaller)
			w2, h2 = CFontSize(strFontSmall)
			bFontsSetup = true
		end
	end

	draw.RoundedBox(8, x, y, wid, hei, colBG2)


	--first lets draw the number of players on each team
	--humans
	draw.SimpleText(strH..iHumans, strFontSmall, 5, 0, colHumans)
	--zombies
	draw.SimpleText(strZ..iZombies, strFontSmall, 5, 40, colZombies)

	--now lets draw the rules
	override = MySelf:IsValid() and GetGlobalString(strHUDOverride1..MySelf:Team(), strEmpty)
	wave = GAMEMODE:GetWave()
	if override and #override > 0 then
		text = override
	else
		if GAMEMODE:IsEscapeSequence() then
			text = translate.Get(MySelf:IsValid() and MySelf:Team() == TEAM_UNDEAD and escapez or escapeh)
		elseif wave <= 0 then
			text = prepare
		elseif GAMEMODE.ZombieEscape then
			text = zescape
		else
			maxwaves = GAMEMODE:GetNumberOfWaves()
			if maxwaves ~= -1 then
				text = translate.Format(strXofY, wave, maxwaves)
				if not GAMEMODE:GetWaveActive() then
					text = inter..strDash..text
				end
			elseif not GAMEMODE:GetWaveActive() then
				text = inter
			end
		end
	end

	if text then
		draw.SimpleText(text, strFontSmaller, 80, 0, COLOR_GRAY)
	end

	--now we draw timers
	if wave <= 0 then
		timeleft = math.max(0, GAMEMODE:GetWaveStart() - CurTime())
		if timeleft < 10 then
			glow = math.sin(RealTime() * 8) * 200 + 255
			col = Color(190, glow, glow)
		else
			col = COLOR_GRAY
		end

		draw.SimpleText(translate.Format(zinvstr, util.ToMinutesSeconds(timeleft)), strFontSmaller, 80, h, col)
	elseif GAMEMODE:GetWaveActive() then
		waveend = GAMEMODE:GetWaveEnd()
		if waveend ~= -1 then
			timeleft = math.max(0, waveend - CurTime())
			draw.SimpleText(translate.Format(waveEnd, util.ToMinutesSeconds(timeleft)), strFontSmaller, 80, h, 10 < timeleft and COLOR_GRAY or Color(255, 0, 0, math.abs(math.sin(RealTime() * 8)) * 180 + 40))
		end
	else
		wavestart = GAMEMODE:GetWaveStart()
		if wavestart ~= -1 then
			local timeleft = math.max(0, wavestart - CurTime())
			draw.SimpleText(translate.Format(nextwave, util.ToMinutesSeconds(timeleft)), strFontSmaller, 80, h, 10 < timeleft and COLOR_GRAY or Color(255, 0, 0, math.abs(math.sin(RealTime() * 8)) * 180 + 40))
		end
	end

	--and then we draw the scores
	if MySelf:Team() == TEAM_UNDEAD then
		toredeem = GAMEMODE:GetRedeemBrains()
		if toredeem > 0 then
			draw.SimpleText("Brains: "..MySelf:Frags(), strFontSmaller, 10, h*4.5, Color(249, 0, 0))
		end
	else
			draw.SimpleText(translate.Format(points, MySelf:GetPoints()), strFontSmaller,10, h*4.5, Color(0, 255, 213))
			draw.SimpleText("Score: "..MySelf:Frags(), strFontSmaller,10, h*5.5, Color(0, 255, 213))
	end
	--print("Time taken to draw WaveState: ", SysTime() - t)
end)

--achievement system, clientside module
--purpose: to notify players of gained achievements, any other things can be added onto here as well

--enumerations
ACHIEVEMENT_ACTION = 0
ACHIEVEMENT_PROGRESS = 1
ACHIEVEMENT_TIERED_PROGRESS = 2

local colWhite = Color(255, 255, 255)
local colPurple = Color(230, 71, 255)
local colOrange = Color(255, 135, 71)
local colGreen = Color(40, 255, 40)
net.Receive("zs_achievements", function(length)
	local type = net.ReadUInt(2)
	local ply = net.ReadEntity()
	local name = net.ReadCString()
	local bAllTiers = false
	local tname = "UNKNOWN"
	if type == ACHIEVEMENT_TIERED_PROGRESS then
		tname = net.ReadCString()
		bAllTiers = net.ReadBool()
	end

	if ply and ply:IsValid() then
		if type == ACHIEVEMENT_TIERED_PROGRESS then
			if bAllTiers then
				chat.AddText(colGreen, "[ZS ACHIEVEMENTS] ", colWhite, "Player ", colPurple, ply:Nick(), colWhite, " unlocked all tiers of the achievement ",
				colOrange, name, colWhite, "!")
			else
				chat.AddText(colGreen, "[ZS ACHIEVEMENTS] ", colWhite, "Player ", colPurple, ply:Nick(), colWhite, " unlocked the achievement tier ",
				colOrange, tname, colWhite, " of achievement ", colOrange, name, colWhite, "!")
			end
		else
			chat.AddText(colGreen, "[ZS ACHIEVEMENTS] ", colWhite, "Player ", colPurple, ply:Nick(), colWhite, " unlocked the achievement ",
			colOrange, name, colWhite, "!")
		end
	end
end)

--achievement menu
net.Receive("zs_achievements_menu", function(length)
	local tbl = net.ReadDataTable(length / 8) --player achievement info
	if tbl then
		local pFrame = vgui.Create("DFrame")
		pFrame:SetSize(ScrW() / 2, ScrH() / 2)
		pFrame:SetTitle("Achievements")
		pFrame:SetDraggable(false)
		pFrame:Center()
		pFrame:MakePopup()

		local pScroll = vgui.Create("DScrollPanel", pFrame)
		pScroll:Dock(FILL)
		
		local pList = vgui.Create("DListLayout", pScroll)
		pList:Dock(FILL)

		
		--now the real fun begins
		for name, info in pairs(GAMEMODE.Achievements) do
			local a = tbl[name]
			local pPanel = vgui.Create("DPanel")
			local x, y = pFrame:GetWide(), 30
			pPanel:SetSize(x, y) --temporary value since we may need to add on to it
			local desc = "["..name.."] "..(info.desc or "")
			local desclab = EasyLabel(pPanel, desc, "ZSHUDFontSmall", COLOR_GREEN)
			desclab:Dock(TOP)

			local bMainUnlocked = a and a.unlocked and "Unlocked!" or "Locked!"

			if info.type == ACHIEVEMENT_ACTION then
				y = y + 30
				pPanel:SetSize(x, y)
				local progress = bMainUnlocked and "Unlocked!" or "Perform the action to unlock!"
				local proglab = EasyLabel(pPanel, progress, "ZSHUDFontTiny", COLOR_WHITE)
				proglab:Dock(TOP)
			end


			if info.type ~= ACHIEVEMENT_ACTION then
				if bMainUnlocked ~= "Unlocked!" then
					y = y + 30
					pPanel:SetSize(x, y)
					local progress = "Progress: "..(a and (a.progress or a.tiers and a.tiers.progress) or 0)
					local proglab = EasyLabel(pPanel, progress, "ZSHUDFontTiny", COLOR_WHITE)
					proglab:Dock(TOP)
				else
					y = y + 30
					pPanel:SetSize(x, y)
					local progress = "Unlocked!"
					local proglab = EasyLabel(pPanel, progress, "ZSHUDFontTiny", COLOR_WHITE)
					proglab:Dock(TOP)
				end
			end

			if info.tiers then
				for i, tab in pairs(info.tiers) do
					local ta = a and a.tiers and a.tiers[i]
					y = y + 30
					pPanel:SetSize(x, y)

					local bUnlocked = ta and ta.unlocked and true or false
					print(name)
					print(type(tab))
					print(tab)
					local name = tab.name --sigh
					local tiername = "Tier "..name.." (To Unlock: "..tab.limit..")"
					if bUnlocked then
						tiername = "Tier "..name.." (Unlocked!)"
					end
					local tierlab = EasyLabel(pPanel, tiername, "ZSHUDFontTiny", COLOR_WHITE)
					tierlab:Dock(TOP)
				end
			end
			--even though we did variable manipulations, the bounds are invalid
			pPanel:InvalidateLayout(true)
			pPanel:SizeToChildren(false, true)
			pList:Add(pPanel)
		end
	end
end)
--zs staff menu
--purpose: to view all zs punishments and make edits etc

--enumerations
ZSINFO_DELETE = 0
ZSINFO_MODIFY = 1
ZSINFO_ADD = 2
ZSINFO_COMMENT = 3
ZSINFO_COMMENT_VIEW = 4

ZSINFO_HAMMERBAN = 1
ZSINFO_BALLPIT = 2
ZSINFO_NOODLE = 3

ZSINFO_NAME = 1
ZSINFO_STEAMID = 2
ZSINFO_TYPE = 3
ZSINFO_PUNISHER = 4
ZSINFO_EXPIRY = 5

local function ChangePunishmentSubmit(sid, info, type)
	net.Start("zs_playerinfo")
		net.WriteUInt(ZSINFO_MODIFY, 4)
		net.WriteCString(sid)
		net.WriteUInt(type, 4)
		net.WriteCString(info)
	net.SendToServer()
end

local function SubmitComment(sid, info, type)
	net.Start("zs_playerinfo")
		net.WriteUInt(ZSINFO_COMMENT, 4)
		net.WriteCString(sid)
		net.WriteUInt(type, 4)
		net.WriteCString(info)
	net.SendToServer()
end

local function ChangePunishment(id, pnl)
	local sid = pnl:GetColumnText(ZSINFO_STEAMID)
	local info = pnl:GetColumnText(ZSINFO_TYPE)

	if id == ZSINFO_DELETE then
		net.Start("zs_playerinfo")
			net.WriteUInt(id, 4)
			net.WriteCString(sid)
			net.WriteCString(info)
		net.SendToServer()
		MySelf:ChatPrint("Successfully deleted entry!")
		pnl:Remove()
		return
	end

	local pFrame = vgui.Create("DFrame")
	pFrame:SetSize(ScrW() / 4, ScrH() / 6)
	pFrame:Center()
	pFrame:SetTitle("Change Punishment of "..pnl:GetColumnText(ZSINFO_NAME))

	local pTE = vgui.Create("DTextEntry", pFrame)
	pTE:SetText("Enter New Time")
	pTE:Dock(TOP)
	pTE.OnGetFocus = function(self) self:SetText("") end
	pTE.OnEnter = function(self) ChangePunishmentSubmit(sid, self:GetText()) pFrame:Close() end

	local pBtn = vgui.Create("DButton", pFrame)
	pBtn:Dock(BOTTOM)
	pBtn:SetText("Submit Change")
	pBtn.DoClick = function(self) ChangePunishmentSubmit(sid, pTE:GetText()) pFrame:Close() end
end

local function OpenCommentWindow(id, pnl)
	if id ~= ZSINFO_COMMENT_VIEW then
		local pFrame = vgui.Create("DFrame")
		pFrame:SetSize(ScrW() / 4, ScrH() / 6)
		pFrame:Center()
		pFrame:SetTitle("Submit comment for "..pnl:GetColumnText(ZSINFO_NAME))

		local pBtn = vgui.Create("DButton", pFrame)
		pBtn:Dock(BOTTOM)
		pBtn:SetText("Submit Comment")
		pBtn.DoClick = function(self) ChangePunishmentSubmit(sid, pTE:GetText()) pFrame:Close() end

		local pTE = vgui.Create("DTextEntry", pFrame)
		pTE:SetText("Enter Comment")
		pTE:Dock(FILL)
		pTE.OnGetFocus = function(self) if self:GetText() == "Enter Comment" then self:SetText("") end end
		pTE.OnEnter = function(self) SubmitComment(sid, self:GetText()) pFrame:Close() end
	else
		net.Start("zs_playerinfo_comments")
		net.SendToServer()
	end		
end

net.Receive("zs_playerinfo_comments", function(ln)
	local tComments = net.ReadDataTable(ln / 8)
	if tComments then
		local pFrame = vgui.Create("DFrame")
		pFrame:SetSize(ScrW() / 4, ScrH() / 4)
		pFrame:Center()
		pFrame:SetTitle("Viewing comments...")

		local scroll = vgui.Create("DScrollPanel", pFrame)
		scroll:Dock(FILL)

		for i = 1, #tComments do
			local sid = tComments[1]
			local content = tComments[2]

			local lab = vgui.Create("DLabel")
			lab:SetFont("ZSHUDFontSmall")
			lab:SetAutoStretchVertical(true)
			lab:SetWrap(true)
			lab:SetText(sid..": "..comment)
			scroll:Add(lab)
		end
	end
end)

net.Receive("zs_playerinfo", function(ln)
	local data = net.ReadDataTable(ln / 8)

	if data then
		local pFrame = vgui.Create("DFrame")
		pFrame:SetSize(ScrW() / 2.5, ScrH() / 2)
		pFrame:Center()
		pFrame:SetTitle("ZS Punishments")

		--local pSheet = vgui.Create("DPropertySheet", pFrame)
		--pSheet:Dock(FILL)
		
		local pBanList = vgui.Create("DListView", pFrame)
		pBanList:Dock(FILL)
		pBanList:SetMultiSelect(false)
		pBanList:AddColumn("Name")
		pBanList:AddColumn("SteamID")
		pBanList:AddColumn("Type")
		pBanList:AddColumn("Punisher")
		pBanList:AddColumn("Expiry")
		pBanList.OnRowRightClick = function(self, id, pLine)
			local pMenu = DermaMenu()
			local b
			--pMenu:SetParent(pBanList)
			b = pMenu:AddOption("Remove Punishment", function(self) ChangePunishment(ZSINFO_DELETE, pLine) end)
			b:SetIcon("icon16/group_delete.png")

			b = pMenu:AddOption("Modify Punishment", function(self) ChangePunishment(ZSINFO_MODIFY, pLine) end)
			b:SetIcon("icon16/group_edit.png")

			pMenu:AddSpacer()

			b = pMenu:AddOption("Add Comment", function(self) OpenCommentWindow(ZSINFO_COMMENT, pLine) end)
			b:SetIcon("icon16/comment_add.png")

			b = pMenu:AddOption("View Comments", function(self) OpenCommentWindow(ZSINFO_COMMENT_VIEW, pLine) end)
			b:SetIcon("icon16/comments.png")

			pMenu:Open()
		end

		for sid, tbl in pairs(data) do
			for ban, info in pairs(tbl) do
				local ply = player.GetBySteamID(sid)
				local aply = player.GetBySteamID(info[2])
				local aname = aply and aply:IsValid() and aply:Nick() or info[2]
				local name = ply and ply:IsValid() and ply:Nick() or info[3] or "***OFFLINE***"
				local expiry = info[1] == true and "Permanent" or os.date("%H:%M:%S - %d/%m/%Y", info[1])
				pBanList:AddLine(name, sid, ban, aname, expiry)
			end
		end

		pFrame:MakePopup()	
	end
end)

--emote system client

function OpenEmoteMenu()
	if MySelf.EmoteMenu and MySelf.EmoteMenu:IsValid() then return end

	local frame = vgui.Create("DFrame")
	frame:SetSize(ScrW() / 4, ScrH() / 2)
	frame:Center()
	frame:SetTitle("")

	local scroll = vgui.Create("DScrollPanel", frame)
	scroll:Dock(FILL)

	local list = vgui.Create("DListLayout", scroll)
	list:Dock(FILL)

	local panel = vgui.Create("DPanel")
	panel:SetSize(list:GetWide(), 120)
	list:Add(panel)

	local info = "Below is a list of all available emotes.\nClick to sample each one!\nRight click to copy to clipboard!"
	local infolab = EasyLabel(panel, info, "ZSHUDFontSmall", COLOR_GREEN)
	infolab:SetPos(20, panel:GetTall() * 0.5 - infolab:GetTall() * 0.5)
	panel.m_InfoLabe = infolab

	for text, info in SortedPairs(GAMEMODE.TextEmotes) do
		local btn = vgui.Create("DButton")
		btn:SetSize(list:GetWide(), 40)
		btn:SetText(text)
		btn:SetFont("ZSHUDFontSmallest")
		btn:SetColor(Color(255, 255, 255, 255))
		btn.DoClick = function(self) RunConsoleCommand("say", self:GetText()) end
		btn.DoRightClick = function(self) SetClipboardText(self:GetText()) end

		list:Add(btn)
	end
	frame:MakePopup()
	MySelf.EmoteMenu = frame
end

net.Receive("zs_openemotemenu", function(ln)
	OpenEmoteMenu()
end)


--force r_drawmodeldecals to 0, prevents a crash
hook.Add("HookGetLocal", "DisableModelDecals", function()
	RunConsoleCommand("r_drawmodeldecals", "0")
end)

--purpose: draw the nail assist text for when others repair another's nail

net.Receive("zs_repairobject_assist", function(ln)
	local ent = net.ReadEntity()
	local flPts = net.ReadFloat()
	if flPts and ent and ent:IsValid() then
		local data = EffectData()
		data:SetOrigin(ent:WorldSpaceCenter())
		data:SetMagnitude(flPts)

		util.Effect("floatingscore_nail_assist", data, true)
	end
end)

--purpose: add option to disable killfeed
local KFCvar = CreateClientConVar("zs_killfeed_enable", 1, true, false, "Enables/disables the ZS killfeed")

hook.Add("AddExtraOptions", "KillFeedOptions", function(list, Window)
	local check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Display killfeed (lower FPS)")
	check:SetConVar("zs_killfeed_enable")
	check:SizeToContents()
	
	list:AddItem(check)
end)

local function EvaluateKillFeed(cvar, prevval, newval)
	if newval == "1" then
		if not (GAMEMODE.TopNotificationHUD and GAMEMODE.TopNotificationHUD:IsValid()) then
			print(true)
			GAMEMODE.TopNotificationHUD = vgui.Create("DEXNotificationsList")
			GAMEMODE.TopNotificationHUD:SetAlign(RIGHT)
			GAMEMODE.TopNotificationHUD.PerformLayout = function(pan)
				local screenscale = BetterScreenScale()
				pan:SetSize(ScrW() * 0.4, ScrH() * 0.6)
				pan:AlignTop(16 * screenscale)
				pan:AlignRight()
			end
			GAMEMODE.TopNotificationHUD:InvalidateLayout()
			GAMEMODE.TopNotificationHUD:ParentToHUD()
		end
	else
		if GAMEMODE.TopNotificationHUD and GAMEMODE.TopNotificationHUD:IsValid() then
			GAMEMODE.TopNotificationHUD:Remove()
			GAMEMODE.TopNotificationHUD = nil
		end
	end
end

cvars.AddChangeCallback("zs_killfeed_enable", EvaluateKillFeed)

--[[
--purpose: sync backitems from server to client
net.Receive("zs_backitem_notify", function(ln)
	local status = net.ReadEntity()
	local wep = net.ReadEntity()
	local bDel = net.ReadBool()
	
	if status and status:IsValid() and wep and wep:IsValid() then
		if bDel then
			status.TrackedItems[wep] = nil
		else
			status.TrackedItems[wep] = true
		end
		status:UpdateCSItems(wep)
	end
end)
--]]

--purpose: we want to be able to let staff view nails of other players while undead
--this is the clientside portion
hook.Add("HUDPaint", "ViewNails", function()
	if MySelf.m_CanSeeNails then --set via net message
		local ent = MySelf:GetEyeTraceNoCursor().Entity
		if ent and ent:IsValid() then
			if ent.Nails then
				local nail = ent.Nails[1] --get the first nail in the entity
				local owner = nail:GetDeployer()
				if owner and owner:IsValid() and owner:IsPlayer() then
					draw.SimpleText("Nail Owner: "..owner:Nick(), "ZSHUDFontSmall", ScrW() / 2, ScrH() / 2 + 100, Color(255, 60, 60), TEXT_ALIGN_CENTER)
				end
			end
		end
	end
end)

--Custom Last Human Music
--purpose: clientside framework to stream last human music
--TODO: Try to look into ways to cache data
if not file.Exists("zscache", "DATA") then
	file.CreateDir("zscache/music")
	file.CreateDir("zscache/images")
end

local function URLMusicCallback(HL2EngineAudio, errID, errName)
	if HL2EngineAudio and HL2EngineAudio:IsValid() then
		HL2EngineAudio:EnableLooping(true)
		GAMEMODE.LastHumanMusic = HL2EngineAudio --so that we can use this later
	end

	if errID or errName then
		print("Error caught: ", errID, errName)
	end
end

GM.LHFileName = "" --hacky fix for a problem of passing a filename to a callback, in order to avoid this we could construct the callback in the fetch function
local function MusicFetchSuccess(body, size, headers, code)
	if code == 404 then return end --we got nothing
	print("HTTP Music Fetched succeeded.")
	print("Size: ", size)
	if body then
		file.Write("zscache/music/"..GAMEMODE.LHFileName..".dat", body)
	end
	GAMEMODE.FetchingMusic = false
end

local function MusicFetchFailure(error)
	print("HTTP Music Fetch failed")
	print("Error: ", error)
	GAMEMODE.FetchingMusic = false
end
GM.FetchingMusic = false
function GM:SetupMusicStream(filename, bFS)
	if bFS then
		--this track exists in the filesystem, so we should play it from there
		sound.PlayFile(filename, "noblock", URLMusicCallback)
		return
	end
	
	--first lets see if there is a cached version available
	local strFile = string.sub(filename, 1, -5) --strip the extension
	if file.Exists("zscache/music/"..strFile..".dat", "DATA") then
		sound.PlayFile("data/zscache/music/"..strFile..".dat", "noblock", URLMusicCallback)
	else
		local url = ""..filename
		sound.PlayURL(url, "noblock", URLMusicCallback) --start playing the music immediately by opening a stream

		--wait a bit then fetch the file to save it locally, we wait a bit to give the stream a chance to buffer
		if not self.FetchingMusic then --.dat files will be corrupted if we dont do some sort of check
			self.LHFileName = strFile
			self.FetchingMusic = true --initialize our expected filename then lock all further requests so that we can make sure our data is saved properly
			--theres a better way to do this but i'm too lazy
			timer.Simple(5, function()
				http.Fetch(url, MusicFetchSuccess, MusicFetchFailure)
			end)
		end
	end
end

function GM:PlayMusicIndex(index)
	local music = self.LHMusic[index]
	if music then
		local track = music[2]
		local bFS = music[4]
		if track then
			self:SetupMusicStream(track, bFS)
		end
	end
end

function TranslateMusicIndex(i)
	if GAMEMODE.LHMusic[i] then
		return GAMEMODE.LHMusic[i][1]
	end
end

net.Receive("zs_lhmusic", function(ln)
	local track = net.ReadUInt(8)
	if track then
		GAMEMODE:PlayMusicIndex(track)
	end
end)

--clientside menu portion
--our menu will have 2 windows, top and bottom
--the top window will contain a scrollable list of all the tracks
--the bottom window will contain the art and controls for each track
--TODO: a possible length selector?
net.Receive("zs_lhmusic_menu", function(ln)
	GAMEMODE:OpenLHMusicMenu()
end)

local function TrackButtonDoClick(self)
	self.InfoPanel:SetData(self.Info, self.Index)
end

local function PreviewMusicDoClick(self)
	if GAMEMODE.LastHumanMusic then
		if GAMEMODE.LastHumanMusic:IsValid() then
			GAMEMODE.LastHumanMusic:Stop()
			GAMEMODE.LastHumanMusic = nil
		else
			GAMEMODE.LastHumanMusic:Stop()
			GAMEMODE.LastHumanMusic = nil
		end
	end

	GAMEMODE:PlayMusicIndex(self.Index)
end

local function SelectMusicDoClick(self)
	--Placeholder for beta
	net.Start("zs_lhmusic")
		net.WriteUInt(self.Index, 8)
	net.SendToServer()
end

local function TrackInfoSetData(self, tInfo, index)
	self.ImagePanel:SetImage(tInfo[3], "vgui/avatar_default")
	self.PreviewBtn.Index = index
	self.SelectBtn.Index = index
	self.Label:SetText(tInfo[1])
	self.Label:SizeToContents()
	self.Label:CenterHorizontal()
end

local function MusicBtnDoClick(self)
	self.InfoPanel:SetData(self.Info, self.Index)
end

local function MusicBtnStop(self)
	if GAMEMODE.LastHumanMusic then
		if GAMEMODE.LastHumanMusic:IsValid() then
			GAMEMODE.LastHumanMusic:Stop()
			GAMEMODE.LastHumanMusic = nil
		else
			GAMEMODE.LastHumanMusic:Stop()
			GAMEMODE.LastHumanMusic = nil
		end
	end
end

function GM:OpenLHMusicMenu()
	if self.LHMenu and self.LHMenu:IsValid() then return end

	local pFrame = vgui.Create("DFrame")
	pFrame:SetSize(ScrW() / 3, ScrH() / 1.5)
	pFrame:Center()
	pFrame:SetTitle("Last Human Music")

	self.LHMenu = pFrame

	local pTrackScroll = vgui.Create("DScrollPanel", pFrame)
	local pTrackList = vgui.Create("DListLayout", pTrackScroll)
	local pTrackInfo = vgui.Create("DPanel", pFrame)

	pTrackScroll:SetPos(0, 20)
	pTrackScroll:SetSize(pFrame:GetWide(), pFrame:GetTall() * 1/3)
	pTrackList:Dock(FILL)

	pTrackInfo:SetPos(0, pTrackScroll:GetTall() + 20)
	pTrackInfo:SetSize(pFrame:GetWide(), pFrame:GetTall() * 2/3 - 20)
	pTrackInfo.Paint = function() end

	--add our tracks via sorted pairs so that the tracks are sorted alphabetically
	for index, tInfo in SortedPairsByMemberValue(self.LHMusic, 1) do
		local btn = vgui.Create("DButton", pTrackList)
		btn:SetFont("ZSHUDFontSmallest")
		btn:SetColor(color_white)
		btn.Info = tInfo
		btn.Index = index
		btn.InfoPanel = pTrackInfo
		btn.DoClick = MusicBtnDoClick
		btn:SetText(tInfo[1])

		pTrackList:Add(btn)
	end

	--setup our trackinfo with defaults
	local pImg = vgui.Create("DWebImage", pTrackInfo)
	pImg:SetSize(192, 192)
	pImg:SetPos(pTrackInfo:GetWide() / 2 - pImg:GetWide() / 2, 20)
	--pImg:CenterHorizontal()
	pImg:SetImage("", "vgui/avatar_default", true)
	pTrackInfo.ImagePanel = pImg
	
	local lab = EasyLabel(pTrackInfo, "Select a Last Human track!", "ZSHUDFontSmall", COLOR_GREEN)
	lab:MoveBelow(pImg, 10)
	lab:CenterHorizontal()
	pTrackInfo.Label = lab

	local disclaimer = EasyLabel(pTrackInfo, "NOTICE: Custom Last Human music is in open beta so all music is available. Things can and will change.", "ZSHUDFontTiny", COLOR_RED)
	disclaimer:MoveBelow(lab)
	disclaimer:CenterHorizontal()


	local pBtn = vgui.Create("DButton", pTrackInfo)
	pBtn:SetFont("ZSHUDFontTiny")
	pBtn:SetText("Preview Music")
	pBtn:SetColor(color_white)
	--pBtn:SetPos(10, pTrackInfo:GetTall() - pBtn:GetTall())
	pBtn:Dock(BOTTOM)
	pBtn.Index = 0
	pBtn.DoClick = PreviewMusicDoClick
	pTrackInfo.PreviewBtn = pBtn

	local pBtnStop = vgui.Create("DButton", pTrackInfo)
	pBtnStop:SetFont("ZSHUDFontTiny")
	pBtnStop:SetText("Stop Music")
	pBtnStop:SetColor(COLOR_RED)
	--pBtnStop:MoveRightOf(pBtn, 10)
	pBtnStop:Dock(BOTTOM)
	pBtnStop.DoClick = MusicBtnStop

	local pBtn2 = vgui.Create("DButton", pTrackInfo)
	pBtn2:SetFont("ZSHUDFontTiny")
	pBtn2:SetText("Select Music")
	pBtn:SetColor(color_white)
	--pBtn2:SetPos(pTrackInfo:GetWide() - pBtn2:GetWide() - 10, pTrackInfo:GetTall() - pBtn2:GetTall())
	pBtn2:Dock(BOTTOM)
	pBtn2.Index = 0
	pBtn2.DoClick = SelectMusicDoClick
	pTrackInfo.SelectBtn = pBtn2

	pTrackInfo.SetData = TrackInfoSetData

	pFrame:MakePopup()
end
--]]

--purpose: add a few convars and concmds from BGO to the options menu
hook.Add("AddExtraOptions", "BloodOptions", function(list, Window)
	local btn = vgui.Create("DButton")
	btn:SetText("Clear Weapon Blood")
	btn.DoClick = function(self)
		RunConsoleCommand("cl_bgo_fx_blood_weapon_clean")
	end
	btn:SizeToContents()
	list:AddItem(btn)


	local check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Display viewmodel blood")
	check:SetConVar("cl_bgo_fx_blood_weapon_enabled")
	check:SizeToContents()
	list:AddItem(check)
end)

--purpose: add snow to panels
--Credit to Shendow, from https://gist.github.com/Shendow/4b1aab62c617ce289fc309106b713741
local math = math
local draw = draw
local ipairs = ipairs

surface.CreateFont("Snow1", {font = "Roboto", size = 10})
surface.CreateFont("Snow2", {font = "Roboto", size = 9})
surface.CreateFont("Snow3", {font = "Roboto", size = 8})
surface.CreateFont("Snow4", {font = "Roboto", size = 9})
surface.CreateFont("Snow5", {font = "Roboto", size = 10})

local strParticle = "⬤"
local colParticle = COLOR_PURPLE
local rate = 0.033
local anglerate = 0.01

function AddSnowToPanel(panel, max)
	max = max or 25

	local w, h = panel:GetWide(), panel:GetTall()
	local particles = {}
	local angle = 0

	local canvas = vgui.Create("DPanel", panel)
	canvas:StretchToParent(0, 0, 0, 0)
	canvas:SetDrawBackground(false)
	canvas:SetMouseInputEnabled(false)
	canvas:SetDrawOnTop(true)
	canvas.Paint = function(me, w, h)
		for _, v in ipairs (particles) do
			draw.SimpleText(strParticle, v[5], v[1], v[2], colParticle)
		end
	end
	canvas.Think = function(me)
		local rt = RealTime()
		if (me.m_fNextThink and me.m_fNextThink > rt) then
			return end
		
		me.m_fNextThink = rt + rate
		angle = angle + anglerate

		for i, v in ipairs (particles) do
			v[1] = v[1] + math.sin(angle) * 2
			v[2] = v[2] + math.cos(angle + v[4]) + 1 + v[3] * 0.5

			if (v[1] < -5 or v[1] > w + 5 or v[2] > h) then
				if (i % 3 > 0) then
					v[1] = math.random() * w
					v[2] = -10
				else
					if (math.sin(angle) > 0) then
						v[1] = -5
						v[2] = math.random() * h
					else
						v[1] = w + 5
						v[2] = math.random() * h
					end
				end
			end
		end
	end

	for i = 1, max do
		local r = math.Round(math.random() * 4 + 1)
	
		table.insert(particles, {
			math.random() * w,
			math.random() * h,
			r,
			math.random() * max,
			"Snow" .. math.random(r)
		})
	end
end

--[[
--purpose: simply hook to notify players of things, such as LH music availablity
hook.Add("PlayerBindPress", "Notify", function(ply, bind, pressed)
	--query for the lhmusic
	if ply:query("ulx lhmusic") then
		chat.AddText(team.GetColor(ply:Team()), "You are able to use the beta Custom Last Human Music due to your rank!")
		chat.AddText(team.GetColor(ply:Team()), "Simply type !LHMusic to browse and select music.")
	end

	hook.Remove("PlayerBindPress", "Notify") --remove our hook once it's been called so it's only done once
end)
]]

--purpose: persistant multicore through the f4 menu
--this is achieved through a pretty hacky method but w/e
--[[
local cvMulticore = CreateConVar("zs_multicore", 0, FCVAR_ARCHIVE, "Persistent surrogate convar for multicore rendering")

hook.Add("HookGetLocal", "ZSMulticoreHandler", function()
	if cvMulticore:GetInt() > 0 then
		RunConsoleCommand("gmod_mcore_test", "1")
	end
end)

hook.Add("AddExtraOptions", "MulticoreOptions", function(list, Window)
	local check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Enable Multicore Rendering\nNOTE: Significant FPS increase but may cause crashes")
	check:SetConVar(cvMulticore:GetName())
	check:SizeToContents()
	list:AddItem(check)
end)
--]]

--[ --might be causing crashes
--purpose: clientside portion of trail disabling, for pointshops and etc, moved to gamemode

local trailCvar = CreateClientConVar("zs_showpstrails", "1", true, true, "Whether or not to disable trails.\n1 = trails enabled\n0 = trails disabled\nNOTE: This does not remove the entity, it merely stops networking it.\nThus, THIS WILL NOT UPDATE IMMEDIATELY.")
hook.Add("AddExtraOptions", "pointshopOptions", function(list, Window)
	local check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Show pointshop trails\nNOTE: Changes are applied next map")
	check:SetConVar("zs_showpstrails")
	check:SizeToContents()
	
	list:AddItem(check)
end)

hook.Add("OnEntityCreated", "TrailEntHook", function(ent)
	if ent:GetClass() == "env_spritetrail" then
		if trailCvar:GetInt() == 0 then
			net.Start("zs_entnotifyclient")
				net.WriteEntity(ent)
				net.WriteBool(true)
			net.SendToServer()
		end
	end
end)
--]]

--purpose: clientside portion of not allowing others to place nails in a prop you already nailed, similar to how HG has it.
CreateClientConVar("zs_nonail", 0, true, true, "Doesn't allow others to place nails in your props when you own the first nail if nonzero.") 
CreateClientConVar("cl_new_impact_effects", 1, true, true, "Gives you HD visual particle effects.")


hook.Add("AddExtraOptions", "nailOptions", function(list, Window)
	local check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Disallow others nailing owned props.")
	check:SetConVar("zs_nonail")
	check:SizeToContents()
	list:AddItem(check)
end)

--purpose: clientside portion of hint system

--cooldown system, now clientside
GM.HintHistory = {}

if not file.Exists("zshints", "DATA") then
	file.CreateDir("zshints")
end

if file.Exists("zshints/hintdata.txt", "DATA") then
	GM.HintHistory = util.JSONToTable(file.Read("zshints/hintdata.txt"))
end


local cvHints = CreateClientConVar("gc_hints", "1", true, true, "Enables the display of helpful hints during the round.")
function IsHintActive(hintdata)
	local hint = hintdata.type
	local limit = hintdata.limit or 8
	if cvHints:GetInt() == 0 then return false end

	if limit == -1 then return true end

	local tHints = GAMEMODE.HintHistory or {}

	if not tHints[hint] then
		tHints[hint] = 0
	end

	if tHints[hint] > limit then
		return false
	end

	tHints[hint] = tHints[hint] + 1

	return true
end

hook.Add("ShutDown", "HintDataSave", function()
	file.Write("zshints/hintdata.txt", util.TableToJSON(GAMEMODE.HintHistory))
end)

--options

hook.Add("AddExtraOptions", "hintOptions", function(list, Window)
	local check = vgui.Create("DCheckBoxLabel", Window)
	check:SetText("Display hints during rounds")
	check:SetConVar("gc_hints")
	check:SizeToContents()
	list:AddItem(check)
end)

--renderer
net.Receive("gc_hint", function(ln)
	local id = net.ReadUInt(8)
	local pos = net.ReadVector()
	if id and pos then
		local tHint = GAMEMODE:GetHintByID(id)
		if tHint then
			InterpretHint(tHint, pos)
		end
	end
end)



function InterpretHint(hintdata, pos)
	if not IsHintActive(hintdata) then return end
	--be sure our panel is ready
	if not GAMEMODE.HintPanel then
		GAMEMODE.HintPanel = vgui.Create("DHint")
	end
	surface.PlaySound(hintdata.snd) --play a good notification sound
	--now lets fix up our data
	local showTime = CurTime() + hintdata.time
	local hint = hintdata.info
	local bind = hintdata.bind
	if bind then --some hints are purely informational and do not have binds
		local binds = {}
		if bind:find("&") then
			binds = string.Explode("&", bind, false)
		end
		if #binds == 0 then binds[1] = bind end
		--now lets sanitize our keybinds to the actual keys
		for num, keybind in pairs(binds) do
			binds[num] = (input.LookupBinding(keybind) or "not bound"):upper()
		end
		
		--and now we add these binds to the string where our identifiers are
		for num, keybind in pairs(binds) do
			hint = hint:Replace("%"..num, keybind)
		end
	end
	
	--now that our backend is finished working, we can start displaying on the frontend
	local w = ScrW()
	local h = ScrH()
	local halfw = w / 2
	local halfh = h / 2
	local halfylower = h / 2 + 200
	local colHint = Color(40, 255, 40, 255)
	local colFrame = Color(20, 20, 20, 200)
	local strFont = "ZSHUDFontSmaller"
	local zVec = Vector(0,0,0)
	--good idea to cache these vars outside of the hud paint hook
	local strImg = 'vgui/notices/hint'
	local setup = false

	--these two tables could be moved out but meh
	local hintimgbig ={
	texture = surface.GetTextureID('vgui/notices/hint'),
	color	= Color(255, 255, 255, 255),
	x = halfw - 64,
	y = 32,
	w = 128,
	h = 128
	}
	local hintimg ={
		texture = surface.GetTextureID('vgui/notices/hint'),
		color	= Color(255, 255, 255, 255),
		w = 32,
		h = 32
		}

	hook.Add("HUDPaint", "GCHints", function()
		cam.Start3D()
		cam.End3D() --fixes some issues with ToScreen
		local usevec = false
		local x = halfw
		local y = h - 300
		local canSee = true
		if pos ~= zVec then
			local tbl = pos:ToScreen()
			y=math.Clamp(tbl.y, 100, ScrH() - 200)
			x=math.Clamp(tbl.x, 100, ScrW() - 500)
			canSee = tbl.visible 
			usevec = true
		end

		local pHint = GAMEMODE.HintPanel
		pHint:SetVisible(true)
		if not setup then
			pHint:Setup(strImg, hint)
			setup = true
		end
		if not usevec then return end
		local prevx, prevy = pHint:GetPos()
		local FT = FrameTime() * 25
		pHint:SetPos(Lerp(FT, prevx, x), Lerp(FT, prevy, y))
	end)

	hook.Add("Think", "GCHintTimer", function()
		if CurTime() > showTime then
			MySelf.m_HintActive = false
			hook.Remove("HUDPaint", "GCHints")
			hook.Remove("Think", "GCHintTimer")
			GAMEMODE.HintPanel:Remove()
			GAMEMODE.HintPanel = nil
		end
	end)
end