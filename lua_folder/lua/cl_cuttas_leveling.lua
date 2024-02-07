if CLIENT then

surface.CreateFont( "ExpPoints", {
	font = "typenoksidi",
	size = 40,
	weight = 800} )
surface.CreateFont( "ExpPointsB", {
	font = "typenoksidi",
	size = 34,
	weight = 500} )
end

local barExtra = 0
local alpha_exp = 0
local alpha_exp_movement = 0.491 --crosshair middle
local state = 0
local sub = 0
local exp = 0
local exp_anim = 0
local timeout = 0



net.Receive("DR_Experienced",function(l,ply)
	if GetGlobalBool("enable_cuttas_leveling_skills", true) == true then
		state = 1
		sub = 4	
		if(timeout <= CurTime()) then
			exp = net.ReadFloat()
		else
			exp = exp + net.ReadFloat()
		end
		timeout = CurTime() + 4
	end	
end)


hook.Add("HUDPaint","DrawDRHUD",function()
	if GetGlobalBool("enable_cuttas_leveling_skills", true) then
		local scrW = ScrW()
		local scrH = ScrH()
		local frameTime = FrameTime()
		local curTime = CurTime()

		local offset = scrW / 1.51
		local offsetY = scrH / 8 + 20
		local leftofscreen, topofscreen = scrW - offset, scrH - (offsetY / 3.6)
		local exp = MySelf:GetExp(1)
		local prg = leftofscreen * exp

		if(state == 0) then
			alpha_exp  = Lerp(frameTime * 6, alpha_exp, -1)
			alpha_exp_movement = Lerp(frameTime, alpha_exp_movement, 0.7)
			exp_anim = 0
		end

		if(state == 1 && (alpha_exp < 255 or exp_anim < exp)) then
			alpha_exp = Lerp(math.TimeFraction(0, curTime * frameTime * 1000, curTime), alpha_exp, 256)
			alpha_exp_movement = 0.491
			exp_anim = math.ceil(Lerp(frameTime, exp_anim, exp))
		elseif(state == 1) then
			state = 2
		end

		if(sub > 0) then
			sub = sub - frameTime
		else
			state = 0
		end

		surface.SetDrawColor(24, 0, 69)
		surface.DrawRect(leftofscreen, topofscreen + 3, leftofscreen, 26)

		surface.SetDrawColor(Color(0, 255, 76, 150))
		surface.DrawRect(leftofscreen, topofscreen + 7, prg, 20)

		surface.SetDrawColor(Color(221, 255, 0, 150))
		surface.DrawRect(leftofscreen, topofscreen + 6, prg, 4)

		local level = MySelf:GetLevel()
		local exp2 = math.Round(MySelf:GetExp(2))
		local totalExp = MySelf:GetNWInt("cutta_TotalExperience", 0)

		draw.SimpleText("Level: "..level.. "  "..exp.."/"..exp2.."", "Default", leftofscreen * 1.49, topofscreen + 7, Color(243, 150, 1), TEXT_ALIGN_CENTER)
		draw.SimpleText("+"..exp_anim, "TargetID", scrW * 0.45, scrH * alpha_exp_movement, Color(50, 0, 124, (alpha_exp / 255) * 255), TEXT_ALIGN_CENTER)
		draw.SimpleText("+"..exp_anim, "TargetID", scrW * 0.45, scrH * alpha_exp_movement, Color(0, 232, 178, (alpha_exp / 255) * 255), TEXT_ALIGN_CENTER)
		draw.SimpleText("Total Exp: "..totalExp.."", "Default", leftofscreen * 1.8, topofscreen + 7, Color(226, 110, 1), TEXT_ALIGN_CENTER)
	end
end)

