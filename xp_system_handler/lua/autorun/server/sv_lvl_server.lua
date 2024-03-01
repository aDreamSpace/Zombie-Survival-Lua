util.AddNetworkString( "SimpleXPSendSettings" )
util.AddNetworkString( "SimpleXPSendInfo" )
util.AddNetworkString( "SimpleXPSendLeaderboards" )
util.AddNetworkString( "SimpleXPSendLevelChange" )

local Folder = SimpleXPConfig.DefaultFolder
local AllFCVar = FCVAR_ARCHIVE + FCVAR_SERVER_CAN_EXECUTE

CreateConVar("sv_xp_default_color_r", "255", AllFCVar , "Sets the default red color of the XP addon's overlay." )
CreateConVar("sv_xp_default_color_g", "255", AllFCVar , "Sets the default green color of the XP addon's overlay." )
CreateConVar("sv_xp_default_color_b", "255", AllFCVar , "Sets the default blue color of the XP addon's overlay." )

local DEBUGMODE = false


function SimpleXPGetSteamIDProper(ply)
	if DEBUGMODE then print("Getting Steam Edit...") end
	return string.gsub(ply:SteamID(), ":", "_")
end

function SimpleXPGetDataPath(ply)
	if DEBUGMODE then print("Getting path...") end
	return Folder .. "/" .. SimpleXPGetSteamIDProper(ply) .. ".txt"
end

function SimpleXPDataCheck(ply)
	if DEBUGMODE then print("Checking Data...") end
	if not file.Exists(Folder,"DATA") then
		file.CreateDir(Folder)
	end
	if not file.Exists(SimpleXPGetDataPath(ply),"DATA") then 
		file.Write(SimpleXPGetDataPath(ply),"0") 
	end
end

function SimpleXPSaveData(ply,data)
	if DEBUGMODE then print("Saving Data...") end
	SimpleXPDataCheck(ply)
	ply:SetNWFloat("BurgerLevel",data)
	file.Write(SimpleXPGetDataPath(ply),data)
end

function SimpleXPLoadData(ply)
	if DEBUGMODE then print("Loading Data...") end
	SimpleXPDataCheck(ply)
	local ReadFile = file.Read(SimpleXPGetDataPath(ply),"DATA")
	local Data = tonumber(ReadFile)
	return Data
end

function SimpleXPPlayerSpawn(ply)
	SimpleXPSetXP(ply,SimpleXPLoadData(ply),true)
end

hook.Add("PlayerInitialSpawn","Burger Level Player Initial Spawn",SimpleXPPlayerSpawn)

function SimpleXPSendTableData(messagename,data,ply)
	net.Start(messagename)
		net.WriteTable(data)
	net.Send(ply)
end

function SimpleXPAddXPSafe(ply,xp,suppresshook)
	if DEBUGMODE then print("Sending XP...") end
	if not suppresshook then
		xp = hook.Run("OnSimpleXPAddXP", ply, xp) or xp
	end
	xp = math.floor(xp)
	if not SimpleXPGetXP(ply) then 
		SimpleXPSetXP(ply,SimpleXPLoadData(ply),true)
	end
	local CurrentLevelXPAmount = SimpleXPGetXP(ply) - SimpleXPCalculateLevelToXP(SimpleXPGetLevel(ply))
	if CurrentLevelXPAmount + xp < 0 then
		xp = -CurrentLevelXPAmount
	end
	SimpleXPAddXP(ply,xp,true)
end

function SimpleXPCheckPlayerLevel(ply)

	local CurrentLevel = SimpleXPGetLevel(ply)
	
	if not ply.SIMPLEXP_LastLevel then
		ply.SIMPLEXP_LastLevel = CurrentLevel
	elseif ply.SIMPLEXP_LastLevel ~= CurrentLevel then
		local WasLevelUp = CurrentLevel > ply.SIMPLEXP_LastLevel
		SimpleXPLevelChange(ply,ply.SIMPLEXP_LastLevel,CurrentLevel)
		ply.SIMPLEXP_LastLevel = CurrentLevel	
	end

end

function SimpleXPLevelChange(ply,oldlevel,newlevel)

	hook.Run("SimpleXPOnLevelChange",ply,oldlevel,newlevel)

	net.Start("SimpleXPSendLevelChange")
		net.WriteEntity(ply)
		net.WriteInt(oldlevel,32)
		net.WriteInt(newlevel,32)
	net.Broadcast()
	
end

function SimpleXPAddXP(ply,xp,suppresshook)
	if DEBUGMODE then print("Adding XP...") end
	if not suppresshook then
		xp = hook.Run("OnSimpleXPAddXP", ply, xp) or xp
	end
	xp = math.floor(xp)
	SimpleXPSetXP(ply,SimpleXPGetXP(ply) + xp,true)
end

function SimpleXPAddXPText(ply,xp,text,override,suppresshook)
	if not suppresshook then
		xp = hook.Run("OnSimpleXPAddXP", ply, xp, text) or xp
	end
	local XP, MessageTable = SimpleXPHandleMessageAndXP(text,xp,{},0,override)
	if XP and MessageTable then
		SimpleXPSendTableData("SimpleXPSendInfo",MessageTable,ply)
		SimpleXPAddXPSafe(ply,XP,true)
	end
end

function SimpleXPSetXP(ply,xp,suppresshook)
	if DEBUGMODE then print("Setting XP...") end
	xp = math.floor(xp)
	xp = math.min(xp,SimpleXPCalculateLevelToXP(SimpleXPConfig.LevelCap))
	xp = math.max(0,xp)
	if not suppresshook then
		xp = hook.Run("OnSimpleXPSetXP", ply, xp, text) or xp
	end
	SimpleXPSaveData(ply,xp)
	SimpleXPCheckPlayerLevel(ply)
end

function SimpleXPSetXPText(ply,xp,text,suppresshook)
	local Difference = xp - SimpleXPGetXP(ply)
	if not suppresshook then
		xp = hook.Run("OnSimpleXPSetXP", ply, xp, text) or xp
	end
	XP, MessageTable = SimpleXPHandleMessageAndXP(text,Difference,{},0)
	if XP and MessageTable then
		SimpleXPSetXP(ply,xp,true)
		SimpleXPSendTableData("SimpleXPSendInfo",MessageTable,ply)
	end
end

function SimpleXPHasAdmin(ply)
	return ply:IsAdmin() or ply:IsSuperAdmin() or ply:GetUserGroup() == "admin" or ply:GetUserGroup() == "superadmin"
end

local NextSpew = 0

function SimpleXPTrackTime()
	if NextSpew <= RealTime() then
		for k,v in pairs(player.GetAll()) do
			SimpleXPAddXPText(v,SimpleXPConfig.GiveXPOnTimeAmount,SimpleXPConfig.GiveXPOnTimeMessage)
		end
		NextSpew = RealTime() + SimpleXPConfig.GiveXPOnTimeDelay
	end
end

hook.Add("Think","Levelling Time Tracker",SimpleXPTrackTime)

function SimpleXPTrackDamage(ply,hitgroup,dmginfo)
	if DEBUGMODE then print("Tracking Damage...") end
	local attacker = dmginfo:GetAttacker()
	local damage = dmginfo:GetDamage() or 1
	SimpleXPHandleAssists(attacker,ply,damage)
end

hook.Add("ScalePlayerDamage","Assists Tracker",SimpleXPTrackDamage)

function SimpleXPHandleAssists(attacker,victim,damage)
	if DEBUGMODE then print("Tracking Assists...") end
	if attacker:IsPlayer() then
		if not victim.Attackers then
			victim.Attackers = {}
		end
		if not victim.Attackers[attacker] then
			victim.Attackers[attacker] = {}
			victim.Attackers[attacker]["damage"] = damage
		else
			victim.Attackers[attacker]["damage"] = victim.Attackers[attacker]["damage"] + damage
		end
		victim.Attackers[attacker]["attacker"] = attacker
		victim.Attackers[attacker]["time"] = RealTime() + 60
	end
end

function SimpleXPTrackKills(victim,weapon,attacker)
	if DEBUGMODE then print("Tracking Kills...") end
	
	local Check = SimpleXPConfig.PlayerCount or 0
	
	local Pass = (Check <= 0) or (Check <= table.Count(player.GetAll()) ) or (game.SinglePlayer())

	if attacker:IsPlayer() and Pass then
		if weapon:IsPlayer() and attacker:GetActiveWeapon() then
			weapon = attacker:GetActiveWeapon()
		end
		if not victim.BurLastDeath then
			victim.BurLastDeath = victim
		end
		if not attacker.BurLastKill then
			attacker.BurLastKill = attacker
		end
		SimpleXPHandleSpree(attacker,victim)
		SimpleXPHandleMultiKills(attacker)
		SimpleXPHandleKillsXP(victim,weapon,attacker)
		SimpleXPHandleAssistsXP(victim,attacker)
		SimpleXPHandleRevenge(attacker,victim)
	end
	
end

hook.Add("PlayerDeath","Level Death Tracker",SimpleXPTrackKills)

function SimpleXPTrackNPC(victim,attacker,weapon)
	if attacker:IsPlayer() then
		local MessageTable =  {}
		local XP = 0
		if weapon:IsPlayer() and attacker:GetActiveWeapon() then
			weapon = attacker:GetActiveWeapon()
		end
		local HealthThing = SimpleXPConfig.NpcKillsBase + SimpleXPConfig.NpcMaxHealth*victim:GetMaxHealth()
		SimpleXPAddXPText(attacker,HealthThing,"KILL")
	end
end

hook.Add("OnNPCKilled","Level NPC Kill Tracker",SimpleXPTrackNPC)

function SimpleXPHandleKillsXP(victim,weapon,attacker)
	if DEBUGMODE then print("Handling Kills...") end
	
	local MessageTable =  {}
	local XP = 0
	
	if victim == attacker then
		if SimpleXPConfig.Suicide ~= 0 then
			XP, MessageTable = SimpleXPHandleMessageAndXP("SUICIDE",SimpleXPConfig.Suicide,MessageTable,XP)
		end
	else
		XP, MessageTable = SimpleXPHandlePlayer(XP,MessageTable,victim,attacker)
		XP, MessageTable = SimpleXPHandleWeapons(XP,MessageTable,weapon)
	end
	
	if MessageTable and XP then
		SimpleXPSendTableData("SimpleXPSendInfo",MessageTable,attacker)
		SimpleXPAddXPSafe(attacker,XP)
	end
	
end

function SimpleXPHandlePlayer(XP,MessageTable,victim,attacker)

	if victim:IsPlayer() then
		if SimpleXPConfig.Kills != 0 then
			XP, MessageTable = SimpleXPHandleMessageAndXP("KILL",SimpleXPConfig.Kills,MessageTable,XP)
		end
	end

	if SimpleXPConfig.Headshots != 0 then
		if victim:LastHitGroup() == HITGROUP_HEAD then
			XP, MessageTable = SimpleXPHandleMessageAndXP("HEADSHOT BONUS",SimpleXPConfig.Headshots,MessageTable,XP)
		end
	end
	
	if SimpleXPConfig.Multikills != 0 then
		if attacker.BurMultiKills > 1 then
			XP, MessageTable = SimpleXPHandleMessageAndXP("MULTIKILL BONUS",(SimpleXPConfig.Multikills*attacker.BurMultiKills) - SimpleXPConfig.Multikills,MessageTable,XP)
		end
	end
	
	if SimpleXPConfig.Spree != 0 then
		if attacker.BurSpree > 1 then
			XP, MessageTable = SimpleXPHandleMessageAndXP("SPREE BONUS",(SimpleXPConfig.Spree*attacker.BurSpree) - SimpleXPConfig.Spree,MessageTable,XP)
		end
	end
	
	if SimpleXPConfig.Survivor != 0 then
		if attacker:Health() < 25 and attacker:Alive() then
			XP, MessageTable = SimpleXPHandleMessageAndXP("CLOSE CALL",SimpleXPConfig.Survivor,MessageTable,XP)
		end
	end

	if SimpleXPConfig.Range != 0 then
		local Distance = attacker:GetPos():Distance(victim:GetPos())
		if Distance >= 2048 then
			XP, MessageTable = SimpleXPHandleMessageAndXP("RANGE BONUS",SimpleXPConfig.Range, MessageTable ,XP)
		end
	end
	
	if SimpleXPConfig.Overkill != 0 then
		local OverkillBonus = math.Clamp(-victim:Health(),0,500)*SimpleXPConfig.Overkill
		if OverkillBonus >= 25 then
			XP, MessageTable = SimpleXPHandleMessageAndXP("OVERKILL BONUS",OverkillBonus, MessageTable ,XP)
		end
	end
	
	if SimpleXPConfig.RepeatOffender ~= 0 then
		if attacker.BurLastKill == victim then
			XP, MessageTable = SimpleXPHandleMessageAndXP("REPEAT OFFENDER BONUS",SimpleXPConfig.RepeatOffender, MessageTable ,XP)
		end
	end
	
	if SimpleXPConfig.Revenge ~= 0 then
		if attacker.BurLastDeath == victim then
			attacker.BurLastDeath = nil
			XP, MessageTable = SimpleXPHandleMessageAndXP("REVENGE BONUS",SimpleXPConfig.Revenge, MessageTable ,XP)
		end
	end
	
	if SimpleXPConfig.HigherLevel ~= 0 then
		local HighTargetMath = math.Clamp(SimpleXPGetLevel(victim) - SimpleXPGetLevel(attacker),0,100)*SimpleXPConfig.HigherLevel
		if (HighTargetMath > 0) then
			XP, MessageTable = SimpleXPHandleMessageAndXP("HIGHER LEVEL BONUS", HighTargetMath, MessageTable, XP)
		end
	end
	
	return XP, MessageTable

end

function SimpleXPHandleWeapons(XP,MessageTable,weapon)

	if IsValid(weapon) then
		if weapon:IsWeapon() then
		
			local HoldType = weapon:GetHoldType() or weapon.HoldType or "none"
		
			if HoldType then
			
				if SimpleXPConfig.Pistol != 0 then
					if HoldType == "pistol" or HoldType == "duel" or HoldType == "revolver" then
						XP, MessageTable = SimpleXPHandleMessageAndXP("SIDEARM BONUS",SimpleXPConfig.Pistol,MessageTable,XP)
					end
				end
			
				if SimpleXPConfig.SMG != 0 then
					if HoldType == "smg" then
						XP, MessageTable = SimpleXPHandleMessageAndXP("SMG BONUS",SimpleXPConfig.SMG,MessageTable,XP)
					end
				end

				if SimpleXPConfig.Equipment != 0 then
					if HoldType == "grenade" or HoldType == "slam" then
						XP, MessageTable = SimpleXPHandleMessageAndXP("EQUIPMENT BONUS",SimpleXPConfig.Equipment,MessageTable,XP)
					end
				end
				
				if SimpleXPConfig.Rifle != 0 then
					if HoldType == "ar2" then
						XP, MessageTable = SimpleXPHandleMessageAndXP("RIFLE BONUS",SimpleXPConfig.Rifle,MessageTable,XP)
					end
				end
				
				if SimpleXPConfig.Shotgun != 0 then
					if HoldType == "shotgun" then
						XP, MessageTable = SimpleXPHandleMessageAndXP("SHOTGUN BONUS",SimpleXPConfig.Shotgun,MessageTable,XP)
					end
				end
				
				if SimpleXPConfig.Launcher != 0 then
					if HoldType == "rpg" then
						XP, MessageTable = SimpleXPHandleMessageAndXP("LAUNCHER BONUS",SimpleXPConfig.Launcher,MessageTable,XP)
					end
				end
				
				if SimpleXPConfig.Phys != 0 then
					if HoldType == "physgun" then
						XP, MessageTable = SimpleXPHandleMessageAndXP("PHYSICS BONUS",SimpleXPConfig.Phys ,MessageTable,XP)
					end
				end
				
				if SimpleXPConfig.Crossbow != 0 then
					if HoldType == "crossbow" then
						XP, MessageTable = SimpleXPHandleMessageAndXP("CROSSBOW BONUS",SimpleXPConfig.Crossbow,MessageTable,XP)
					end
				end
				
				if SimpleXPConfig.Melee != 0 then
					if HoldType == "melee" or HoldType == "melee2" or HoldType == "fist" or HoldType == "knife" then
						XP, MessageTable = SimpleXPHandleMessageAndXP("MELEE BONUS",SimpleXPConfig.Melee,MessageTable,XP)
					end
				end
					
				if SimpleXPConfig.Magic != 0 then
					if HoldType == "normal" or HoldType == "passive" or HoldType == "magic" or HoldType == "camera" then
						XP, MessageTable = SimpleXPHandleMessageAndXP("MAGIC BONUS",SimpleXPConfig.Magic,MessageTable,XP)
					end
				end

			end
			
		end
	end
		
	return XP, MessageTable
end

function SimpleXPHandleAssistsXP(ply,attacker)
	if DEBUGMODE then print("Handling Assists...") end
	if ply.Attackers then
		for k,v in pairs(ply.Attackers) do
			if IsValid(k) then
				if k ~= attacker then
					if ply.Attackers[k]["time"] > RealTime() then
						local Mul = math.Clamp(ply.Attackers[k]["damage"],0,100) * SimpleXPConfig.Assist
						if Mul ~= 0 then
							SimpleXPAddXPText(k,Mul,"KILL ASSIST")
						end
					end
				end
			end
		end
	end
	ply.Attackers = {}
end

function SimpleXPHandleMessageAndXP(message,xptoadd,messagetable,xp,ignoremultipliers)

	if DEBUGMODE then print("Handling Messages and XP...") end
	
	if not ignoremultipliers and xptoadd > 0 then
		local Weekday = os.date("%a",os.time())
		
		if Weekday == "Sun" or Weekday == "Sat" or Weekday == "Fri" then
			xptoadd = xptoadd * math.max(SimpleXPConfig.WeekendScale,0)
		else
			xptoadd = xptoadd * math.max(SimpleXPConfig.WeekdayScale,0)
		end
	end
	
	xptoadd = math.floor(xptoadd)
	
	local NewTable = {}
	NewTable.message = message
	NewTable.xp = xptoadd
	local NewMessageTable = table.Copy(messagetable)
	table.Add(NewMessageTable,{NewTable})
	
	xp = xp + xptoadd
	
	return xp, NewMessageTable
end

function SimpleXPHandleRevenge(attacker,victim)
	victim.BurLastDeath = attacker
	attacker.BurLastKill = victim
end

function SimpleXPHandleSpree(attacker,victim)

	if not attacker.BurSpree then
		attacker.BurSpree = 1
	else
		attacker.BurSpree = attacker.BurSpree + 1
	end
	
	victim.BurSpree = 0
	
end

function SimpleXPHandleMultiKills(attacker)

	if not attacker.BurMultiKillsCoolDown then
		attacker.BurMultiKillsCoolDown = 1
	end

	if attacker.BurMultiKillsCoolDown <= RealTime() then 
		attacker.BurMultiKills = 0
	end

	if not attacker.BurMultiKills then
		attacker.BurMultiKills = 1
	end

	attacker.BurMultiKills = attacker.BurMultiKills + 1
	attacker.BurMultiKillsCoolDown = RealTime() + 7

end

function SimpleXPBonuses(ply)
    -- Check if the player's team is not team_undead
    if ply:Team() ~= TEAM_UNDEAD then
        timer.Simple(0,function()
            if SimpleXPConfig.BonusHP ~= 0 then
                local Mul = math.Clamp(100 + math.floor(SimpleXPConfig.BonusHP*SimpleXPGetLevel(ply)),1,9999)
                ply:SetMaxHealth(Mul)
                ply:SetHealth(Mul)
            end
            if SimpleXPConfig.BonusArmor ~= 0 then
                local Mul = math.Clamp(math.floor(SimpleXPConfig.BonusArmor*SimpleXPGetLevel(ply)),0,250)
                ply:SetArmor(Mul)
            end
        end)
    end
end

hook.Add("PlayerSpawn","SimpleXP: PlayerSpawn",SimpleXPBonuses)

local NextRegen = 30

function SimpleXPBonusesThink()

	if NextRegen <= RealTime() then
		for k,v in pairs(player.GetAll()) do
			
			if v and v:Alive() then
			
				if SimpleXPConfig.BonusHPRegen ~= 0 then
					if not v.XPSetHP then
						v.XPSetHP = 0
					else
						v.XPSetHP = v.XPSetHP + math.max(0,SimpleXPConfig.BonusHPRegen*SimpleXPGetLevel(v))
					end
				
					if v.XPSetHP >= 1 and v:Health() < v:GetMaxHealth() then
						local Add = math.floor(v.XPSetHP)
						v:SetHealth( math.Clamp(v:Health() + Add ,1,v:GetMaxHealth()) )
						v.XPSetHP = v.XPSetHP - Add
					end
				end
				
				if SimpleXPConfig.BonusArmorRegen ~= 0 then
					if not v.XPSetArmor then
						v.XPSetArmor = 0
					else
						v.XPSetArmor = v.XPSetArmor + math.max(0,SimpleXPConfig.BonusArmorRegen*SimpleXPGetLevel(v))
					end
				
					if v.XPSetArmor >= 1 and v:Armor() < math.min(250,SimpleXPConfig.BonusArmor*SimpleXPGetLevel(v)) then
						local Add = math.floor(v.XPSetArmor)
						v:SetArmor( math.Clamp(v:Armor() + Add, 0, math.min(250,SimpleXPConfig.BonusArmor*SimpleXPGetLevel(v)) ))
						v.XPSetArmor = v.XPSetArmor - Add
					end
				end
				
			end
		
		end
		
		NextRegen = RealTime() + SimpleXPConfig.TickTime
		
	end
	

end

hook.Add("Think","SimpleXP: Think",SimpleXPBonusesThink)

