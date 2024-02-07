local w,h = ScrW(), ScrH()
local mw, mh

local maincolor = Color( 125, 0, 0, 225 )
local allowedclick = true

if not MENU then MENU = {} end

function MENU:SkillsMenu()
	
	if GAMEMODE.InMenu and not cutta_leveling_skills then return end
	
	if cutta_leveling_skills then
		cutta_leveling_skills:Remove()
		cutta_leveling_skills = nil
		gui.EnableScreenClicker( false )
		GAMEMODE.InMenu = false
		return
	end
	gui.EnableScreenClicker( true )
	GAMEMODE.InMenu = true
	cutta_leveling_skills = vgui.Create("DPanel")
	cutta_leveling_skills:SetSize( w*0.25, h*0.4 )
	cutta_leveling_skills:SetPos( w*0.5, h*0.3 )
	cutta_leveling_skills:Center()
	cutta_leveling_skills.Paint = function( pan, ww, hh )
		draw.RoundedBox( 12, 0, 0, w*0.25, h*0.4, Color( 0, 99, 16, 65) )
		draw.SimpleTextOutlined( "Skills", "Trebuchet24", ww/2, hh*0.1, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 0, color_white )
		surface.SetFont( "Trebuchet24" )
		local tx, ty = surface.GetTextSize( "Skills" )
		surface.SetDrawColor( color_white )
		surface.DrawLine( ww/2 - tx/2, hh*0.1, ww/2 + tx/2, hh*0.1 )
	end

	mw, mh = cutta_leveling_skills:GetSize()

	local ply = LocalPlayer()
	------------------------------------------Skills MENU

	MENU:cutta_skills_points()
	
	-------------------------------------------------

	local AttackPower = vgui.Create( "DButton", cutta_leveling_skills)
	local button_size_adust = 0.25
	AttackPower:SetSize( mw*button_size_adust, mh*0.2 )
	AttackPower:SetPos( mw*0.05, mh*0.24 )
	AttackPower:SetText( "" )
	AttackPower.Paint = function( pan, ww, hh )
		draw.RoundedBox( 12, 0, 0, mw*button_size_adust, mh*0.2, Color(0, 99, 16, 189) )
		draw.SimpleTextOutlined( "AttackPower", "Trebuchet24", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		local attackpoints = LocalPlayer():GetNWInt("cutta_AttackPoints")
		if attackpoints < 100 then
			draw.SimpleTextOutlined( attackpoints, "Trebuchet18", ww/2, hh/2+20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		else
			draw.SimpleTextOutlined( "Max", "Trebuchet18", ww/2, hh/2+20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		end

		if AttackPower:IsHovered() then
			local apointsadjusted = attackpoints / 1
			cutta_skills_AttackUpStat_text = "Power Increased by "..apointsadjusted.."%", "Trebuchet18"
		else
			cutta_skills_AttackUpStat_text = ""
		end
	end
	AttackPower.DoClick = function( pan )
		local attackpoints = LocalPlayer():GetNWInt("cutta_AttackPoints")
		if attackpoints < 100 then
			if allowedclick == true then
				surface.PlaySound( "buttons/button14.wav" )
			-------------------------------------------
				net.Start("REGmod.AttackPower")
				net.SendToServer()
				SkillsRemaining:Remove()
				cutta_skills_AttackUpStat:Remove()
				allowedclick = false
				timer.Simple(0.5,function()
					MENU:cutta_skills_points()
					MENU:cutta_skills_text_info_attack()
					allowedclick = true
				end)
			end
		else
			LocalPlayer():PrintMessage(HUD_PRINTTALK,"Max Attack Power")
		end
	end

	------------------------------------------------

	local HealthUp = vgui.Create( "DButton", cutta_leveling_skills)
	HealthUp:SetSize( mw*button_size_adust, mh*0.2 )
	HealthUp:SetPos( mw*0.38, mh*0.24 )
	HealthUp:SetText( "" )
	HealthUp.Paint = function( pan, ww, hh )
		draw.RoundedBox( 12, 0, 0, mw*button_size_adust, mh*0.2, Color(0, 99, 16, 189) )
		local healthpoints = LocalPlayer():GetNWInt("cutta_HealthPoints")
		draw.SimpleTextOutlined( "HealthUp", "Trebuchet24", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		if healthpoints < 150 then
			draw.SimpleTextOutlined( healthpoints, "Trebuchet18", ww/2, hh/2+20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		else
			draw.SimpleTextOutlined( "Max", "Trebuchet18", ww/2, hh/2+20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		end

		if HealthUp:IsHovered() then
			local apointsadjusted = healthpoints / 1
			cutta_skills_HealthUpStat_text = "Health Increased by "..apointsadjusted.."%"
		else
			cutta_skills_HealthUpStat_text = ""
		end
	end
	HealthUp.DoClick = function( pan )
		local healthpoints = LocalPlayer():GetNWInt("cutta_HealthPoints")
		if healthpoints < 150 then
			if allowedclick == true then
				surface.PlaySound( "buttons/button14.wav" )

				-------------------------------------------
				allowedclick = false
				net.Start("REGmod.HealthUp")
				net.SendToServer()
				SkillsRemaining:Remove()
				cutta_skills_HealthUpStat:Remove()
				timer.Simple(0.5,function()
					MENU:cutta_skills_points()
					MENU:cutta_skills_text_info_health()
					allowedclick = true
				end)
			end
		else
			LocalPlayer():PrintMessage(HUD_PRINTTALK,"Max Health Up")
		end
	end



	------------------------------------------------

	local AmmoUp = vgui.Create( "DButton", cutta_leveling_skills)
	AmmoUp:SetSize( mw*button_size_adust, mh*0.2 )
	AmmoUp:SetPos( mw*0.7, mh*0.24 )
	AmmoUp:SetText( "" )
	AmmoUp.Paint = function( pan, ww, hh )
		draw.RoundedBox( 12, 0, 0, mw*button_size_adust, mh*0.2, Color(0, 99, 16, 189) )
		local ammopoints = LocalPlayer():GetNWInt("cutta_AmmoRegenPoints")
		draw.SimpleTextOutlined( "Ammo Regen", "Trebuchet24", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		if ammopoints < 150 then
			draw.SimpleTextOutlined( ammopoints, "Trebuchet18", ww/2, hh/2+20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		else
			draw.SimpleTextOutlined( "Max", "Trebuchet18", ww/2, hh/2+20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		end

		if AmmoUp:IsHovered() then
			local ammopointsadjusted = cuttas_leveling_ammoregen_ammotimeadjusted - (ammopoints)
			if ammopoints > 0 then
				cutta_skills_AmmoUpStat_text = "AmmoRegen Rate Is "..ammopointsadjusted.." seconds"
			else
				cutta_skills_AmmoUpStat_text = "No AmmoRegen"
			end
		else
			cutta_skills_AmmoUpStat_text = ""
		end
	end
	AmmoUp.DoClick = function( pan )
		local ammopoints = LocalPlayer():GetNWInt("cutta_AmmoRegenPoints")
		if ammopoints < 150 then
			if allowedclick == true then
				surface.PlaySound( "buttons/button14.wav" )
			--LocalPlayer():ChatPrint("This is not done yet")

			-------------------------------------------
			
				net.Start("REGmod.AmmoRegen")
				net.SendToServer()
				SkillsRemaining:Remove()
				cutta_skills_AmmoUpStat:Remove()
				allowedclick = false
				timer.Simple(0.5,function()
					MENU:cutta_skills_points()
					MENU:cutta_skills_text_info_ammo()
					allowedclick = true
				end)
			end
		else
			LocalPlayer():PrintMessage(HUD_PRINTTALK,"Max Ammo Regen")
		end
	end

	local DefenseUp = vgui.Create( "DButton", cutta_leveling_skills)
	DefenseUp:SetSize( mw*button_size_adust, mh*0.2 )
	DefenseUp:SetPos( mw*0.7, mh*0.44 )
	DefenseUp:SetText( "" )
	DefenseUp.Paint = function( pan, ww, hh )
		draw.RoundedBox( 12, 0, 0, mw*button_size_adust, mh*0.2, Color(0, 99, 16, 189) )
		local defensepoints = LocalPlayer():GetNWInt("cutta_DefensePoints")
		draw.SimpleTextOutlined( "Defense Up", "Trebuchet24", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		if defensepoints < 50 then
			draw.SimpleTextOutlined( defensepoints, "Trebuchet18", ww/2, hh/2+20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		else
			draw.SimpleTextOutlined( "Max", "Trebuchet18", ww/2, hh/2+20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		end

		if DefenseUp:IsHovered() then
			local apointsadjusted = defensepoints / 1
			cutta_skills_DefenseUpStat_text = "Damage Reduced by "..apointsadjusted.."%"
			--cutta_skills_DefenseUpStat_text = "Not Working Right Now"
		else
			cutta_skills_DefenseUpStat_text = ""
		end
	end
	DefenseUp.DoClick = function( pan )
		local defensepoints = LocalPlayer():GetNWInt("cutta_DefensePoints")
		if defensepoints < 50 then
			if allowedclick == true then
				surface.PlaySound( "buttons/button14.wav" )
			--LocalPlayer():ChatPrint("This is not done yet")

			-------------------------------------------
			
				net.Start("REGmod.DefenseUp")
				net.SendToServer()
				SkillsRemaining:Remove()
				cutta_skills_DefenseUpStat:Remove()
				allowedclick = false
				timer.Simple(0.5,function()
					MENU:cutta_skills_points()
					MENU:cutta_skills_text_info_defense()
					allowedclick = true
				end)
			end
		else
			LocalPlayer():PrintMessage(HUD_PRINTTALK,"Max Damage Reduction")
		end
	end

	local MeleeUp = vgui.Create( "DButton", cutta_leveling_skills)
	MeleeUp:SetSize( mw*button_size_adust, mh*0.2 )
	MeleeUp:SetPos( mw*0.38, mh*0.44 )
	MeleeUp:SetText( "" )
	MeleeUp.Paint = function( pan, ww, hh )
		draw.RoundedBox( 12, 0, 0, mw*button_size_adust, mh*0.2, Color(0, 99, 16, 189) )
		local meleepoints = LocalPlayer():GetNWInt("cutta_MeleePoints")
		draw.SimpleTextOutlined( "Melee Up", "Trebuchet24", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		if meleepoints < 75 then
			draw.SimpleTextOutlined( meleepoints, "Trebuchet18", ww/2, hh/2+20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		else
			draw.SimpleTextOutlined( "Max", "Trebuchet18", ww/2, hh/2+20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		end

		if MeleeUp:IsHovered() then
			local apointsadjusted = meleepoints * 2
			cutta_skills_MeleeUpStat_text = "Melee Damage Increased by "..apointsadjusted.."%"
			--cutta_skills_MeleeUpStat_text = "Not Working Right Now"
		else
			cutta_skills_MeleeUpStat_text = ""
		end
	end
	MeleeUp.DoClick = function( pan )
		local meleepoints = LocalPlayer():GetNWInt("cutta_MeleePoints")
		if meleepoints < 75 then
			if allowedclick == true then
				surface.PlaySound( "buttons/button14.wav" )
			--LocalPlayer():ChatPrint("This is not done yet")

			-------------------------------------------
			
				net.Start("REGmod.MeleeUp")
				net.SendToServer()
				SkillsRemaining:Remove()
				cutta_skills_MeleeUpStat:Remove()
				allowedclick = false
				timer.Simple(0.5,function()
					MENU:cutta_skills_points()
					MENU:cutta_skills_text_info_melee()
					allowedclick = true
				end)
			end
		else
			LocalPlayer():PrintMessage(HUD_PRINTTALK,"Max Melee Damage")
		end
	end

	local SpeedUp = vgui.Create( "DButton", cutta_leveling_skills)
	SpeedUp:SetSize( mw*button_size_adust, mh*0.2 )
	SpeedUp:SetPos( mw*0.05, mh*0.44 )
	SpeedUp:SetText( "" )
	SpeedUp.Paint = function( pan, ww, hh )
		draw.RoundedBox( 12, 0, 0, mw*button_size_adust, mh*0.2, Color(0, 99, 16, 189) )
		local speedpoints = LocalPlayer():GetNWInt("cutta_SpeedPoints")
		draw.SimpleTextOutlined( "Speed Up", "Trebuchet24", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		if speedpoints < 50 then
			draw.SimpleTextOutlined( speedpoints, "Trebuchet18", ww/2, hh/2+20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		else
			draw.SimpleTextOutlined( "Max", "Trebuchet18", ww/2, hh/2+20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
		end

		if SpeedUp:IsHovered() then
			local apointsadjusted = speedpoints * 2
			cutta_skills_MeleeUpStat_text = "Movement Speed Increased by "..apointsadjusted..""
			--cutta_skills_SpeedUpStat_text = "Not Working Right Now"
		else
			cutta_skills_SpeedUpStat_text = ""
		end
	end
	SpeedUp.DoClick = function( pan )
		local speedpoints = LocalPlayer():GetNWInt("cutta_SpeedPoints")
		if speedpoints < 100 then
			if allowedclick == true then
				surface.PlaySound( "buttons/button14.wav" )
			--LocalPlayer():ChatPrint("This is not done yet")

			-------------------------------------------
			
				net.Start("REGmod.SpeedUp")
				net.SendToServer()
				SkillsRemaining:Remove()
				cutta_skills_SpeedUpStat:Remove()
				allowedclick = false
				timer.Simple(0.5,function()
					MENU:cutta_skills_points()
					MENU:cutta_skills_text_info_speed()
					allowedclick = true
				end)
			end
		else
			LocalPlayer():PrintMessage(HUD_PRINTTALK,"Max Speed")
		end
	end


	------------------Show Stats with skills-----------

	MENU:cutta_skills_text_info_health()
	MENU:cutta_skills_text_info_attack()
	MENU:cutta_skills_text_info_ammo()
	MENU:cutta_skills_text_info_defense()
	MENU:cutta_skills_text_info_melee()
	MENU:cutta_skills_text_info_speed()
	
	--------------------------------
	local closebutt = vgui.Create( "DButton", cutta_leveling_skills )
	closebutt:SetSize( mw*0.9, mh*0.12 )
	closebutt:SetPos( mw*0.05, mh*0.83 )
	closebutt:SetText( "" )
	closebutt.Paint = function( pan, ww, hh )
		draw.RoundedBox( 12, 0, 0, mw*0.9, mh*0.12, Color(0, 99, 16, 189) )
		draw.SimpleTextOutlined( "Close Menu", "Trebuchet24", ww/2, hh/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
	end
	closebutt.DoClick = function( pan )
		surface.PlaySound( "buttons/button14.wav" ) 
		cutta_leveling_skills:Remove()
		cutta_leveling_skills = nil
		gui.EnableScreenClicker( false )
		GAMEMODE.InMenu = false
	end		
	
end

function MENU:cutta_skills_points()

	local ply = LocalPlayer()

	local points = ply:GetNWInt("cutta_SkillPoints")

	if not cutta_leveling_skills then return end

	SkillsRemaining = vgui.Create( "DLabel", cutta_leveling_skills )
	
	
	--
	SkillsRemaining:SetText( "You Have "..points.." Points" )
	SkillsRemaining:SetFont( "Trebuchet24" )
	SkillsRemaining:CenterHorizontal(0.39)
	SkillsRemaining:CenterVertical( -0.28 )
	SkillsRemaining:SetSize( mw, mh )

end

function MENU:cutta_skills_text_info_health()
	cutta_skills_HealthUpStat_text = ""
	local ply = LocalPlayer()
	cutta_skills_HealthUpStat = vgui.Create( "DLabel", cutta_leveling_skills )
	local hpoints = ply:GetNWInt("cutta_HealthPoints")
	local hpointsadjusted = hpoints / 4
	cutta_skills_HealthUpStat:SetSize( mw, mh )
	cutta_skills_HealthUpStat:SetText( "" )
	cutta_skills_HealthUpStat.Paint = function( pan, ww, hh )
		draw.SimpleTextOutlined( cutta_skills_HealthUpStat_text, "Trebuchet18", ww*0.5, hh*0.79, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
	end

end

function MENU:cutta_skills_text_info_attack()
	cutta_skills_AttackUpStat_text = ""
	local ply = LocalPlayer()
	cutta_skills_AttackUpStat = vgui.Create( "DLabel", cutta_leveling_skills )
	local apoints = ply:GetNWInt("cutta_AttackPoints")
	local apointsadjusted = apoints / 4
	cutta_skills_AttackUpStat:SetSize( mw, mh )
	cutta_skills_AttackUpStat:SetText( "" )
	cutta_skills_AttackUpStat.Paint = function( pan, ww, hh )
		draw.SimpleTextOutlined( cutta_skills_AttackUpStat_text, "Trebuchet18", ww*0.5, hh*0.79, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
	end

end

function MENU:cutta_skills_text_info_ammo()
	cutta_skills_AmmoUpStat_text = ""
	local ply = LocalPlayer()
	cutta_skills_AmmoUpStat = vgui.Create( "DLabel", cutta_leveling_skills )
	local ammopoints = ply:GetNWInt("cutta_AmmoRegenPoints")
	local ammopointsadjusted = cuttas_leveling_ammoregen_ammotimeadjusted - (ammopoints)
	cutta_skills_AmmoUpStat:SetSize( mw, mh )
	cutta_skills_AmmoUpStat:SetText( "" )
	cutta_skills_AmmoUpStat.Paint = function( pan, ww, hh )
		
		draw.SimpleTextOutlined( cutta_skills_AmmoUpStat_text, "Trebuchet18", ww*0.5, hh*0.79, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )

	end

end

function MENU:cutta_skills_text_info_defense()
	cutta_skills_DefenseUpStat_text = ""
	local ply = LocalPlayer()
	cutta_skills_DefenseUpStat = vgui.Create( "DLabel", cutta_leveling_skills )
	local defensepoints = ply:GetNWInt("cutta_DefensePoints")
	local apointsadjusted = defensepoints / 1
	cutta_skills_DefenseUpStat:SetSize( mw, mh )
	cutta_skills_DefenseUpStat:SetText( "" )
	cutta_skills_DefenseUpStat.Paint = function( pan, ww, hh )
		draw.SimpleTextOutlined( cutta_skills_DefenseUpStat_text, "Trebuchet18", ww*0.5, hh*0.79, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
	end
end

function MENU:cutta_skills_text_info_melee()
	cutta_skills_MeleeUpStat_text = ""
	local ply = LocalPlayer()
	cutta_skills_MeleeUpStat = vgui.Create( "DLabel", cutta_leveling_skills )
	local meleepoints = ply:GetNWInt("cutta_MeleePoints")
	local apointsadjusted = meleepoints / 4
	cutta_skills_MeleeUpStat:SetSize( mw, mh )
	cutta_skills_MeleeUpStat:SetText( "" )
	cutta_skills_MeleeUpStat.Paint = function( pan, ww, hh )
		draw.SimpleTextOutlined( cutta_skills_MeleeUpStat_text, "Trebuchet18", ww*0.5, hh*0.79, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
	end
end

function MENU:cutta_skills_text_info_speed()
	cutta_skills_SpeedUpStat_text = ""
	local ply = LocalPlayer()
	cutta_skills_SpeedUpStat = vgui.Create( "DLabel", cutta_leveling_skills )
	local speedpoints = ply:GetNWInt("cutta_SpeedPoints")
	local apointsadjusted = speedpoints / 4
	cutta_skills_SpeedUpStat:SetSize( mw, mh )
	cutta_skills_SpeedUpStat:SetText( "" )
	cutta_skills_SpeedUpStat.Paint = function( pan, ww, hh )
		draw.SimpleTextOutlined( cutta_skills_SpeedUpStat_text, "Trebuchet18", ww*0.5, hh*0.79, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, color_white )
	end
end


--[[



























]]--

function MENU:CuttaLevelConfigMenu()

	

	CuttaLevelConfigMenu_Frame = vgui.Create( "DFrame" )
	CuttaLevelConfigMenu_Frame:SetSize( 300, 150 ) 
	CuttaLevelConfigMenu_Frame:Center()
	CuttaLevelConfigMenu_Frame:SetTitle( "Cutta Leveling Config Menu" ) 
	CuttaLevelConfigMenu_Frame:SetVisible( true ) 
	CuttaLevelConfigMenu_Frame:SetDraggable( true ) 
	CuttaLevelConfigMenu_Frame:ShowCloseButton( true ) 
	CuttaLevelConfigMenu_Frame:MakePopup()	

	local xptext = vgui.Create( "DLabel", CuttaLevelConfigMenu_Frame )
	xptext:SetSize(300, 150)
	xptext:SetText( "" )
	xptext.Paint = function( pan, ww, hh )
		draw.SimpleTextOutlined( "Xp Per Kill", "Trebuchet18", ww*0.05, hh*0.25, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, color_white )
	end

	local xpsetting = vgui.Create("DNumberWang", CuttaLevelConfigMenu_Frame)
	xpsetting:SetPos(85, 25)
	xpsetting:SetSize(45, 26)
	xpsetting:SetMin(0)
	xpsetting:SetValue(GetGlobalInt("cutta_leveling_xpperkill",1))
	xpsetting.OnValueChanged = function(self)
		net.Start("cuttalevelsettingsmenu")
		net.WriteInt(self:GetValue(),32)
		net.SendToServer()
	end

	MENU:CuttaLevelConfigMenu2()
	MENU:CuttaLevelConfigMenu3()
	MENU:CuttaLevelConfigMenu4()
	MENU:CuttaLevelConfigMenu5()

end

function MENU:CuttaLevelConfigMenu2()

	local xptext2 = vgui.Create( "DLabel", CuttaLevelConfigMenu_Frame )
	xptext2:SetSize(300, 150)
	xptext2:SetText( "" )
	xptext2.Paint = function( pan, ww, hh )
		draw.SimpleTextOutlined( "Max Xp To Levelup per level", "Trebuchet18", ww*0.05, hh*0.45, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, color_white )
	end

	local xpsetting2 = vgui.Create("DNumberWang", CuttaLevelConfigMenu_Frame)
	xpsetting2:SetPos(187, 55)
	xpsetting2:SetSize(45, 26)
	xpsetting2:SetMin(0)
	xpsetting2:SetValue(GetGlobalInt("cutta_leveling_xpmultiply_per_level",25))
	xpsetting2.OnValueChanged = function(self)
		net.Start("cuttalevelsettingsmenu2")
		net.WriteInt(self:GetValue(),32)
		net.SendToServer()
	end

end

function MENU:CuttaLevelConfigMenu3()

	local xptext3 = vgui.Create( "DLabel", CuttaLevelConfigMenu_Frame )
	xptext3:SetSize(300, 150)
	xptext3:SetText( "" )
	xptext3.Paint = function( pan, ww, hh )
		draw.SimpleTextOutlined( "Enable Cutta's Leveling/Skills", "Trebuchet18", ww*0.05, hh*0.6, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, color_white )
	end

	local checkbox = CuttaLevelConfigMenu_Frame:Add( "DCheckBox" )
	checkbox:SetPos( xptext3:GetWide()*0.8, xptext3:GetTall()*0.55 ) 
	checkbox:SetValue( GetGlobalBool("enable_cuttas_leveling_skills", true) ) 
	function checkbox:OnChange(bool)
		net.Start("cuttalevelsettingsmenu3")
		if (bool) then
			net.WriteBool(true)
		else
			net.WriteBool(false)
		end
		net.SendToServer()
	end

end

function MENU:CuttaLevelConfigMenu4()

	local xptext4 = vgui.Create( "DLabel", CuttaLevelConfigMenu_Frame )
	xptext4:SetSize(300, 150)
	xptext4:SetText( "" )
	xptext4.Paint = function( pan, ww, hh )
		draw.SimpleTextOutlined( "Enable XP when killing player", "Trebuchet18", ww*0.05, hh*0.75, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, color_white )
	end

	local checkbox = CuttaLevelConfigMenu_Frame:Add( "DCheckBox" )
	checkbox:SetPos( xptext4:GetWide()*0.8, xptext4:GetTall()*0.7 ) 
	checkbox:SetValue( GetGlobalBool("enable_cuttas_xp_killing_player", true) ) 
	function checkbox:OnChange(bool)
		net.Start("cuttalevelsettingsmenu4")
		if (bool) then
			net.WriteBool(true)
		else
			net.WriteBool(false)
		end
		net.SendToServer()
	end

end

function MENU:CuttaLevelConfigMenu5()

	local xptext5 = vgui.Create( "DLabel", CuttaLevelConfigMenu_Frame )
	xptext5:SetSize(300, 150)
	xptext5:SetText( "" )
	xptext5.Paint = function( pan, ww, hh )
		draw.SimpleTextOutlined( "Enable XP when killing NPC", "Trebuchet18", ww*0.05, hh*0.9, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, color_white )
	end

	local checkbox = CuttaLevelConfigMenu_Frame:Add( "DCheckBox" )
	checkbox:SetPos( xptext5:GetWide()*0.8, xptext5:GetTall()*0.85 ) 
	checkbox:SetValue( GetGlobalBool("enable_cuttas_xp_killing_npc", true) ) 
	function checkbox:OnChange(bool)
		net.Start("cuttalevelsettingsmenu5")
		if (bool) then
			net.WriteBool(true)
		else
			net.WriteBool(false)
		end
		net.SendToServer()
	end

end

net.Receive("cuttaskillsmenu",function(l,ply)
	MENU:SkillsMenu()

end)

net.Receive("cuttalevelsettingsmenu",function(l,ply)
	MENU:CuttaLevelConfigMenu()

end)






-----------------------------------------------------
function MENU:LeaderBoardsMenu()
	
	if GAMEMODE.InMenu and not cuttta_leveling_leaderboards then return end
	
	if cuttta_leveling_leaderboards then
		cuttta_leveling_leaderboards:Remove()
		cuttta_leveling_leaderboards = nil
		gui.EnableScreenClicker( false )
		GAMEMODE.InMenu = false
		return
	end
	gui.EnableScreenClicker( true )
	GAMEMODE.InMenu = true
	cuttta_leveling_leaderboards = vgui.Create("DPanel")
	cuttta_leveling_leaderboards:SetSize( w*0.25, h*0.4 )
	cuttta_leveling_leaderboards:SetPos( w*0.5, h*0.3 )
	cuttta_leveling_leaderboards:Center()
	cuttta_leveling_leaderboards.Paint = function( pan, ww, hh )
		draw.RoundedBox( 12, 0, 0, w*0.25, h*0.4, Color( 0, 99, 16, 65) )
		draw.SimpleTextOutlined( "LeaderBoards", "Trebuchet24", ww/2, hh*0.1, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 0, color_white )
		surface.SetFont( "Trebuchet24" )
		local tx, ty = surface.GetTextSize( "LeaderBoards" )
		surface.SetDrawColor( color_white )
		surface.DrawLine( ww/2 - tx/2, hh*0.1, ww/2 + tx/2, hh*0.1 )
	end

	mw, mh = cuttta_leveling_leaderboards:GetSize()

	local ply = LocalPlayer()
	------------------------------------------LeaderBoards MENU
	

	local DScrollPanel = vgui.Create( "DScrollPanel", cuttta_leveling_leaderboards )
	DScrollPanel:Dock( FILL )
	
	table.SortByMember( cuttas_leveling_leaderboards_list, "plyxp" )
	--PrintTable(cuttas_leveling_leaderboards_list)
	for k,v in ipairs(cuttas_leveling_leaderboards_list) do
			local DButton = DScrollPanel:Add( "DButton" )
			DButton:SetText( k.."| "..v.plyname.."  is Level  "..v.plylvl.."  with TotalXP  "..v.plyxp)
			DButton:Dock( TOP )
			DButton:DockMargin( 0, mh*0.1, 0, mh*-0.1 )
		
	end

end

net.Receive("cuttalevelleaderboards", function(l,ply)
	cuttas_leveling_leaderboards_list = net.ReadTable()
	
	for k,v in pairs(cuttas_leveling_leaderboards_list) do
		if v.plyname == nil then
			table.remove(cuttas_leveling_leaderboards_list, k)
		end
	end
end)

net.Receive("cuttalevelleaderboards_open", function(l,ply)
	MENU:LeaderBoardsMenu()
end)