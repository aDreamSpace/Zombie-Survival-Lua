--[[

Zombie Survival
by William "JetBoom" Moodhe
williammoodhe@gmail.com -or- jetboom@noxiousnet.com
http://www.noxiousnet.com/

Further credits displayed by pressing F1 in-game.
This was my first ever gamemode. A lot of stuff is from years ago and some stuff is very recent.

]]

-- TODO: player introduced to a "main menu" sort of thing. auto joins as spectator. Requires recoding of a lot of logic because right now we assume only two possible teams and no spectator for humans.

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

AddCSLuaFile("sh_translate.lua")
AddCSLuaFile("sh_colors.lua")
AddCSLuaFile("sh_serialization.lua")
AddCSLuaFile("sh_globals.lua")
AddCSLuaFile("sh_crafts.lua")
AddCSLuaFile("sh_util.lua")
AddCSLuaFile("sh_options.lua")
AddCSLuaFile("sh_zombieclasses.lua")
AddCSLuaFile("sh_animations.lua")
AddCSLuaFile("sh_sigils.lua")
AddCSLuaFile("sh_channel.lua")
AddCSLuaFile("sh_custom.lua")

AddCSLuaFile("cl_core.lua")
AddCSLuaFile("cl_draw.lua")
AddCSLuaFile("cl_util.lua")
AddCSLuaFile("cl_options.lua")
AddCSLuaFile("cl_scoreboard.lua")
AddCSLuaFile("cl_targetid.lua")
AddCSLuaFile("cl_postprocess.lua")
AddCSLuaFile("cl_deathnotice.lua")
AddCSLuaFile("cl_floatingscore.lua")
AddCSLuaFile("cl_dermaskin.lua")
AddCSLuaFile("cl_hint.lua")
AddCSLuaFile("cl_custom.lua")
AddCSLuaFile("cl_voice.lua")
AddCSLuaFile("cl_voicesets.lua")
--AddCSLuaFile("cl_hitdamagenumbers.lua")

AddCSLuaFile("obj_vector_extend.lua")
AddCSLuaFile("obj_player_extend.lua")
AddCSLuaFile("obj_player_extend_cl.lua")
AddCSLuaFile("obj_weapon_extend.lua")
AddCSLuaFile("obj_weapon_extend_cl.lua")
AddCSLuaFile("obj_entity_extend.lua")
AddCSLuaFile("obj_entity_extend_cl.lua")

AddCSLuaFile("vgui/dgamestate.lua")
AddCSLuaFile("vgui/dteamcounter.lua")
AddCSLuaFile("vgui/dmodelpanelex.lua")
AddCSLuaFile("vgui/dammocounter.lua")
AddCSLuaFile("vgui/dpingmeter.lua")
AddCSLuaFile("vgui/dteamheading.lua")
AddCSLuaFile("vgui/dsidemenu.lua")
AddCSLuaFile("vgui/dmodelkillicon.lua")
AddCSLuaFile("vgui/dhint.lua")
AddCSLuaFile("vgui/dwebimage.lua")

AddCSLuaFile("vgui/dexroundedpanel.lua")
AddCSLuaFile("vgui/dexroundedframe.lua")
AddCSLuaFile("vgui/dexrotatedimage.lua")
AddCSLuaFile("vgui/dexnotificationslist.lua")
AddCSLuaFile("vgui/dexchanginglabel.lua")

AddCSLuaFile("vgui/mainmenu.lua")
AddCSLuaFile("vgui/pmainmenu.lua")
AddCSLuaFile("vgui/poptions.lua")
AddCSLuaFile("vgui/phelp.lua")
AddCSLuaFile("vgui/pclassselect.lua")
AddCSLuaFile("vgui/pweapons.lua")
AddCSLuaFile("vgui/pendboard.lua")
AddCSLuaFile("vgui/pworth.lua")
AddCSLuaFile("vgui/ppointshop.lua")
--AddCSLuaFile("vgui/parsenal.lua")
AddCSLuaFile("vgui/zshealtharea.lua")
AddCSLuaFile("vgui/pteleport.lua")
--AddCSLuaFile("cl_splitmessage.lua")

include("shared.lua")
include("sv_options.lua")
include("sv_crafts.lua")
include("obj_entity_extend_sv.lua")
include("obj_player_extend_sv.lua")
include("mapeditor.lua")
include("sv_playerspawnentities.lua")
include("sv_core.lua")
include("sv_sigils.lua")
include("sv_custom.lua")
--include("sv_hitdamagenumbers.lua") 

include("sv_zombieescape.lua")

if file.Exists(GM.FolderName.."/gamemode/core_modules/maps/"..game.GetMap()..".lua", "LUA") then
	include("maps/"..game.GetMap()..".lua")
end

function BroadcastLua(code)
	for _, pl in pairs(player.GetAll()) do
		pl:SendLua(code)
	end
end

player.GetByUniqueID = player.GetByUniqueID or function(uid)
	for _, pl in pairs(player.GetAll()) do
		if pl:UniqueID() == uid then return pl end
	end
end

function GM:WorldHint(hint, pos, ent, lifetime, filter)
	net.Start("zs_worldhint")
		net.WriteString(hint)
		net.WriteVector(pos or ent and ent:IsValid() and ent:GetPos() or vector_origin)
		net.WriteEntity(ent or NULL)
		net.WriteFloat(lifetime or 8)
	if filter then
		net.Send(filter)
	else
		net.Broadcast()
	end
end

function GM:CreateGibs(pos, headoffset)
	headoffset = headoffset or 0

	local headpos = Vector(pos.x, pos.y, pos.z + headoffset)
	for i = 1, 2 do
		local ent = ents.CreateLimited("prop_playergib")
		if ent:IsValid() then
			ent:SetPos(headpos + VectorRand() * 5)
			ent:SetAngles(VectorRand():Angle())
			ent:SetGibType(i)
			ent:Spawn()
		end
	end

	for i=1, 4 do
		local ent = ents.CreateLimited("prop_playergib")
		if ent:IsValid() then
			ent:SetPos(pos + VectorRand() * 12)
			ent:SetAngles(VectorRand():Angle())
			ent:SetGibType(math.random(3, #GAMEMODE.HumanGibs))
			ent:Spawn()
		end
	end
end

function GM:TryHumanPickup(pl, entity)
	if self.ZombieEscape or pl.NoObjectPickup or not pl:Alive() or pl:Team() ~= TEAM_HUMAN then return end

	if entity:IsValid() and not entity.m_NoPickup then
		local entclass = string.sub(entity:GetClass(), 1, 12)
		if (entclass == "prop_physics" or entclass == "func_physbox" or entity.HumanHoldable and entity:HumanHoldable(pl)) and not entity:IsNailed() and entity:GetMoveType() == MOVETYPE_VPHYSICS and entity:GetPhysicsObject():IsValid() and entity:GetPhysicsObject():GetMass() <= CARRY_MAXIMUM_MASS and entity:GetPhysicsObject():IsMoveable() and entity:OBBMins():Length() + entity:OBBMaxs():Length() <= CARRY_MAXIMUM_VOLUME then
			local holder, status = entity:GetHolder()
			if not holder and not pl:IsHolding() and CurTime() >= (pl.NextHold or 0)
			and pl:GetShootPos():DistToSqr(entity:NearestPoint(pl:GetShootPos())) <= 4096 and pl:GetGroundEntity() ~= entity then
				local newstatus = ents.Create("status_human_holding")
				if newstatus:IsValid() then
					pl.NextHold = CurTime() + 0.25
					pl.NextUnHold = CurTime() + 0.05
					newstatus:SetPos(pl:GetShootPos())
					newstatus:SetOwner(pl)
					newstatus:SetParent(pl)
					newstatus:SetObject(entity)
					newstatus:Spawn()
				end
			end
		end
	end
end

function GM:AddResources()
	--content mounted via workshop
end

function GM:Initialize()
	self:RegisterPlayerSpawnEntities()
	self:AddResources()
	self:PrecacheResources()
	self:AddCustomAmmo()
	self:AddNetworkStrings()

	self:SetPantsMode(self.PantsMode, true)
	self:SetClassicMode(self:IsClassicMode(), true)
	self:SetBabyMode(self:IsBabyMode(), true)
	self:SetRedeemBrains(self.DefaultRedeem)

	local mapname = string.lower(game.GetMap())
	if string.find(mapname, "_obj_", 1, true) or string.find(mapname, "objective", 1, true) then
		self.ObjectiveMap = true
	end

	--[[if string.sub(mapname, 1, 3) == "zm_" then
		NOZOMBIEGASSES = true
	end]]

	game.ConsoleCommand("fire_dmgscale 1\n")
	game.ConsoleCommand("mp_flashlight 1\n")
	game.ConsoleCommand("sv_gravity 600\n")
end

function GM:AddNetworkStrings()
	util.AddNetworkString("zs_gamestate")
	util.AddNetworkString("zs_wavestart")
	util.AddNetworkString("zs_waveend")
	util.AddNetworkString("zs_lasthuman")
	util.AddNetworkString("zs_gamemodecall")
	util.AddNetworkString("zs_lasthumanpos")
	util.AddNetworkString("zs_endround")
	util.AddNetworkString("zs_centernotify")
	util.AddNetworkString("zs_topnotify")
	util.AddNetworkString("zs_zvols")
	util.AddNetworkString("zs_nextboss")
	util.AddNetworkString("zs_classunlock")

	util.AddNetworkString("zs_playerredeemed")
	util.AddNetworkString("zs_dohulls")
	util.AddNetworkString("zs_penalty")
	util.AddNetworkString("zs_nextresupplyuse")
	util.AddNetworkString("zs_lifestats")
	util.AddNetworkString("zs_lifestatsbd")
	util.AddNetworkString("zs_lifestatshd")
	util.AddNetworkString("zs_lifestatsbe")
	util.AddNetworkString("zs_boss_spawned")
	util.AddNetworkString("zs_commission")
	util.AddNetworkString("zs_healother")
	util.AddNetworkString("zs_repairobject")
	util.AddNetworkString("zs_repairobject_assist")
	util.AddNetworkString("zs_worldhint")
	util.AddNetworkString("zs_honmention")
	util.AddNetworkString("zs_floatscore")
	util.AddNetworkString("zs_floatscore_vec")
	util.AddNetworkString("zs_zclass")
	util.AddNetworkString("zs_dmg")
	util.AddNetworkString("zs_dmg_prop")
	util.AddNetworkString("zs_legdamage")

	util.AddNetworkString("zs_crow_kill_crow")
	util.AddNetworkString("zs_pl_kill_pl")
	util.AddNetworkString("zs_pls_kill_pl")
	util.AddNetworkString("zs_pl_kill_self")
	util.AddNetworkString("zs_death")
	util.AddNetworkString("zs_pl_kill_ent")

	util.AddNetworkString("voice_eyepain")
	util.AddNetworkString("voice_giveammo")
	util.AddNetworkString("voice_death")
	util.AddNetworkString("voice_zombiedeath")
	util.AddNetworkString("voice_pain")
	util.AddNetworkString("voice_zombiepain")
end

function GM:IsClassicMode()
	return self.ClassicMode
end

function GM:IsBabyMode()
	return self.BabyMode
end

function GM:CenterNotifyAll(...)
	net.Start("zs_centernotify")
		net.WriteTable({...})
	net.Broadcast()
end
GM.CenterNotify = GM.CenterNotifyAll

function GM:TopNotifyAll(...)
	net.Start("zs_topnotify")
		net.WriteTable({...})
	net.Broadcast()
end
GM.TopNotify = GM.TopNotifyAll

function GM:ShowHelp(pl)
	if (pl:GetActiveWeapon().CW20Weapon and pl:GetActiveWeapon().dt.State == CW_CUSTOMIZE) then return end
	pl:SendLua("GAMEMODE:ShowHelp()")
end

function GM:ShowTeam(pl)
	if (pl:GetActiveWeapon().CW20Weapon and pl:GetActiveWeapon().dt.State == CW_CUSTOMIZE) then return end
	if pl:Team() == TEAM_HUMAN and not self.ZombieEscape then
		pl:SendLua(self:GetWave() > 0 and "GAMEMODE:OpenPointsShop()" or "MakepWorth()")
	end
end

function GM:ShowSpare1(pl)
	if (pl:GetActiveWeapon().CW20Weapon and pl:GetActiveWeapon().dt.State == CW_CUSTOMIZE) then return end
	if pl:Team() == TEAM_UNDEAD then
		if self:ShouldUseAlternateDynamicSpawn() then
			pl:CenterNotify(COLOR_RED, translate.ClientGet(pl, "no_class_switch_in_this_mode"))
		else
			pl:SendLua("GAMEMODE:OpenClassSelect()")
		end
	elseif pl:Team() == TEAM_HUMAN then
		pl:SendLua("MakepWeapons()")
	end
end

function GM:ShowSpare2(pl)
	if (pl:GetActiveWeapon().CW20Weapon and pl:GetActiveWeapon().dt.State == CW_CUSTOMIZE) then return end
	pl:SendLua("MakepOptions()")
end

function GM:SetupSpawnPoints()
	local ztab = ents.FindByClass("info_player_undead")
	ztab = table.Add(ztab, ents.FindByClass("info_player_zombie"))
	ztab = table.Add(ztab, ents.FindByClass("info_player_rebel"))

	local htab = ents.FindByClass("info_player_human")
	htab = table.Add(htab, ents.FindByClass("info_player_combine"))

	local mapname = string.lower(game.GetMap())
	-- Terrorist spawns are usually in some kind of house or a main base in CS_  in order to guard the hosties. Put the humans there.
	if string.sub(mapname, 1, 3) == "cs_" or string.sub(mapname, 1, 3) == "zs_" then
		ztab = table.Add(ztab, ents.FindByClass("info_player_counterterrorist"))
		htab = table.Add(htab, ents.FindByClass("info_player_terrorist"))
	else -- Otherwise, this is probably a DE_, ZM_, or ZH_ map. In DE_ maps, the T's spawn away from the main part of the map and are zombies in zombie plugins so let's do the same.
		ztab = table.Add(ztab, ents.FindByClass("info_player_terrorist"))
		htab = table.Add(htab, ents.FindByClass("info_player_counterterrorist"))
	end

	-- Add all the old ZS spawns from GMod9.
	for _, oldspawn in pairs(ents.FindByClass("gmod_player_start")) do
		if oldspawn.BlueTeam then
			table.insert(htab, oldspawn)
		else
			table.insert(ztab, oldspawn)
		end
	end

	-- You shouldn't play a DM map since spawns are shared but whatever. Let's make sure that there aren't team spawns first.
	if #htab == 0 then
		htab = ents.FindByClass("info_player_start")
		htab = table.Add(htab, ents.FindByClass("info_player_deathmatch")) -- Zombie Master
	end
	if #ztab == 0 then
		ztab = ents.FindByClass("info_player_start")
		ztab = table.Add(ztab, ents.FindByClass("info_zombiespawn")) -- Zombie Master
	end

	team.SetSpawnPoint(TEAM_UNDEAD, ztab)
	team.SetSpawnPoint(TEAM_HUMAN, htab)
	team.SetSpawnPoint(TEAM_SPECTATOR, htab)

	self.RedeemSpawnPoints = ents.FindByClass("info_player_redeemed")
	self.BossSpawnPoints = table.Add(ents.FindByClass("info_player_zombie_boss"), ents.FindByClass("info_player_undead_boss"))
end

function GM:PlayerPointsAdded(pl, amount)
end

local weaponmodelstoweapon = {}
--weaponmodelstoweapon["models/props/cs_office/computer_keyboard.mdl"] = "weapon_zs_keyboard"
--weaponmodelstoweapon["models/props_c17/computer01_keyboard.mdl"] = "weapon_zs_keyboard"
--weaponmodelstoweapon["models/props_c17/metalpot001a.mdl"] = "weapon_zs_pot"
--weaponmodelstoweapon["models/props_interiors/pot02a.mdl"] = "weapon_zs_fryingpan"
--weaponmodelstoweapon["models/props_c17/metalpot002a.mdl"] = "weapon_zs_fryingpan"
--weaponmodelstoweapon["models/props_junk/shovel01a.mdl"] = "weapon_zs_shovel"
--weaponmodelstoweapon["models/props/cs_militia/axe.mdl"] = "weapon_zs_axe"
weaponmodelstoweapon["models/props_c17/tools_wrench01a.mdl"] = "cw_tool_hammer"
weaponmodelstoweapon["models/weapons/w_knife_t.mdl"] = "cw_melee_knife"
weaponmodelstoweapon["models/weapons/w_knife_ct.mdl"] = "cw_melee_knife"
weaponmodelstoweapon["models/weapons/w_crowbar.mdl"] = "cw_melee_crowbar"
weaponmodelstoweapon["models/weapons/w_stunbaton.mdl"] = "cw_melee_stunstick"
weaponmodelstoweapon["models/props_interiors/furniture_lamp01a.mdl"] = "weapon_zs_lamp"
weaponmodelstoweapon["models/props_junk/rock001a.mdl"] = "weapon_zs_stone"
weaponmodelstoweapon["models/props_c17/canister01a.mdl"] = "weapon_zs_oxygentank"
--weaponmodelstoweapon["models/props_canal/mattpipe.mdl"] = "weapon_zs_pipe"
--weaponmodelstoweapon["models/props_junk/meathook001a.mdl"] = "weapon_zs_hook"

function GM:InitPostEntity()
	gamemode.Call("InitPostEntityMap")

	RunConsoleCommand("mapcyclefile", "mapcycle_zombiesurvival.txt")

	if string.find(string.lower(GetConVarString("hostname")), "hellsgamers", 1, true) then
		self.Think = function() end
		self.DoPlayerDeath = self.Think
		self.SetWave = self.Think
		timer.Simple(20, function() RunConsoleCommand("quit") end)

		ErrorNoHalt("You are literally not allowed to host this version. See license.txt")
	end
end

function GM:SetupProps()
	for _, ent in pairs(ents.FindByClass("prop_physics*")) do
		local mdl = ent:GetModel()
		if mdl then
			mdl = string.lower(mdl)
			if table.HasValue(self.BannedProps, mdl) then
				ent:Remove()
			elseif weaponmodelstoweapon[mdl] then
				local wep = ents.Create("prop_weapon")
				if wep:IsValid() then
					wep:SetPos(ent:GetPos())
					wep:SetAngles(ent:GetAngles())
					wep:SetWeaponType(weaponmodelstoweapon[mdl])
					wep:SetShouldRemoveAmmo(false)
					wep:Spawn()

					ent:Remove()
				end
			elseif (ent:GetMaxHealth() == 1 and ent:Health() == 0 or ent:GetClass() == "prop_physics_multiplayer") and ent:GetKeyValues().damagefilter ~= "invul" and ent:GetName() == "" then
				local health = math.min(2500, math.ceil((ent:OBBMins():Length() + ent:OBBMaxs():Length()) * 10))
				local hmul = self.PropHealthMultipliers[mdl]
				if hmul then
					health = health * hmul
				end

				ent.PropHealth = health
				ent.TotalHealth = health
			else
				ent:SetHealth(math.ceil(ent:Health() * 3))
				ent:SetMaxHealth(ent:Health())
			end
		end
	end
end

function GM:RemoveUnusedEntities()
	-- Causes a lot of needless lag.
	util.RemoveAll("prop_ragdoll")

	-- Remove NPCs because first of all this game is PvP and NPCs can cause crashes.
	

	-- Such a headache. Just remove them all.
	util.RemoveAll("item_ammo_crate")

	-- Shouldn't exist.
	util.RemoveAll("item_suitcharger")
end


local weaponreplacements = {
weapon_zs_owens = "cw_pist_cz75",
weapon_zs_blaster = "cw_shot_shorty",
weapon_zs_deagle = "cw_pist_p99",
weapon_zs_akbar = "cw_ar_ak74",
weapon_zs_m4 = "cw_ar_ar15",
weapon_zs_peashooter = "cw_pist_fnp45",
weapon_zs_battleaxe = "cw_pist_usp",
weapon_zs_uzi = "cw_smg_vz61",
weapon_zs_reaper = "cw_smg_mp9",
weapon_zs_crackler = "cw_ar_famas",
weapon_zs_hunter = "cw_rif_winchester",
weapon_zs_inferno = "cw_ak12",
weapon_zs_magnum = "cw_pist_deagle",
weapon_zs_pulserifle = "cw_ar_msbs",
weapon_zs_annabelle =  "cw_winchester",
weapon_zs_bulletstorm = "cw_smg_mp40",
weapon_zs_silencer = "cw_smg_mp5",
weapon_zs_slugrifle = "cw_rif_mosin",
--weapon_zs_waraxe = 
weapon_zs_stubber = "cw_rif_delisle",
weapon_zs_ender = "cw_shot_spas12",
weapon_zs_eraser = "cw_pist_fiveseven",
weapon_zs_glock3 = "cw_pist_makarov",
weapon_zs_redeemers = "cw_pist_mateba",
weapon_zs_sweepershotgun = "cw_shot_m3super90",
weapon_zs_tosser = "cw_smg_mac_11",
weapon_zs_hammer = "cw_tool_hammer",
weapon_zs_stunbaton = "cw_melee_stunstick",
weapon_zs_stunstick = "cw_melee_stunstick",
weapon_zs_crowbar = "cw_melee_crowbar",
weapon_zs_knife = "cw_melee_knife",
weapon_zs_swissarmyknife = "cw_melee_knife",
}

local attreplacements = {
	weapon_zs_electrohammer = "md_m_electrumhammer",
}

function GM:ReplaceMapWeapons()
	for _, ent in pairs(ents.FindByClass("weapon_*")) do
		local wepclass = ent:GetClass()
		if wepclass ~= "weapon_map_base" then
			if string.sub(wepclass, 1, 10) == "weapon_zs_" then
				if attreplacements[wepclass] then --first handle attachment placements
					local att = ents.Create("prop_attachment")
					if att and att:IsValid() then
						att:SetPos(ent:GetPos())
						att:SetAngles(ent:GetAngles())
						att:SetAttachmentType(attreplacements[wepclass])
						att:Spawn()

						ent:Remove()
						
						continue
					end
				end
					
				local wep = ents.Create("prop_weapon")
				if wep:IsValid() and (weaponreplacements[wepclass] or ent.AmmoIfHas) then
					wep:SetPos(ent:GetPos())
					wep:SetAngles(ent:GetAngles())
					wep:SetWeaponType(weaponreplacements[wepclass] or wepclass)
					wep:SetShouldRemoveAmmo(false)
					wep:Spawn()
					wep.IsPreplaced = true
				end
			end
			ent:Remove()
		end
	end
end

local ammoreplacements = {
	["item_ammo_357"] = "357",
	["item_ammo_357_large"] = "357",
	["item_ammo_pistol"] = "pistol",
	["item_ammo_pistol_large"] = "pistol",
	["item_ammo_buckshot"] = "buckshot",
	["item_ammo_ar2"] = "ar2",
	["item_ammo_ar2_large"] = "ar2",
	["item_ammo_ar2_altfire"] = "pulse",
	["item_ammo_crossbow"] = "xbowbolt",
	["item_ammo_smg1"] = "smg1",
	["item_ammo_smg1_large"] = "smg1",
	["item_box_buckshot"] = "buckshot"
}
function GM:ReplaceMapAmmo()
	for classname, ammotype in pairs(ammoreplacements) do
		for _, ent in pairs(ents.FindByClass(classname)) do
			local newent = ents.Create("prop_ammo")
			if newent:IsValid() then
				newent:SetAmmoType(ammotype)
				newent.PlacedInMap = true
				newent:SetPos(ent:GetPos())
				newent:SetAngles(ent:GetAngles())
				newent:Spawn()
				newent:SetAmmo(self.AmmoCache[ammotype] or 1)
			end
			ent:Remove()
		end
	end

	util.RemoveAll("item_item_crate")
end

function GM:ReplaceMapBatteries()
	util.RemoveAll("item_battery")
end

function GM:CreateZombieGas()
	if NOZOMBIEGASSES then return end

	local humanspawns = team.GetValidSpawnPoint(TEAM_HUMAN)
	local zombiespawns = team.GetValidSpawnPoint(TEAM_UNDEAD)

	for _, zombie_spawn in pairs(zombiespawns) do
		local gasses = ents.FindByClass("zombiegasses")
		if 4 < #gasses then
			return
		end

		if #gasses > 0 and math.random(5) ~= 1 then
			continue
		end

		local spawnpos = zombie_spawn:GetPos() + Vector(0, 0, 24)

		local near = false

		if not self.ZombieEscape then
			for __, human_spawn in pairs(humanspawns) do
				if human_spawn:IsValid() and human_spawn:GetPos():Distance(spawnpos) < 500 then
					near = true
					break
				end
			end
		end

		if not near then
			for __, gas in pairs(gasses) do
				if gas:GetPos():Distance(spawnpos) < 350 then
					near = true
					break
				end
			end
		end

		if not near then
			local ent = ents.Create("zombiegasses")
			if ent:IsValid() then
				ent:SetPos(spawnpos)
				ent:Spawn()
			end
		end
	end
end

function GM:CheckDynamicSpawnHR(ent)
	if ent and ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_UNDEAD then
		ent.DynamicSpawnedOn = ent.DynamicSpawnedOn + 1
	end
end

local playermins = Vector(-17, -17, 0)
local playermaxs = Vector(17, 17, 4)
local LastSpawnPoints = {}


function GM:PlayerSelectSpawn(pl)
	local spawninplayer = false
	local teamid = pl:Team()
	local tab
	local epicenter
	if pl.m_PreRedeem and teamid == TEAM_HUMAN and #self.RedeemSpawnPoints >= 1 then
		tab = self.RedeemSpawnPoints
	elseif teamid == TEAM_UNDEAD then
		if pl:GetZombieClassTable().Boss and (not pl.DeathClass or self.ZombieClasses[pl.DeathClass].Boss) and #self.BossSpawnPoints >= 1 then
			tab = self.BossSpawnPoints
		elseif self.DynamicSpawning --[[and CurTime() >= self:GetWaveStart() + 1]] then -- If we're a bit in the wave then we can spawn on top of heavily dense groups with no humans looking at us.
			if self:ShouldUseAlternateDynamicSpawn() then
				-- If they're near a human, use position where they died.
				for _, h in pairs(team.GetPlayers(TEAM_HUMAN)) do
					if h:GetPos():Distance(epicenter or pl:GetPos()) < 1024 then
						epicenter = pl.KilledPos
						break
					end
				end

				-- Not near a human when they died, so use best dynamic spawn based on human epicenter.
				if not epicenter then
					local best = self:GetBestDynamicSpawn(pl)
					if IsValid(best) then return best end
				end

				tab = table.Copy(team.GetValidSpawnPoint(TEAM_UNDEAD))
				local dynamicspawns = self:GetDynamicSpawns(pl)
				if #dynamicspawns > 0 then
					spawninplayer = true
					table.Add(tab, dynamicspawns)
				end
			else
				local dyn = pl.ForceDynamicSpawn
				if dyn then
					pl.ForceDynamicSpawn = nil
					if self:DynamicSpawnIsValid(dyn) then
						self:CheckDynamicSpawnHR(dyn)

						if dyn:GetClass() == "prop_creepernest" then
							local owner = dyn.Owner
							if owner and owner:IsValid() and owner:Team() == TEAM_UNDEAD then
								owner.NestSpawns = owner.NestSpawns + 1
							end
						end

						return dyn
					end

					epicenter = dyn:GetPos() -- Ok, at least skew our epicenter to what they tried to spawn at.
					tab = table.Copy(team.GetValidSpawnPoint(TEAM_UNDEAD))
					local dynamicspawns = self:GetDynamicSpawns(pl)
					if #dynamicspawns > 0 then
						spawninplayer = true
						table.Add(tab, dynamicspawns)
					end
				else
					tab = table.Copy(team.GetValidSpawnPoint(TEAM_UNDEAD))
					local dynamicspawns = self:GetDynamicSpawns(pl)
					if #dynamicspawns > 0 then
						spawninplayer = true
						table.Add(tab, dynamicspawns)
					end
				end
			end
		end
	end

	if not tab or #tab == 0 then tab = team.GetValidSpawnPoint(teamid) or {} end

	-- Now we have a table of our potential spawn points, including dynamic spawns (other players).
	-- We validate if the spawn is blocked, disabled, or otherwise not suitable below.

	local count = #tab
	if count > 0 then
		local potential = {}

		for _, spawn in pairs(tab) do
			if spawn:IsValid() and not spawn.Disabled and (spawn:IsPlayer() or spawn ~= LastSpawnPoints[teamid] or #tab == 1) and spawn:IsInWorld() then
				local blocked
				local spawnpos = spawn:GetPos()
				for _, ent in pairs(ents.FindInBox(spawnpos + playermins, spawnpos + playermaxs)) do
					if IsValid(ent) and ent:IsPlayer() and not spawninplayer or string.sub(ent:GetClass(), 1, 5) == "prop_" then
						blocked = true
						break
					end
				end
				if not blocked then
					potential[#potential + 1] = spawn
				end
			end
		end

		-- Now our final spawn list. Pick the one that's closest to the humans if we're a zombie. Otherwise use a random spawn.
		if #potential > 0 then
			local spawn = teamid == TEAM_UNDEAD and self:GetClosestSpawnPoint(potential, epicenter or self:GetTeamEpicentre(TEAM_HUMAN)) or table.Random(potential)
			if spawn then
				LastSpawnPoints[teamid] = spawn
				self:CheckDynamicSpawnHR(spawn)
				pl.SpawnedOnSpawnPoint = true
				return spawn
			end
		end
	end

	pl.SpawnedOnSpawnPoint = true

	-- Fallback.
	return LastSpawnPoints[teamid] or #tab > 0 and table.Random(tab) or pl
end

local function BossZombieSort(a, b)
	local ascore = a.BarricadeDamage * 0.2 + a.DamageDealt[TEAM_UNDEAD]
	local bscore = b.BarricadeDamage * 0.2 + b.DamageDealt[TEAM_UNDEAD]
	if ascore == bscore then
		return a:Deaths() < b:Deaths()
	end

	return ascore > bscore
end

function GM:SpawnBossZombie(bossplayer, silent)
	local MULTIBOSS = false
	if not bossplayer then
		bossplayer = self:CalculateNextBoss(self.BossesToSpawn)
		MULTIBOSS = true
	else
		bossplayer = {bossplayer} --legacy support
	end

	if not bossplayer then return end

	local tSpawnedBosses = {}
	for i = 1, #bossplayer do
		local boss
		if MULTIBOSS then --if we're dealing with multiple bosses lets construct it our way
			local iEntIndex = bossplayer[i][1]
			boss = Entity(iEntIndex)
		else
			boss = bossplayer[1] --else we just treat it as normal
		end
		if boss and boss:IsValid() then
			local bossindex = boss:GetBossZombieIndex()
			if bossindex == -1 then return end

			self.LastBossZombieSpawned = self:GetWave()

			local curclass = boss.DeathClass or boss:GetZombieClass()
			boss:KillSilent()
			boss:SetZombieClass(bossindex)
			boss:DoHulls(bossindex, TEAM_UNDEAD)
			boss.DeathClass = nil
			boss:UnSpectateAndSpawn()
			boss.DeathClass = curclass

			if not silent then
				tSpawnedBosses[boss:EntIndex()] = bossindex
			end
		end
	end
	net.Start("zs_boss_spawned")
		net.WriteDataTable(tSpawnedBosses, true)
	net.Broadcast()
end

function GM:SendZombieVolunteers(pl, nonemptyonly)
	if nonemptyonly and #self.ZombieVolunteers == 0 then return end

	net.Start("zs_zvols")
		net.WriteUInt(#self.ZombieVolunteers, 8)
		for _, p in ipairs(self.ZombieVolunteers) do
			net.WriteEntity(p)
		end
	if pl then
		net.Send(pl)
	else
		net.Broadcast()
	end
end

local NextTick = 0
local time
local wave
local strSetWaveActive = "SetWaveActive"
local players
local bosses
local iPlys
local pl
local NextBossCalculate = 0
GM.BossesToSpawn = 0
function GM:Think()
	time = CurTime()
	wave = self:GetWave()
	--lets do the boss zombie logic here and only once, cause this was getting ridiculous
	bosses = bosses or self.BossZombies and not self.PantsMode and not self:IsClassicMode() and not self.ZombieEscape
	iPlys = player.GetCount()

	if not self.RoundEnded then
		if self:GetWaveActive() then
			if self:GetWaveEnd() <= time and self:GetWaveEnd() ~= -1 then
				gamemode.Call(strSetWaveActive, false)
			end
		elseif self:GetWaveStart() ~= -1 then
			if self:GetWaveStart() <= time then
				gamemode.Call(strSetWaveActive, true)
			elseif bosses and self.LastBossZombieSpawned ~= wave and wave > 0 and (self.BossZombiePlayersRequired <= 0 or iPlys >= self.BossZombiePlayersRequired) then
				self.BossesToSpawn = math.Clamp(wave, 1, 4)
				if self:GetWaveStart() - 10 <= time then
					self:SpawnBossZombie()
				elseif NextBossCalculate < time then
					NextBossCalculate = time + 0.5 --prevent a lot of networking and calculations...
					self:CalculateNextBoss(self.BossesToSpawn)
				end
			end
		end
	end

	players = player.GetAll() --team.GetPlayers simply iterates over player.GetAll() anyway so if we're looping anyway, what's the point?
	for i = 1, iPlys do --iPlys is calculated from player.GetCount while this loops over player.GetAll()... hopefully this doesn't error
		pl = players[i]
		if pl:Team() == TEAM_HUMAN then
			if pl:GetBarricadeGhosting() then
				pl:BarricadeGhostingThink()
			end

			if pl.m_PointQueue >= 1 and time >= pl.m_LastDamageDealt + 3 then
				pl:PointCashOut((pl.m_LastDamageDealtPosition or pl:GetPos()) + Vector(0, 0, 32), FM_NONE)
			end
		end
	end

	if wave == 0 then
		self:CalculateZombieVolunteers()
	end

	if NextTick <= time then
		NextTick = time + 1

		local doafk = not self:GetWaveActive() and wave == 0
		local dopoison = self:GetEscapeStage() == ESCAPESTAGE_DEATH

		for i = 1, iPlys do
			pl = players[i]
			if pl:Team() == TEAM_HUMAN and pl:Alive() then
				if doafk then
					local plpos = pl:GetPos()
					if pl.LastAFKPosition and (pl.LastAFKPosition.x ~= plpos.x or pl.LastAFKPosition.y ~= plpos.y) then
						pl.LastNotAFK = CurTime()
					end
					pl.LastAFKPosition = plpos
				end

				if pl:WaterLevel() >= 3 and not (pl.status_drown and pl.status_drown:IsValid()) then
					pl:GiveStatus("drown")
				else
					pl:PreventSkyCade()
				end

				if self:GetWave() >= 1 and time >= pl.BonusDamageCheck + 60 and pl.m_PointDebuff ~= true then
					pl.BonusDamageCheck = time
					pl:AddPoints(2)
					pl:PrintTranslatedMessage(HUD_PRINTCONSOLE, "minute_points_added", 2)
				end

				if pl.BuffRegenerative and time >= pl.NextRegenerate and pl:Health() < pl:GetMaxHealth() * 0.75 then
					pl.NextRegenerate = time + 5
					pl:SetHealth(pl:Health() + 1)
				end

				if dopoison then
					pl:TakeSpecialDamage(5, DMG_POISON)
				end
			end
		end
	end
end

-- We calculate the volunteers. If the list changed then broadcast the new list.
function GM:CalculateZombieVolunteers()
	local volunteers = {}
	local allplayers = player.GetAll()
	self:SortZombieSpawnDistances(allplayers)
	for i = 1, self:GetDesiredStartingZombies() do
		volunteers[i] = allplayers[i]
	end

	local mismatch = false
	if #volunteers ~= #self.ZombieVolunteers then
		mismatch = true
	else
		for i=1, #volunteers do
			if volunteers[i] ~= self.ZombieVolunteers[i] then
				mismatch = true
				break
			end
		end
	end
	if mismatch then
		self.ZombieVolunteers = volunteers
		self:SendZombieVolunteers()
	end
end

local livingbosses
local zombies
local tPlys
local ent
local ply
local newbosses
local iBossBudget
local tBots
local iDiff
local bot
function GM:CalculateNextBoss(iBosses)
	livingbosses = 0
	zombies = {}
	tBots = {}
	tPlys = player.GetAll()
	for i = 1, #tPlys do
		ent = tPlys[i]
		if ent:Team() == TEAM_UNDEAD then
			if ent:Alive() and ent:GetZombieClassTable().Boss then
				livingbosses = livingbosses + 1
				if livingbosses >= 4 then return end
			else
				if ent:GetInfo("zs_nobosspick") == "0" and not ent.MarkedAsAFK then
					table.insert(zombies, ent)
				elseif ent:IsBot() then
					table.insert(tBots, ent)
				end
			end
		end
	end

	table.sort(zombies, BossZombieSort)
	newbosses = {}
	iBossBudget = iBosses - livingbosses
	if iBossBudget > 0 then
		for i = 1, iBossBudget do
			ply = zombies[i]
			if ply and ply:IsValid() then
				table.insert(newbosses, {ply:EntIndex(), GAMEMODE.ZombieClasses[ply:GetBossZombieIndex()].Name or ""})
			end
		end
	end

	iDiff = iBossBudget - #newbosses --do we need any filler bosses?
	if iDiff > 0 then --if we do, start picking bots
		for i = 1, iDiff do
			bot = table.remove(tBots, math.random(#tBots)) --it doesn't matter which bot we choose, so we don't need to bother sorting this
			if bot and bot:IsValid() then
				table.insert(newbosses, {bot:EntIndex(), GAMEMODE.ZombieClasses[bot:GetBossZombieIndex()].Name or ""})
			end
		end
	end

	net.Start("zs_nextboss")
		net.WriteDataTable(newbosses, true)
	net.Broadcast()
	 
	return newbosses
end

function GM:LastBite(victim, attacker)
	LAST_BITE = attacker
end

function GM:CalculateInfliction(victim, attacker)
	local wave = self:GetWave()
	if self.RoundEnded or wave == 0 then return self.CappedInfliction end

	local players = 0
	local zombies = 0
	local humans = 0
	local wonhumans = 0
	local hum
	for _, pl in pairs(player.GetAllActive()) do
		if not pl.Disconnecting then
			if pl:Team() == TEAM_UNDEAD then
				zombies = zombies + 1
			elseif pl:HasWon() then
				wonhumans = wonhumans + 1
			else
				humans = humans + 1
				hum = pl
			end
		end
	end

	players = humans + zombies

	if players == 0 then return self.CappedInfliction end

	local infliction = math.max(zombies / players, self.CappedInfliction)
	self.CappedInfliction = infliction

	if humans == 1 and 2 < zombies then
		gamemode.Call("LastHuman", hum)
	elseif 1 <= infliction then
		infliction = 1

		if wonhumans >= 1 then
			gamemode.Call("EndRound", TEAM_HUMAN)
		else
			gamemode.Call("EndRound", TEAM_UNDEAD)

			if attacker and attacker:IsValid() and attacker:IsPlayer() and attacker:Team() == TEAM_UNDEAD and attacker ~= victim then
				gamemode.Call("LastBite", victim, attacker)
			end
		end
	end

	if wave > 1 and not self:IsClassicMode() and not self.ZombieEscape and not self:IsBabyMode() and not self.PantsMode then
		for k, v in ipairs(self.ZombieClasses) do
			if v.Infliction and infliction >= v.Infliction and not self:IsClassUnlocked(v.Name) then
				v.Unlocked = true

				if not self.PantsMode and not self:IsClassicMode() and not self:IsBabyMode() and not self.ZombieEscape then
					if not v.Locked then
						for _, pl in pairs(player.GetAll()) do
							pl:CenterNotify(COLOR_RED, translate.ClientFormat(pl, "infliction_reached", v.Infliction * 100))
							pl:CenterNotify(translate.ClientFormat(pl, "x_unlocked", translate.ClientGet(pl, v.TranslationName)))
						end
					end
				end
			end
		end
	end

	for _, ent in pairs(ents.FindByClass("logic_infliction")) do
		if ent.Infliction <= infliction then
			ent:Input("oninflictionreached", NULL, NULL, infliction)
		end
	end

	return infliction
end
timer.Create("CalculateInfliction", 2, 0, function() gamemode.Call("CalculateInfliction") end)

function GM:OnNPCKilled(ent, attacker, inflictor)
end

function GM:LastHuman(pl)
	if not LASTHUMAN then
		net.Start("zs_lasthuman")
			net.WriteEntity(pl or NULL)
			net.WriteUInt(pl.LastHumanTrack or 0, 8)
		net.Broadcast()

		for _, ent in pairs(ents.FindByClass("logic_infliction")) do
			ent:Input("onlasthuman", pl, pl, pl and pl:IsValid() and pl:EntIndex() or -1)
		end

		LASTHUMAN = true
	end

	self.TheLastHuman = pl
end

function GM:PlayerHealedTeamMember(pl, other, health, wep)
	if self:GetWave() == 0 then return end

	pl.HealedThisRound = pl.HealedThisRound + health
	local validHealth = 0
	if other and other:IsValid() and other:IsPlayer() then
		local iZDmg = other.m_UndeadDamage or 0
		validHealth = math.min(health, iZDmg) --first we need to define how much we're going to give in points via the damage
		pl.m_UndeadDamage = math.max(iZDmg - validHealth, 0) --subtract "healed" damage from players damage tracker
	else
		validHealth = health
	end

	pl.CarryOverHealth = (pl.CarryOverHealth or 0) + validHealth

	local hpperpoint = self.MedkitPointsPerHealth
	if hpperpoint <= 0 then return end

	local points = math.floor(pl.CarryOverHealth / hpperpoint)

	if 1 <= points then
		pl:AddPoints(points)

		pl.CarryOverHealth = pl.CarryOverHealth - points * hpperpoint

		net.Start("zs_healother")
			net.WriteEntity(other)
			net.WriteUInt(points, 16)
		net.Send(pl)
	end
end

function GM:ObjectPackedUp(pack, packer, owner)
end

function GM:PlayerRepairedObject(pl, other, health, wep)
	if self:GetWave() == 0 then return end

	local pFirstNailOwner = NULL
	if other and other:IsValid() and (other.IsBarricadeProp and other:IsBarricadeProp()) and other.Nails then --check to see if our other entity is a barricade prop and has/had nails in it.
		health = health - other:RemoveUselessDamage(health)

		local nail = other.Nails[1] --we need the absolute first nail, GetFirstNail prioritizes world nails
		if nail and nail:IsValid() then
			local owner = nail:GetDeployer()
			if owner and owner:IsValid() and owner:IsPlayer() and owner:Alive() and owner:Team() == TEAM_HUMAN then
				pFirstNailOwner = owner
			end
		end
	end

	PushAchievementProgress(pl, "Carpenter", health)

	pl.RepairedThisRound = pl.RepairedThisRound + health
	pl.CarryOverRepair = (pl.CarryOverRepair or 0) + health

	local hpperpoint = self.RepairPointsPerHealth
	if hpperpoint <= 0 then return end

	local points = math.floor(pl.CarryOverRepair / hpperpoint)

	if 1 <= points then
		pl:AddPoints(points)

		pl.CarryOverRepair = pl.CarryOverRepair - points * hpperpoint

		net.Start("zs_repairobject")
			net.WriteEntity(other)
			net.WriteUInt(points, 16)
		net.Send(pl)

		--we should reward the original nail owner with some assist points, given that they aren't the ones doing the repairing!
		if pFirstNailOwner and pFirstNailOwner:IsValid() and pFirstNailOwner ~= pl then
			--we can only set points to integers, so we should save the leftover and add it back for further calculations
			local prevLeftover = pl.CarryOverRepairAssist or 0
			local assist = math.Round((points / 2) + prevLeftover, 1) --add our leftovers to the calculations
			local iAssist = math.floor(assist) --store a copy of our "real" value as an integer for the reward
			pl.CarryOverRepairAssist = (assist - iAssist) --store our new leftover that didn't get saved

			net.Start("zs_repairobject_assist")
				net.WriteEntity(other)
				net.WriteFloat(assist) --write the "real" points to the net
			net.Send(pFirstNailOwner)

			if iAssist >= 1 then
				pFirstNailOwner:AddPoints(iAssist) --add our integer points
			end
		end
	end
end

function GM:CacheHonorableMentions()
	if self.CachedHMs then return end

	self.CachedHMs = {}

	for i, hm in ipairs(self.HonorableMentions) do
		if hm.GetPlayer then
			local pl, magnitude = hm.GetPlayer(self)
			if pl then
				self.CachedHMs[i] = {pl, i, magnitude or 0}
			end
		end
	end

	gamemode.Call("PostDoHonorableMentions")
end

function GM:DoHonorableMentions(filter)
	self:CacheHonorableMentions()

	for i, tab in pairs(self.CachedHMs) do
		net.Start("zs_honmention")
			net.WriteEntity(tab[1])
			net.WriteUInt(tab[2], 8)
			net.WriteInt(tab[3], 32)
		if filter then
			net.Send(filter)
		else
			net.Broadcast()
		end
	end
end

function GM:PostDoHonorableMentions()
end

function GM:PostEndRound(winner)
end

-- You can override or hook and return false in case you have your own map change system.
local function RealMap(map)
	return string.match(map, "(.+)%.bsp")
end
function GM:LoadNextMap()
	-- Just in case.
	timer.Simple(10, game.LoadNextMap)
	timer.Simple(15, function() RunConsoleCommand("changelevel", game.GetMap()) end)

	if file.Exists(GetConVarString("mapcyclefile"), "GAME") then
		game.LoadNextMap()
	else
		local maps = file.Find("maps/zs_*.bsp", "GAME")
		maps = table.Add(maps, file.Find("maps/ze_*.bsp", "GAME"))
		maps = table.Add(maps, file.Find("maps/zm_*.bsp", "GAME"))
		table.sort(maps)
		if #maps > 0 then
			local currentmap = game.GetMap()
			for i, map in ipairs(maps) do
				local lowermap = string.lower(map)
				local realmap = RealMap(lowermap)
				if realmap == currentmap then
					if maps[i + 1] then
						local nextmap = RealMap(maps[i + 1])
						if nextmap then
							RunConsoleCommand("changelevel", nextmap)
						end
					else
						local nextmap = RealMap(maps[1])
						if nextmap then
							RunConsoleCommand("changelevel", nextmap)
						end
					end

					break
				end
			end
		end
	end
end

function GM:PreRestartRound()
	for _, pl in pairs(player.GetAll()) do
		pl:StripWeapons()
		pl:Spectate(OBS_MODE_ROAMING)
		pl:GodDisable()
	end
end

GM.CurrentRound = 1
function GM:RestartRound()
	self.CurrentRound = self.CurrentRound + 1

	self:RestartLua()
	self:RestartGame()

	net.Start("zs_gamemodecall")
		net.WriteString("RestartRound")
	net.Broadcast()
end

GM.DynamicSpawning = true
GM.CappedInfliction = 0
GM.StartingZombie = {}
GM.CheckedOut = {}
GM.PreviouslyDied = {}
GM.StoredUndeadFrags = {}

function GM:RestartLua()
	self.CachedHMs = nil
	self.TheLastHuman = nil
	self.LastBossZombieSpawned = nil
	self.UseSigils = nil -- we don't use this system, will be gutted

	-- logic_pickups
	self.MaxWeaponPickups = nil
	self.MaxAmmoPickups = nil
	self.MaxFlashlightPickups = nil
	self.WeaponRequiredForAmmo = nil
	for _, pl in pairs(player.GetAll()) do
		pl.AmmoPickups = nil
		pl.WeaponPickups = nil
	end

	self.OverrideEndSlomo = nil
	if type(GetGlobalBool("endcamera", 1)) ~= "number" then
		SetGlobalBool("endcamera", nil)
	end
	if GetGlobalString("winmusic", "-") ~= "-" then
		SetGlobalString("winmusic", nil)
	end
	if GetGlobalString("losemusic", "-") ~= "-" then
		SetGlobalString("losemusic", nil)
	end
	if type(GetGlobalVector("endcamerapos", 1)) ~= "number" then
		SetGlobalVector("endcamerapos", nil)
	end

	self.CappedInfliction = 0

	self.StartingZombie = {}
	self.CheckedOut = {}
	self.PreviouslyDied = {}
	self.StoredUndeadFrags = {}

	ROUNDWINNER = nil
	LAST_BITE = nil
	LASTHUMAN = nil

	hook.Remove("PlayerShouldTakeDamage", "EndRoundShouldTakeDamage")
	hook.Remove("PlayerCanHearPlayersVoice", "EndRoundCanHearPlayersVoice")

	self:RevertZombieClasses()
end

-- I don't know.
local function CheckBroken()
	for _, pl in pairs(player.GetAll()) do
		if pl:Alive() and (pl:Health() <= 0 or pl:GetObserverMode() ~= OBS_MODE_NONE or pl:OBBMaxs().x ~= 16) then
			pl:SetObserverMode(OBS_MODE_NONE)
			pl:UnSpectateAndSpawn()
		end
	end
end

function GM:DoRestartGame()
	self.RoundEnded = nil

	for _, ent in pairs(ents.FindByClass("prop_weapon")) do
		ent:Remove()
	end

	for _, ent in pairs(ents.FindByClass("prop_ammo")) do
		ent:Remove()
	end

	self:SetUseSigils(false)
	self:SetEscapeStage(ESCAPESTAGE_NONE)

	self:SetWave(0)
	if GAMEMODE.ZombieEscape then
		self:SetWaveStart(CurTime() + 30)
	else
		self:SetWaveStart(CurTime() + self.WaveZeroLength)
	end
	self:SetWaveEnd(self:GetWaveStart() + self:GetWaveOneLength())
	self:SetWaveActive(false)

	SetGlobalInt("numwaves", -2)

	timer.Create("CheckBroken", 10, 1, CheckBroken)

	game.CleanUpMap(false, self.CleanupFilter)
	gamemode.Call("InitPostEntityMap")

	for _, pl in pairs(player.GetAll()) do
		pl:UnSpectateAndSpawn()
		pl:GodDisable()
		gamemode.Call("PlayerInitialSpawnRound", pl)
		gamemode.Call("PlayerReadyRound", pl)
	end
end

function GM:RestartGame()
	for _, pl in pairs(player.GetAll()) do
		pl:StripWeapons()
		pl:StripAmmo()
		pl:SetFrags(0)
		pl:SetDeaths(0)
		pl:SetPoints(0)
		pl:ChangeTeam(TEAM_HUMAN)
		pl:DoHulls()
		pl:SetZombieClass(self.DefaultZombieClass)
		pl.DeathClass = nil
	end

	self:SetWave(0)
	if GAMEMODE.ZombieEscape then
		self:SetWaveStart(CurTime() + 30)
	else
		self:SetWaveStart(CurTime() + self.WaveZeroLength)
	end
	self:SetWaveEnd(self:GetWaveStart() + self:GetWaveOneLength())
	self:SetWaveActive(false)

	SetGlobalInt("numwaves", -2)
	if GetGlobalString("hudoverride"..TEAM_UNDEAD, "") ~= "" then
		SetGlobalString("hudoverride"..TEAM_UNDEAD, "")
	end
	if GetGlobalString("hudoverride"..TEAM_HUMAN, "") ~= "" then
		SetGlobalString("hudoverride"..TEAM_HUMAN, "")
	end

	timer.Simple(0.25, function() GAMEMODE:DoRestartGame() end)
end

function GM:InitPostEntityMap(fromze)
	pcall(gamemode.Call, "LoadMapEditorFile")

	gamemode.Call("SetupSpawnPoints")
	gamemode.Call("RemoveUnusedEntities")
	if not fromze then
		gamemode.Call("ReplaceMapWeapons")
		gamemode.Call("ReplaceMapAmmo")
		gamemode.Call("ReplaceMapBatteries")
	end
	gamemode.Call("CreateZombieGas")
	gamemode.Call("SetupProps")

	for _, ent in pairs(ents.FindByClass("prop_ammo")) do ent.PlacedInMap = true end
	for _, ent in pairs(ents.FindByClass("prop_weapon")) do ent.PlacedInMap = true end

	if self.ObjectiveMap then
		self:SetDynamicSpawning(false)
		self.BossZombies = false
	end

	--[[if not game.IsDedicated() then
		gamemode.Call("CreateSigils")
	end]]
end

local function EndRoundPlayerShouldTakeDamage(pl, attacker) return pl:Team() == TEAM_UNDEAD or not attacker:IsPlayer() end
local function EndRoundPlayerCanSuicide(pl) return pl:Team() == TEAM_UNDEAD end

local function EndRoundSetupPlayerVisibility(pl)
	if GAMEMODE.LastHumanPosition and GAMEMODE.RoundEnded then
		AddOriginToPVS(GAMEMODE.LastHumanPosition)
	else
		hook.Remove("SetupPlayerVisibility", "EndRoundSetupPlayerVisibility")
	end
end

function GM:EndRound(winner)
	if self.RoundEnded then return end
	self.RoundEnded = true
	self.RoundEndedTime = CurTime()
	ROUNDWINNER = winner

	if self.OverrideEndSlomo == nil or self.OverrideEndSlomo then
		game.SetTimeScale(0.25)
		timer.Simple(2, function() game.SetTimeScale(1) end)
	end

	hook.Add("PlayerCanHearPlayersVoice", "EndRoundCanHearPlayersVoice", function() return true end)

	if self.OverrideEndCamera == nil or self.OverrideEndCamera then
		hook.Add("SetupPlayerVisibility", "EndRoundSetupPlayerVisibility", EndRoundSetupPlayerVisibility)
	end

	if self:ShouldRestartRound() then
		timer.Simple(self.EndGameTime - 3, function() gamemode.Call("PreRestartRound") end)
		timer.Simple(self.EndGameTime, function() gamemode.Call("RestartRound") end)
	else
		timer.Simple(self.EndGameTime, function() gamemode.Call("LoadNextMap") end)
	end

	-- Get rid of some lag.
	util.RemoveAll("prop_ammo")
	util.RemoveAll("prop_weapon")

	timer.Simple(5, function() gamemode.Call("DoHonorableMentions") end)

	if winner == TEAM_HUMAN then
		self.LastHumanPosition = nil

		hook.Add("PlayerShouldTakeDamage", "EndRoundShouldTakeDamage", EndRoundPlayerShouldTakeDamage)
	elseif winner == TEAM_UNDEAD then
		hook.Add("PlayerShouldTakeDamage", "EndRoundShouldTakeDamage", EndRoundPlayerCanSuicide)
	end

	net.Start("zs_endround")
		net.WriteUInt(winner or -1, 8)
		net.WriteString(game.GetMapNext())
	net.Broadcast()

	if winner == TEAM_HUMAN then
		for _, ent in pairs(ents.FindByClass("logic_winlose")) do
			ent:Input("onwin")
		end
	else
		for _, ent in pairs(ents.FindByClass("logic_winlose")) do
			ent:Input("onlose")
		end
	end

	gamemode.Call("PostEndRound", winner)

	self:SetWaveStart(CurTime() + 9999)
end

function GM:PlayerReady(pl)
	gamemode.Call("PlayerReadyRound", pl)
end

function GM:PlayerReadyRound(pl)
	if not pl:IsValid() then return end

	self:FullGameUpdate(pl)
	pl:UpdateAllZombieClasses()

	local classid = pl:GetZombieClass()
	pl:SetZombieClass(classid, true, pl)
	
	if self.OverrideStartingWorth then
		pl:SendLua("GAMEMODE.StartingWorth="..tostring(self.StartingWorth))
	end

	if pl:Team() == TEAM_UNDEAD then
		-- This is just so they get updated on what class they are and have their hulls set up right.
		pl:DoHulls(classid, TEAM_UNDEAD)
	elseif pl:Team() == TEAM_HUMAN then
		if self:GetWave() <= 0 and self.StartingWorth > 0 and not self.StartingLoadout and not self.ZombieEscape then
			pl:SendLua("MakepWorth()")
		else
			gamemode.Call("GiveDefaultOrRandomEquipment", pl)
		end
	end

	if self.RoundEnded then
		pl:SendLua("gamemode.Call(\"EndRound\", "..tostring(ROUNDWINNER)..", \""..game.GetMapNext().."\")")
		gamemode.Call("DoHonorableMentions", pl)
	end

	if pl:GetInfo("zs_noredeem") == "1" then
		pl.NoRedeeming = true
	end

	if self:GetWave() == 0 then
		self:SendZombieVolunteers(pl, true)
	end

	if self:IsClassicMode() then
		pl:SendLua("SetGlobalBool(\"classicmode\", true)")
	elseif self:IsBabyMode() then
		pl:SendLua("SetGlobalBool(\"babymode\", true)")
	end
end

function GM:FullGameUpdate(pl)
	net.Start("zs_gamestate")
		net.WriteInt(self:GetWave(), 16)
		net.WriteFloat(self:GetWaveStart())
		net.WriteFloat(self:GetWaveEnd())
	if pl then
		net.Send(pl)
	else
		net.Broadcast()
	end
end

concommand.Add("initpostentity", function(sender, command, arguments)
	if not sender.DidInitPostEntity then
		sender.DidInitPostEntity = true

		gamemode.Call("PlayerReady", sender)
	end
end)

local playerheight = Vector(0, 0, 72)
local playermins = Vector(-17, -17, 0)
local playermaxs = Vector(17, 17, 4)
local function groupsort(a, b)
	return #a > #b
end
function GM:AttemptHumanDynamicSpawn(pl)
	if pl:IsValid() and pl:IsPlayer() and pl:Alive() and pl:Team() == TEAM_HUMAN and self.DynamicSpawning then
		local groups = self:GetTeamRallyGroups(TEAM_HUMAN)
		table.sort(groups, groupsort)
		for i=1, #groups do
			local group = groups[i]

			local allplayers = team.GetPlayers(TEAM_HUMAN)
			for _, otherpl in pairs(group) do
				if otherpl ~= pl then
					local pos = otherpl:GetPos() + Vector(0, 0, 1)
					if otherpl:Alive() and otherpl:GetMoveType() == MOVETYPE_WALK and not util.TraceHull({start = pos, endpos = pos + playerheight, mins = playermins, maxs = playermaxs, mask = MASK_SOLID, filter = allplayers}).Hit then
						local nearzombie = false
						for __, ent in pairs(team.GetPlayers(TEAM_UNDEAD)) do
							if ent:Alive() and ent:GetPos():Distance(pos) <= 256 then
								nearzombie = true
							end
						end

						if not nearzombie then
							pl:SetPos(otherpl:GetPos())
							return true
						end
					end
				end
			end
		end
	end

	return false
end

function GM:PlayerInitialSpawn(pl)
	gamemode.Call("PlayerInitialSpawnRound", pl)
end


-- Stop the music when the game is over
hook.Add("OnEndRound", "StopMusic", function(winner)
    if isSongPlaying then
        -- Stop the music for all players
        for _, ply in pairs(player.GetAll()) do
            ply:StopSound(songPath)
        end

        -- Reset the flag
        isSongPlaying = false
    end
end)
function GM:PlayerInitialSpawnRound(pl)
	pl:SprintDisable()
	if pl:KeyDown(IN_WALK) then
		pl:ConCommand("-walk")
	end

	pl:SetCanWalk(false)
	pl:SetCanZoom(false)
	pl:SetNoCollideWithTeammates(true)
	pl:SetCustomCollisionCheck(false)

	pl.ZombiesKilled = 0
	pl.ZombiesKilledAssists = 0
	pl.BrainsEaten = 0

	pl.ResupplyBoxUsedByOthers = 0

	pl.WaveJoined = self:GetWave()

	pl.CrowKills = 0
	pl.CrowVsCrowKills = 0
	pl.CrowBarricadeDamage = 0

	pl.BarricadeDamage = 0
	pl.DynamicSpawnedOn = 0

	pl.NextPainSound = 0

	pl.BonusDamageCheck = 0

	pl.LegDamage = 0

	pl.DamageDealt = {}
	pl.DamageDealt[TEAM_UNDEAD] = 0
	pl.DamageDealt[TEAM_HUMAN] = 0

	pl.LifeBarricadeDamage = 0
	pl.LifeHumanDamage = 0
	pl.LifeBrainsEaten = 0

	pl.m_PointQueue = 0
	pl.m_LastDamageDealt = 0

	pl.HealedThisRound = 0
	pl.CarryOverHealth = 0
	pl.RepairedThisRound = 0
	pl.CarryOverRepair = 0
	pl.PointsCommission = 0
	pl.CarryOverCommision = 0
	pl.NextRegenerate = 0
	pl.NestsDestroyed = 0
	pl.NestSpawns = 0

	local nosend = not pl.DidInitPostEntity
	pl.HumanSpeedAdder = nil
	pl.HumanSpeedAdder = nil
	pl.HumanRepairMultiplier = nil
	pl.HumanHealMultiplier = nil
	pl.BuffResistant = nil
	pl.BuffRegenerative = nil
	pl.BuffMuscular = nil
	pl.WeaponMaster = nil
	pl.IsWeak = nil
	pl.HumanSpeedAdder = nil
	pl:SetPalsy(false, nosend)
	pl:SetHemophilia(false, nosend)
	pl:SetUnlucky(false)
	pl.Clumsy = nil
	pl.NoGhosting = nil
	pl.NoObjectPickup = nil
	pl.DamageVulnerability = nil

	local uniqueid = pl:UniqueID()

	if table.HasValue(self.FanList, uniqueid) then
		pl.DamageVulnerability = (pl.DamageVulnerability or 1) + 10
		pl:PrintTranslatedMessage(HUD_PRINTTALK, "thanks_for_being_a_fan_of_zs")
	end

	if self.PreviouslyDied[uniqueid] then
		-- They already died and reconnected.
		pl:ChangeTeam(TEAM_UNDEAD)
	--[[else
		pl:ChangeTeam(TEAM_SPECTATOR)
		pl:Spectate(OBS_MODE_ROAMING)]]
	elseif LASTHUMAN then ----
		-- Joined during last human.
		pl.SpawnedTime = CurTime()
		pl:ChangeTeam(TEAM_UNDEAD)
	elseif self:GetWave() <= 0 then
		-- Joined during ready phase.
		pl.SpawnedTime = CurTime()
		pl:ChangeTeam(TEAM_HUMAN)
	elseif self:GetNumberOfWaves() == -1 or self.NoNewHumansWave <= self:GetWave() or team.NumPlayers(TEAM_UNDEAD) == 0 and 1 <= team.NumPlayers(TEAM_HUMAN) then -- Joined during game, no zombies, some humans or joined past the deadline.
		pl:ChangeTeam(TEAM_UNDEAD)
		self.PreviouslyDied[uniqueid] = CurTime()
	else
		-- Joined past the ready phase but before the deadline.
		pl.SpawnedTime = CurTime()
		pl:ChangeTeam(TEAM_HUMAN)
		if self.DynamicSpawning then
			timer.Simple(0, function() GAMEMODE:AttemptHumanDynamicSpawn(pl) end)
		end ----
	end

	if pl:Team() == TEAM_UNDEAD and not self:GetWaveActive() and self.ZombieClasses["Crow"] then
		pl:SetZombieClass(self.ZombieClasses["Crow"].Index)
		pl.DeathClass = self.DefaultZombieClass
	else
		pl:SetZombieClass(self.DefaultZombieClass)
	end

	if pl:Team() == TEAM_UNDEAD and self.StoredUndeadFrags[uniqueid] then
		pl:SetFrags(self.StoredUndeadFrags[uniqueid])
		self.StoredUndeadFrags[uniqueid] = nil
	end
end

function GM:GetDynamicSpawning()
	return self.DynamicSpawning
end

function GM:PlayerRedeemed(pl, silent, noequip)
	pl:RemoveStatus("overridemodel", false, true)
	pl:ChangeTeam(TEAM_HUMAN)
	if not noequip then pl.m_PreRedeem = true end
	pl:UnSpectateAndSpawn()
	pl.m_PreRedeem = nil
	pl:DoHulls()

	local frags = pl:Frags()
	if frags < 0 then
		pl:SetFrags(frags * 5)
	else
		pl:SetFrags(0)
	end
	pl:SetDeaths(0)

	pl.DeathClass = nil
	pl:SetZombieClass(self.DefaultZombieClass)

	pl.SpawnedTime = CurTime()

	if not silent then
		net.Start("zs_playerredeemed")
			net.WriteEntity(pl)
			net.WriteString(pl:Name())
		net.Broadcast()
	end
end

function GM:PlayerDisconnected(pl)
	pl.Disconnecting = true

	local uid = pl:UniqueID()

	self.PreviouslyDied[uid] = CurTime()

	if pl:Team() == TEAM_HUMAN then
		pl:DropAll()
	elseif pl:Team() == TEAM_UNDEAD then
		self.StoredUndeadFrags[uid] = pl:Frags()
	end

	if pl:Health() > 0 and not pl:IsSpectator() then
		local lastattacker = pl:GetLastAttacker()
		if IsValid(lastattacker) then
			pl:TakeDamage(1000, lastattacker, lastattacker)

			PrintTranslatedMessage(HUD_PRINTCONSOLE, "disconnect_killed", pl:Name(), lastattacker:Name())
		end
	end

	gamemode.Call("CalculateInfliction")
end

-- Reevaluates a prop and its constraint system (or all props if no arguments) to determine if they should be frozen or not from nails.
local NextEntityCache = 0
local tEntTbl = {}
local function ReturnEntityCache()
	local CT = CurTime()

	if NextEntityCache < CT then
		NextEntityCache = CT + 0.3
		tEntTbl = ents.GetAll()
		return tEntTbl
	end
	return tEntTbl
end

function GM:EvaluatePropFreeze(ent, neighbors)
	if not ent then
		for _, e in pairs(ReturnEntityCache()) do
			if e and e:IsValid() then
				self:EvaluatePropFreeze(e)
			end
		end

		return
	end

	if ent:IsNailedToWorldHierarchy() then
		ent:SetNailFrozen(true)
	elseif ent:GetNailFrozen() then
		ent:SetNailFrozen(false)
	end

	neighbors = neighbors or {}
	table.insert(neighbors, ent)

	for _, nail in pairs(ent:GetNails()) do
		if nail:IsValid() then
			local baseent = nail:GetBaseEntity()
			local attachent = nail:GetAttachEntity()
			if baseent:IsValid() and not baseent:IsWorld() and not table.HasValue(neighbors, baseent) then
				self:EvaluatePropFreeze(baseent, neighbors)
			end
			if attachent:IsValid() and not attachent:IsWorld() and not table.HasValue(neighbors, attachent) then
				self:EvaluatePropFreeze(attachent, neighbors)
			end
		end
	end
end

-- A nail takes some damage. isdead is true if the damage is enough to remove the nail. The nail is invalid after this function call if it dies.
function GM:OnNailDamaged(ent, attacker, inflictor, damage, dmginfo)
end

-- A nail is removed between two entities. The nail is no longer considered valid right after this function and is not in the entities' Nails tables. remover may not be nil if it was removed with the hammer's unnail ability.
local function evalfreeze(ent)
	if ent and ent:IsValid() then
		gamemode.Call("EvaluatePropFreeze", ent)
	end
end
function GM:OnNailRemoved(nail, ent1, ent2, remover)
	if ent1 and ent1:IsValid() and not ent1:IsWorld() then
		timer.Simple(0, function() evalfreeze(ent1) end)
		timer.Simple(0.2, function() evalfreeze(ent1) end)
	end
	if ent2 and ent2:IsValid() and not ent2:IsWorld() then
		timer.Simple(0, function() evalfreeze(ent2) end)
		timer.Simple(0.2, function() evalfreeze(ent2) end)
	end

	if remover and remover:IsValid() and remover:IsPlayer() then
		local deployer = nail:GetDeployer()
		if deployer:IsValid() and deployer ~= remover and deployer:Team() == TEAM_HUMAN then
			PrintTranslatedMessage(HUD_PRINTCONSOLE, "nail_removed_by", remover:Name(), deployer:Name())
		end
	end
end

-- A nail is created between two entities.
function GM:OnNailCreated(ent1, ent2, nail)
	if ent1 and ent1:IsValid() and not ent1:IsWorld() then
		timer.Simple(0, function() evalfreeze(ent1) end)
	end
	if ent2 and ent2:IsValid() and not ent2:IsWorld() then
		timer.Simple(0, function() evalfreeze(ent2) end)
	end
end

function GM:RemoveDuplicateAmmo(pl)
	local AmmoCounts = {}
	local WepAmmos = {}
	for _, wep in pairs(pl:GetWeapons()) do
		if wep.Primary then
			local ammotype = wep:ValidPrimaryAmmo()
			if ammotype and wep.Primary.DefaultClip > 0 then
				AmmoCounts[ammotype] = (AmmoCounts[ammotype] or 0) + 1
				WepAmmos[wep] = wep.Primary.DefaultClip - wep.Primary.ClipSize
			end
			local ammotype2 = wep:ValidSecondaryAmmo()
			if ammotype2 and wep.Secondary.DefaultClip > 0 then
				AmmoCounts[ammotype2] = (AmmoCounts[ammotype2] or 0) + 1
				WepAmmos[wep] = wep.Secondary.DefaultClip - wep.Secondary.ClipSize
			end
		end
	end
	for ammotype, count in pairs(AmmoCounts) do
		if count > 1 then
			local highest = 0
			local highestwep
			for wep, extraammo in pairs(WepAmmos) do
				if wep.Primary.Ammo == ammotype then
					highest = math.max(highest, extraammo)
					highestwep = wep
				end
			end
			if highestwep then
				for wep, extraammo in pairs(WepAmmos) do
					if wep ~= highestwep and wep.Primary.Ammo == ammotype then
						pl:RemoveAmmo(extraammo, ammotype)
					end
				end
			end
		end
	end
end

local function TimedOut(pl)
	if pl:IsValid() and pl:Team() == TEAM_HUMAN and pl:Alive() and not GAMEMODE.CheckedOut[pl:UniqueID()] then
		gamemode.Call("GiveRandomEquipment", pl)
	end
end

function GM:GiveDefaultOrRandomEquipment(pl)
	if not self.CheckedOut[pl:UniqueID()] and not self.ZombieEscape then
		if self.StartingLoadout then
			self:GiveStartingLoadout(pl)
		else
			pl:SendLua("GAMEMODE:RequestedDefaultCart()")
			if self.StartingWorth > 0 then
				timer.Simple(4, function() TimedOut(pl) end)
			end
		end
	end
end

function GM:GiveStartingLoadout(pl)
	for item, amount in pairs(self.StartingLoadout) do
		for i=1, amount do
			pl:Give(item)
		end
	end
end

function GM:GiveRandomEquipment(pl)
	if self.CheckedOut[pl:UniqueID()] or self.ZombieEscape then return end
	self.CheckedOut[pl:UniqueID()] = true

	if self.StartingLoadout then
		self:GiveStartingLoadout(pl)
	elseif GAMEMODE.OverrideStartingWorth then
		pl:Give("weapon_zs_swissarmyknife")
	elseif #self.StartLoadouts >= 1 then
		for _, id in pairs(self.StartLoadouts[math.random(#self.StartLoadouts)]) do
			local tab = FindStartingItem(id)
			if tab then
				if tab.Callback then
					tab.Callback(pl)
				elseif tab.SWEP then
					pl:StripWeapon(tab.SWEP)
					pl:Give(tab.SWEP)
				end
			end
		end
	end
end



    local isSongPlaying = false

    hook.Add("PlayerSpawn", "PlayRandomHL2Song", function(ply)
        local hl2SongCount = 34 -- Total number of HL2 songs
        local randomSongIndex = math.random(1, hl2SongCount)
        local songPath = "music/hl2_song" .. randomSongIndex .. ".mp3"

        -- Only play the song if no song is currently playing
        if not isSongPlaying then
            -- Set the flag to indicate that a song is now playing
            isSongPlaying = true

            -- Play the selected song for the spawned player
            ply:SendLua("surface.PlaySound('" .. songPath .. "')")

            -- Set a timer to play the next song after the current one finishes
            local songDuration = SoundDuration(songPath) -- Get the duration of the current song
            timer.Simple(songDuration, function()
                -- Reset the flag to allow the next song to play
                isSongPlaying = false

                -- Play another random song for the player
                local newRandomSongIndex = math.random(1, hl2SongCount)
                local newSongPath = "music/hl2_song" .. newRandomSongIndex .. ".mp3"
                ply:SendLua("surface.PlaySound('" .. newSongPath .. "')")
            end)
        end
    end)

    -- Stop the music when the game is over
    hook.Add("OnEndRound", "StopMusic", function(winner)
        if isSongPlaying then
            -- Stop the music for all players
            for _, ply in pairs(player.GetAll()) do
                ply:SendLua("RunConsoleCommand('stopsound')")
            end

            -- Reset the flag
            isSongPlaying = false
        end
    end)

	
function GM:PlayerCanCheckout(pl)
	return pl:IsValid() and pl:Team() == TEAM_HUMAN and pl:Alive() and not self.CheckedOut[pl:UniqueID()] and not self.StartingLoadout and not self.ZombieEscape and self.StartingWorth > 0 and self:GetWave() < 2
end

concommand.Add("zs_pointsshopbuy", function(sender, command, arguments)
	if not (sender:IsValid() and sender:IsConnected()) or #arguments == 0 then return end

	if sender:GetUnlucky() then
		sender:CenterNotify(COLOR_RED, translate.ClientGet(sender, "banned_for_life_warning"))
		sender:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
		return
	end

	if not sender:NearArsenalCrate() then
		sender:CenterNotify(COLOR_RED, translate.ClientGet(sender, "need_to_be_near_arsenal_crate"))
		sender:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
		return
	end

	if not gamemode.Call("PlayerCanPurchase", sender) then
		sender:CenterNotify(COLOR_RED, translate.ClientGet(sender, "cant_purchase_right_now"))
		sender:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
		return
	end
	
	if isstring(arguments[2]) and CustomizableWeaponry then
		local info = CustomizableWeaponry.registeredAttachmentsSKey[arguments[2]]
		local points = sender:GetPoints()
		local cost = info.price or 10
		if not GAMEMODE:GetWaveActive() then
			cost = cost * GAMEMODE.ArsenalCrateMultiplier
		end
		
		if GAMEMODE:IsClassicMode() and itemtab.NoClassicMode then
			sender:CenterNotify(COLOR_RED, translate.ClientFormat(sender, "cant_use_x_in_classic", itemtab.Name))
			sender:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
			return
		end

		if GAMEMODE.ZombieEscape and itemtab.NoZombieEscape then
			sender:CenterNotify(COLOR_RED, translate.ClientFormat(sender, "cant_use_x_in_zombie_escape", itemtab.Name))
			sender:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
			return
		end

		cost = math.ceil(cost)

		if points < cost then
			sender:CenterNotify(COLOR_RED, translate.ClientGet(sender, "dont_have_enough_points"))
			sender:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
			return
		end

		if info then
			CustomizableWeaponry:giveAttachment(sender, info.name, false)
		else
			return
		end

		sender:TakePoints(cost)
		sender:PrintTranslatedMessage(HUD_PRINTTALK, "purchased_x_for_y_points", info.displayName, cost)
		sender:SendLua("surface.PlaySound(\"ambient/levels/labs/coinslot1.wav\")")
		
		local nearestars = sender:NearestArsenalCrateOwnedByOther(true)
		if nearestars then
			local XP = cost
			local CurXP = nearestars:GetXP() or 0
			nearestars:SetXP(CurXP + XP)
		end
		
		local nearest = sender:NearestArsenalCrateOwnedByOther()
		if nearest then
			local owner = nearest:GetObjectOwner()
			if owner:IsValid() then
				local nonfloorcommission = cost * 0.07
				local commission = math.floor(nonfloorcommission)
				if commission > 0 then
					owner.PointsCommission = owner.PointsCommission + cost

					owner:AddPoints(commission)

					net.Start("zs_commission")
						net.WriteEntity(nearest)
						net.WriteEntity(sender)
						net.WriteUInt(commission, 16)
					net.Send(owner)
				end

				local leftover = nonfloorcommission - commission
				if leftover > 0 then
					owner.CarryOverCommision = owner.CarryOverCommision + leftover
					if owner.CarryOverCommision >= 1 then
						local carried = math.floor(owner.CarryOverCommision)
						owner.CarryOverCommision = owner.CarryOverCommision - carried
						owner:AddPoints(carried)

						net.Start("zs_commission")
							net.WriteEntity(nearest)
							net.WriteEntity(sender)
							net.WriteUInt(carried, 16)
						net.Send(owner)
					end
				end
			end
		end
		return
	end

	local itemtab
	local id = arguments[1]
	local num = tonumber(id)
	if num then
		itemtab = GAMEMODE.Items[num]
	else
		for i, tab in pairs(GAMEMODE.Items) do
			if tab.Signature == id then
				itemtab = tab
				break
			end
		end
	end

	if not itemtab or not itemtab.PointShop then return end

	local points = sender:GetPoints()
	local cost = itemtab.Worth
	if not GAMEMODE:GetWaveActive() then
		cost = cost * GAMEMODE.ArsenalCrateMultiplier
	end

	if GAMEMODE:IsClassicMode() and itemtab.NoClassicMode then
		sender:CenterNotify(COLOR_RED, translate.ClientFormat(sender, "cant_use_x_in_classic", itemtab.Name))
		sender:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
		return
	end

	if GAMEMODE.ZombieEscape and itemtab.NoZombieEscape then
		sender:CenterNotify(COLOR_RED, translate.ClientFormat(sender, "cant_use_x_in_zombie_escape", itemtab.Name))
		sender:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
		return
	end

	cost = math.ceil(cost)

	if points < cost then
		sender:CenterNotify(COLOR_RED, translate.ClientGet(sender, "dont_have_enough_points"))
		sender:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
		return
	end

	if itemtab.Callback then
		itemtab.Callback(sender)
	elseif itemtab.SWEP then
		if sender:HasWeapon(itemtab.SWEP) then
			local stored = weapons.GetStored(itemtab.SWEP)
			if stored and stored.AmmoIfHas then
				sender:GiveAmmo(stored.Primary.DefaultClip, stored.Primary.Ammo)
			else
				local wep = ents.Create("prop_weapon")
				if wep:IsValid() then
					wep:SetPos(sender:GetShootPos())
					wep:SetAngles(sender:GetAngles())
					wep:SetWeaponType(itemtab.SWEP)
					wep:SetShouldRemoveAmmo(true)
					wep:Spawn()
				end
			end
		else
			local wep = sender:Give(itemtab.SWEP)
			if wep and wep:IsValid() and wep.EmptyWhenPurchased and wep:GetOwner():IsValid() then
				if wep.Primary then
					local primary = wep:ValidPrimaryAmmo()
					if primary then
						sender:RemoveAmmo(math.max(0, wep.Primary.DefaultClip - wep.Primary.ClipSize), primary)
					end
				end
				if wep.Secondary then
					local secondary = wep:ValidSecondaryAmmo()
					if secondary then
						sender:RemoveAmmo(math.max(0, wep.Secondary.DefaultClip - wep.Secondary.ClipSize), secondary)
					end
				end
			end
		end
	else
		return
	end

	sender:TakePoints(cost)
	sender:PrintTranslatedMessage(HUD_PRINTTALK, "purchased_x_for_y_points", itemtab.Name, cost)
	sender:SendLua("surface.PlaySound(\"ambient/levels/labs/coinslot1.wav\")")
	
	local nearestars = sender:NearestArsenalCrateOwnedByOther(true)
	if nearestars then
		local XP = cost
		local CurXP = nearestars:GetXP() or 0
		nearestars:SetXP(CurXP + XP)
	end
	
	local nearest = sender:NearestArsenalCrateOwnedByOther()
	if nearest then
		local owner = nearest:GetObjectOwner()
		if owner:IsValid() then
			local nonfloorcommission = cost * 0.07
			local commission = math.floor(nonfloorcommission)
			if commission > 0 then
				owner.PointsCommission = owner.PointsCommission + cost
				PushAchievementProgress(owner, "Salesman", cost)

				owner:AddPoints(commission)

				net.Start("zs_commission")
					net.WriteEntity(nearest)
					net.WriteEntity(sender)
					net.WriteUInt(commission, 16)
				net.Send(owner)
			end

			local leftover = nonfloorcommission - commission
			if leftover > 0 then
				owner.CarryOverCommision = owner.CarryOverCommision + leftover
				if owner.CarryOverCommision >= 1 then
					local carried = math.floor(owner.CarryOverCommision)
					owner.CarryOverCommision = owner.CarryOverCommision - carried
					owner:AddPoints(carried)

					net.Start("zs_commission")
						net.WriteEntity(nearest)
						net.WriteEntity(sender)
						net.WriteUInt(carried, 16)
					net.Send(owner)
				end
			end
		end
	end
end)

concommand.Add("worthrandom", function(sender, command, arguments)
	if sender:IsValid() and sender:IsConnected() and gamemode.Call("PlayerCanCheckout", sender) then
		gamemode.Call("GiveRandomEquipment", sender)
	end
end)

concommand.Add("worthcheckout", function(sender, command, arguments)
	if not (sender:IsValid() and sender:IsConnected()) or #arguments == 0 then return end

	if not gamemode.Call("PlayerCanCheckout", sender) then
		sender:CenterNotify(COLOR_RED, translate.ClientGet(sender, "cant_use_worth_anymore"))
		return
	end

	local cost = 0
	local hasalready = {}
	local reqatts = {}
	local attTab = CustomizableWeaponry.registeredAttachmentsSKey
	
	for _, id in pairs(arguments) do
		local tab = FindStartingItem(id)
		if tab and not hasalready[id] then
			cost = cost + tab.Worth
			hasalready[id] = true
		elseif not tab then
			--we have a CW attachment probably
			local info = attTab[id]
			if info and info.worth then
				cost = cost + info.worth
				table.insert(reqatts, info.name)
			end
		end
	end

	if cost > GAMEMODE.StartingWorth then return end

	local hasalready = {}

	for _, id in pairs(arguments) do
		local tab = FindStartingItem(id)
		if tab and not hasalready[id] then
			if tab.NoClassicMode and GAMEMODE:IsClassicMode() then
				sender:PrintMessage(HUD_PRINTTALK, translate.ClientFormat(sender, "cant_use_x_in_classic_mode", tab.Name))
			elseif tab.Callback then
				tab.Callback(sender)
				hasalready[id] = true
			elseif tab.SWEP then
				sender:StripWeapon(tab.SWEP) -- "Fixes" players giving each other empty weapons to make it so they get no ammo from the Worth menu purchase.
				sender:Give(tab.SWEP)
				hasalready[id] = true
			end
		end
	end

	for _, att in pairs(reqatts) do
		CustomizableWeaponry:giveAttachment(sender, att, false)
	end

	if table.Count(hasalready) > 0 or table.Count(reqatts) > 0 then
		GAMEMODE.CheckedOut[sender:UniqueID()] = true
	end

	gamemode.Call("RemoveDuplicateAmmo", sender)
end)

function GM:PlayerDeathThink(pl)
	if self.RoundEnded or pl.Revive or self:GetWave() == 0 then return end

	if pl:GetObserverMode() == OBS_MODE_CHASE then
		local target = pl:GetObserverTarget()
		if not target or not target:IsValid() or target:IsPlayer() and (not target:Alive() or target:Team() ~= pl:Team()) then
			pl:StripWeapons()
			pl:Spectate(OBS_MODE_ROAMING)
			pl:SpectateEntity(NULL)
		end
	end

	if pl:Team() ~= TEAM_UNDEAD then
		pl.StartCrowing = nil
		pl.StartSpectating = nil
		return
	end

	if pl.NextSpawnTime and pl.NextSpawnTime <= CurTime() then -- Force spawn.
		pl.NextSpawnTime = nil

		pl:RefreshDynamicSpawnPoint()
		pl:UnSpectateAndSpawn()
	elseif pl:GetObserverMode() == OBS_MODE_NONE then -- Not in spectator yet.
		if self:GetWaveActive() then -- During wave.
			if not pl.StartSpectating or CurTime() >= pl.StartSpectating then
				pl.StartSpectating = nil

				pl:StripWeapons()
				local best = self:GetBestDynamicSpawn(pl)
				if best then
					pl:Spectate(OBS_MODE_CHASE)
					pl:SpectateEntity(best)
				else
					pl:Spectate(OBS_MODE_ROAMING)
					pl:SpectateEntity(NULL)
				end
			end
		elseif not pl.StartCrowing or CurTime() >= pl.StartCrowing then -- Not during wave. Turn in to a crow. If we die as a crow then we get turned to spectator anyway.
			pl:ChangeToCrow()
		end
	else -- In spectator.
		if pl:KeyDown(IN_RELOAD) then
			if self:GetWaveActive() then
				pl.ForceDynamicSpawn = nil
				local prev = self.DynamicSpawning
				self.DynamicSpawning = false
				pl:UnSpectateAndSpawn()
				self.DynamicSpawning = prev
			else
				pl:ChangeToCrow()
			end
		elseif pl:KeyDown(IN_WALK) then
			pl:TrySpawnAsGoreChild()
		elseif pl:KeyDown(IN_ATTACK) then
			if self:GetWaveActive() then
				pl:RefreshDynamicSpawnPoint()
				pl:UnSpectateAndSpawn()
			else
				pl:ChangeToCrow()
			end
		elseif pl:KeyPressed(IN_ATTACK2) then
			pl.SpectatedPlayerKey = (pl.SpectatedPlayerKey or 0) + 1

			local livingzombies = {}
			for _, v in pairs(ents.FindByClass("prop_creepernest")) do
				if v:GetNestBuilt() then table.insert(livingzombies, v) end
			end
			for _, v in pairs(team.GetPlayers(TEAM_ZOMBIE)) do
				if v:Alive() then table.insert(livingzombies, v) end
			end
			--[[for _, v in pairs(team.GetSpawnPointGrouped(TEAM_UNDEAD)) do
				table.insert(livingzombies, v)
			end]]

			pl:StripWeapons()

			if pl.SpectatedPlayerKey > #livingzombies then
				pl.SpectatedPlayerKey = 1
			end

			local specplayer = livingzombies[pl.SpectatedPlayerKey]
			if specplayer then
				pl:Spectate(OBS_MODE_CHASE)
				pl:SpectateEntity(specplayer)
			end
		elseif pl:KeyPressed(IN_JUMP) then
			pl:Spectate(OBS_MODE_ROAMING)
			pl:SpectateEntity(NULL)
			pl.SpectatedPlayerKey = nil
		end
	end
end

function GM:ShouldAntiGrief(ent, attacker, dmginfo, health)
	return ent.m_AntiGrief and self.GriefMinimumHealth <= health and attacker:IsPlayer() and attacker:Team() == TEAM_HUMAN and not dmginfo:IsExplosionDamage()
end

function GM:PropBreak(attacker, ent)
	gamemode.Call("PropBroken", ent, attacker)
end

function GM:PropBroken(ent, attacker)
end

function GM:NestDestroyed(ent, attacker)
end

--this potentially gets called multiple times a frame. worth caching
local attacker, inflictor
local dmgtype
local strPhysics = "prop_physics"
local entclass
local dispatchdamagedisplay
local strSAG = "ShouldAntiGrief"
local brit
local col
local br
local health
local holder, status

function GM:EntityTakeDamage(ent, dmginfo)
	attacker = dmginfo:GetAttacker()
	inflictor = dmginfo:GetInflictor()

	if attacker == inflictor and attacker:IsProjectile() and dmginfo:GetDamageType() == DMG_CRUSH then -- Fixes projectiles doing physics-based damage.
		dmginfo:SetDamage(0)
		dmginfo:ScaleDamage(0)
		return
	end

	if ent._BARRICADEBROKEN and not (attacker:IsPlayer() and attacker:Team() == TEAM_UNDEAD) then
		dmginfo:SetDamage(dmginfo:GetDamage() * 3)
	end

	if ent.GetObjectHealth and not (attacker:IsPlayer() and attacker:Team() == TEAM_HUMAN) then
		ent.m_LastDamaged = CurTime()
	end

	if ent.ProcessDamage and ent:ProcessDamage(dmginfo) then return end
	attacker, inflictor = dmginfo:GetAttacker(), dmginfo:GetInflictor()

	-- Don't allow blowing up props during wave 0.
	if self:GetWave() <= 0 and string.sub(ent:GetClass(), 1, 12) == strPhysics and inflictor.NoPropDamageDuringWave0 then
		dmginfo:SetDamage(0)
		dmginfo:SetDamageType(DMG_BULLET)
		return
	end

	-- We need to stop explosive chains team killing.
	if inflictor:IsValid() then
		dmgtype = dmginfo:GetDamageType()
		if dmgtype == DMG_BLAST or dmgtype == DMG_BURN or dmgtype == DMG_SLOWBURN then
			if ent:IsPlayer() then
				if inflictor.LastExplosionTeam == ent:Team() and inflictor.LastExplosionAttacker ~= ent and inflictor.LastExplosionTime and CurTime() < inflictor.LastExplosionTime + 10 then -- Player damaged by physics object explosion / fire.
					dmginfo:SetDamage(0)
					dmginfo:ScaleDamage(0)
					return
				end
			elseif inflictor ~= ent and string.sub(ent:GetClass(), 1, 12) == strPhysics and string.sub(inflictor:GetClass(), 1, 12) == strPhysics then -- Physics object damaged by physics object explosion / fire.
				ent.LastExplosionAttacker = inflictor.LastExplosionAttacker
				ent.LastExplosionTeam = inflictor.LastExplosionTeam
				ent.LastExplosionTime = CurTime()
			end
		elseif inflictor:IsPlayer() and string.sub(ent:GetClass(), 1, 12) == strPhysics then -- Physics object damaged by player.
			if inflictor:Team() == TEAM_HUMAN then
				local phys = ent:GetPhysicsObject()
				if phys:IsValid() and phys:HasGameFlag(FVPHYSICS_PLAYER_HELD) and inflictor:GetCarry() ~= ent or ent._LastDropped and CurTime() < ent._LastDropped + 3 and ent._LastDroppedBy ~= inflictor then -- Human player damaged a physics object while it was being carried or recently carried. They weren't the carrier.
					dmginfo:SetDamage(0)
					dmginfo:ScaleDamage(0)
					return
				end
			end

			ent.LastExplosionAttacker = inflictor
			ent.LastExplosionTeam = inflictor:Team()
			ent.LastExplosionTime = CurTime()
		end
	end

	-- Prop is nailed. Forward damage to the nails.
	if ent:DamageNails(attacker, inflictor, dmginfo:GetDamage(), dmginfo) then return end

	dispatchdamagedisplay = false

	entclass = ent:GetClass()

	if ent:IsPlayer() then
		dispatchdamagedisplay = true
	elseif ent.PropHealth then -- A prop that was invulnerable and converted to vulnerable.
		if self.NoPropDamageFromHumanMelee and attacker:IsPlayer() and attacker:Team() == TEAM_HUMAN and inflictor.IsMelee then
			dmginfo:SetDamage(0)
			return
		end

		if gamemode.Call(strSAG, ent, attacker, dmginfo, ent.PropHealth) then
			attacker:AntiGrief(dmginfo)
			if dmginfo:GetDamage() <= 0 then return end
		end

		ent.PropHealth = ent.PropHealth - dmginfo:GetDamage()

		dispatchdamagedisplay = true

		if ent.PropHealth <= 0 and not ent.ISNOWBREAKING then
			ent.ISNOWBREAKING = true
			local effectdata = EffectData()
			effectdata:SetOrigin(ent:GetPos())
			util.Effect("cball_explode", effectdata, true, true)
			util.Effect("HunterDamage", effectdata, true, true)
			util.Effect("RPGShotDown", effectdata, true, true)
			ent:Fire("break")

			gamemode.Call("PropBroken", ent, attacker)
		else
			brit = math.Clamp(ent.PropHealth / ent.TotalHealth, 0, 1)
			col = ent:GetColor()
			col.r = 255
			col.g = 255 * brit
			col.b = 255 * brit
			ent:SetColor(col)
		end
	elseif entclass == "func_door_rotating" then
		if ent:GetKeyValues().damagefilter == "invul" or ent.Broken then return end

		if not ent.Heal then
			br = ent:BoundingRadius()
			if br > 80 then return end -- Don't break these kinds of doors that are bigger than this.

			health = br * 35
			ent.Heal = health
			ent.TotalHeal = health
		end

		if gamemode.Call("ShouldAntiGrief", ent, attacker, dmginfo, ent.TotalHeal) then
			attacker:AntiGrief(dmginfo)
			if dmginfo:GetDamage() <= 0 then return end
		end

		if dmginfo:GetDamage() >= 20 and attacker:IsPlayer() and attacker:Team() == TEAM_UNDEAD then
			ent:EmitSound(math.random(2) == 1 and "npc/zombie/zombie_pound_door.wav" or "ambient/materials/door_hit1.wav")
		end

		ent.Heal = ent.Heal - dmginfo:GetDamage()
		brit = math.Clamp(ent.Heal / ent.TotalHeal, 0, 1)
		col = ent:GetColor()
		col.r = 255
		col.g = 255 * brit
		col.b = 255 * brit
		ent:SetColor(col)

		dispatchdamagedisplay = true

		if ent.Heal <= 0 then
			ent.Broken = true

			ent:EmitSound("Breakable.Metal")
			ent:Fire("unlock", "", 0)
			ent:Fire("open", "", 0.01) -- Trigger any area portals.
			ent:Fire("break", "", 0.1)
			ent:Fire("kill", "", 0.15)
		end
	elseif entclass == "prop_door_rotating" then
		if ent:GetKeyValues().damagefilter == "invul" or ent:HasSpawnFlags(2048) or ent.Broken then return end

		ent.Heal = ent.Heal or ent:BoundingRadius() * 35
		ent.TotalHeal = ent.TotalHeal or ent.Heal

		if gamemode.Call("ShouldAntiGrief", ent, attacker, dmginfo, ent.TotalHeal) then
			attacker:AntiGrief(dmginfo)
			if dmginfo:GetDamage() <= 0 then return end
		end

		if dmginfo:GetDamage() >= 20 and attacker:IsPlayer() and attacker:Team() == TEAM_UNDEAD then
			ent:EmitSound(math.random(2) == 1 and "npc/zombie/zombie_pound_door.wav" or "ambient/materials/door_hit1.wav")
		end

		ent.Heal = ent.Heal - dmginfo:GetDamage()
		brit = math.Clamp(ent.Heal / ent.TotalHeal, 0, 1)
		col = ent:GetColor()
		col.r = 255
		col.g = 255 * brit
		col.b = 255 * brit
		ent:SetColor(col)

		dispatchdamagedisplay = true

		if ent.Heal <= 0 then
			ent.Broken = true

			ent:EmitSound("Breakable.Metal")
			ent:Fire("unlock", "", 0)
			ent:Fire("open", "", 0.01) -- Trigger any area portals.
			ent:Fire("break", "", 0.1)
			ent:Fire("kill", "", 0.15)

			local physprop = ents.Create("prop_physics")
			if physprop:IsValid() then
				physprop:SetPos(ent:GetPos())
				physprop:SetAngles(ent:GetAngles())
				physprop:SetSkin(ent:GetSkin() or 0)
				physprop:SetMaterial(ent:GetMaterial())
				physprop:SetModel(ent:GetModel())
				physprop:Spawn()
				physprop:SetPhysicsAttacker(attacker)
				if attacker:IsValid() then
					local phys = physprop:GetPhysicsObject()
					if phys:IsValid() then
						phys:SetVelocityInstantaneous((physprop:NearestPoint(attacker:EyePos()) - attacker:EyePos()):GetNormalized() * math.Clamp(dmginfo:GetDamage() * 3, 40, 300))
					end
				end
				if physprop:GetMaxHealth() == 1 and physprop:Health() == 0 then
					local health = math.ceil((physprop:OBBMins():Length() + physprop:OBBMaxs():Length()) * 2)
					if health < 2000 then
						physprop.PropHealth = health
						physprop.TotalHealth = health
					end
				end
			end
		end
	elseif string.sub(entclass, 1, 12) == "func_physbox" then
		holder, status = ent:GetHolder()
		if holder then status:Remove() end

		if ent:GetKeyValues().damagefilter == "invul" then return end

		ent.Heal = ent.Heal or ent:BoundingRadius() * 35
		ent.TotalHeal = ent.TotalHeal or ent.Heal

		if gamemode.Call("ShouldAntiGrief", ent, attacker, dmginfo, ent.TotalHeal) then
			attacker:AntiGrief(dmginfo)
			if dmginfo:GetDamage() <= 0 then return end
		end

		ent.Heal = ent.Heal - dmginfo:GetDamage()
		local brit = math.Clamp(ent.Heal / ent.TotalHeal, 0, 1)
		local col = ent:GetColor()
		col.r = 255
		col.g = 255 * brit
		col.b = 255 * brit
		ent:SetColor(col)

		dispatchdamagedisplay = true

		if ent.Heal <= 0 then
			local foundaxis = false
			local entname = ent:GetName()
			local allaxis = ents.FindByClass("phys_hinge")
			for _, axis in pairs(allaxis) do
				local keyvalues = axis:GetKeyValues()
				if keyvalues.attach1 == entname or keyvalues.attach2 == entname then
					foundaxis = true
					axis:Remove()
					ent.Heal = ent.Heal + 120
				end
			end

			if not foundaxis then
				ent:Fire("break", "", 0)
			end
		end
	elseif entclass == "func_breakable" then
		if ent:GetKeyValues().damagefilter == "invul" then return end

		if gamemode.Call("ShouldAntiGrief", ent, attacker, dmginfo, ent:GetMaxHealth()) then
			attacker:AntiGrief(dmginfo, true)
			if dmginfo:GetDamage() <= 0 then return end
		end

		if ent:Health() == 0 and ent:GetMaxHealth() == 1 then return end

		brit = math.Clamp(ent:Health() / ent:GetMaxHealth(), 0, 1)
		col = ent:GetColor()
		col.r = 255
		col.g = 255 * brit
		col.b = 255 * brit
		ent:SetColor(col)

		dispatchdamagedisplay = true
	elseif ent:IsBarricadeProp() and attacker:IsPlayer() and attacker:Team() == TEAM_UNDEAD then
		dispatchdamagedisplay = true
	end

	if dmginfo:GetDamage() > 0 or ent:IsPlayer() and ent:GetZombieClassTable().Name == "Shade" then
		holder, status = ent:GetHolder()
		if holder then status:Remove() end

		if attacker:IsPlayer() and dispatchdamagedisplay then
			self:DamageFloater(attacker, ent, dmginfo)
		end
	end
end

local dmgpos
local strZSDmg = "zs_dmg"
local strZSDmgProp = "zs_dmg_prop"

function GM:DamageFloater(attacker, victim, dmginfo)
	dmgpos = dmginfo:GetDamagePosition()
	if dmgpos == vector_origin then dmgpos = victim:NearestPoint(attacker:EyePos()) end

	net.Start(victim:IsPlayer() and strZSDmg or strZSDmgProp)
		if INFDAMAGEFLOATER then
			INFDAMAGEFLOATER = nil
			net.WriteUInt(9999, 16)
		else
			net.WriteUInt(math.ceil(dmginfo:GetDamage()), 16)
		end
		net.WriteVector(dmgpos)
	net.Send(attacker)
end

function GM:SetRandomToZombie()
	local plays = team.GetPlayers(TEAM_HUMAN)
	local pl = plays[math.random(#plays)]

	if not pl then return end

	pl:ChangeTeam(TEAM_UNDEAD)
	pl:SetFrags(0)
	pl:SetDeaths(0)

	self.StartingZombie[pl:UniqueID()] = true
	self.PreviouslyDied[pl:UniqueID()] = CurTime()
	pl:UnSpectateAndSpawn()

	return pl
end

function GM:OnPlayerChangedTeam(pl, oldteam, newteam)
	if newteam == TEAM_UNDEAD then
		pl:SetPoints(0)
		pl.DamagedBy = {}
		pl:SetBarricadeGhosting(false)
		self.CheckedOut[pl:UniqueID()] = true
	elseif newteam == TEAM_HUMAN then
		self.PreviouslyDied[pl:UniqueID()] = nil
	end

	pl:SetLastAttacker(nil)
	for _, p in pairs(player.GetAll()) do
		if p.LastAttacker == pl then
			p.LastAttacker = nil
		end
	end

	pl.m_PointQueue = 0

	timer.Simple(0, function() gamemode.Call("CalculateInfliction") end)
end

function GM:SetPantsMode(mode)
	if self.ZombieEscape then return end

	self.PantsMode = mode and self.ZombieClasses["Zombie Legs"] ~= nil and not self:IsClassicMode() and not self:IsBabyMode()

	if self.PantsMode then
		local index = self.ZombieClasses["Zombie Legs"].Index

		self.PreOverrideDefaultZombieClass = self.PreOverrideDefaultZombieClass or self.DefaultZombieClass
		self.DefaultZombieClass = index

		for _, pl in pairs(player.GetAll()) do
			local classname = pl:GetZombieClassTable().Name
			if classname ~= "Zombie Legs" and classname ~= "Crow" then
				if pl:Team() == TEAM_UNDEAD then
					pl:KillSilent()
					pl:SetZombieClass(index)
					pl:UnSpectateAndSpawn()
				else
					pl:SetZombieClass(index)
				end
			end
			pl.DeathClass = index
		end
	else
		self.DefaultZombieClass = self.PreOverrideDefaultZombieClass or self.DefaultZombieClass

		for _, pl in pairs(player.GetAll()) do
			if pl:GetZombieClassTable().Name == "Zombie Legs" then
				if pl:Team() == TEAM_UNDEAD then
					pl:KillSilent()
					pl:SetZombieClass(self.DefaultZombieClass or 1)
					pl:UnSpectateAndSpawn()
				else
					pl:SetZombieClass(self.DefaultZombieClass or 1)
				end
			end
		end
	end
end

function GM:SetClassicMode(mode)
	if self.ZombieEscape then return end

	self.ClassicMode = mode and self.ZombieClasses["Classic Zombie"] ~= nil and not self.PantsMode and not self:IsBabyMode()

	SetGlobalBool("classicmode", self.ClassicMode)

	if self:IsClassicMode() then
		util.RemoveAll("prop_nail")

		local index = self.ZombieClasses["Classic Zombie"].Index

		self.PreOverrideDefaultZombieClass = self.PreOverrideDefaultZombieClass or self.DefaultZombieClass
		self.DefaultZombieClass = index

		for _, pl in pairs(player.GetAll()) do
			local classname = pl:GetZombieClassTable().Name
			if classname ~= "Classic Zombie" and classname ~= "Crow" then
				if pl:Team() == TEAM_UNDEAD then
					pl:KillSilent()
					pl:SetZombieClass(index)
					pl:UnSpectateAndSpawn()
				else
					pl:SetZombieClass(index)
				end
			end
			pl.DeathClass = index
		end
	else
		self.DefaultZombieClass = self.PreOverrideDefaultZombieClass or self.DefaultZombieClass

		for _, pl in pairs(player.GetAll()) do
			if pl:GetZombieClassTable().Name == "Classic Zombie" then
				if pl:Team() == TEAM_UNDEAD then
					pl:KillSilent()
					pl:SetZombieClass(self.DefaultZombieClass or 1)
					pl:UnSpectateAndSpawn()
				else
					pl:SetZombieClass(self.DefaultZombieClass or 1)
				end
			end
		end
	end
end

function GM:SetBabyMode(mode)
	if self.ZombieEscape then return end

	self.BabyMode = mode and self.ZombieClasses["Gore Child"] ~= nil and not self.PantsMode and not self:IsClassicMode()

	SetGlobalBool("babymode", self.BabyMode)

	if self:IsBabyMode() then
		local index = self.ZombieClasses["Gore Child"].Index

		self.PreOverrideDefaultZombieClass = self.PreOverrideDefaultZombieClass or self.DefaultZombieClass
		self.DefaultZombieClass = index

		for _, pl in pairs(player.GetAll()) do
			local classname = pl:GetZombieClassTable().Name
			if classname ~= "Gore Child" and classname ~= "Giga Gore Child" and classname ~= "Crow" then
				if pl:Team() == TEAM_UNDEAD then
					pl:KillSilent()
					pl:SetZombieClass(index)
					pl:UnSpectateAndSpawn()
				else
					pl:SetZombieClass(index)
				end
			end
			pl.DeathClass = index
		end
	else
		self.DefaultZombieClass = self.PreOverrideDefaultZombieClass or self.DefaultZombieClass

		for _, pl in pairs(player.GetAll()) do
			if pl:GetZombieClassTable().Name == "Gore Child" then
				if pl:Team() == TEAM_UNDEAD then
					pl:KillSilent()
					pl:SetZombieClass(self.DefaultZombieClass or 1)
					pl:UnSpectateAndSpawn()
				else
					pl:SetZombieClass(self.DefaultZombieClass or 1)
				end
			end
		end
	end
end

function GM:SetClosestsToZombie()
	local allplayers = player.GetAllActive()
	local numplayers = #allplayers
	if numplayers <= 1 then return end

	local desiredzombies = self:GetDesiredStartingZombies()

	self:SortZombieSpawnDistances(allplayers)

	local zombies = {}
	for _, pl in pairs(allplayers) do
		if pl:Team() ~= TEAM_HUMAN or not pl:Alive() then
			table.insert(zombies, pl)
		end
	end

	-- Need to place some people back on the human team.
	if #zombies > desiredzombies then
		local toswap = #zombies - desiredzombies
		for _, pl in pairs(zombies) do
			if pl.DiedDuringWave0 and pl:GetInfo("zs_alwaysvolunteer") ~= "1" then
				pl:SetTeam(TEAM_HUMAN)
				pl:UnSpectateAndSpawn()
				toswap = toswap - 1
				if toswap <= 0 then
					break
				end
			end
		end
	end

	for i = 1, desiredzombies do
		local pl = allplayers[i]
		if pl:Team() ~= TEAM_UNDEAD then
			pl:ChangeTeam(TEAM_UNDEAD)
			self.PreviouslyDied[pl:UniqueID()] = CurTime()
		end
		pl:SetFrags(0)
		pl:SetDeaths(0)
		self.StartingZombie[pl:UniqueID()] = true
		pl:UnSpectateAndSpawn()
	end

	for _, pl in pairs(allplayers) do
		if pl:Team() == TEAM_HUMAN and pl._ZombieSpawnDistance <= 128 then
			pl:SetPos(self:PlayerSelectSpawn(pl):GetPos())
		end
	end
end

function GM:AllowPlayerPickup(pl, ent)
	return false
end

function GM:PlayerShouldTakeDamage(pl, attacker)
	if attacker.PBAttacker and attacker.PBAttacker:IsValid() and CurTime() < attacker.NPBAttacker then -- Protection against prop_physbox team killing. physboxes don't respond to SetPhysicsAttacker()
		attacker = attacker.PBAttacker
	end

	if attacker:IsPlayer() and attacker ~= pl and not attacker.AllowTeamDamage and not pl.AllowTeamDamage and attacker:Team() == pl:Team() then return false end

	return true
end

function GM:PlayerHurt(victim, attacker, healthremaining, damage)
	local bPainSound = healthremaining > 1
	if victim:Team() == TEAM_HUMAN then
		victim.BonusDamageCheck = CurTime()

		if healthremaining < 75 and 1 <= healthremaining then
			victim:ResetSpeed(nil, healthremaining)
		end
		
		if bPainSound then
			victim:PlayPainSound()
		end
	else
		if bPainSound then
			victim:PlayZombiePainSound()
		end
	end

	--TODO: jetboom moved this to ScalePlayerDamage, maybe I should too
	if attacker:IsValid() then
		if attacker:IsPlayer() then
			victim:SetLastAttacker(attacker)

			local myteam = attacker:Team()
			local otherteam = victim:Team()
			if myteam ~= otherteam then
				damage = math.min(damage, victim.m_PreHurtHealth)
				victim.m_PreHurtHealth = healthremaining

				attacker.DamageDealt[myteam] = attacker.DamageDealt[myteam] + damage

				if myteam == TEAM_UNDEAD then
					if otherteam == TEAM_HUMAN then
						PointCalc(attacker, damage, victim:WorldSpaceCenter())
						attacker:AddLifeHumanDamage(damage)
						victim.m_UndeadDamage = (victim.m_UndeadDamage or 0) + damage
					end
				elseif myteam == TEAM_HUMAN and otherteam == TEAM_UNDEAD then
					victim.DamagedBy[attacker] = (victim.DamagedBy[attacker] or 0) + damage
					if (not victim.m_LastWaveStartSpawn or CurTime() >= victim.m_LastWaveStartSpawn + 3)
						and (healthremaining <= 0 or not victim.m_LastGasHeal or CurTime() >= victim.m_LastGasHeal + 2) then
						attacker.m_PointQueue = attacker.m_PointQueue + damage / victim:GetMaxHealth() * (victim:GetZombieClassTable().Points or 0)
					end
					attacker.m_LastDamageDealtPosition = victim:GetPos()
					attacker.m_LastDamageDealt = CurTime()
				end
			end
		elseif attacker:GetClass() == "trigger_hurt" then
			victim.LastHitWithTriggerHurt = CurTime()
		end
	end
end
-- Don't change speed instantly to stop people from shooting and then running away with a faster weapon.
function GM:WeaponDeployed(pl, wep)
	local timername = tostring(pl).."speedchange"
	timer.Destroy(timername)

	local speed = pl:ResetSpeed(true) -- Determine what speed we SHOULD get without actually setting it.
	if speed < pl:GetMaxSpeed() then
		pl:SetSpeed(speed)
	elseif pl:GetMaxSpeed() < speed then
		timer.CreateEx(timername, 0.333, 1, ValidFunction, pl, "SetHumanSpeed", speed)
	end
end

function GM:KeyPress(pl, key)
	if key == IN_USE then
		if pl:Team() == TEAM_HUMAN and pl:Alive() then
			if pl:IsCarrying() then
				pl.status_human_holding:Remove()
			else
				self:TryHumanPickup(pl, pl:TraceLine(64).Entity)
			end
		end
	elseif key == IN_SPEED then
		if pl:Alive() then
			if pl:Team() == TEAM_HUMAN then
				pl:DispatchAltUse()
			elseif pl:Team() == TEAM_UNDEAD then
				pl:CallZombieFunction("AltUse")
			end
		end
	elseif key == IN_ZOOM then
		if pl:Team() == TEAM_HUMAN and pl:Alive() and (pl:IsOnGround() or pl:GetMoveType() == MOVETYPE_LADDER) and not self.ZombieEscape then --and pl:GetGroundEntity():IsWorld() then
			pl:SetBarricadeGhosting(true)
		end
	end
end

function GM:GetNearestSpawn(pos, teamid)
	local nearest = NULL

	local nearestdist = math.huge
	for _, ent in pairs(team.GetValidSpawnPoint(teamid)) do
		if ent.Disabled then continue end

		local dist = ent:GetPos():Distance(pos)
		if dist < nearestdist then
			nearestdist = dist
			nearest = ent
		end
	end

	return nearest
end

function GM:EntityWouldBlockSpawn(ent)
	local spawnpoint = self:GetNearestSpawn(ent:GetPos(), TEAM_UNDEAD)

	if spawnpoint:IsValid() then
		local spawnpos = spawnpoint:GetPos()
		if spawnpos:Distance(ent:NearestPoint(spawnpos)) <= 40 then return true end
	end

	return false
end

function GM:GetNearestSpawnDistance(pos, teamid)
	local nearest = self:GetNearestSpawn(pos, teamid)
	if nearest:IsValid() then
		return nearest:GetPos():Distance(pos)
	end

	return -1
end

function GM:PlayerUse(pl, ent)
	if not pl:Alive() or pl:Team() == TEAM_UNDEAD and pl:GetZombieClassTable().NoUse or pl:GetBarricadeGhosting() then return false end

	if pl:IsHolding() and pl:GetHolding() ~= ent then return false end

	local entclass = ent:GetClass()
	if entclass == "prop_door_rotating" then
		if CurTime() < (ent.m_AntiDoorSpam or 0) then -- Prop doors can be glitched shut by mashing the use button.
			return false
		end
		ent.m_AntiDoorSpam = CurTime() + 0.85
	elseif entclass == "item_healthcharger" then
		if pl:Team() == TEAM_UNDEAD then return false end
	elseif pl:Team() == TEAM_HUMAN and not pl:IsCarrying() and pl:KeyPressed(IN_USE) then
		self:TryHumanPickup(pl, ent)
	end

	return true
end

function GM:PlayerDeath(pl, inflictor, attacker)
end

function GM:PlayerDeathSound()
	return true
end

local function SortDist(a, b)
	return a._temp < b._temp
end
function GM:CanPlayerSuicide(pl)
	if self.RoundEnded or pl:HasWon() then return false end

	if pl:Team() == TEAM_HUMAN then
		if self:GetWave() <= self.NoSuicideWave then
			pl:PrintTranslatedMessage(HUD_PRINTCENTER, "give_time_before_suicide")
			return false
		end

		-- If a person is going to suicide with no last attacker, give the kill to the closest zombie.
		if not IsValid(pl:GetLastAttacker()) then
			local plpos = pl:EyePos()
			local tosort = {}
			for _, zom in pairs(team.GetPlayers(TEAM_UNDEAD)) do
				if zom:Alive() then
					local dist = zom:GetPos():Distance(plpos)
					if dist <= 512 then
						zom._temp = dist
						table.insert(tosort, zom)
					end
				end
			end

			table.sort(tosort, SortDist)

			if tosort[1] then
				pl:SetLastAttacker(tosort[1])
			end
		end
	elseif pl:Team() == TEAM_UNDEAD then
		local ret = pl:CallZombieFunction("CanPlayerSuicide")
		if ret == false then return false end
	end

	return pl:GetObserverMode() == OBS_MODE_NONE and pl:Alive() and (not pl.SpawnNoSuicide or pl.SpawnNoSuicide < CurTime())
end

function GM:DefaultRevive(pl)
	local status = pl:GiveStatus("revive")
	if status and status:IsValid() then
		status:SetReviveTime(CurTime() + 2)
	end
end

function GM:HumanKilledZombie(pl, attacker, inflictor, dmginfo, headshot, suicide)
	if (pl:GetZombieClassTable().Points or 0) == 0 or self.RoundEnded then return end

	-- Simply distributes based on damage but also do some stuff for assists.

	local totaldamage = 0
	for otherpl, dmg in pairs(pl.DamagedBy) do
		if otherpl:IsValid() and otherpl:Team() == TEAM_HUMAN then
			totaldamage = totaldamage + dmg
		end
	end

	local mostassistdamage = 0
	local halftotaldamage = totaldamage / 2
	local mostdamager
	for otherpl, dmg in pairs(pl.DamagedBy) do
		if otherpl ~= attacker and otherpl:IsValid() and otherpl:Team() == TEAM_HUMAN and dmg > mostassistdamage and dmg >= halftotaldamage then
			mostassistdamage = dmg
			mostdamager = otherpl
		end
	end

	attacker.ZombiesKilled = attacker.ZombiesKilled + 1

	if mostdamager then
		attacker:PointCashOut(pl, FM_LOCALKILLOTHERASSIST)
		mostdamager:PointCashOut(pl, FM_LOCALASSISTOTHERKILL)

		mostdamager.ZombiesKilledAssists = mostdamager.ZombiesKilledAssists + 1
	else
		attacker:PointCashOut(pl, FM_NONE)
	end

	gamemode.Call("PostHumanKilledZombie", pl, attacker, inflictor, dmginfo, mostdamager, mostassistdamage, headshot)

	return mostdamager
end

function GM:PostHumanKilledZombie(pl, attacker, inflictor, dmginfo, assistpl, assistamount, headshot)
end

function GM:ZombieKilledHuman(pl, attacker, inflictor, dmginfo, headshot, suicide)
	if self.RoundEnded then return end

	local plpos = pl:GetPos()
	local dist = 99999
	for _, ent in pairs(team.GetValidSpawnPoint(TEAM_UNDEAD)) do
		dist = math.min(math.ceil(ent:GetPos():Distance(plpos)), dist)
	end
	pl.ZombieSpawnDeathDistance = dist

	attacker:AddBrains(1)
	attacker:AddLifeBrainsEaten(1)

	if not pl.Gibbed and not suicide then
		local status = pl:GiveStatus("revive_slump_human")
		if status then
			status:SetReviveTime(CurTime() + 4)
			status:SetZombieInitializeTime(CurTime() + 2)
		end

		local classtab = self.ZombieEscape and self.ZombieClasses["Super Zombie"] or self:IsClassicMode() and self.ZombieClasses["Classic Zombie"] or self:IsBabyMode() and GAMEMODE.ZombieClasses["Gore Child"] or GAMEMODE.ZombieClasses["Fresh Dead"]
		if classtab then
			pl:SetZombieClass(classtab.Index)
		end
	end

	gamemode.Call("PostZombieKilledHuman", pl, attacker, inflictor, dmginfo, headshot, suicide)

	return attacker:Frags()
end

function GM:PostZombieKilledHuman(pl, attacker, inflictor, dmginfo, headshot, suicide)
end

local function DelayedChangeToZombie(pl)
	if pl:IsValid() then
		if pl.ChangeTeamFrags then
			pl:SetFrags(pl.ChangeTeamFrags)
			pl.ChangeTeamFrags = 0
		end

		pl:ChangeTeam(TEAM_UNDEAD)
	end
end

function GM:DoPlayerDeath(pl, attacker, dmginfo)
	pl:RemoveStatus("confusion", false, true)
	pl:RemoveStatus("ghoultouch", false, true)

	local inflictor = dmginfo:GetInflictor()
	local plteam = pl:Team()
	local ct = CurTime()
	local suicide = attacker == pl or attacker:IsWorld()

	pl:Freeze(false)

	local headshot = pl:LastHitGroup() == HITGROUP_HEAD and pl.m_LastHeadShot and CurTime() <= pl.m_LastHeadShot + 0.1

	if suicide then attacker = pl:GetLastAttacker() or attacker end
	pl:SetLastAttacker()

	if inflictor == NULL then inflictor = attacker end

	if inflictor == attacker and attacker:IsPlayer() then
		local wep = attacker:GetActiveWeapon()
		if wep:IsValid() then
			inflictor = wep
		end
	end

	if headshot then
		local effectdata = EffectData()
			effectdata:SetOrigin(dmginfo:GetDamagePosition())
			local force = dmginfo:GetDamageForce()
			effectdata:SetMagnitude(force:Length() * 3)
			effectdata:SetNormal(force:GetNormalized())
			effectdata:SetEntity(pl)
		util.Effect("headshot", effectdata, true, true)
	end

	if not pl:CallZombieFunction("OnKilled", attacker, inflictor, suicide, headshot, dmginfo) then
		if pl:Health() <= -200 and not pl.NoGibs and not self.ZombieEscape then
			pl:Gib(dmginfo)
		elseif not pl.KnockedDown then
			pl:CreateRagdoll()
		end
	end

	pl:RemoveStatus("overridemodel", false, true)

	local revive
	local assistpl
	if plteam == TEAM_UNDEAD then
		local classtable = pl:GetZombieClassTable()

		pl:PlayZombieDeathSound()

		if not classtable.NoDeaths then
			pl:AddDeaths(1)
		end

		if self:GetWaveActive() then
			pl.StartSpectating = ct + 2
		else
			pl.StartCrowing = ct + 3
		end

		if attacker:IsValid() and attacker:IsPlayer() and attacker ~= pl then
			if classtable.Revives and not pl.Gibbed and not headshot then
				if classtable.ReviveCallback then
					revive = classtable:ReviveCallback(pl, attacker, dmginfo)
				elseif math.random(1, 4) ~= 1 then
					self:DefaultRevive(pl)
					revive = true
				end
			end

			if not revive and attacker:Team() == TEAM_HUMAN then
				assistpl = gamemode.Call("HumanKilledZombie", pl, attacker, inflictor, dmginfo, headshot, suicide)
			end
		end

		if not revive and (pl.LifeBarricadeDamage ~= 0 or pl.LifeHumanDamage ~= 0 or pl.LifeBrainsEaten ~= 0) then
			net.Start("zs_lifestats")
				net.WriteUInt(math.ceil(pl.LifeBarricadeDamage or 0), 24)
				net.WriteUInt(math.ceil(pl.LifeHumanDamage or 0), 24)
				net.WriteUInt(pl.LifeBrainsEaten or 0, 16)
			net.Send(pl)
		end

		pl:CallZombieFunction("PostOnKilled", attacker, inflictor, suicide, headshot, dmginfo)
	elseif plteam == TEAM_HUMAN then
		pl.NextSpawnTime = ct + 4

		pl:PlayDeathSound()

		if attacker:IsPlayer() and attacker ~= pl then
			gamemode.Call("ZombieKilledHuman", pl, attacker, inflictor, dmginfo, headshot, suicide)
		end

		pl:DropAll()
		timer.Simple(0, function() DelayedChangeToZombie(pl) end) -- We don't want people shooting barrels near teammates.
		self.PreviouslyDied[pl:UniqueID()] = CurTime()
		if self:GetWave() == 0 then
			pl.DiedDuringWave0 = true
		end

		local frags = pl:Frags()
		if frags < 0 then
			pl.ChangeTeamFrags = math.ceil(frags / 5)
		else
			pl.ChangeTeamFrags = 0
		end

		if pl.SpawnedTime then
			pl.SurvivalTime = math.max(ct - pl.SpawnedTime, pl.SurvivalTime or 0)
			pl.SpawnedTime = nil
		end

		if team.NumPlayers(TEAM_HUMAN) <= 1 then
			self.LastHumanPosition = pl:WorldSpaceCenter()

			net.Start("zs_lasthumanpos")
				net.WriteVector(self.LastHumanPosition)
			net.Broadcast()
		end

		local hands = pl:GetHands()
		if IsValid(hands) then
			hands:Remove()
		end
	end

	if revive or pl:CallZombieFunction("NoDeathMessage", attacker, dmginfo) or pl:IsSpectator() then return end

	if attacker == pl then
		net.Start("zs_pl_kill_self")
			net.WriteEntity(pl)
			net.WriteUInt(plteam, 16)
		net.Broadcast()
	elseif attacker:IsPlayer() then
		if assistpl then
			net.Start("zs_pls_kill_pl")
				net.WriteEntity(pl)
				net.WriteEntity(attacker)
				net.WriteEntity(assistpl)
				net.WriteString(inflictor:GetClass())
				net.WriteUInt(plteam, 16)
				net.WriteUInt(attacker:Team(), 16) -- Assuming assistants are always on the same team.
				net.WriteBit(headshot)
			net.Broadcast()

			gamemode.Call("PlayerKilledByPlayer", pl, assistpl, inflictor, headshot, dmginfo, true)
		else
			net.Start("zs_pl_kill_pl")
				net.WriteEntity(pl)
				net.WriteEntity(attacker)
				net.WriteString(inflictor:GetClass())
				net.WriteUInt(plteam, 16)
				net.WriteUInt(attacker:Team(), 16)
				net.WriteBit(headshot)
			net.Broadcast()
		end

		gamemode.Call("PlayerKilledByPlayer", pl, attacker, inflictor, headshot, dmginfo)
	else
		net.Start("zs_death")
			net.WriteEntity(pl)
			net.WriteString(inflictor:GetClass())
			net.WriteString(attacker:GetClass())
			net.WriteUInt(plteam, 16)
		net.Broadcast()
	end
end

function GM:PlayerKilledByPlayer(pl, attacker, inflictor, headshot, dmginfo)
end

function GM:PlayerCanPickupWeapon(pl, ent)
	if pl:GetZombieClassTable().Name == "Super Zombie" then return true end
	if pl:IsSpectator() then return false end

	if pl:Team() == TEAM_UNDEAD then
		local name = ent:GetClass()
		local swep = pl:GetZombieClassTable().SWEP
		if swep then
			if istable(swep) then
				for _, class in pairs(swep) do
					if name == class then
						return true
					end
				end
				return false
			else
				return name == swep
			end
		end
	end

	return not ent.ZombieOnly and ent:GetClass() ~= "weapon_stunstick"
end

function GM:PlayerStepSoundTime(pl, iType, bWalking)
	return 350
end

function GM:PlayerFootstep(pl, vPos, iFoot, strSoundName, fVolume, pFilter)
end

concommand.Add("zsdropweapon", function(sender, command, arguments)
	if GAMEMODE.ZombieEscape then return end

	if not (sender:IsValid() and sender:Alive() and sender:Team() == TEAM_HUMAN) or CurTime() < (sender.NextWeaponDrop or 0) or GAMEMODE.ZombieEscape then return end
	sender.NextWeaponDrop = CurTime() + 0.15

	local currentwep = sender:GetActiveWeapon()
	if currentwep and currentwep:IsValid() then
		local ent = sender:DropWeaponByType(currentwep:GetClass())
		if ent and ent:IsValid() then
			local shootpos = sender:GetShootPos()
			local aimvec = sender:GetAimVector()
			ent:SetPos(util.TraceHull({start = shootpos, endpos = shootpos + aimvec * 32, mask = MASK_SOLID, filter = sender, mins = Vector(-2, -2, -2), maxs = Vector(2, 2, 2)}).HitPos)
			ent:SetAngles(sender:GetAngles())
		end
	end
end)

concommand.Add("zsemptyclip", function(sender, command, arguments)
	if GAMEMODE.ZombieEscape then return end

	if not (sender:IsValid() and sender:Alive() and sender:Team() == TEAM_HUMAN) then return end

	sender.NextEmptyClip = sender.NextEmptyClip or 0
	if sender.NextEmptyClip <= CurTime() then
		sender.NextEmptyClip = CurTime() + 0.1

		local wep = sender:GetActiveWeapon()
		if wep:IsValid() and not wep.NoMagazine then
			local primary = wep:ValidPrimaryAmmo()
			if primary and 0 < wep:Clip1() then
				sender:GiveAmmo(wep:Clip1(), primary, true)
				wep:SetClip1(0)
			end
			local secondary = wep:ValidSecondaryAmmo()
			if secondary and 0 < wep:Clip2() then
				sender:GiveAmmo(wep:Clip2(), secondary, true)
				wep:SetClip2(0)
			end
		end
	end
end)

concommand.Add("zsgiveammo", function(sender, command, arguments)
	if GAMEMODE.ZombieEscape then return end

	if not sender:IsValid() or not sender:Alive() or sender:Team() ~= TEAM_HUMAN then return end

	local ammotype = arguments[1]
	if not ammotype or #ammotype == 0 or not GAMEMODE.AmmoCache[ammotype] then return end

	local count = sender:GetAmmoCount(ammotype)
	if count <= 0 then
		sender:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
		sender:PrintTranslatedMessage(HUD_PRINTCENTER, "no_spare_ammo_to_give")
		return
	end

	local ent
	local dent = Entity(tonumbersafe(arguments[2] or 0) or 0)
	if GAMEMODE:ValidMenuLockOnTarget(sender, dent) then
		ent = dent
	end

	if not ent then
		ent = sender:MeleeTrace(48, 2).Entity
	end

	if ent and ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_HUMAN and ent:Alive() then
		local desiredgive = math.min(count, GAMEMODE.AmmoCache[ammotype])
		if desiredgive >= 1 then
			sender:RemoveAmmo(desiredgive, ammotype)
			ent:GiveAmmo(desiredgive, ammotype)
			hook.Run("PlayerGetAmmo", ent, desiredgive, GAMEMODE.AmmoNames[ammotype] or "Unknown", sender)

			if CurTime() >= (sender.NextGiveAmmoSound or 0) then
				sender.NextGiveAmmoSound = CurTime() + 1
				sender:PlayGiveAmmoSound()
			end

			sender:RestartGesture(ACT_GMOD_GESTURE_ITEM_GIVE)

			return
		end
	else
		sender:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
		sender:PrintTranslatedMessage(HUD_PRINTCENTER, "no_person_in_range")
	end
end)

concommand.Add("zsgiveweapon", function(sender, command, arguments)
	if GAMEMODE.ZombieEscape then return end

	if not (sender:IsValid() and sender:Alive() and sender:Team() == TEAM_HUMAN) or GAMEMODE.ZombieEscape then return end

	local currentwep = sender:GetActiveWeapon()
	if currentwep and currentwep:IsValid() then
		local ent
		local dent = Entity(tonumbersafe(arguments[2] or 0) or 0)
		if GAMEMODE:ValidMenuLockOnTarget(sender, dent) then
			ent = dent
		end

		if not ent then
			ent = sender:MeleeTrace(48, 2).Entity
		end

		if ent and ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_HUMAN and ent:Alive() then
			if not ent:HasWeapon(currentwep:GetClass()) then
				sender:GiveWeaponByType(currentwep, ent, false)
			else
				sender:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
				sender:PrintTranslatedMessage(HUD_PRINTCENTER, "person_has_weapon")
			end
		else
			sender:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
			sender:PrintTranslatedMessage(HUD_PRINTCENTER, "no_person_in_range")
		end
	end
end)

concommand.Add("zsgiveweaponclip", function(sender, command, arguments)
	if GAMEMODE.ZombieEscape then return end

	if not (sender:IsValid() and sender:Alive() and sender:Team() == TEAM_HUMAN) then return end
	
	local currentwep = sender:GetActiveWeapon()
	if currentwep and currentwep:IsValid() then
		local ent
		local dent = Entity(tonumbersafe(arguments[2] or 0) or 0)
		if GAMEMODE:ValidMenuLockOnTarget(sender, dent) then
			ent = dent
		end

		if not ent then
			ent = sender:MeleeTrace(48, 2).Entity
		end

		if ent and ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_HUMAN and ent:Alive() then
			if not ent:HasWeapon(currentwep:GetClass()) then
				sender:GiveWeaponByType(currentwep, ent, true)
			else
				sender:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
				sender:PrintTranslatedMessage(HUD_PRINTCENTER, "person_has_weapon")
			end
		else
			sender:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
			sender:PrintTranslatedMessage(HUD_PRINTCENTER, "no_person_in_range")
		end
	end
end)

concommand.Add("zsdropammo", function(sender, command, arguments)
	if GAMEMODE.ZombieEscape then return end

	if not sender:IsValid() or not sender:Alive() or sender:Team() ~= TEAM_HUMAN or CurTime() < (sender.NextDropClip or 0) then return end

	sender.NextDropClip = CurTime() + 0.2

	local wep = sender:GetActiveWeapon()
	if not wep:IsValid() and not arguments[1] then return end

	local ammotype = arguments[1] or wep:GetPrimaryAmmoTypeString()
	if GAMEMODE.AmmoNames[ammotype] and GAMEMODE.AmmoCache[ammotype] then
		local ent = sender:DropAmmoByType(ammotype, GAMEMODE.AmmoCache[ammotype] * 2)
		if ent and ent:IsValid() then
			ent:SetPos(sender:EyePos() + sender:GetAimVector() * 8)
			ent:SetAngles(sender:GetAngles())
			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then
				phys:Wake()
				phys:SetVelocityInstantaneous(sender:GetVelocity() * 0.85)
			end
		end
	end
end)

--this might be better off in sh_options/sh_globals or even a GM table but whatever
local VoiceSetTranslate = {}
VoiceSetTranslate["models/player/alyx.mdl"] = VOICESET_ALYX
VoiceSetTranslate["models/player/barney.mdl"] = VOICESET_BARNEY
VoiceSetTranslate["models/player/combine_soldier.mdl"] = VOICESET_COMBINE
VoiceSetTranslate["models/player/combine_soldier_prisonguard.mdl"] = VOICESET_COMBINE
VoiceSetTranslate["models/player/combine_super_soldier.mdl"] = VOICESET_COMBINE
VoiceSetTranslate["models/player/police.mdl"] = VOICESET_COMBINE
VoiceSetTranslate["models/grim.mdl"] = VOICESET_COMBINE
VoiceSetTranslate["models/player/police_fem.mdl"] = VOICESET_COMBINE
VoiceSetTranslate["models/player/monk.mdl"] = VOICESET_MONK
VoiceSetTranslate["models/jason278-players/gabe_3.mdl"] = VOICESET_MONK
VoiceSetTranslate["models/player/mossman.mdl"] = VOICESET_FEMALE
VoiceSetTranslate["models/player/brsp.mdl"] = VOICESET_FEMALE
VoiceSetTranslate["models/player/moe_glados_p.mdl"] = VOICESET_FEMALE
VoiceSetTranslate["models/player/mossman_arctic.mdl"] = VOICESET_FEMALE
VoiceSetTranslate["models/player/p2_chell.mdl"] = VOICESET_FEMALE
VoiceSetTranslate["models/dawson/obese_male_deluxe/obese_male_deluxe.mdl"] = VOICESET_MONK
VoiceSetTranslate["models/player/cirno/cirno_player.mdl"] = VOICESET_FEMALE
VoiceSetTranslate["models/player/dewobedil/eromanga_sensei/sagiri/pajama_p.mdl"] = VOICESET_FEMALE
VoiceSetTranslate["models/loyalists/mmd/remilia/remilia_mp_pm.mdl"] = VOICESET_FEMALE
VoiceSetTranslate["models/loyalists/mmd/flandre/flandre_mp_pm.mdl"] = VOICESET_FEMALE
VoiceSetTranslate["models/jazzmcfly/kantai/yuudachi/yuudachi.mdl"] = VOICESET_FEMALE
VoiceSetTranslate["models/player/dewobedil/vocaloid/haku/bikini_p.mdl"] = VOICESET_FEMALE
VoiceSetTranslate["models/player/dewobedil/touhou/junko/default_p.mdl"] = VOICESET_FEMALE











function GM:PlayerSpawn(pl)
	pl:StripWeapons()
	pl:RemoveStatus("confusion", false, true)

	if pl:GetMaterial() ~= "" then
		pl:SetMaterial("")
	end

	pl:UnSpectate()

	pl.StartCrowing = nil
	pl.StartSpectating = nil
	pl.NextSpawnTime = nil
	pl.Gibbed = nil

	pl.SpawnNoSuicide = CurTime() + 1
	pl.SpawnedTime = CurTime()

	pl:ShouldDropWeapon(false)

	pl:SetLegDamage(0)
	pl:SetLastAttacker()

	if pl:Team() == TEAM_UNDEAD then
		pl:RemoveStatus("overridemodel", false, true)

		if not pl.Revived then
			pl.DamagedBy = {}
		end

		pl.LifeBarricadeDamage = 0
		pl.LifeHumanDamage = 0
		pl.LifeBrainsEaten = 0

		if self:GetEscapeSequence() and self:GetEscapeStage() >= ESCAPESTAGE_BOSS then
			local bossindex = pl:GetBossZombieIndex()
			if bossindex ~= -1 then
				pl:SetZombieClass(bossindex)
			end
		elseif pl.DeathClass and self:GetWaveActive() then
			pl:SetZombieClass(pl.DeathClass)
			pl.DeathClass = nil
		end

		local classtab = pl:GetZombieClassTable()
		pl:DoHulls(pl:GetZombieClass(), TEAM_UNDEAD)

		if classtab.Model then
			pl:SetModel(classtab.Model)
		elseif classtab.UsePlayerModel then
			local desiredname = pl:GetInfo("cl_playermodel")
			if #desiredname == 0 then
				pl:SelectRandomPlayerModel()
			else	
			pl:SetModel("models/player/AR_combine_soldier03B.mdl")
			end
		elseif classtab.UsePreviousModel then
			local curmodel = string.lower(pl:GetModel())
			if table.HasValue(self.RestrictedModels, curmodel) or string.sub(curmodel, 1, 14) ~= "models/player/" then
				pl:SelectRandomPlayerModel()
			end
		elseif classtab.UseRandomModel then
			pl:SelectRandomPlayerModel()
		else
			pl:SetModel("models/player/zombie_classic.mdl")
		end

		local numundead = team.NumPlayers(TEAM_UNDEAD)

		--Scaling system, hastily put together by MagicSwap, also needed to adjust other functions
		pl.m_ScaledHP = nil --always reset this variable on spawn... just in case

		--Scaling factors are defined in sh_options
		if self.OutnumberedHealthBonus <= numundead or classtab.Boss then
			if classtab.Boss and GAMEMODE.UseBossScaling and classtab.Name ~= "Shade" then --dont scale shade's hp at all
				local hp = GAMEMODE:GetScaledHP(player.GetCount(), classtab.Health)
				pl:SetHealth(hp)
				pl.m_ScaledHP = hp
			else
				pl:SetHealth(classtab.Health)
			end
		else
			pl:SetHealth(classtab.Health * 1.5)
		end

		local added = 0
		if pl:GetZTraitCurrent("25hlth") then
			added = added + classtab.Health * 0.25
		end
		if pl:GetZTraitCurrent("1000hlth") then
			added = added +classtab.Health * 10
		end

		pl:SetHealth(pl:Health() + added)

		--[[
		if pl:IsBot() then
			local hp = pl:Health() * (5/6)
			pl:SetHealth(hp)
			pl.m_ScaledHP = hp
		end
		--]]

		local oSWEP = classtab.SWEP
		if oSWEP then
			if istable(oSWEP) then
				for k, v in pairs(oSWEP) do
					pl:Give(v)
				end
			else
				pl:Give(oSWEP)
			end
		end

		pl:SetNoTarget(true)
		pl:SetMaxHealth(1)

		pl:ResetSpeed()
		pl:SetCrouchedWalkSpeed(classtab.CrouchedWalkSpeed or 0.70)

		if not pl.Revived or not self:GetWaveActive() or CurTime() > self:GetWaveEnd() then
			pl.StartCrowing = 0
		end

		if pl.ForceSpawnAngles then
			pl:SetEyeAngles(pl.ForceSpawnAngles)
			pl.ForceSpawnAngles = nil
		end

		if pl.SpawnedOnSpawnPoint and not pl.DidntSpawnOnSpawnPoint and not pl.Revived and not pl:GetZombieClassTable().NeverAlive then
			pl:GiveStatus("zombiespawnbuff", self.ObjectiveMap and 1.5 or 3)
		end
		pl.DidntSpawnOnSpawnPoint = nil
		pl.SpawnedOnSpawnPoint = nil

		local overridemodel = pl:GetZombieClassTable().OverrideModel
		if overridemodel then
			local current = pl:GiveStatus("overridemodel")
			if current and current:IsValid() then
				current:SetModel(overridemodel)
				current:ResetBones()
				pl:CallZombieFunction("ManipulateOverrideModel", current)
			end
		else
			pl:RemoveStatus("overridemodel", false, true)
		end

		pl:CallZombieFunction("OnSpawned")
	elseif pl:Team() == TEAM_HUMAN then
		pl.m_PointQueue = 0
		pl.PackedItems = {}

		local desiredname = pl:GetInfo("cl_playermodel")
		local modelname = "models/player/AR_combine_soldier03B.mdl"
		local lowermodelname = string.lower(modelname)
		if table.HasValue(self.RestrictedModels, lowermodelname) then
			modelname = "models/player/AR_combine_soldier03B.mdl"
			lowermodelname = modelname
		end
		pl:SetModel(modelname)

		-- Cache the voice set.
		if VoiceSetTranslate[lowermodelname] then
			pl:SetDTInt(DT_PLAYER_INT_VOICESET, VoiceSetTranslate[lowermodelname])
		elseif string.find(lowermodelname, "female", 1, true) then
			pl:SetDTInt(DT_PLAYER_INT_VOICESET, VOICESET_FEMALE)
		else
			pl:SetDTInt(DT_PLAYER_INT_VOICESET, VOICESET_MALE)
		end

		pl.HumanSpeedAdder = nil

		pl.BonusDamageCheck = CurTime()

		pl:ResetSpeed()
		pl:SetJumpPower(DEFAULT_JUMP_POWER)
		pl:SetCrouchedWalkSpeed(0.65)

		pl:SetNoTarget(false)
		pl:SetMaxHealth(100)

		if self.ZombieEscape then
			pl:Give("weapon_zs_zeknife")
			pl:Give("weapon_zs_zegrenade")
			pl:Give(table.Random(self.ZombieEscapeWeapons))
		else
			pl:GiveAmmo(1, "dummy", true)
			pl:Give("weapon_zs_fists")
			
			if self.StartingLoadout then
				self:GiveStartingLoadout(pl)
			elseif pl.m_PreRedeem then
				if self.RedeemLoadout then
					for _, class in pairs(self.RedeemLoadout) do
						pl:Give(class)
					end
				else
					pl:Give("cw_pistol_cz75_auto")
					pl:Give("cw_melee_knife")
					pl:Give("weapon_zs_fists")
					pl:GiveAmmo(380,"pistol")
				end
			end
		end

		local oldhands = pl:GetHands()
		if IsValid(oldhands) then
			oldhands:Remove()
		end

		local hands = ents.Create("zs_hands")
		if hands:IsValid() then
			hands:DoSetup(pl)
			hands:Spawn()
		end
	end
--[[
	pl:DoMuscularBones()
	pl:DoNoodleArmBones()
--]]
	local pcol = Vector(pl:GetInfo("cl_playercolor"))
	pcol.x = math.Clamp(pcol.x, 0, 2.5)
	pcol.y = math.Clamp(pcol.y, 0, 2.5)
	pcol.z = math.Clamp(pcol.z, 0, 2.5)
	pl:SetPlayerColor(pcol)

	local wcol = Vector(pl:GetInfo("cl_weaponcolor"))
	wcol.x = math.Clamp(wcol.x, 0, 2.5)
	wcol.y = math.Clamp(wcol.y, 0, 2.5)
	wcol.z = math.Clamp(wcol.z, 0, 2.5)
	pl:SetWeaponColor(wcol)

	pl.m_PreHurtHealth = pl:Health()
end

function GM:SetWave(wave)
	local previouslylocked = {}
	local UnlockedClasses = {}
	for i, classtab in ipairs(GAMEMODE.ZombieClasses) do
		if not gamemode.Call("IsClassUnlocked", classid) then
			previouslylocked[i] = true
		end
	end

	SetGlobalInt("wave", wave)

	for classid in pairs(previouslylocked) do
		if gamemode.Call("IsClassUnlocked", classid) then
			local classtab = self.ZombieClasses[classid]
			if not classtab.UnlockedNotify then
				classtab.UnlockedNotify = true
				table.insert(UnlockedClasses, classid)
			end

			for _, ent in pairs(ents.FindByClass("logic_classunlock")) do
				local classname = GAMEMODE.ZombieClasses[classid].Name
				if ent.Class == string.lower(classname) then
					ent:Input("onclassunlocked", ent, ent, classname)
				end
			end
		end
	end

	if #UnlockedClasses > 0 then
		for _, pl in pairs(player.GetAll()) do
			local classnames = {}
			for __, classid in pairs(UnlockedClasses) do
				table.insert(classnames, translate.ClientGet(pl, self.ZombieClasses[classid].TranslationName))
			end
			net.Start("zs_classunlock")
				net.WriteString(string.AndSeparate(classnames))
			net.Send(pl)
		end
	end
end

GM.NextEscapeDamage = 0

local trace = {start = Vector(0, 0, 0), endpos = Vector(0, 0, 0), filter = NULL, mask = MASK_SOLID}
local function TraceToFloor(ent)
	--drop to floor has issues with displacement collisions, so we'll run a trace instead
	local vPos = ent:WorldSpaceCenter()
	trace.start = vPos
	trace.endpos = vPos + Vector(0, 0, -1000) --drop it by 1000 units
	trace.filter = {ent}
	local tr = util.TraceLine(trace)
	if tr.Hit and tr.HitPos then
		ent:SetPos(tr.HitPos)
	end
end

function GM:WaveStateChanged(newstate)
	if newstate then
		if self:GetWave() == 0 then
			self:SetClosestsToZombie()

			local humans = {}
			for _, pl in pairs(player.GetAll()) do
				if pl:Team() == TEAM_HUMAN and pl:Alive() then
					table.insert(humans, pl)
				end
			end

			if #humans >= 1 then
				for _, pl in pairs(humans) do
					gamemode.Call("GiveDefaultOrRandomEquipment", pl)
					pl.BonusDamageCheck = CurTime()
				end
			end

			-- We should spawn a crate in a random spawn point if no one has any.
			if not self.ZombieEscape and #ents.FindByClass("prop_arsenalcrate") == 0 then
				local have = false
				for _, pl in pairs(humans) do	
					if pl:HasWeapon("weapon_zs_arsenalcrate") then
						have = true
						break
					end
				end

				if not have and #humans >= 1 then
					local spawn = self:PlayerSelectSpawn(humans[math.random(#humans)])
					if spawn and spawn:IsValid() then
						local ent = ents.Create("prop_arsenalcrate")
						if ent:IsValid() then
							ent:SetPos(spawn:GetPos())
							ent:Spawn()
							--ent:DropToFloor() --causes issues, use the trace to floor method instead for testing
							TraceToFloor(ent)
							ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER) -- Just so no one gets stuck in it.
							ent.NoTakeOwnership = true
						end
					end
				end
			end
		end

		local prevwave = self:GetWave()

		if self:GetUseSigils() and prevwave >= self:GetNumberOfWaves() then return end

		gamemode.Call("SetWave", prevwave + 1)
		gamemode.Call("SetWaveStart", CurTime())
		if self.ZombieEscape then
			gamemode.Call("SetWaveEnd", -1)
			SetGlobalInt("numwaves", -1)
		else
			gamemode.Call("SetWaveEnd", self:GetWaveStart() + self:GetWaveOneLength() + (self:GetWave() - 1) * (GetGlobalBool("classicmode") and self.TimeAddedPerWaveClassic or self.TimeAddedPerWave))
		end

		net.Start("zs_wavestart")
			net.WriteInt(self:GetWave(), 16)
			net.WriteFloat(self:GetWaveEnd())
		net.Broadcast()

		for _, pl in pairs(team.GetPlayers(TEAM_UNDEAD)) do
			pl.m_LastWaveStartSpawn = CurTime()
			if pl:GetZombieClassTable().Name == "Crow" then
				pl:SetZombieClass(pl.DeathClass or 1)
				pl:UnSpectateAndSpawn()
			elseif not pl:Alive() and not pl.Revive then
				pl:UnSpectateAndSpawn()
			end
		end

		local curwave = self:GetWave()
		for _, ent in pairs(ents.FindByClass("logic_waves")) do
			if ent.Wave == curwave or ent.Wave == -1 then
				ent:Input("onwavestart", ent, ent, curwave)
			end
		end
		for _, ent in pairs(ents.FindByClass("logic_wavestart")) do
			if ent.Wave == curwave or ent.Wave == -1 then
				ent:Input("onwavestart", ent, ent, curwave)
			end
		end
	elseif self:GetWave() >= self:GetNumberOfWaves() then -- Last wave is over
		if self:GetUseSigils() then
			if self:GetEscapeStage() == ESCAPESTAGE_BOSS then
				self:SetEscapeStage(ESCAPESTAGE_DEATH)

				PrintMessage(3, "Escape sequence death fog stage")

				gamemode.Call("SetWaveEnd", -1)
			elseif self:GetEscapeStage() == ESCAPESTAGE_ESCAPE then
				self:SetEscapeStage(ESCAPESTAGE_BOSS)

				-- 2 minutes to get out with everyone spawning as bosses.
				gamemode.Call("SetWaveEnd", CurTime() + 120)

				PrintMessage(3, "Escape sequence boss stage")

				-- Start spawning boss zombies.
			elseif self:GetEscapeStage() == ESCAPESTAGE_NONE then
				-- If we're using sigils, remove them all and spawn the doors.
				for _, sigil in pairs(ents.FindByClass("prop_obj_sigil")) do
					local ent = ents.Create("prop_obj_exit")
					if ent:IsValid() then
						ent:SetPos(sigil.NodePos or sigil:GetPos())
						ent:SetAngles(sigil:GetAngles())
						ent:Spawn()
					end

					sigil:Destroy()
				end

				--[[net.Start("zs_waveend")
					net.WriteInt(self:GetWave(), 16)
					net.WriteFloat(CurTime())
				net.Broadcast()]]
				PrintMessage(3, "Escape sequence started")

				-- 2 minutes to escape.
				gamemode.Call("SetWaveActive", true)
				gamemode.Call("SetWaveEnd", CurTime() + 120)
				self:SetEscapeStage(ESCAPESTAGE_ESCAPE)

				local curwave = self:GetWave()
				for _, ent in pairs(ents.FindByClass("logic_waves")) do
					if ent.Wave == curwave or ent.Wave == -1 then
						ent:Input("onwaveend", ent, ent, curwave)
					end
				end
				for _, ent in pairs(ents.FindByClass("logic_waveend")) do
					if ent.Wave == curwave or ent.Wave == -1 then
						ent:Input("onwaveend", ent, ent, curwave)
					end
				end
			end
		else
			-- If not using sigils then humans all win.
			gamemode.Call("EndRound", TEAM_HUMAN)

			local curwave = self:GetWave()
			for _, ent in pairs(ents.FindByClass("logic_waves")) do
				if ent.Wave == curwave or ent.Wave == -1 then
					ent:Input("onwaveend", ent, ent, curwave)
				end
			end
			for _, ent in pairs(ents.FindByClass("logic_waveend")) do
				if ent.Wave == curwave or ent.Wave == -1 then
					ent:Input("onwaveend", ent, ent, curwave)
				end
			end
		end
	else
		gamemode.Call("SetWaveStart", CurTime() + (GetGlobalBool("classicmode") and self.WaveIntermissionLengthClassic or self.WaveIntermissionLength))

		net.Start("zs_waveend")
			net.WriteInt(self:GetWave(), 16)
			net.WriteFloat(self:GetWaveStart())
		net.Broadcast()

		for _, pl in pairs(player.GetAll()) do
			if pl:Team() == TEAM_HUMAN and pl:Alive() then
				if self.EndWaveHealthBonus > 0 then
					pl:SetHealth(math.min(pl:GetMaxHealth(), pl:Health() + self.EndWaveHealthBonus))
				end
			elseif pl:Team() == TEAM_UNDEAD and not pl:Alive() and not pl.Revive then
				local curclass = pl.DeathClass or pl:GetZombieClass()
				local crowindex = GAMEMODE.ZombieClasses["Crow"].Index
				pl:SetZombieClass(crowindex)
				pl:DoHulls(crowindex, TEAM_UNDEAD)
				pl.DeathClass = nil
				pl:UnSpectateAndSpawn()
				pl.DeathClass = curclass
			end

			pl.SkipCrow = nil
		end

		local curwave = self:GetWave()
		for _, ent in pairs(ents.FindByClass("logic_waves")) do
			if ent.Wave == curwave or ent.Wave == -1 then
				ent:Input("onwaveend", ent, ent, curwave)
			end
		end
		for _, ent in pairs(ents.FindByClass("logic_waveend")) do
			if ent.Wave == curwave or ent.Wave == -1 then
				ent:Input("onwaveend", ent, ent, curwave)
			end
		end
	end

	gamemode.Call("OnWaveStateChanged")
end

function GM:PlayerSwitchFlashlight(pl, newstate)
	if pl:Team() == TEAM_UNDEAD then
		if pl:Alive() then
			pl:SendLua("gamemode.Call(\"ToggleZombieVision\")")
		end

		return false
	end

	return pl:Team() == TEAM_HUMAN
end

function GM:PlayerStepSoundTime(pl, iType, bWalking)
	return 350
end

concommand.Add("zs_class", function(sender, command, arguments)
	if sender:Team() ~= TEAM_UNDEAD or sender.Revive or GAMEMODE.PantsMode or GAMEMODE:IsClassicMode() or GAMEMODE:IsBabyMode() or GAMEMODE.ZombieEscape then return end

	local classname = arguments[1]
	local suicide = arguments[2] == "1"
	local classtab = GAMEMODE.ZombieClasses[classname]
	if not classtab or classtab.Hidden and not (classtab.CanUse and classtab:CanUse(sender)) then return end

	if not gamemode.Call("IsClassUnlocked", classname) then
		sender:CenterNotify(COLOR_RED, translate.ClientFormat(sender, "class_not_unlocked_will_be_unlocked_x", classtab.Wave))
	elseif sender:GetZombieClassTable().Name == classname and not sender.DeathClass then
		sender:CenterNotify(COLOR_RED, translate.ClientFormat(sender, "you_are_already_a_x", translate.ClientGet(sender, classtab.TranslationName)))
	else
		sender.DeathClass = classtab.Index
		sender:CenterNotify(translate.ClientFormat(sender, "you_will_spawn_as_a_x", translate.ClientGet(sender, classtab.TranslationName)))

		if suicide and sender:Alive() and not sender:GetZombieClassTable().Boss and gamemode.Call("CanPlayerSuicide", sender) then
			sender:Kill()
		end
	end
end)
