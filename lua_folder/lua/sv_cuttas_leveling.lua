if SERVER then
	util.AddNetworkString("DR_Experienced")
	util.AddNetworkString("cuttalevelleaderboards")
	util.AddNetworkString("cuttalevelleaderboards_open")
	util.AddNetworkString("cuttaskillsmenu")
	util.AddNetworkString("cuttalevelsettingsmenu")
	util.AddNetworkString("cuttalevelsettingsmenu2")
	util.AddNetworkString("cuttalevelsettingsmenu3")
	util.AddNetworkString("cuttalevelsettingsmenu4")
	util.AddNetworkString("cuttalevelsettingsmenu5")
	util.AddNetworkString( "REGmod.HealthUp" )
	util.AddNetworkString( "REGmod.AttackPower" )
	util.AddNetworkString( "REGmod.AmmoRegen" )
	util.AddNetworkString( "REGmod.DefenseUp" )
	util.AddNetworkString( "REGmod.SpeedUp" )
	util.AddNetworkString( "REGmod.MeleeUp" )
	util.AddNetworkString("SyncLevel")
	util.AddNetworkString("SyncLevelUp")
end

--------------------------------------------------------------------------------------------

--[[

	nets and Saving for settings

]]--

----------Settings

function cutta_leveling_skills_savesettings()

	local saves = {}
	saves["cutta_leveling_xpperkill"] = GetGlobalInt("cutta_leveling_xpperkill", 1)
	saves["cutta_leveling_xpmultiply_per_level"] = GetGlobalInt("cutta_leveling_xpmultiply_per_level", 1)
	saves["enable_cuttas_leveling_skills"] = GetGlobalBool("enable_cuttas_leveling_skills", true)
	saves["enable_cuttas_xp_killing_player"] = GetGlobalBool("enable_cuttas_xp_killing_player", true)
	saves["enable_cuttas_xp_killing_npc"] = GetGlobalBool("enable_cuttas_xp_killing_npc", false)
	local savefile = util.TableToJSON(saves)
	file.Write("cuttas_leveling/settings.txt", savefile)

end

net.Receive( "cuttalevelsettingsmenu", function()

	local number = net.ReadInt(32)
	SetGlobalInt("cutta_leveling_xpperkill", number)

	cutta_leveling_skills_savesettings()

end)

net.Receive( "cuttalevelsettingsmenu2", function()

	local number = net.ReadInt(32)
	SetGlobalInt("cutta_leveling_xpmultiply_per_level", number)

	cutta_leveling_skills_savesettings()

end)

net.Receive( "cuttalevelsettingsmenu3", function()

	local bool = net.ReadBool()
	SetGlobalBool("enable_cuttas_leveling_skills", bool)

	cutta_leveling_skills_savesettings()

end)

net.Receive( "cuttalevelsettingsmenu4", function()

	local bool = net.ReadBool()
	SetGlobalBool("enable_cuttas_xp_killing_player", bool)

	cutta_leveling_skills_savesettings()

end)

net.Receive( "cuttalevelsettingsmenu5", function()

	local bool = net.ReadBool()
	SetGlobalBool("enable_cuttas_xp_killing_npc", bool)

	cutta_leveling_skills_savesettings()

end)

hook.Add("InitPostEntity", "cutta_LoadxpSettings", function()

    if file.Exists("cuttas_leveling/settings.txt", "DATA") then
        local saves = util.JSONToTable(file.Read("cuttas_leveling/settings.txt") )
        local xpperkill = saves["cutta_leveling_xpperkill"]
        local xpmultiply_per_level = saves["cutta_leveling_xpmultiply_per_level"]
		local enable_cuttas_leveling_skills = saves["enable_cuttas_leveling_skills"]
		local enable_cuttas_xp_killing_player = saves["enable_cuttas_xp_killing_player"]
		local enable_cuttas_xp_killing_npc = saves["enable_cuttas_xp_killing_npc"]
        SetGlobalInt("cutta_leveling_xpperkill", xpperkill)
        SetGlobalInt("cutta_leveling_xpmultiply_per_level", xpmultiply_per_level)
		SetGlobalBool("enable_cuttas_leveling_skills", enable_cuttas_leveling_skills)
		SetGlobalBool("enable_cuttas_xp_killing_player", enable_cuttas_xp_killing_player)
		SetGlobalBool("enable_cuttas_xp_killing_npc", enable_cuttas_xp_killing_npc)
	else
		SetGlobalInt("cutta_leveling_xpperkill", 1)
        SetGlobalInt("cutta_leveling_xpmultiply_per_level", 25)
		SetGlobalBool("enable_cuttas_leveling_skills", true)
		SetGlobalBool("enable_cuttas_xp_killing_player", true)
		SetGlobalBool("enable_cuttas_xp_killing_npc", true)
    end
	
	if file.Exists("cuttas_leveling/leaderboards.txt", "DATA") then
        cuttas_leveling_leaderboards_list = util.JSONToTable(file.Read("cuttas_leveling/leaderboards.txt") )
	else
		cuttas_leveling_leaderboards_list = {}
    end

end)

function update_cutta_levels_leaderboards(ply, totalxp, plylevel)
	local playerstats = {
		plyname = ply:Nick(),
		plyid = ply:SteamID(),
		plyxp = totalxp,
		plylvl = plylevel,
	}
	for k,v in pairs(cuttas_leveling_leaderboards_list) do
		for j,t in pairs(v) do
			if t == ply:SteamID() then
				table.remove(cuttas_leveling_leaderboards_list, k)
			end
		end
	end
	table.insert(cuttas_leveling_leaderboards_list, playerstats)
	file.Write("cuttas_leveling/leaderboards.txt", util.TableToJSON(cuttas_leveling_leaderboards_list))

	net.Start( "cuttalevelleaderboards" )
	net.WriteTable(cuttas_leveling_leaderboards_list)
	net.Send( player.GetAll() )
end

hook.Add("PlayerSpawn","cuttas_levels_leaderboardsSavesonspawn",function(ply)
	if GetGlobalBool("enable_cuttas_leveling_skills", true) != true then return end
	update_cutta_levels_leaderboards(ply, ply:GetNWInt("cutta_TotalExperience",0), ply:GetNWInt("cutta_Level",1))
end)

hook.Add("DoPlayerDeath","cuttas_levels_leaderboardsSavesondeath",function(ply)
	if GetGlobalBool("enable_cuttas_leveling_skills", true) != true then return end
	update_cutta_levels_leaderboards(ply, ply:GetNWInt("cutta_TotalExperience",0), ply:GetNWInt("cutta_Level",1))
end)

hook.Add("PlayerDisconnected","cuttas_levels_leaderboardsSavesondisconnect",function(ply)
	if GetGlobalBool("enable_cuttas_leveling_skills", true) != true then return end
	update_cutta_levels_leaderboards(ply, ply:GetNWInt("cutta_TotalExperience",0), ply:GetNWInt("cutta_Level",1))
end)

hook.Add("PlayerButtonDown", "cutta_openleaderboardsection", function(ply, key)
	if key == KEY_F7 and IsValid(ply) then
		net.Start( "cuttalevelleaderboards_open" )
		net.Send( ply )
		cutta_leveling_skills_saving()
	end
end)

--------Players Levels and SKills

hook.Add("PlayerInitialSpawn","InitializerPlayer",function(ply)
	--load player profile
	local str_Steam = string.Replace(ply:SteamID(),":",";")
	local playerdata = "cuttas_leveling/"..str_Steam..".txt"

	

	if !file.Exists("cuttas_leveling", "DATA") then
		file.CreateDir( "cuttas_leveling" )
	end
	if !file.Exists(playerdata, "DATA") then
		ply:SetNWInt("cutta_Level",ply:GetNWInt("cutta_Level",1))
		ply:SetNWInt("cutta_Experience",ply:GetNWInt("cutta_Experience",0))
		ply:SetNWInt("cutta_AttackPoints",ply:GetNWInt("cutta_AttackPoints",0))
		ply:SetNWInt("cutta_HealthPoints",ply:GetNWInt("cutta_HealthPoints",0))
		ply:SetNWInt("cutta_AmmoRegenPoints",ply:GetNWInt("cutta_AmmoRegenPoints",0))
		ply:SetNWInt("cutta_MeleePoints",ply:GetNWInt("cutta_MeleePoints",0))
		ply:SetNWInt("cutta_SpeedPoints",ply:GetNWInt("cutta_SpeedPoints",0))
		ply:SetNWInt("cutta_DefensePoints",ply:GetNWInt("cutta_DefensePoints",0))
		ply:SetNWInt("cutta_SkillPoints",ply:GetNWInt("cutta_SkillPoints",0))
		ply:SetNWInt("cutta_TotalExperience",ply:GetNWInt("cutta_TotalExperience",0))
	elseif file.Exists(playerdata, "DATA") then
		local saves = util.JSONToTable(file.Read(playerdata) )
		local level = saves["cutta_Level"]
		local experience = saves["cutta_Experience"]
		local attpnts = saves["cutta_AttackPoints"]
		local hltpnts = saves["cutta_HealthPoints"]
		local ammoregenpnts = saves["cutta_AmmoRegenPoints"]
		local speedpnts = saves["cutta_SpeedPoints"]
		local defensepnts = saves["cutta_DefensePoints"]
		local meleepnts = saves["cutta_MeleePoints"]
		local skillpnts = saves["cutta_SkillPoints"]
		local totalxp = saves["cutta_TotalExperience"]
		ply:SetNWInt("cutta_Level",tonumber(level))
		ply:SetNWInt("cutta_Experience",tonumber(experience))
		ply:SetNWInt("cutta_AttackPoints",tonumber(attpnts))
		ply:SetNWInt("cutta_HealthPoints",tonumber(hltpnts))
		ply:SetNWInt("cutta_AmmoRegenPoints",tonumber(ammoregenpnts))
		ply:SetNWInt("cutta_MeleePoints",tonumber(meleepnts))
		ply:SetNWInt("cutta_SpeedPoints",tonumber(speedpnts))
		ply:SetNWInt("cutta_DefensePoints",tonumber(defensepnts))
		ply:SetNWInt("cutta_SkillPoints",tonumber(skillpnts))
		ply:SetNWInt("cutta_TotalExperience",tonumber(totalxp))
	end

	
end)

function cutta_leveling_skills_saving()
	--save player profile
	local players = player.GetAll()

	for i = 1, #players do

		local ply = players[i]


		local str_Steam = string.Replace(ply:SteamID(),":",";")
		local playerdata = "cuttas_leveling/"..str_Steam..".txt"

		local saves = {}
		saves["cutta_Level"] = ply:GetNWInt("cutta_Level",1)
		saves["cutta_Experience"] = ply:GetNWInt("cutta_Experience",0)
		saves["cutta_AttackPoints"] = ply:GetNWInt("cutta_AttackPoints",0)
		saves["cutta_HealthPoints"] = ply:GetNWInt("cutta_HealthPoints",0)
		saves["cutta_AmmoRegenPoints"] = ply:GetNWInt("cutta_AmmoRegenPoints",0)

		saves["cutta_MeleePoints"] = ply:GetNWInt("cutta_MeleePoints",0)
		saves["cutta_SpeedPoints"] = ply:GetNWInt("cutta_SpeedPoints",0)
		saves["cutta_DefensePoints"] = ply:GetNWInt("cutta_DefensePoints",0)

		saves["cutta_SkillPoints"] = ply:GetNWInt("cutta_SkillPoints",0)
		saves["cutta_TotalExperience"] = ply:GetNWInt("cutta_TotalExperience",0)
		local savefile = util.TableToJSON(saves)
		file.Write(playerdata, savefile)

	end

end

--[[

	nets and Saving for settings

]]--

--------------------------------------------------------------------------------------------

--[[

	Chat Commands

]]--


hook.Add("PlayerSay","bringupskillsmenu",function(ply, text, team)

	if string.sub(text,1,13) == "!skills" and GetGlobalBool("enable_cuttas_leveling_skills", true) == true then
		net.Start( "cuttaskillsmenu" )
		net.Send( ply )
	end

end)

hook.Add("PlayerButtonDown", "Cutta_Levels_Press_SkillsOpen", function(ply, key)

	if key == KEY_F6 and IsValid(ply) then
		net.Start( "cuttaskillsmenu" )
		net.Send( ply )
	end
end)

hook.Add("PlayerSay","bringuplevelingsettingsmenu",function(ply, text, team)

	if string.sub(text,1,19) == "!skillsconfig" and ply:IsSuperAdmin() then
		net.Start( "cuttalevelsettingsmenu" )
		net.Send( ply )
	end

end)




--[[

	Chat Commands

]]--

--------------------------------------------------------------------------------------------









--[[

	Since we can only get xp from killing, 
		we just save everytime we kill.
			Simple and easy

]]--
gameevent.Listen( "entity_killed" )
hook.Add( "entity_killed", "cutta_leveling_save3", cutta_leveling_skills_saving)
------------------------------------------
------------------------------------------
------------------------------------------
------------------------------------------
------------------------------------------

--[[

hook.Add("EntityTakeDamage","FixDamage",function(ent,dmg)
	if(ent:IsPlayer()) then
		local l = math.floor(ent:GetLevel()/10)
		dmg:ScaleDamage(1-5*l)
	end
end)

]]

----Health Skill
hook.Add("PlayerSpawn","cuttas_skills_give_health",function(ply)
	if GetGlobalBool("enable_cuttas_leveling_skills", true) != true then return end
		--local l = math.floor(ply:GetLevel()/10)
		local l = ply:GetNWInt("cutta_HealthPoints")/1
		timer.Simple(1, function()
			ply:SetMaxHealth(ply:GetMaxHealth()+l)
		end)
		
		--print(""..ply:Nick().." has "..ply:GetMaxHealth().." max health")
end)




----Attack Skill
hook.Add("EntityTakeDamage", "cutta_skills_give_attack", function(ent, dmg)
	if GetGlobalBool("enable_cuttas_leveling_skills", true) != true then return end
	if (IsValid(ent)) then

		local damage = dmg:GetDamage();

		if (damage < 0.5) then
			return;
		end

		local attacker = dmg:GetAttacker();
		if (not IsValid(attacker) ) then
			return;
		end

		local points = attacker:GetNWInt("cutta_AttackPoints")
		if (points <= 0) then
			return; 
		end

		local weapon = attacker:GetActiveWeapon();

		

			local realDamage = damage + (points / 1);
			if (attacker:IsPlayer()) then
				dmg:SetDamage(realDamage);
			end

		--print(realDamage)
	end
end)


-----Ammo Regen Skill

local AmmoRegenCooldown = 0
hook.Add("Tick", "AmmoRegenSkill", function()

	if GetGlobalBool("enable_cuttas_leveling_skills", true) != true then return end
	
	if (CurTime() < AmmoRegenCooldown ) then return end

	local players = player.GetAll()
	for i = 1, #players do

			local player = players[i]

			ammoregenpoints = player:GetNWInt("cutta_AmmoRegenPoints")

			local weapon = player:GetActiveWeapon()

			


			if (ammoregenpoints > 0) then
				
				local amt = 15

				if player:GetAmmoCount( "pistol" ) <= 3000  then
					player:GiveAmmo( math.Clamp(player:GetAmmoCount( "pistol" ) + (amt - 45), 0, 32), "pistol" )
				end
				if player:GetAmmoCount( "smg1" ) <= 3000 then
					player:GiveAmmo( math.Clamp(player:GetAmmoCount( "smg1" ) + (amt - 90), 0, 90), "smg1" )
				end
				if player:GetAmmoCount( "ar2" ) <= 3000  then
					player:GiveAmmo( math.Clamp(player:GetAmmoCount( "ar2" ) + (amt - 84), 0, 64), "ar2" )
				end
				if player:GetAmmoCount( "357" ) <= 3000  then
					player:GiveAmmo( math.Clamp(player:GetAmmoCount( "357" ) + (amt - 36), 0, 12), "357" )
				end
				if player:GetAmmoCount( "buckshot" ) <= 3000  then
					player:GiveAmmo( math.Clamp(player:GetAmmoCount( "buckshot" ) + (amt - 24), 0, 12), "buckshot" )
				end
				if player:GetAmmoCount( "gravity" ) <= 3000  then
					player:GiveAmmo( math.Clamp(player:GetAmmoCount( "buckshot" ) + (amt - 50), 0, 12), "buckshot" )
				end
				if player:GetAmmoCount( "alyxgun" ) <= 3000  then
					player:GiveAmmo( math.Clamp(player:GetAmmoCount( "buckshot" ) + (amt - 75), 0, 12), "buckshot" )
				end
				if SERVER then
					player:EmitSound( "items/ammo_pickup.wav", 110, 150 )
				end
						
			end
	end

	if ammoregenpoints != nil then
		AmmoRegenCooldown = CurTime() + (cuttas_leveling_ammoregen_ammotimeadjusted - ammoregenpoints)
	end
end)


-----------------Speed Up
cutta_skills_playerspeedskill_run = 0
cutta_skills_playerspeedskill_walk = 0
hook.Add("PlayerSpawn", "cutta_skills_set_speed", function(ply,mv)
	timer.Simple(2, function()
	if ply.cutta_skills_queried_speeddata == nil then
		ply.cutta_skills_queried_speeddata = true
		ply:SetNWInt("cutta_skills_queried_speeddata_run", ply:GetRunSpeed())
		ply:SetNWInt("cutta_skills_queried_speeddata_walk", ply:GetWalkSpeed())
	end

	
	cutta_skills_playerspeedskill_run = ply:GetNWInt("cutta_skills_queried_speeddata_run") + ( ply:GetNWInt("cutta_SpeedPoints",0) * 1.1 )
	cutta_skills_playerspeedskill_walk = ply:GetNWInt("cutta_skills_queried_speeddata_walk") + ( ply:GetNWInt("cutta_SpeedPoints",0) * 1.1 )
	
		ply:SetRunSpeed( cutta_skills_playerspeedskill_run )
		ply:SetWalkSpeed( cutta_skills_playerspeedskill_walk )
	end)
end)


----Melee Skill
hook.Add("EntityTakeDamage", "cutta_skills_give_melee", function(ent, dmg)
	if GetGlobalBool("enable_cuttas_leveling_skills", true) != true then return end
	if (IsValid(ent)) then

		local damage = dmg:GetDamage();

		if (damage < 1) then
			return;
		end

		local attacker = dmg:GetAttacker();
		if (not IsValid(attacker) ) then
			return;
		end

		local points = attacker:GetNWInt("cutta_MeleePoints")
		if (points <= 0) then
			return; 
		end

		local weapon = attacker:GetActiveWeapon();

		
		

			local realDamage = damage + (points * 2);
			if (attacker:IsPlayer()) and (dmg:GetDamageType() == DMG_GENERIC or dmg:GetDamageType() == DMG_SLASH or dmg:GetDamageType() == DMG_CLUB) then
				dmg:SetDamage(realDamage);
			end

		--print(realDamage)
	end
end)

----Defense Skill
hook.Add("EntityTakeDamage", "cutta_skills_give_defense", function(ent, dmg)
	if GetGlobalBool("enable_cuttas_leveling_skills", true) != true then return end
	if (IsValid(ent)) then

		local damage = dmg:GetDamage();

		if (damage < 1) then
			return;
		end

		local attacker = dmg:GetAttacker()

		local points = ent:GetNWInt("cutta_DefensePoints")
		if (points <= 0) then
			return; 
		end

		local realDamage = 1 - (points * 0.01)
		if attacker:IsNPC() or attacker:IsPlayer() or attacker:IsNextBot() then
			dmg:ScaleDamage( realDamage )
		end
	end
end)


local promoted = {}

hook.Add("OnNPCKilled","npc_AddExperience",function(npc,killer)

	if GetGlobalBool("enable_cuttas_leveling_skills", true) == true then
		if killer:IsPlayer() and IsValid(killer) and GetGlobalBool("enable_cuttas_xp_killing_npc", true) == true then
			killer:giveExp(GetGlobalInt("cutta_leveling_xpperkill", 1))
		end
	end

end)

hook.Add("PlayerDeath","ply_AddExperience",function(victim, inflictor, attacker)
	if GetGlobalBool("enable_cuttas_leveling_skills", true) == true then
		if ( victim == attacker ) then
		else
			if attacker:IsPlayer() and IsValid(attacker) and GetGlobalBool("enable_cuttas_xp_killing_player", true) == true then
				attacker:giveExp(GetGlobalInt("cutta_leveling_xpperkill", 1)*5)
			end
		end
	end

end)

----------------------------------------skills

net.Receive( "REGmod.HealthUp", function( len, ply )
	
	if ply:GetNWInt("cutta_SkillPoints") > 0 then
		ply:SetNWInt("cutta_HealthPoints", ply:GetNWInt("cutta_HealthPoints") + 1)
		ply:SetNWInt("cutta_SkillPoints", ply:GetNWInt("cutta_SkillPoints") - 1)
	else
		--ply:PrintMessage(HUD_PRINTTALK,"You Don't Have Enough Skill Points")
	end

end )



net.Receive( "REGmod.AttackPower", function( len, ply )

	if ply:GetNWInt("cutta_SkillPoints") > 0 then
		ply:SetNWInt("cutta_AttackPoints", ply:GetNWInt("cutta_AttackPoints") + 1)
		ply:SetNWInt("cutta_SkillPoints", ply:GetNWInt("cutta_SkillPoints") - 1)
	else
		--ply:PrintMessage(HUD_PRINTTALK,"You Don't Have Enough Skill Points")
	end

end )

net.Receive( "REGmod.AmmoRegen", function( len, ply )

	if ply:GetNWInt("cutta_SkillPoints") > 0 then
		ply:SetNWInt("cutta_AmmoRegenPoints", ply:GetNWInt("cutta_AmmoRegenPoints") + 1)
		ply:SetNWInt("cutta_SkillPoints", ply:GetNWInt("cutta_SkillPoints") - 1)
	else
		--ply:PrintMessage(HUD_PRINTTALK,"You Don't Have Enough Skill Points")
	end

end )

net.Receive( "REGmod.DefenseUp", function( len, ply )

	if ply:GetNWInt("cutta_SkillPoints") > 0 then
		ply:SetNWInt("cutta_DefensePoints", ply:GetNWInt("cutta_DefensePoints") + 1)
		ply:SetNWInt("cutta_SkillPoints", ply:GetNWInt("cutta_SkillPoints") - 1)
	else
		--ply:PrintMessage(HUD_PRINTTALK,"You Don't Have Enough Skill Points")
	end

end )

net.Receive( "REGmod.MeleeUp", function( len, ply )

	if ply:GetNWInt("cutta_SkillPoints") > 0 then
		ply:SetNWInt("cutta_MeleePoints", ply:GetNWInt("cutta_MeleePoints") + 1)
		ply:SetNWInt("cutta_SkillPoints", ply:GetNWInt("cutta_SkillPoints") - 1)
	else
		--ply:PrintMessage(HUD_PRINTTALK,"You Don't Have Enough Skill Points")
	end

end )

net.Receive( "REGmod.SpeedUp", function( len, ply )

	if ply:GetNWInt("cutta_SkillPoints") > 0 then
		ply:SetNWInt("cutta_SpeedPoints", ply:GetNWInt("cutta_SpeedPoints") + 1)
		ply:SetNWInt("cutta_SkillPoints", ply:GetNWInt("cutta_SkillPoints") - 1)
		timer.Simple(0, function()
			ply:SetRunSpeed( cutta_skills_playerspeedskill_run )
			ply:SetWalkSpeed( cutta_skills_playerspeedskill_walk )
		end)
	else
		--ply:PrintMessage(HUD_PRINTTALK,"You Don't Have Enough Skill Points")
	end

end )

concommand.Add("sv_giveskillpoint", function(ply,cmd,arg)

	local name = arg[1]
	local points = arg[2]

	if !ply:IsSuperAdmin() then return end

	for k,v in ipairs(player.GetAll()) do
		if v:Nick() == name then
			v:SetNWInt("cutta_SkillPoints", v:GetNWInt("cutta_SkillPoints") + points)
		end
	end

	

end)