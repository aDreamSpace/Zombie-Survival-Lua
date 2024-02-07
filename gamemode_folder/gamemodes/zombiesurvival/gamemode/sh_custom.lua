--anti juke
hook.Add("OnPlayerHitGround", "CrouchReset", function(ply, water, floater, speed)
	if ply:IsValid() and ply:Alive() then
		if speed > 64 and not GAMEMODE.ZombieEscape then
			ply.LandSlow = true --based on ZS antibhop
		end
		
		ply.HoldCrouch = 0 --dunno why this was in a 1 frame timer before
	end
end)

hook.Add("StartCommand", "CrouchLimit", function(ply, cmd)
	if ply:GetMoveType() == MOVETYPE_NOCLIP then return end
	if not ply.HoldCrouch then ply.HoldCrouch = 0 end

	if ply:IsValid() and ply:Alive() then
		local flCT = CurTime()

		if ply.HoldCrouch <= flCT then
			if cmd:KeyDown(IN_DUCK) and not ply:OnGround() then
				ply.HoldCrouch = flCT + 0.4
			end
		elseif not cmd:KeyDown(IN_DUCK) then
			cmd:SetButtons(cmd:GetButtons() + IN_DUCK)
		end
	end
end)

local flMaxVel = 250 * 250 --sqr'd for use of Length2DSqr
hook.Add("FinishMove", "AntiBhop", function(ply, mvdata)
	if ply.LandSlow then
		ply.LandSlow = false
		local vel = mvdata:GetVelocity()
		local spd = vel:Length2DSqr()

		if spd > flMaxVel then
			local mul = 0.60

			vel.x = vel.x * mul
			vel.y = vel.y * mul
			
			mvdata:SetVelocity(vel)
		end
	end
end)

--mouth move
function GM:MouthMoveAnimation( ply )
	if ply:Team() == TEAM_HUMAN then

	local flexes = {
		ply:GetFlexIDByName( "jaw_drop" ),
		ply:GetFlexIDByName( "left_part" ),
		ply:GetFlexIDByName( "right_part" ),
		ply:GetFlexIDByName( "left_mouth_drop" ),
		ply:GetFlexIDByName( "right_mouth_drop" )
	}

	local weight = ply:IsSpeaking() and math.Clamp( ply:VoiceVolume() * 2, 0, 2 ) or 0

	for k, v in pairs( flexes ) do

		ply:SetFlexWeight( v, weight )

	end
	end
end

--purpose: special round shared functions
--indexed numerically
--Rather than rely on separate func definitions for client and server, i'll just define them here so that the client can do whatever when the server sends the func index
GM.SpecialRoundRuleHoldTime = 20
GM.SpecialRoundIncomingHoldTime = 5
GM.SpecialRoundIncomingDelay = 30
GM.SpecialRoundTitle = ""
GM.SpecialRoundRules = ""
GM.SRProcessor = ""
GM.SRCurrentPredictorFunc = ""
SpecialRounds = {}
--[[ --not fun in practice
function SpeedRound()
	GAMEMODE.SpecialRoundTitle = "Speed Round"
	GAMEMODE.SpecialRoundRules = "Movement Speed for all players increased by 150%"
	
	hook.Add("Move", "SpeedRoundSet", function(ply, mvdata)
		local speed = ply:GetMaxSpeed() * 1.5
		mvdata:SetMaxSpeed(speed)
		mvdata:SetMaxClientSpeed(speed)
	end)
end
SpecialRounds[#SpecialRounds+1] = SpeedRound
--]]
function FogRound()
	GAMEMODE.SpecialRoundTitle = "Fog Round"
	GAMEMODE.SpecialRoundRules = "Map is now covered with a thick fog!"
	GAMEMODE.SRProcessor = "Hijacking env_fog_controller..."
	
	if CLIENT then
		hook.Add("SetupWorldFog", "FogRound", function()
			if MySelf:Team() == TEAM_HUMAN then
				render.FogMode(MATERIAL_FOG_LINEAR)
				render.FogStart(30)
				render.FogEnd(256)
				render.FogMaxDensity(1)
				render.FogColor(180, 180, 180)
				return true
			end
		end)
		hook.Add("SetupSkyboxFog", "FogRound", function(scale)
			if MySelf:Team() == TEAM_HUMAN then
				render.FogMode(MATERIAL_FOG_LINEAR)
				render.FogStart(30 * scale)
				render.FogEnd(256 * scale)
				render.FogMaxDensity(1)
				render.FogColor(180, 180, 180)
				return true
			end
		end)
	end
end
SpecialRounds[#SpecialRounds+1] = FogRound
--]]

function NightRound()
	GAMEMODE.SpecialRoundTitle = "BLACKED"
	GAMEMODE.SpecialRoundRules = "Map lighting has been disabled. Enjoy."
	GAMEMODE.SRProcessor = "Setting up map lightmaps..."

	if SERVER then
		engine.LightStyle(0, "a")
	end

	if CLIENT then
		timer.Simple(3, function()
			render.RedownloadAllLightmaps(true)
		end)
	end
end
SpecialRounds[#SpecialRounds+1] = NightRound

--precache
function PrecacheDir( dir )
    local files, directories = file.Find( dir.."*", "GAME" )
    for _, fdir in pairs(directories) do
        if fdir != ".svn" then
            PrecacheDir(dir..fdir.."/")
        end
    end

    for k,v in pairs(files) do
        local fname = string.lower(dir..v)
                --print(fname)
        local ismodel = -1
        local ismaterial = -1
        local isparticle = -1
        local issound = -1
        ismodel = (string.find(fname,".mdl"))
        ismaterial = (string.find(fname,".vtf") or string.find(fname,".vmt"))
        isparticle = (string.find(fname,".pcf"))
        issound = (string.find(fname,".wav") or string.find(fname,".mp3")  )
        if ismaterial then
            if ismaterial >= 0 then
                local tmpmat = Material(fname,"mips")
            end
        elseif isparticle then
            if isparticle >= 0 then

                PrecacheParticleSystem(fname)
            end
        elseif issound then
            if issound >= 0 then
                util.PrecacheSound(fname)
            end
        else

            if ismodel then
                if ismodel >= 0 then
                    util.PrecacheModel(fname)
                end
            end
        end
    end
end

hook.Add("PostGamemodeLoaded", "CWPrecache", function()
	for k, w in ipairs(weapons.GetList()) do
		if w then --and w.CW20Weapon then
			if w.ViewModel then
				util.PrecacheModel(w.ViewModel)
				--print("found and loaded "..w.ViewModel)
			end
			if w.WorldModel then
				util.PrecacheModel(w.WorldModel)
				--print("found and loaded "..w.WorldModel)
			end
			if w.WM then
				util.PrecacheModel(w.WM)
				--print("found and loaded "..w.WM)
			end
		end
	end
	PrecacheDir("models/attachments/")
	PrecacheDir("models/cw2/")
	PrecacheDir("models/props/pickup/")
	PrecacheDir("models/items/")
	PrecacheDir("models/wystan/")

	--and load loose files, that arent in specific folders (precaching all of /models will be too much)
	util.PrecacheModel("models/props_lab/jar01a.mdl")
	util.PrecacheModel("models/maxofs2d/lamp_flashlight.mdl")

	--loose attachments
	util.PrecacheModel("models/c_fas2_eotech.mdl")
	util.PrecacheModel("models/c_fas2_eotech.mdl")
	util.PrecacheModel("models/v_holo_sight_kkrc.mdl")
	util.PrecacheModel("models/v_cod4_aimpoint.mdl")
	util.PrecacheModel("models/v_fas2_leupold_mounts.mdl")
	util.PrecacheModel("models/c_larue_kkhx.mdl")
	util.PrecacheModel("models/c_magnifier_scope.mdl")
	util.PrecacheModel("models/v_holo_sight_orig_hx.mdl")
	util.PrecacheModel("models/v_cod4_acog.mdl")
	util.PrecacheModel("models/c_fas2_eotech_stencil.mdl")
	util.PrecacheModel("models/v_cod4_eotech.mdl")
	util.PrecacheModel("models/v_fas2_leupold.mdl")
	util.PrecacheModel("models/v_cod4_reflex.mdl")
	util.PrecacheModel("models/c_fas2_aimpoint_rigged.mdl")
end)

--special player functions, for returns, traits, etc.
local Player = FindMetaTable("Player")

--purpose: hint system, similar to l4d in that it will be able to support sounds and positional hints
--registry system for hints
GM.Hints = {}

function GM:RegisterHint(strType, strInfo, strBind, iTeam, iTime, iLimit, strSnd, fSpecial)
	strSnd = strSnd or "garrysmod/save_load1.wav"
	iTime = iTime or 10
	iLimit = iLimit or 8
	local tHints = self.Hints
	local id = #tHints+1
	tHints[id] = {type = strType, info = strInfo, bind = strBind, team = iTeam, time = iTime, limit = iLimit, snd = strSnd, spec = fSpecial, id = id}

	return id
end

function GM:GetHintByType(strType)
	local tHints = self.Hints
	for i = 1, #tHints do
		local tData = tHints[i]
		if tData.type == strType then
			return tData.id
		end
	end
end

function GM:GetHintByID(id)
	return self.Hints[id]
end

GM:RegisterHint("barricadephase", "You can hold down %1 or %2 to move through nailed props as a human", "undo&+zoom", TEAM_HUMAN, 10, 12)
GM:RegisterHint("wepammo", "Find an Arsenal Crate to buy weapons and ammo by pressing %1 on it, or use %2 to quickly buy ammo", "+use&+menu", TEAM_HUMAN, 20, 12)
GM:RegisterHint("prop2prop", "Nailing props to other props weakens the barricade, press %1 to remove the nail and nail it to the walls or floor instead", "+reload", TEAM_HUMAN, 15, 16)
GM:RegisterHint("f3menu", "You can press %1 to change to different, more effective Zombie Classes as they are unlocked. Remember, you have infinite lives, so don't be afraid to attack, attack, attack!", "gm_showspare1", TEAM_UNDEAD, 20)
GM:RegisterHint("unnail", "Do not unnail other people's props. You will receive a score and health penalty for fickle unnailing", nil, TEAM_HUMAN, 15, 12)
GM:RegisterHint("proprotate", "In addition to rotating props, if you hold down %1 and %2 then rotation will snap to common angles", "+speed&+walk", TEAM_HUMAN, 15)


GM.MaxHints = 8 --amount of hints to display before we stop giving that specific hint

local tCooldowns = {}
local zVec = Vector(0, 0, 0)
function Player:DispatchHint(id, pos)
	if self:IsBot() then return end
	if not self.m_HintCooldown then self.m_HintCooldown = {} end
	if not self.m_HintCooldown[id] then self.m_HintCooldown[id] = 0 end
	if self.m_HintCooldown[id] > 3 then return end --temporary round-based to limit the hints we dispatch
	self.m_HintActive = self.m_HintActive or 0 --now lets make sure this is initialized
	if self.m_HintActive > CurTime() then return end --dont do anything if we already have a hint

	local tHint = GAMEMODE:GetHintByID(id)

	if tHint.team and self:Team() ~= tHint.team then return end --if we're not on the right team do nothing
	--we saved ourselves a lot of networking by doing that
	--however this could be avoided altogether by providing checks at dispatchhint in code
	
	--now we should sanitize our hintdata for networking, 
	--this could use more work in order to just send the data we nee
	if CLIENT then
		InterpretHint(tHint, pos or zVec)
	else
		net.Start("gc_hint")
			net.WriteUInt(id, 8)
			net.WriteVector(pos or zVec) --zero vector will be interpreted as no vector
		net.Send(self)
		self.m_HintCooldown[id] = self.m_HintCooldown[id] + 1
	end
	self.m_HintActive = CurTime() + tHint.time
end

--tired of hunting down print statements that i lost.
--so lets rewrite the print function altogether.
--credit to thelastpenguin (https://facepunch.com/member.php?u=419691)

--first lets make sure there's an option to disable this stuff...
CreateConVar("gc_debugprint", 0, {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE}, "Displays additional information in print statements.")

local fileColors = {}
local fileAbbrev = {}
local MsgC, oldPrint = _G.MsgC , _G.print
local incr = SERVER and 72 or 0 -- server side version of file gets different color from client... way less confusing like that
function print(...)
	if cvars.Number("gc_debugprint", 0) == 0 then
		oldPrint(...)
		return 
	end

    local info = debug.getinfo(2)
    if not info then 
        oldPrint(...)
        return
    end
    
    local fname = info.short_src;
    if fileAbbrev[fname] then
        fname = fileAbbrev[fname];
    else
        local oldfname = fname;
        fname = string.Explode('/', fname);
        fname = fname[#fname];
        fileAbbrev[oldfname] = fname;
    end
    
    if not fileColors[fname] then
        incr = incr + 1;
        fileColors[fname] = HSVToColor(incr * 100 % 255, 1, 1)
    end
    
    MsgC(fileColors[fname], fname..':'..info.linedefined.." : ")
    oldPrint(... )
end

--stamina system
local meta = FindMetaTable("Player")

function meta:AddStamina(num)
	if self.StamDelay and self.StamDelay > CurTime() then return end
	local add = math.Round(num)
	if not self.m_Stamina then self.m_Stamina = 100 end
	self.m_Stamina = self.m_Stamina + add
	if self.m_Stamina > 100 then
		self.m_Stamina = 100
	elseif self.m_Stamina < 0 then
		self.m_Stamina = 0
	end
end

function meta:SetStamina(num)
	if not self.m_Stamina then self.m_Stamina = 100 end
	self.m_Stamina = math.Round(num)
	if self.m_Stamina > 100 then
		self.m_Stamina = 100
	elseif self.m_Stamina < 0 then
		self.m_Stamina = 0
	end
end

function meta:GetStamina()
	if self:Team() == TEAM_UNDEAD then return false end
	if not self.m_Stamina then self.m_Stamina = 100 end
	return self.m_Stamina
end

function meta:RemoveStamina(num)
	local sub = math.Round(num)
	if not self.m_Stamina then self.m_Stamina = 100 end
	self.m_Stamina = self.m_Stamina - sub
	self.StamDelay = CurTime() + 1
	if self.m_Stamina > 100 then
		self.m_Stamina = 100
	elseif self.m_Stamina < 0 then
		self.m_Stamina = 0
	end
end

hook.Add("PlayerInitialSpawn", "StaminaInit", function(ply)
	ply.m_Stamina = 100
end)

local nextThink = 0
hook.Add("Think", "StaminaRegen", function()
	if nextThink > CurTime() then return end
	nextThink = CurTime() + 0.2
	local plys = team.GetPlayers(TEAM_HUMAN)
	for _, v in pairs(plys) do
		v:AddStamina(3)
	end
end)
--]]

--nailtype enumerations, for customizable hammers and etc
NAILTYPE_NONE = 0
NAILTYPE_BARBED = 1
NAILTYPE_HEAVY = 2
NAILTYPE_FROZEN = 3
NAILTYPE_BOOM = 4
NAILTYPE_LONG = 5
NAILTYPE_CHEAP = 6
NAILTYPE_GALVANIZED = 7
NAILTYPE_STEEL = 8

--infusion enumerations, for melee infusions and etc
INFUSION_NONE = 0
INFUSION_HEAVY = 1
INFUSION_SHARP = 2
INFUSION_FIRE = 3
INFUSION_POISON = 4
INFUSION_BLOOD = 5
INFUSION_CHAOS = 6


--shared emotes, in order to facilitate adding a menu system
--emotes
--to add additional ones, format is:
--GM.TextEmotes["chat text in lowercase"] = {Sound("zombiesurvival/emotes/soundfile.ogg"), cooldownInSeconds(default=0), HideFromChat(true/false)(default=false)}
local strDir = "zombiesurvival/emotes/" --just so i dont have to type this over and over
GM.TextEmotes = {}
--utility funtion to add emotes
function GM:AddEmote(trigger, path, delay, bHide)
	self.TextEmotes[trigger] = {path, delay, bHide}
end

GM.TextEmotes["ass"] = {"zombiesurvival/emotes/assviolated.ogg", 0.5, false}
GM.TextEmotes["don't want to die"] = {"zombiesurvival/emotes/dontwantdie.ogg", 1.4, true}
GM.TextEmotes["china"] = {"zombiesurvival/emotes/china.ogg", 0.5, false}
GM.TextEmotes["haha"] = {"zombiesurvival/emotes/glaugh.ogg", 0.8, false}
GM.TextEmotes["wall"] = {"zombiesurvival/emotes/greatwall.ogg", 1.2, false}
GM.TextEmotes["hillary"] = {"zombiesurvival/emotes/hillary.ogg", 0.7, false}
GM.TextEmotes["bing bong"] = {"zombiesurvival/emotes/bingbingbong.ogg", 1.2, false}
GM.TextEmotes["bastard"] = {"zombiesurvival/emotes/bastard.ogg", 0.4, false}
GM.TextEmotes["my man"] = {"zombiesurvival/emotes/myman.ogg", 0.8, false}
GM.TextEmotes["cough"] = {"zombiesurvival/emotes/cough.ogg", 0.5, false}
GM.TextEmotes["what are you doing"] = {"zombiesurvival/emotes/whatyoudoing.ogg", 1, false}
GM.TextEmotes["oh my"] = {"zombiesurvival/emotes/ohmy.ogg", 0.3, false}
GM.TextEmotes["medic"] = {"zombiesurvival/emotes/medic.ogg", 1.5, false}
GM.TextEmotes["give me tendies"] = {"zombiesurvival/emotes/givetendies.ogg", 15, true}
GM.TextEmotes["extreme sex activated"] = {"zombiesurvival/emotes/extremesex.ogg", 1, true}
GM.TextEmotes["gives me conniptions"] = {"zombiesurvival/emotes/conniptions.ogg", 0.6, false}
GM.TextEmotes["retard alert"] = {"zombiesurvival/emotes/retardalert.ogg", 1, false}
GM.TextEmotes["thanks"] = {"zombiesurvival/emotes/thanks.ogg", 0.5, false}
GM.TextEmotes["purple"] = {"zombiesurvival/emotes/purple.ogg", 1.25, true}
GM.TextEmotes["mein fuhrer"] = {"zombiesurvival/emotes/meinfuhrer.ogg", 1, true}
GM.TextEmotes["what"] = {"zombiesurvival/emotes/what.ogg", 0.5, false}
GM.TextEmotes["wah"] = {"zombiesurvival/emotes/wah.ogg", 0.5, false}
GM.TextEmotes["i love you"] = {"zombiesurvival/emotes/iloveyou.ogg", 0.8, false}
GM.TextEmotes["victory screech"] = {"zombiesurvival/emotes/victoryscreech.ogg", 1, true}
GM.TextEmotes["soiled it"] = {"zombiesurvival/emotes/soiledit.ogg", 0.5, true}
GM.TextEmotes["very nice"] = {"zombiesurvival/emotes/verynice.ogg", 0.6, false}
GM.TextEmotes["eek"] = {"ambient/voices/f_scream1.wav", 0.5, false}
GM.TextEmotes["headhumpers"] = {"vo/streetwar/sniper/ba_headhumpersgordon.wav", 1, false}
GM.TextEmotes["help"] = {"vo/streetwar/sniper/male01/c17_09_help01.wav", 0.5, false}
GM.TextEmotes["feel free to look around"] = {"vo/eli_lab/eli_lookaround.wav", 1, false}
GM.TextEmotes["eeh"] = {"vo/eli_lab/eli_handle_b.wav", 0.5, false}
GM.TextEmotes["you idiot"] = {"vo/coast/bugbait/sandy_youidiot.wav", 4, false}
GM.TextEmotes["ah hello"] = {"vo/coast/odessa/nlo_cub_hello.wav", 1.5, false}
GM.TextEmotes["done"] = {"vo/novaprospekt/al_done01.wav", 1, false}
GM.TextEmotes["hit the road"] = {"vo/canals/boxcar_go_nag04.wav", 1.2, false}
GM.TextEmotes["you fucking doughnut"] = {"zombiesurvival/emotes/doughnut.ogg", 1, false}
GM.TextEmotes["door stuck"] = {"zombiesurvival/emotes/doorstuck.ogg", 15, false}
GM.TextEmotes["let me get my desert eagle"] = {"zombiesurvival/emotes/deagle.ogg", 2, true}
GM.TextEmotes["football"] = {"zombiesurvival/emotes/football.ogg", 1, true}
GM.TextEmotes["do i look like some sort of queer to you"] = {"zombiesurvival/emotes/queer.ogg", 3, false}
GM.TextEmotes["laser beams"] = {"zombiesurvival/emotes/laserbeams.ogg", 1.5, false}
GM.TextEmotes["guys we're walking around it"] = {"zombiesurvival/emotes/walkingaroudit.ogg", 1, false}
GM.TextEmotes["be gone thot"] = {"zombiesurvival/emotes/begonethot.ogg", 1, false}
GM.TextEmotes["be nice zombie"] = {"zombiesurvival/emotes/benicezobie.ogg", 1, false}
GM.TextEmotes["i got this"] = {"zombiesurvival/emotes/birdnoextended.ogg", 2, false}
GM.TextEmotes["scream"] = {"zombiesurvival/emotes/birdscream.ogg", 10, false}
GM.TextEmotes["destroy us all"] = {"zombiesurvival/emotes/destroyusall.ogg", 1.5, false}
GM.TextEmotes["excuse me i'm in need of medical attention"] = {"zombiesurvival/emotes/excusememedic.ogg", 3, false}
GM.TextEmotes["furry bastard"] = {"zombiesurvival/emotes/furrybastard.ogg", 0.5, false}
GM.TextEmotes["greetings comrades"] = {"zombiesurvival/emotes/greetingscomrades.ogg", 0.5, false}
GM.TextEmotes["hoy minoy"] = {"zombiesurvival/emotes/hoyminoy.ogg", 15, false}
GM.TextEmotes["jesus christ"] = {"zombiesurvival/emotes/koranjesuschrist.ogg", 1, false}
GM.TextEmotes["you are out of you're fucking gourd my dude"] = {"zombiesurvival/emotes/outofgourd.ogg", 2.5, true}
GM.TextEmotes["why look another headcrab"] = {"zombiesurvival/emotes/whylookheadcrab.ogg", 2, false}
GM.TextEmotes["yes oh yes"] = {"zombiesurvival/emotes/yesgasm.ogg", 1.5, false}
GM.TextEmotes["watch your profanity"] = {"zombiesurvival/emotes/watchyourprofanity.ogg", 0.5, false}
GM.TextEmotes["oof"] = {"zombiesurvival/emotes/oof.ogg", 0.5, false}
GM.TextEmotes["obey your thirst"] = {"zombiesurvival/emotes/obeyyourthirst.ogg", 0.5, false}
GM.TextEmotes["i surrender"] = {"zombiesurvival/emotes/isurrender.ogg", 0.5, false}
GM.TextEmotes["i am the captain now"] = {"zombiesurvival/emotes/iamthecaptainnow.ogg", 0.5, false}
GM.TextEmotes["firmly grasp it"] = {"zombiesurvival/emotes/firmlygraspit.ogg", 0.5, false}
GM.TextEmotes["finest zs establishment"] = {"zombiesurvival/emotes/finestzs.ogg", 0.5, false}
GM.TextEmotes["crawling in my crawl"] = {"zombiesurvival/emotes/crawling.ogg", 0.5, true}
GM.TextEmotes["congratulations"] = {"zombiesurvival/emotes/congratulations.ogg", 0.5, false}
--GM.TextEmotes["poor lazlo"] = {"vo/coast/bugbait/sandy_poorlaszlo.wav", 5, false}
GM.TextEmotes["life is pain"] = {"zombiesurvival/emotes/lifeispain.ogg", 3, false}
GM.TextEmotes["nani"] = {"zombiesurvival/emotes/nani.ogg", 3, false}
GM.TextEmotes["omae wa mou shindeiru"] = {"zombiesurvival/emotes/omae.ogg", 8, false}
GM.TextEmotes["what are we going to do on the bed?"] = {"zombiesurvival/emotes/wwgtdb.ogg", 3, false}
GM.TextEmotes["luigi i'm home"] = {"zombiesurvival/emotes/luigiimhome.ogg", 2, false}
GM.TextEmotes["and if you do drugs you go to hell before you die"] = {"zombiesurvival/emotes/lou.ogg", 6, false}
GM.TextEmotes["i don't think you trust in my table"] = {"zombiesurvival/emotes/table2.ogg", 6, true}
GM.TextEmotes["hacking is easy"] = {strDir.."hackingiseasy.ogg", 3, false}
GM.TextEmotes["now you will be worm food"] = {strDir.."wormfood.ogg", 4, false}
GM.TextEmotes["i sawed this boat in half"] = {strDir.."istbih.ogg", 3, false}
GM.TextEmotes["spill the beans"] = {strDir.."stb.ogg", 3, false}
GM.TextEmotes["they're in ze attic"] = {strDir.."attic.ogg", 3, false}
GM.TextEmotes["you're going to suck this cock clean"] = {strDir.."clean.ogg", 5, false}
GM.TextEmotes["stop it, get some help"] = {strDir.."getsomehelp.ogg", 5, false}
GM.TextEmotes["no no"] = {"vo/npc/male01/no01.wav", 4, false}
GM.TextEmotes["please no"] = {"vo/npc/female01/gordead_ans06.wav", 4, false}
GM:AddEmote("no", "vo/citadel/eli_notobreen.wav", 2, false)
GM:AddEmote("nice", "vo/npc/male01/nice.wav", 2, false)
GM:AddEmote("me?", "vo/trainyard/man_me.wav", 2, false)
GM:AddEmote("let's do it", "vo/npc/Barney/ba_letsdoit.wav", 3, false)
GM:AddEmote("incoming", "vo/canals/male01/stn6_incoming.wav", 3, false)
GM:AddEmote("hush", "vo/ravenholm/shotgun_hush.wav", 2, false)
GM:AddEmote("hey", "vo/canals/shanty_hey.wav", 2, false)
GM:AddEmote("hi", "vo/npc/male01/hi01.wav", 1, false)
GM:AddEmote("headcrabs", "vo/npc/male01/headcrabs01.wav", 2, false)
GM:AddEmote("guh", "vo/k_lab/ba_guh.wav", 1, false)
GM:AddEmote("good god", "vo/citadel/eli_goodgod.wav", 2.5, false)
GM:AddEmote("follow me", "vo/npc/male01/squad_away03.wav", 1.5, false)
GM:AddEmote("done!", "vo/streetwar/nexus/ba_done.wav", 1.5, false)
GM:AddEmote("damnit", "vo/npc/barney/ba_damnit.wav", 1.5, false)
GM:AddEmote("cut it out", "vo/trainyard/male01/cit_hit01.wav", 2.5, false)
GM:AddEmote("stop that", "vo/trainyard/male01/cit_hit02.wav", 2, false)
GM:AddEmote("joygasm", "vo/npc/female01/pain06.wav", 2, true)
GM:AddEmote("he's dead", "vo/npc/male01/gordead_ques01.wav", 2, false)
GM:AddEmote("got one", "vo/npc/male01/gotone01.wav", 2, false)
GM:AddEmote("go on", "vo/canals/shanty_go_nag02.wav", 2, false)
GM:AddEmote("duck", "vo/npc/barney/ba_duck.wav", 1, false)
GM:AddEmote("cum", "vo/ravenholm/engage02.wav", 1, false)
GM:AddEmote("but ok", "vo/k_lab/ba_myshift02.wav", 1, false)
GM:AddEmote("but where will you go?", "vo/novaprospekt/eli_wherewillyougo01.wav", 3, false)
GM:AddEmote("that was brutal", "vo/npc/alyx/brutal02.wav", 3, false)
GM:AddEmote("gasp", "vo/novaprospekt/al_gasp01.wav", 2, false)
GM:AddEmote("get back here dad", "vo/novaprospekt/al_comebackdad.wav", 3, false)
GM:AddEmote("you're scaring off the pigeons", "vo/trainyard/male01/cit_bench04.wav", 4, false)
GM:AddEmote("do you understand", strDir.."doyouunderstand.ogg", 7, false)
GM:AddEmote("do you suck dicks", strDir.."dysd.ogg", 2, false)
GM:AddEmote("now we can do this the easy way or the hard way", strDir.."easyway.ogg", 6, true)
GM:AddEmote("fucking die", strDir.."fdie.ogg", 2, false)
GM:AddEmote("hey fagit", strDir.."hf.ogg", 2.5, false)
GM:AddEmote("it got his eyes", strDir.."ighe.ogg", 5, false)
GM:AddEmote("i have the power of god and anime", strDir.."ihtpogaa.ogg", 8, true)
GM:AddEmote("it don't matter, none of this matters", strDir.."itdontmatter.ogg", 5, false)
GM:AddEmote("it's an enemy stand", strDir.."itsanenemystand.ogg", 4, false)
GM:AddEmote("kill me", strDir.."killme.ogg", 3, false)
GM:AddEmote("shit down neck", strDir.."neckshit.ogg", 7, true)
GM:AddEmote("nicu nicu", strDir.."nicunicu.ogg", 3, false)
GM:AddEmote("shia surprise", strDir.."shiasurprise.ogg", 6, true)
GM:AddEmote("i didn't know they stacked shit that high", strDir.."stackedshit.ogg", 6, false)
GM:AddEmote("tonight, you", strDir.."tonightyou.ogg", 4, false)
GM:AddEmote("who the fuck said that", strDir.."wtfsd.ogg", 4, false)
GM:AddEmote("gnaaa", strDir.."gnaaa.ogg", 3, true)
GM:AddEmote("damnit!", strDir.."damnit.ogg", 2, false)
GM:AddEmote("he's gonna lose", strDir.."hgl.ogg", 2, false)
GM:AddEmote("lampoil", strDir.."lampoil.ogg", 12, true)
GM:AddEmote("not a soldier's gun", strDir.."nasg.ogg", 4, true)
GM:AddEmote("richer", strDir.."richer.ogg", 11, true)
GM:AddEmote("sugoi", strDir.."sugoi.ogg", 2, false)
GM:AddEmote("unreliable", strDir.."unreliable.ogg", 2, false)
GM:AddEmote("aagh", strDir.."aah.ogg", 2, false)
GM:AddEmote("fucking cumming", strDir.."fc.ogg", 3, true)
GM:AddEmote("fucking slaves, get your ass back here", strDir.."fs.ogg", 4, false)
GM:AddEmote("mmm", strDir.."mmm.ogg", 2, false)
GM:AddEmote("what the hell are you two doing", strDir.."wthaytd.ogg", 4, false)
GM:AddEmote("we're 100% black", strDir.."100pcblack.ogg", 2, false)
GM:AddEmote("me too", strDir.."metoo.ogg", 1, false)
GM:AddEmote("maybe you should try getting a job", strDir.."mystgaj.ogg", 3, false)
GM:AddEmote("this is my store", strDir.."tims.ogg", 2, false)
GM:AddEmote("what a shame", strDir.."whatashame.ogg", 1.5, false)
GM:AddEmote("why contain it", strDir.."whycontainit.ogg", 1.5, false)
GM:AddEmote("you can't scare me with this", strDir.."ycsmwt.ogg", 2, false)
GM:AddEmote("hentai", strDir.."hentai.ogg", 2, true)
GM:AddEmote("super succ", strDir.."supersucc.ogg", 3, true)
GM:AddEmote("finish that croissant?", strDir.."aygtftc.ogg", 4, true)
GM:AddEmote("here they come", strDir.."heretheycome.ogg", 3, false)
GM:AddEmote("burn those motherfuckers", strDir.."burnem.ogg", 3.5, false)
GM:AddEmote("freeman message", strDir.."freemanmessage.ogg", 7, true)
GM:AddEmote("fuck yeah", strDir.."fuckyeah.ogg", 1.5, false)
GM:AddEmote("splendid idea", strDir.."goodidea.ogg", 6, true)
GM:AddEmote("this is the greatest handgun in the world", strDir.."handgun.ogg", 4, false)
GM:AddEmote("let's go", strDir.."letsgo.ogg", 1.5, false)
GM:AddEmote("you're that ninja", strDir.."ninja.ogg", 2.5, false)
GM:AddEmote("i'm gonna need a sweeper", strDir.."sweeper.ogg", 3.5, false)
GM:AddEmote("when i get my hands on that ass", strDir.."wigmhota.ogg", 4, false)
GM:AddEmote("anu cheeki breeki iv damke", strDir.."cheekibreeki.ogg", 3, false)
GM:AddEmote("dinosaurs", strDir.."dinosaurs.ogg", 1.5, false)
GM:AddEmote("fuck you", strDir.."fuckyou.ogg", 2, false)
GM:AddEmote("get out of that jabroni outfit", strDir.."gootjo.ogg", 3, false)
GM:AddEmote("i'd be right happy to", strDir.."ibrht.ogg", 2.5, false)
GM:AddEmote("i did nothing", strDir.."ididnothing.ogg", 1.5, false)
GM:AddEmote("no shame in our dicks", strDir.."noshame.ogg", 4, true)
GM:AddEmote("oh shit i'm sorry", strDir.."osis", 2, false)
GM:AddEmote("sorry for what", strDir.."sorryforwhat.ogg", 2, false)
GM:AddEmote("welcome to uganda", strDir.."wtu.ogg", 3, false)
GM:AddEmote("that's a bad idea", strDir.."badidea.ogg", 2, false)
GM:AddEmote("you better stop i'm getting pissed", strDir.."betterstop.ogg", 3, false)
GM:AddEmote("c'mon little girls lets go", strDir.."clglg.ogg", 2.5, false)
GM:AddEmote("come back with me little guy", strDir.."comebackwithme.ogg", 2.5, false)
GM:AddEmote("like shooting fish in a barrel", strDir.."lsfiab.ogg", 2.5, false)
GM:AddEmote("look who's still alive", strDir.."lwsa.ogg", 2, false)
GM:AddEmote("told ya i wasn't scared", strDir.."tyiws.ogg", 2.5, false)
GM:AddEmote("uh these are our hostages", strDir.."utaoh.ogg", 2.5, false)
GM:AddEmote("where did you think you were going", strDir.."wdutuwg.ogg", 2.5, false)
GM:AddEmote("we got your number", strDir.."wgyn.ogg", 2, false)
GM:AddEmote("you can't tame the beast", strDir.."ycttb.ogg", 2.5, false)
GM:AddEmote("yeah no", strDir.."yeahno.ogg", 1.5, false)
GM:AddEmote("you're wrong", strDir.."yourewrong.ogg", 1, false)
GM:AddEmote("hard way", strDir.."hardway.ogg", 2, true)
GM:AddEmote("i came looking for booty", strDir.."iclfb.ogg", 2, false)
GM:AddEmote("i like ya, and i want ya", strDir.."ilyaiwy.ogg", 2, false)
GM:AddEmote("mmhmm, take your time", strDir.."mhmmtyt.ogg", 1.5, false)
GM:AddEmote("boop", strDir.."boop.ogg", 0.5, false)
GM:AddEmote("hello", strDir.."hello.ogg", 0.5, false)
GM:AddEmote("help me", strDir.."hm.ogg", 0.6, false)
GM:AddEmote("very good", strDir.."vg.ogg", 0.8, false)
GM:AddEmote("thank you", strDir.."ty.ogg", 0.8, false)
GM:AddEmote("i'm sorry", strDir.."sorry.ogg", 1, false)
GM:AddEmote("you, you", strDir.."youyou.ogg", 2.5, false)
GM:AddEmote("delete this", strDir.."deldis.ogg", 4, false)
GM:AddEmote("never", "vo/citadel/eli_nonever.wav", 1, false)
GM:AddEmote("open the gate!", "vo/streetwar/barricade/male01/c17_05_opengate.wav", 2, false)
GM:AddEmote("rest my child", "vo/ravenholm/monk_kill03.wav", 2.5, false)
GM:AddEmote("rofl", "vo/citadel/br_laugh01.wav", 2.5, false)
GM:AddEmote("run", "vo/npc/male01/strider_run.wav", 2, false)
GM:AddEmote("shit", "vo/npc/barney/ba_ohshit03.wav", 1, false)
GM:AddEmote("sorry", "vo/npc/male01/sorry01.wav", 1, false)
GM:AddEmote("that's my girl", "vo/citadel/eli_mygirl.wav", 2, false)
GM:AddEmote("what the hell", "vo/k_lab/ba_whatthehell.wav", 1.5, false)
GM:AddEmote("you fool", "vo/citadel/br_youfool.wav", 1.5, false)
GM:AddEmote("yeah", "vo/npc/male01/yeah02.wav", 1, false)
GM:AddEmote("is this touhou?", strDir.."itth.ogg", 1, false)
GM:AddEmote("holy shit what a fucking disappointment", strDir.."hswafd.ogg", 2.7, false)
GM:AddEmote("hey moe", strDir.."heymoe.ogg", 1, false)
GM:AddEmote("duki nuki", strDir.."dukinuki.ogg", 1, false)
GM:AddEmote("i'm playing minecraft", strDir.."minecraft.ogg", 4, true)
GM:AddEmote("sometimes i dream about cheese", "vo/npc/male01/question06.wav", 3, false)
GM:AddEmote("like that?", "vo/npc/male01/likethat.wav", 1, false)
GM:AddEmote("i'm thinking i'm thinking", "vo/trainyard/ba_thinking01.wav", 2.5, false)
GM:AddEmote("this is my third transfer this year", "vo/trainyard/male01/cit_term_ques02.wav", 3, false)
GM:AddEmote("rambling", "vo/trainyard/cit_pacing.wav", 8, true)
GM:AddEmote("i'm not even gonna tell you what that reminds me of", "vo/npc/male01/question14.wav", 4, false)
GM:AddEmote("it is i", "vo/ravenholm/engage06.wav", 3, false)
GM:AddEmote("something must be wrong with me i almost understood that", "vo/npc/male01/vanswer10.wav", 4, false)
GM:AddEmote("so this is the combine portal", "vo/NovaProspekt/eli_thisisportal.wav", 4, false)
GM:AddEmote("right on", "vo/npc/male01/answer32.wav", 1, false)
GM:AddEmote("did you hear a cat just now?", "vo/streetwar/sniper/ba_hearcat.wav", 3, false)
GM:AddEmote("he's done this before he'll be ok", "vo/npc/male01/gordead_ans18.wav", 4, false)
GM:AddEmote("they'll get you started on the right foot", "vo/canals/boxcar_lookout_d.wav", 4, false)
GM:AddEmote("grenade", "vo/npc/barney/ba_grenade01.wav", 2, false)
GM:AddEmote("i'll come find you", "vo/k_lab/ba_getoutofsight02.wav", 3, false)
GM:AddEmote("they're looking for your car", "vo/coast/barn/male01/chatter.wav", 3, false)
GM:AddEmote("where art thou brother", "vo/ravenholm/monk_coverme07.wav", 3, false)
GM:AddEmote("gee thanks", "vo/k_lab/ba_geethanks.wav", 2, false)
GM:AddEmote("it's a party", "bot/its_a_party.wav", 1.5, false)
GM:AddEmote("and if you see dr. breen tell him i said fuck you", "vo/Streetwar/rubble/ba_tellbreen.wav", 7, false)
GM:AddEmote("how did you get in here?", "vo/k_lab/br_tele_05.wav", 3, false)
GM:AddEmote("i can't look", "vo/k_lab/ba_cantlook.wav", 2, false)
GM:AddEmote("i'm not a betting man but the odds are not good", "vo/npc/male01/question21.wav", 5, false)
GM:AddEmote("i couldn't have asked for a finer volunteer", "vo/coast/odessa/nlo_cub_volunteer.wav", 4, false)
GM:AddEmote("how came you here brother", "vo/ravenholm/wrongside_howcome.wav", 4, false)
GM:AddEmote("lead the way", "vo/npc/male01/leadtheway02.wav", 2, false)
GM:AddEmote("out of my way", "vo/ravenholm/monk_blocked01.wav", 3, false)
GM:AddEmote("gtfo", "vo/npc/male01/gethellout.wav", 4, false)
GM:AddEmote("dear me", "vo/k_lab/kl_dearme.wav", 1, false)
GM:AddEmote("i hope you said your farewells", "vo/Citadel/br_mock09.wav", 4, false)
GM:AddEmote("forget about that thing", "vo/k_lab/ba_forgetthatthing.wav", 4, false)
GM:AddEmote("this is my house", "bot/this_is_my_house.wav", 3, false)
GM:AddEmote("for the dead know no sleep in their graves", "vo/ravenholm/monk_rant12.wav", 8, false)
GM:AddEmote("cover me brother", "vo/ravenholm/monk_coverme01.wav", 3, false)
GM:AddEmote("so again i am alone", "vo/ravenholm/monk_mourn03.wav", 4, false)
GM:AddEmote("you need me", "vo/Citadel/br_youneedme.wav", 3, false)
GM:AddEmote("dibs on the suit", "vo/npc/male01/gordead_ans16.wav", 3, false)
GM:AddEmote("careful", "vo/k_lab/ba_careful01.wav", 1.5, false)
GM:AddEmote("shut up", "vo/npc/male01/answer17.wav", 3, false)
GM:AddEmote("some things i just never get used to", "vo/npc/male01/vquestion02.wav", 4, false)
GM:AddEmote("conditions could hardly be more ideal", "vo/k_lab/kl_moduli02.wav", 3, false)
GM:AddEmote("i'm pretty sure this isn't part of the plan", "vo/npc/male01/question11.wav", 4, false)
GM:AddEmote("fantastic", "vo/npc/male01/fantastic01.wav", 1, false)
GM:AddEmote("i don't feel anything anymore", "vo/npc/male01/question18.wav", 3, false)
GM:AddEmote("one for me and one for me", "vo/npc/male01/oneforme.wav", 5, false)
GM:AddEmote("draw forth a sword and sheathe it in those that afflict me", "vo/ravenholm/monk_rant19.wav", 7, false)
GM:AddEmote("although they call me crazy i care not", "vo/ravenholm/monk_rant04.wav", 10, false)
GM:AddEmote("you feel it? i feel it", "vo/npc/male01/question17.wav", 3, false)
GM:AddEmote("what's the meaning of this?", "vo/k_lab/br_tele_02.wav", 4, false)
GM:AddEmote("did i not tell you to seek the church", "vo/ravenholm/wrongside_seekchurch.wav", 6, false)
GM:AddEmote("woah deja vu", "vo/npc/male01/question05.wav", 3, false)
GM:AddEmote("let's even the odds a little", "vo/npc/male01/evenodds.wav", 4, false)
GM:AddEmote("lmao", "vo/Citadel/br_laugh01.wav", 4, false)
GM:AddEmote("enough of your bullshit", "vo/novaprospekt/al_enoughbs01.wav", 3, false)
GM:AddEmote("dr. freeman can you hear me? do not go in to the light", "vo/npc/male01/gordead_ques15.wav", 7, false)	
GM:AddEmote("now what?", "vo/npc/male01/gordead_ans01.wav", 2, false)
GM:AddEmote("no!", "vo/Citadel/br_failing11.wav", 1, false)
GM:AddEmote("got one", "vo/npc/male01/gotone01.wav", 2.5, false)
GM:AddEmote("scanners", "vo/npc/male01/scanners01.wav", 2, false)
GM:AddEmote("that's what you said last time", "vo/k_lab/ba_saidlasttime.wav", 3, false)
GM:AddEmote("ah it is you brother", "vo/ravenholm/attic_apologize.wav", 3, false)
GM:AddEmote("tmi", "vo/npc/female01/answer26.wav", 3, false)
GM:AddEmote("okay", "vo/npc/male01/ok01.wav", 1, false)
GM:AddEmote("watch out", "vo/npc/male01/watchout.wav", 1.5, false)
GM:AddEmote("who are you?", "vo/k_lab/br_tele_03.wav", 2, false)
GM:AddEmote("let me end your torment", "vo/ravenholm/engage05.wav", 4, false)
GM:AddEmote("you have already met my congregation", "vo/ravenholm/cartrap_iamgrig.wav", 8, false)
GM:AddEmote("behind you", "vo/npc/male01/behindyou01.wav", 2, false)
GM:AddEmote("why go on?", "vo/npc/male01/gordead_ans13.wav", 3, false)
GM:AddEmote("don't drink the water", "vo/trainyard/cit_water.wav", 10, false)
GM:AddEmote("uh oh", "vo/npc/male01/uhoh.wav", 1, false)
GM:AddEmote("take this medkit", "vo/npc/male01/health01.wav", 2, false)
GM:AddEmote("you got it", "vo/npc/male01/yougotit02.wav", 2, false)
GM:AddEmote("here goes nothing", "vo/npc/male01/squad_affirm06.wav", 2, false)
GM:AddEmote("guard yourself well", "vo/ravenholm/bucket_guardwell.wav", 3, false)
GM:AddEmote("good luck out there", "vo/canals/matt_goodluck.wav", 4, false)
GM:AddEmote("what now?", "vo/npc/male01/gordead_ques16.wav", 2, false)
GM:AddEmote("god damn you breen", "vo/citadel/eli_damnbreen.wav", 4, false)
GM:AddEmote("over here brother", "vo/ravenholm/monk_coverme03.wav", 3, false)
GM:AddEmote("you sure?", "vo/npc/male01/answer37.wav", 1, false)
GM:AddEmote("down you go", "vo/npc/Barney/ba_downyougo.wav", 2.5, false)
GM:AddEmote("flee brother", "vo/ravenholm/exit_nag01.wav", 2, false)
GM:AddEmote("cp", "vo/npc/male01/civilprotection01.wav", 2, false)
GM:AddEmote("good now keep it close", "vo/ravenholm/shotgun_keepitclose.wav", 5, false)
GM:AddEmote("aim for the head", "vo/ravenholm/aimforhead.wav", 3, false)
GM:AddEmote("what's the password?", "vo/Streetwar/tunnel/male01/c17_06_password02.wav", 3, false)
GM:AddEmote("i can see your mit education really pays for itself", "vo/k_lab/ba_sarcastic03.wav", 5, false)
GM:AddEmote("take cover", "vo/npc/male01/takecover02.wav", 1, false)
GM:AddEmote("i can't remember the last time i had a shower", "vo/npc/male01/question19.wav", 3, false)
GM:AddEmote("good boy", "vo/k_lab2/al_goodboy.wav", 1.5, false)
GM:AddEmote("woe to thee", "vo/ravenholm/monk_kill01.wav", 2, false)
GM:AddEmote("oops", "vo/npc/male01/whoops01.wav", 1, false)
GM:AddEmote("don't act dumb", strDir.."dontactdumb.ogg", 2, false)
GM:AddEmote("silly bitch, your weapons cannot harm me", strDir.."cannotharm.ogg", 5, false)
GM:AddEmote("wrrry", strDir.."wrrry.ogg", 3, false)
GM:AddEmote("wrrryyyy", strDir.."wryyyy.ogg", 5, false)
GM:AddEmote("i'm the juggernaut, bitch", strDir.."juggernaut.ogg", 3, false)
GM:AddEmote("evil", strDir.."evil.ogg", 4, false)
GM:AddEmote("every villain is lemons", strDir.."everyvillain.ogg", 5, false)
GM:AddEmote("another one", strDir.."anotherone.ogg", 2, false)
GM:AddEmote("i'm going to jail", strDir.."igtj.ogg", 3, false)
GM:AddEmote("damn, it's that invisible bitch again", strDir.."ditiba.ogg", 4, false)
GM:AddEmote("no more mister nice guy", strDir.."oknmbmng.ogg", 5, true)
GM:AddEmote("money money money", strDir.."moneymoneymoney.ogg", 3, false)
GM:AddEmote("loadsamoney", strDir.."lodsamone.ogg", 3, false)
GM:AddEmote("it's raining money", strDir.."irm.ogg", 3, false)
GM:AddEmote("get out of here stalker", strDir.."goohs.ogg", 3, false)
GM:AddEmote("kono dio da", strDir.."konodioda.ogg", 2, false)
GM:AddEmote("ree", strDir.."ree.ogg", 3, false)
GM:AddEmote("you fuckers", strDir.."yf.ogg", 3.5, false)
GM:AddEmote("esketit", strDir.."esketit.ogg", 2, false)
GM:AddEmote("a lie will remain a lie", strDir.."alie.ogg", 4, false)
GM:AddEmote("a dud", strDir.."adud.ogg", 1.5, false)
GM:AddEmote("only the chosen may survive", strDir.."otcms.ogg", 3, false)
GM:AddEmote("fast food", strDir.."fastfood.ogg", 1.5, false)
GM:AddEmote("seymour", strDir.."seymour.ogg", 2.5, false)
GM:AddEmote("steamed hams", strDir.."steamedhams.ogg", 2, false)
GM:AddEmote("aurora borealis", strDir.."aurora.ogg", 2, false)
GM:AddEmote("me, me", strDir.."me.ogg", 1.5, false)
GM:AddEmote("squak", strDir.."squak.ogg", 1, true)
GM:AddEmote("pumparum", strDir.."pumparum.ogg", 1, false)
GM:AddEmote("picklepee", strDir.."picklepee.ogg", 1, false)
GM:AddEmote("you fucked up my face", strDir.."yfumf.ogg", 1.25, false)
GM:AddEmote("that's it, i'm getting me mallet", strDir.."mallet.ogg", 2, false)
GM:AddEmote("oh yes daddy", strDir.."oyd.ogg", 1.5, false)
GM:AddEmote("destroy him", strDir.."destroyhim.ogg", 1.2, false)
GM:AddEmote("woah", strDir.."woah.ogg", 0.8, false)
GM:AddEmote("i want drugs now", strDir.."drugs.ogg", 1.25, false)
GM:AddEmote("kermit", strDir.."kermit.ogg", 4, true)



--custom networking functions
--net read/write datatable
--purpose: to easily and efficiently write tables to the network string
--input: tbl - table to be sent, OnlyInput - sets if this is the only item being sent, bytes - number of bytes to read if OnlyInput is set
function net.WriteDataTable(tbl, OnlyInput)
	if tbl and istable(tbl) then
		local strTbl = util.TableToJSON(tbl)
		local dTbl = util.Compress(strTbl)
		if dTbl then
			local bytes = #dTbl
			if not OnlyInput then
				net.WriteUInt(bytes, 16)
				net.WriteData(dTbl, bytes)
			else
				net.WriteData(dTbl, bytes)
			end
		end
	end
end

function net.ReadDataTable(bytes)
	if bytes then
		local dInfo = net.ReadData(bytes)
		if dInfo then
			local strInfo = util.Decompress(dInfo)
			if strInfo then
				local tInfo = util.JSONToTable(strInfo)
				return tInfo
			end
		end
	else
		local bytes = net.ReadUInt(16)
		if bytes then
			local dInfo = net.ReadData(bytes)
			if dInfo then
				local strInfo = util.Decompress(dInfo)
				if strInfo then
					local tInfo = util.JSONToTable(strInfo)
					return tInfo
				end
			end
		end
	end
end

--net read/write CString
--purpose: efficiently network string between client/server (can be approx 3x more efficient)

function net.WriteCString(str, OnlyInput)
	local data = util.Compress(str)
	if data then
		local bytes = #data
		if not OnlyInput then
			net.WriteUInt(bytes, 16)
			net.WriteData(data, bytes)
		else
			net.WriteData(data, bytes)
		end
	end
end

function net.ReadCString(bytes)
	if bytes then
		local dInfo = net.ReadData(bytes)
		if dInfo then
			local strInfo = util.Decompress(dInfo)
			return strInfo
		end
	else
		local bytes = net.ReadUInt(16)
		if bytes then
			local dInfo = net.ReadData(bytes)
			if dInfo then
				local strInfo = util.Decompress(dInfo)
				return strInfo
			end
		end
	end
end

--rewrite chatprint
--purpose: to make chatprint much more efficient for networking
local meta = FindMetaTable("Player")
local fChatPrint = meta.ChatPrint --store this in case we need it later...
if SERVER then
	util.AddNetworkString("zs_chatprint")
end

function meta:ChatPrint(str)
	local str = tostring(str)
	if str then
		if CLIENT then --if this is ran shared we want to avoid networking anything
			chat.AddText(color_white, str)
		else
			net.Start("zs_chatprint")
				net.WriteCString(str, true)
			net.Send(self)
		end
	end
end

if CLIENT then
	net.Receive("zs_chatprint", function(ln)
		local str = net.ReadCString(ln / 8)
		if str then
			chat.AddText(color_white, str)
		end
	end)
end

--achievements, shared since we want menus

GM.Achievements = {}
--enumerations
ACHIEVEMENT_ACTION = 0
ACHIEVEMENT_PROGRESS = 1
ACHIEVEMENT_TIERED_PROGRESS = 2

--TODO: move this shared so achievement menus can work
function GM:InitializeAchievement(name, itype, desc, limit, tiers, secret) --name, itype, limit for linear progress, tiered for tiered progress, secret = hide until unlocked
	self.Achievements[name] = {type = itype, hidden = secret}
	local a = self.Achievements[name]
	if tiers then
		a.tiers = tiers
	elseif limit then
		a.limit = limit
	end

	a.desc = desc
end

--initalize achievements here... comment out ones that arent being used so they dont populate the menu
GM:InitializeAchievement("First words...", ACHIEVEMENT_ACTION, "Type in chat for the first time!")
--GM:InitializeAchievement("Type in chat 5 times", ACHIEVEMENT_PROGRESS, 5)
GM:InitializeAchievement("Chat Master", ACHIEVEMENT_TIERED_PROGRESS, "Type in chat!", nil, {{limit = 100, name = "Typist"}, {limit = 500, name = "Keyboard warrior"}, {limit = 1000, name = "Essay writer"}, {limit = 10000, name = "Spammer"}})
GM:InitializeAchievement("Medical Training", ACHIEVEMENT_TIERED_PROGRESS, "Heal other players!", nil, {{limit = 1000, name = "Pain relief"}, {limit = 10000, name = "Saw bones"}, {limit = 100000, name = "Heal slut"},
{limit = 1000000, name = "DOKTOR!"}})
GM:InitializeAchievement("Crafter", ACHIEVEMENT_PROGRESS, "Craft items!", 50)
GM:InitializeAchievement("Zombie Master", ACHIEVEMENT_TIERED_PROGRESS, "Kill humans as zombie!", nil,
{{limit = 10, name = "Taste of blood"}, {limit = 100, name = "Taste of flesh"}, {limit = 1000, name = "Undead horde"}, {limit = 2000, name = "Undead march"}, {limit = 5000, name = "Undead army"}, {limit = 10000, name = "Undead takeover"}})
GM:InitializeAchievement("Zombie Slayer", ACHIEVEMENT_TIERED_PROGRESS, "Kill zombies as human!", nil,
{{limit = 100, name = "Zombie hunter"}, {limit = 1000, name = "Zombie killer"}, {limit = 10000, name = "Zombie grinder"}, {limit = 50000, name = "Zombie slayer"}})
GM:InitializeAchievement("The bigger they are...", ACHIEVEMENT_ACTION, "Kill a boss zombie!")
GM:InitializeAchievement("...The harder they fall", ACHIEVEMENT_PROGRESS, "Kill 50 boss zombies!", 50)
GM:InitializeAchievement("Headhunter", ACHIEVEMENT_TIERED_PROGRESS, "Get headshots on zombies!", nil,
{{limit = 50, name = "Headpopper"}, {limit = 150, name = "Bloody mist"}, {limit = 300, name = "Flying giblets"}, {limit = 500, name = "Headless zombies"}, {limit = 1000, name = "Marksman"}})
GM:InitializeAchievement("Melee Mayhem", ACHIEVEMENT_TIERED_PROGRESS, "Get kills with melee!", nil,
{{limit = 10, name = "If all else fails..."}, {limit = 50, name = "Pulverizer"}, {limit = 100, name = "Swordsman"}, {limit = 1000, name = "Knight"}, {limit = 10000, name = "UNDEAD SOULS"}})
GM:InitializeAchievement("Stoner", ACHIEVEMENT_PROGRESS, "Get 10 kills with stone!", 10)
GM:InitializeAchievement("Fister", ACHIEVEMENT_PROGRESS, "Get 50 kills with fists!", 50)
GM:InitializeAchievement("Carpenter", ACHIEVEMENT_TIERED_PROGRESS, "Repair barricades!", nil, 
{{limit = 100, name = "I'm helping!"}, {limit = 5000, name = "Built to Last"}, {limit = 10000, name = "If it ain't broke..."}, {limit = 50000, name = "...Don't Fix it"}, {limit = 100000, name = "Handyman"}, {limit = 500000, name = "Carpenter"}})
GM:InitializeAchievement("Salesman", ACHIEVEMENT_TIERED_PROGRESS, "Sell stuff from arsenal crates!", nil,
{{limit = 100, name = "Lemonade stand"}, {limit = 1000, name = "Just the essentials"}, {limit = 5000, name = "Supplier"}, {limit = 10000, name = "Trade routes"}, {limit = 50000, name = "Economist"}, {limit = 100000, name = "Master Salesman"}})
GM:InitializeAchievement("Pilot", ACHIEVEMENT_PROGRESS, "Get 100 kills with manhacks!", 100)
GM:InitializeAchievement("Survivalist", ACHIEVEMENT_TIERED_PROGRESS, "Win games of Zombie Survival as a human!", nil,
{{limit = 1, name = "First time for everything"}, {limit = 10, name = "We're safe... for now"}, {limit = 50, name = "Fighting strength"}, {limit = 100, name = "Prepared"}, {limit = 1000, name = "Survivalist"}})
GM:InitializeAchievement("Beam me up Scotty!", ACHIEVEMENT_PROGRESS, "Use a teleporter 50 times!", 50)
--GM:InitializeAchievement("Force of Nature", ACHIEVEMENT_ACTION, "Kill every human as a zombie! (16 or more players)")
--[[
GM:InitializeAchievement("Darwin Award", ACHIEVEMENT_PROGRESS, "Die to a trigger_hurt entity 30 times!", 30)

GM:InitializeAchievement("Novelist", ACHIEVEMENT_PROGRESS, "Write 1000 characters worth of text using message beacons!", 1000)
GM:InitializeAchievement("Graffiti Artist", ACHIEVEMENT_PROGRESS, "Spray your logo 100 times!", 100)
GM:InitializeAchievement("Champion", ACHIEVEMENT_ACTION, "Kill a boss with a starting melee weapons!")
GM:InitializeAchievement("One Punch", ACHIEVEMENT_ACTION, "Kill a boss using your fists!")
GM:InitializeAchievement("Arsehole", ACHIEVEMENT_ACTION, "Destroy the humans' last arsenal crate as a zombie!")
GM:InitializeAchievement("Speed Run Life", ACHIEVEMENT_ACTION, "Join the zombie team before wave 0 ends!")
GM:InitializeAchievement("Potato", ACHIEVEMENT_ACTION, "Buy every return!")
GM:InitializeAchievement("Tinnitus", ACHIEVEMENT_PROGRESS, "Play emotes 100 times!", 100)
GM:InitializeAchievement("Emotional", ACHIEVEMENT_ACTION, "Play every emote at least once!")
GM:InitializeAchievement("Odysseus", ACHIEVEMENT_PROGRESS, "Blind 10 humans as Poison Headcrab", 10)
GM:InitializeAchievement("Clutch", ACHIEVEMENT_ACTION, "Win a round of Zombie Survival as the Last Human (16 or more players)")
GM:InitializeAchievement("Abortion Clinic", ACHIEVEMENT_TIERED_PROGRESS, "Kill 50 Gore Child zombies", nil,
{{limit = 10, name = "Abortionist in Training"}, {limit = 25, name = "Intermediate Abortionist"}, {limit = 50, name = "Trained Abortionist"}, {limit = 100, name = "12 Hour Abortion Clinic"}, {limit = 250, name = "24/7 Abortion Clinic"}})
GM:InitializeAchievement("Objective: Survive", ACHIEVEMENT_PROGRESS, "Play any objective map a total of 50 times!", 50)
GM:InitializeAchievement("Watery Grave", ACHIEVEMENT_PROGRESS, "Die to water 10 times!", 10)
GM:InitializeAchievement("HERESY", ACHIEVEMENT_PROGRESS, "Die to fire 10 times!", 10)
GM:InitializeAchievement("Demolitionist", ACHIEVEMENT_TIERED_PROGRESS, "Deal damage using explosives!")
GM:InitializeAchievement("Undead Souls", ACHIEVEMENT_PROGRESS, "Absorb 50 souls!", 50)
GM:InitializeAchievement("Who made this map?", ACHIEVEMENT_ACTION, "Play any map made by Zetanor")
GM:InitializeAchievement("Pinpoint", ACHIEVEMENT_PROGRESS, "Kill 75 headcrabs with rifles", 75)
GM:InitializeAchievement("Left 4 Dead", ACHIEVEMENT_ACTION, "Get killed by a trigger_hurt entity on any objective map!")
GM:InitializeAchievement("Caw", ACHIEVEMENT_ACTION, "Kill another crow as a crow!")
--]]

--zpoints helper functions
--we'll need to be able to access their variables easily
local meta = FindMetaTable("Player")

function meta:GetZTraitTable(zclass)
	if self:IsBot() then return end
	local class = zclass or GAMEMODE.ZombieClasses[self:GetZombieClass()].Name

	if self.ZDataTable[class] then
		return self.ZDataTable[class]
	else
		self.ZDataTable[class] = {}
		return self.ZDataTable[class]
	end
end

function meta:SetZTrait(class, trait, bEnabled)
	if self:IsBot() then return end
	if not class and trait then return end
	local tData = self.ZDataTable
	if not tData then return end
	
	if not tData[class] then
		tData[class] = {}
	end

	tData[class][trait] = bEnabled
end

function meta:GetZTraitCurrent(trait)
	return self:GetZTrait(self:GetZombieClassTable().Name, trait)
end

function meta:GetZTrait(class, trait)
	if self:IsBot() then return end
	if not class and trait then return end
	local tData = self.ZDataTable
	if not tData then return end
	
	if not tData[class] then
		tData[class] = {}
	end

	return tData[class][trait]
end

function GetZTraitInfo(class, trait)
	if not class and trait then return end
	local class = GAMEMODE.ZombieClasses[class]
	if class then
		if class.ZTraits then
			return class.ZTraits[trait]
		end
	end
end

--We have worldstate traits too, stuff that affects the round as a whole but not everything else
GM.ZTraits = {
	["dark"] = {safename = "Cover of Night", cost = 800, desc = "Shrouds the map with darkness for 3 minutes", callback = function() end},
	["boss"] = {safename = "Forceboss", cost = 1000, desc = "Spawns a boss for the Undead", callback = function() end}


}

--purpose: store LH music in an sequential table shared so we can save on networking

--shared enums for table indexing
--LH_NAME = 1
--LH_TRACKNAME = 2
--LH_IMGURL = 3
--LH_FILESYSTEM = 4
--LH_DISABLED = 5

GM.LHMusic = {}
GM.LHTracks = 0
--TODO: Setup stream caching for images OR precache with Material(img)
function GM:AddLHMusic(name, filename, img, bFileSystem, bDisabled)
	self.LHTracks = self.LHTracks + 1
	if not bDisabled then
		self.LHMusic[self.LHTracks] = {name, filename, img, bFileSystem}
	end
end

GM:AddLHMusic("Thunder Force 4 - Lightning Strikes Again", "tf4-lsa.ogg", "tf4.png")
GM:AddLHMusic("Touhou - Septette for the Dead Princess (Remix)", "touhou-eosd-septette.ogg", "touhou-eosd.png")
GM:AddLHMusic("Touhou - Nuclear Fusion (Remix)", "touhou-11-nuclearfusion.ogg", "touhou-11sa.png")
GM:AddLHMusic("Touhou - Necrofantasia (Remix)", "touhou-necrofantasia.ogg", "touhou-7pcb.png")
GM:AddLHMusic("Touhou - Drunk as I Like (Remix)", "touhou-drunk.ogg", "touhou-swr.png")
GM:AddLHMusic("Touhou - Bad Apple (Remix)", "touhou-badapple.ogg", "touhou-lls.png")
GM:AddLHMusic("Touhou - U.N. Owen was Her? (Remix)", "touhou-unowen.ogg", "touhou-eosd.png")
GM:AddLHMusic("Fist of the North Star - Main Theme (Remix)", "fotns.ogg", "fotns.png")
GM:AddLHMusic("Dark Souls 3 - Slave Knight Gael (Remix)", "ds3-skg.ogg", "ds3.png")
GM:AddLHMusic("Dark Souls - Ornstein & Smough (Remix)", "ds-os.ogg", "ds.png")
GM:AddLHMusic("Bloodborne - Father Gascoigne (Remix)", "bb-fg.ogg", "bloodborne.png")
GM:AddLHMusic("Demon's Souls - Maiden Astrea (Remix)", "des-ma.ogg", "des.png")
GM:AddLHMusic("Alternate Last Human Music", "altlh.ogg", "zs.png") --alternate LH music I see many ZS servers using
GM:AddLHMusic("Dark Souls 3 - Lorian, Elder Prince; Lothric, Younger Prince", "ds3-leplyp.ogg", "ds3.png")
GM:AddLHMusic("Dark Souls 3 - Soul of Cinder", "ds3-soc.ogg", "ds3.png")
GM:AddLHMusic("Darkest Dungeon - The Final Combat", "dd-tfc.ogg", "dd.png")
GM:AddLHMusic("Spongebob - Jellyfish Jam", "jellyjam.ogg", "sponge.png") --we need atleast one meme song
GM:AddLHMusic("Bloodborne - Ludwig the Accursed", "bb-lta.ogg", "bloodborne.png")
GM:AddLHMusic("JoJo's Bizzare Adventure - Awaken", "jjba-awaken.ogg", "jojo.png")
GM:AddLHMusic("JoJo's Bizzare Adventure - Propaganda", "jjba-propaganda.ogg", "jojo.png")
GM:AddLHMusic("Deus Ex - Enemy Within", "de-ew.ogg", "deusex.png")
GM:AddLHMusic("Chrono Trigger - World Revolution", "ct-wr.ogg", "ct.png")
GM:AddLHMusic("Chrono Trigger - Last Battle", "ct-lb.ogg", "ct.png")
GM:AddLHMusic("Chrono Trigger - Boss Battle 1", "ct-bb1.ogg", "ct.png")
GM:AddLHMusic("Chrono Trigger - Boss Battle 2", "ct-bb2.ogg", "ct.png")
GM:AddLHMusic("Destiny - Last Stand", "dest-ls.ogg", "destiny.png")
GM:AddLHMusic("Blue Exorcist - Track 7", "fma-exorcist.ogg", "be.png")
GM:AddLHMusic("S.T.A.L.K.E.R. - Bandit Radio", "stalk-banditradio.ogg", "stalker.png")
GM:AddLHMusic("JoJo's Bizzare Adventure - Avalon", "jojo-avalon.ogg", "jojo.png")
GM:AddLHMusic("Carpenter Brut - Turbo Killer", "cb-tk.ogg", "carpenter.png")
GM:AddLHMusic("Touhou - Lunatic Eyes", "touhou-lunatic.ogg", "touhou-8in.png")
GM:AddLHMusic("Touhou - The Pierrot of the Star-Spangled Banner", "touhou-tpotssb.ogg", "touhou-lolk.png")
GM:AddLHMusic("Touhou - Faraway 380,000-Kilometer Voyage", "touhou-380k.ogg", "touhou-lolk.png")
GM:AddLHMusic("Dragon Age: Origins - Grey Warden", "dao-gw.ogg", "dao.png")
GM:AddLHMusic("Doom - E1M1", "doom-e1m1.ogg", "doom.png")
GM:AddLHMusic("Doom (2016) - Demons to the Ground", "doom16-dttg.ogg", "d44m.png")
GM:AddLHMusic("Doom (2016) - Argent Combat", "doom16-argentcombat.ogg", "d44m.png")
GM:AddLHMusic("Doom (2016) - BFG Division", "doom16-bfg.ogg", "d44m.png")
GM:AddLHMusic("SCP: Containment Breach - Bump in the Night", "scpcb-bitn.ogg", "scp.png")
GM:AddLHMusic("Killing Floor - Abandon All", "kf-abandonall.ogg", "kf.png")
GM:AddLHMusic("LISA - Highway 88", "lisa-hw88.ogg", "lisa.png")
GM:AddLHMusic("LISA - Noisemaker", "lisa-noisemaker.ogg", "lisa.png")
GM:AddLHMusic("Timesplitters 2 - Site", "ts2-site.ogg", "ts2.png")
GM:AddLHMusic("Timesplitters 2 - Nightclub", "ts2-nightclub.ogg", "ts2.png")
GM:AddLHMusic("Timesplitters 2 - Notre Dame Boss", "ts2-notredame.ogg", "ts2.png")
GM:AddLHMusic("Saints Row IV - The Warden Arrival", "sr4-warden.ogg", "sr4.png")
GM:AddLHMusic("Saints Row IV - Zinyak (Bass Theme)", "sr4-vinyak.ogg", "sr4.png")
GM:AddLHMusic("Hotline Miami 2 - Acid Spit", "hm2-acidspit.ogg", "hm2.png")
GM:AddLHMusic("Touhou - Flowering Night (Remix)", "touhou9-fn.ogg", "touhou-9pofv.png")
GM:AddLHMusic("Touhou - Love-Colored Master Spark (Remix)", "touhou8-lcms.ogg", "touhou-8in.png")
GM:AddLHMusic("Demon's Souls - Tower Knight", "des-towerknight.ogg", "des.png")
GM:AddLHMusic("Dark Souls - Taurus Demon", "ds-taurusdemon.ogg", "ds.png")
GM:AddLHMusic("Metal Arms - Hold Your Ground", "ma-hyg.ogg", "ma.png")
GM:AddLHMusic("Metallica - For Whom The Bell Tolls (Instrumental)", "belltollsmetallica.ogg", "ridethelightning.png")
GM:AddLHMusic("Return Of The Living Dead (Main Theme)", "returnofdeadtheme.ogg", "returnoflivingdead.png")
GM:AddLHMusic("How It's Made - Main Theme (Remix) ", "howitsmadedeepfried.ogg", "howitsimg.png")
GM:AddLHMusic("Pendulum - Self vs. Self", "pen-selfvself.ogg", "pendulum.png")
GM:AddLHMusic("Pendulum - Witchcraft", "pen-witchcraft.ogg", "pendulum.png")
GM:AddLHMusic("Pendulum - Midnight Runner", "pen-midnightrunner.ogg", "pendulum.png")
GM:AddLHMusic("Killing Floor 2 - Collapsing", "kf2-collapsing.ogg", "kf2.png")
GM:AddLHMusic("Killing Floor 2 - This I Know", "kf2-thisiknow.ogg", "kf2.png")
GM:AddLHMusic("Trance - 009 Sound System Dreamscape", "trance009.ogg", "trance009img.png")
GM:AddLHMusic("Bird Astley - Never Gonna Give You Points", "nevergonnagiveyoupoints.ogg", "doom.png")
--NOTE: i want to release new tracks as a block later on, so any new tracks please leave commented beyond this point, plus some might not be finished

--half-life
local strFS = "sound/music/" -- instead of retyping it, here it is
GM:AddLHMusic("Half-Life 2 - Apprehension and Evasion", strFS.."hl2_song29.mp3", "hl2.png", true)
GM:AddLHMusic("Half-Life 2 - Combine Harvester", "hl2-charvester.ogg", "hl2.png") --doesnt exist in HL2, use streamed version
GM:AddLHMusic("Half-Life 2 - Hard Fought", strFS.."hl2_song12_long.mp3", "hl2.png", true)
GM:AddLHMusic("Half-Life 2 - You're Not Supposed To Be Here", strFS.."hl2_song14.mp3", "hl2.png", true)
GM:AddLHMusic("Half-Life 2 - Tau-9", strFS.."hl1_song17.mp3", "hl2.png", true)
GM:AddLHMusic("Half-Life 2 - Nuclear Mission Jam", strFS.."hl1_song15.mp3", "hl2.png", true)
GM:AddLHMusic("Half-Life 2 - Hazardous Environments", "hl2-hev.ogg", "hl2.png") --cut short in HL2, use streamed version
GM:AddLHMusic("Half-Life 2 - Brane Scan", strFS.."hl2_song31.mp3", "hl2.png", true)
GM:AddLHMusic("Half-Life 2 - CP Violation", strFS.."hl2_song20_submix0.mp3", "hl2.png", true)

GM:AddLHMusic("Half-Life 2: Episode 1 - Disrupted Original", "ep1-disruptedoriginal.ogg", "hl2ep1.png")
GM:AddLHMusic("Half-Life 2: Episode 1 - Guard Down", "ep1-guarddown.ogg", "hl2ep1.png")
GM:AddLHMusic("Half-Life 2: Episode 1 - Penultimate", "ep1-penultimate.ogg", "hl2ep1.png")
GM:AddLHMusic("Half-Life 2: Episode 1 - Self Destruction", "ep1-selfdestruction.ogg", "hl2ep1.png")
GM:AddLHMusic("Half-Life 2: Episode 1 - What Kind of Hospital is This?", "ep1-whatkindofhospitalisthis.ogg", "hl2ep1.png")

GM:AddLHMusic("Half-Life 2: Episode 2 - Abandoned in Place", "ep2-abandonedinplace.ogg", "hl2ep2.png")
GM:AddLHMusic("Half-Life 2: Episode 2 - Crawl Yard", "ep2-crawlyard.ogg", "hl2ep2.png")
GM:AddLHMusic("Half-Life 2: Episode 2 - Eon Trap", "ep2-eontrap.ogg", "hl2ep2.png")
GM:AddLHMusic("Half-Life 2: Episode 2 - Hunting Party", "ep2-huntingparty.ogg", "hl2ep2.png")
GM:AddLHMusic("Half-Life 2: Episode 2 - Last Legs", "ep2-lastlegs.ogg", "hl2ep2.png")
GM:AddLHMusic("Half-Life 2: Episode 2 - No One Rides for Free", "ep2-nooneridesforfree.ogg", "hl2ep2.png")
GM:AddLHMusic("Half-Life 2: Episode 2 - Sector Sweep", "ep2-sectorsweep.ogg", "hl2ep2.png")
GM:AddLHMusic("Half-Life 2: Episode 2 - Vortal Combat", "ep2-vortalcombat.ogg", "hl2ep2.png")

--portal
GM:AddLHMusic("Portal 2 - Science is Fun", "p2-sciisfun.ogg", "p2.png")
GM:AddLHMusic("Portal 2 - Machiavellian Bach", "p2-mb.ogg", "p2.png")
GM:AddLHMusic("Portal 2 - The Courtesy Call", "p2-thecourtesycall.ogg", "p2.png")
GM:AddLHMusic("Portal 2 - Reconstructing More Science", "p2-reconmoresci.ogg", "p2.png")
GM:AddLHMusic("Portal 2 - Robots FTW", "p2-rftw.ogg", "p2.png")
GM:AddLHMusic("Portal 2 - The Part Where He Kills You", "p2-tpwhky.ogg", "p2.png")
GM:AddLHMusic("Portal 2 - You Will Be Perfect", "p2-perfect.ogg", "p2.png")

--classical/one blueshift track
GM:AddLHMusic("Richard Wagner - Ride Of The Valkyries", "rideofvalkyries.ogg", "classical.png")
GM:AddLHMusic("Samuel Barber - Adagio For Strings", "adagio.ogg", "classical.png")
GM:AddLHMusic("Half Life - Bust", "blueshiftbust.ogg", "hl1.png")
GM:AddLHMusic("Claude Debussy - Clair De Lune", "clairdelune.ogg", "classical.png")
GM:AddLHMusic("Erik Satie - Gymnopedie No.1", "gymnopedie.ogg", "classical.png")
--]]


--purpose: add new traceline/tracehull functionality
--returns a table if hit entities instead of a single entitiy
function util.EnumTraceLine(tInfo, iTries)
	if not iTries then iTries = 10 end
	local tEnts = {}
	for i = 1, iTries do
		local tr = util.TraceLine(tInfo)
		local ent = tr.Entity
		if ent and ent:IsValid() then
			tEnts[#tEnts+1] = ent
			if tInfo.filter then
				table.insert(tInfo.filter, ent)
			else
				tInfo.filter = {ent}
			end
		else
			break
		end
	end

	return tEnts
end

function util.EnumTraceHull(tInfo, iTries)
	if not iTries then iTries = 10 end
	local tEnts = {}
	for i = 1, iTries do
		local tr = util.TraceHull(tInfo)
		local ent = tr.Entity
		if ent and ent:IsValid() then
			tEnts[#tEnts+1] = ent
			if tInfo.filter then
				table.insert(tInfo.filter, ent)
			else
				tInfo.filter = {ent}
			end
		else
			break
		end
	end

	return tEnts
end


--purpose: some zs traits handlers

--helmet, reduced dmg from headcrabs
function Player:SetHelmet(onoff)
	self.m_Helmet = onoff
	if SERVER then
		self:SendLua("MySelf:SetHelmet("..tostring(onoff)..")")
	end
end

function Player:GetHelmet()
	return self.m_Helmet
end

--experienced, reduced recoil
function Player:SetExperienced(onoff)
	self.m_Experienced = onoff
end

function Player:GetExperienced()
	return self.m_Experienced
end

--deadeye, reduced spread
function Player:SetDeadeye(onoff)
	self.m_Deadeye = onoff
end

function Player:GetDeadeye()
	return self.m_Deadeye
end

--long arms, increased pickup range
function Player:SetLongArms(onoff)
	self.m_LongArms = onoff
	if SERVER then
		self:SendLua("MySelf:SetLongArms("..tostring(onoff)..")")
	end
end

function Player:GetLongArms()
	return self.m_LongArms
end

--this hook below deals with the long arm trait
local trace = {start = nil, endpos = nil, filter = nil}
hook.Add("FindUseEntity", "LongArmTrait", function(ply, default)
	if ply:GetLongArms() then
		local pos = ply:EyePos()
		local vAim = ply:GetAimVector()
		vAim:Mul(128)
		vAim:Add(pos)
		trace.start = pos
		trace.endpos = vAim
		trace.filter = player.GetAll()

		local tr = util.TraceLine(trace)
		local ent = tr.Entity
		if ent and ent:IsValid() then
			if string.StartWith(ent:GetClass(), "prop_") then
				return ent
			end
		end
	end
end)

--snake eyes, view items through walls
function Player:SetSnakeEyes(onoff)
	self.m_SnakeEyes = onoff
	if SERVER then
		self:SendLua("MySelf:SetSnakeEyes("..tostring(onoff)..")")
	end
end

function Player:GetSnakeEyes()
	return self.m_SnakeEyes
end

--bright light, additional damage to shade via flashlight

function Player:SetBrightLight(onoff)
	self.m_BrightLight = onoff
	if SERVER then
		self:SendLua("MySelf:SetBrightLight("..tostring(onoff)..")")
	end
end

function Player:GetBrightLight()
	return self.m_BrightLight
end

--socialism mode, to be moved into a special round eventually
GM.SharedPointsMode = false--util.SharedRandom("game.GetMap()", 0, 1, os.time()) < 0.5
GM.SharedPoints = 0

--client setup
if CLIENT then
	local function SharedPointsDraw()
		local w = w or ScrW()
		local col = col or team.GetColor(TEAM_HUMAN)
		if MySelf:Team() == TEAM_HUMAN then
			draw.SimpleText("Team Points: "..GAMEMODE.SharedPoints, "ZSHUDFontSmall", w / 2, 50, col, TEXT_ALIGN_CENTER)
		end
	end

	net.Receive("zs_sharedpointsync", function(ln, ply)
		local iPts = net.ReadUInt(16)
		GAMEMODE.SharedPoints = iPts
	end)

	net.Receive("zs_sharedpointsync", function(ln)
		hook.Add("HUDPaint", "DrawSharedPoints", SharedPointsDraw)

		local mPly = FindMetaTable("Player")
		function mPly:GetPoints()
			return GAMEMODE.SharedPoints
		end

		function mPly:SetPoints(iPts)
			GAMEMODE.SharedPoints = iPts
		end
	end)
end

hook.Add("PostGamemodeLoaded", "SocialismMode", function()
	--server
	if SERVER then
		if GAMEMODE.SharedPointsMode then
			local mPly = FindMetaTable("Player")
			util.AddNetworkString("zs_sharedpointsync")
			util.AddNetworkString("zs_sharedpointsactive")

			local function UpdateSharedPoints(ply)
				net.Start("zs_sharedpointsync")
					net.WriteUInt(GAMEMODE.SharedPoints, 16)
				if ply and ply:IsValid() then
					net.Send(ply)
				else
					net.Broadcast()
				end
			end

			function mPly:GetPoints()
				return GAMEMODE.SharedPoints
			end

			function mPly:SetPoints(iPts)
				GAMEMODE.SharedPoints = iPts
			end

			function mPly:AddPoints(iPts)
				self:AddFrags(iPts)
				GAMEMODE.SharedPoints = GAMEMODE.SharedPoints + iPts

				gamemode.Call("PlayerPointsAdded", self, points)
				UpdateSharedPoints()
			end

			function mPly:TakePoints(iPts)
				GAMEMODE.SharedPoints = GAMEMODE.SharedPoints - iPts

				UpdateSharedPoints()
			end

			hook.Add("PlayerInitialSpawn", "SharedPointUpdater", function(ply)
				if not ply:IsBot() then
					UpdateSharedPoints(ply)
					net.Start("zs_sharedpointactive")
					net.Send(ply)
				end
			end)
		end
	end
end)