GM.ZombieEscapeWeapons = {
	"cw_ze_deagle",
	"cw_ze_ak74",
	"cw_ze_ar15",
	"cw_ze_bizon",
	"cw_ze_mp5",
	"cw_ze_m3super90",
	"cw_ze_scout",
	"cw_ze_g3a3",
	"cw_ze_sks",
}

-- Change this if you plan to alter the cost of items or you severely change how Worth works.
-- Having separate cart files allows people to have separate loadouts for different servers.
GM.CartFile = "metrocart_v1.txt"

ITEMCAT_GUNS = 1
ITEMCAT_PISTOL = 2
ITEMCAT_SMG = 3
ITEMCAT_AR = 4
ITEMCAT_SHOTGUN = 5
ITEMCAT_RIFLE = 6
ITEMCAT_BR = 7
ITEMCAT_MG = 8
ITEMCAT_MELEE = 9
ITEMCAT_VANILLA = 10
ITEMCAT_VMELEE = 11
ITEMCAT_PULSE = 12
ITEMCAT_AMMO = 13
ITEMCAT_TOOLS = 14
ITEMCAT_OTHER = 15
ITEMCAT_TRAITS = 16
ITEMCAT_RETURNS = 17
ITEMCAT_ATT = 18

GM.ItemCategories = {
	[ITEMCAT_GUNS] = "CW 2.0 Weapons",
	[ITEMCAT_PISTOL] = "Pistols",
	[ITEMCAT_SMG] = "SMGs",
	[ITEMCAT_AR] = "Assault Rifles",
	[ITEMCAT_SHOTGUN] = "Shotguns",
	[ITEMCAT_RIFLE] = "Rifles",
	[ITEMCAT_BR] = "Battle Rifles",
	[ITEMCAT_MG] = "Machine Guns",
	[ITEMCAT_MELEE] = "CW 2.0 Melee",
	[ITEMCAT_VANILLA] = "Vanilla Weapons",
	[ITEMCAT_VMELEE] = "Vanilla Melee", 
	[ITEMCAT_PULSE] = "Pulse Weapons",
	[ITEMCAT_AMMO] = "Ammo",
	[ITEMCAT_TOOLS] = "Tools",
	[ITEMCAT_OTHER] = "Misc",
	[ITEMCAT_TRAITS] = "Traits",
	[ITEMCAT_RETURNS] = "Tourment",
	[ITEMCAT_ATT] = "Attachments"
}

GM.AmmoCategories = {
	[ITEMCAT_PISTOL] = "pistolammo",
	[ITEMCAT_SMG] = "smgammo",
	[ITEMCAT_AR] = "assaultrifleammo",
	[ITEMCAT_SHOTGUN] = "shotgunammo",
	[ITEMCAT_RIFLE] = "rifleammo",
	[ITEMCAT_BR] = "brammo",
	[ITEMCAT_MG] = "mgammo",
	[ITEMCAT_PULSE] = "pulseammo",
}

--[[
--for use with new arsenal...
ITEMCAT_GUNS = 1
ITEMCAT_AMMO = 2
ITEMCAT_MELEE = 3
ITEMCAT_TOOLS = 4
ITEMCAT_DEPLOYABLES = 5
ITEMCAT_TRINKETS = 6
ITEMCAT_OTHER = 7
ITEMCAT_TRAITS = 8
ITEMCAT_RETURNS = 9
ITEMCAT_ATT = 10

ITEMSUBCAT_TRINKETS_DEFENSIVE = 1
ITEMSUBCAT_TRINKETS_OFFENSIVE = 2
ITEMSUBCAT_TRINKETS_MELEE = 3
ITEMSUBCAT_TRINKETS_PERFORMANCE = 4
ITEMSUBCAT_TRINKETS_SUPPORT = 5
ITEMSUBCAT_TRINKETS_SPECIAL = 6

ITEMSUBCAT_GUNS_PISTOL = 1
ITEMSUBCAT_GUNS_SMG = 2
ITEMSUBCAT_GUNS_AR = 3
ITEMSUBCAT_GUNS_SHOTGUN = 4
ITEMSUBCAT_GUNS_MG = 5
ITEMSUBCAT_GUNS_BR = 6
ITEMSUBCAT_GUNS_RIF = 7

ITEMSUBCAT_MELEE_1HAND = 1
ITEMSUBCAT_MELEE_DAGGER = 2
ITEMSUBCAT_MELEE_POLEARM = 3
ITEMSUBCAT_MELEE_GS = 4
ITEMSUBCAT_MELEE_MISC = 5

GM.ItemCategories = {
	[ITEMCAT_GUNS] = "Guns",
	[ITEMCAT_AMMO] = "Ammunition",
	[ITEMCAT_MELEE] = "Melee",
	[ITEMCAT_TOOLS] = "Tools",
	[ITEMCAT_DEPLOYABLES] = "Deployables",
	[ITEMCAT_TRINKETS] = "Trinkets",
	[ITEMCAT_OTHER] = "Other"
}

GM.ItemSubCategories = {
	[ITEMSUBCAT_TRINKETS_DEFENSIVE] = "Defensive",
	[ITEMSUBCAT_TRINKETS_OFFENSIVE] = "Offensive",
	[ITEMSUBCAT_TRINKETS_MELEE] = "Melee",
	[ITEMSUBCAT_TRINKETS_PERFORMANCE] = "Performance",
	[ITEMSUBCAT_TRINKETS_SUPPORT] = "Support",
	[ITEMSUBCAT_TRINKETS_SPECIAL] = "Special"
}

GM.ItemSubCategoriesEx = {
	[ITEMCAT_TRINKETS] = GM.ItemSubCategories,
	[ITEMCAT_GUNS] = {
		[ITEMSUBCAT_GUNS_PISTOL] = "Pistols",
		[ITEMSUBCAT_GUNS_SMG] = "SMGs",
		[ITEMSUBCAT_GUNS_AR] = "Assault Rifles",
		[ITEMSUBCAT_GUNS_SHOTGUN] = "Shotguns",
		[ITEMSUBCAT_GUNS_MG] = "Machine Guns",
		[ITEMSUBCAT_GUNS_BR] = "Battle Rifles",
		[ITEMSUBCAT_GUNS_RIF] = "Rifles",
	},

	[ITEMCAT_MELEE] = {
		[ITEMSUBCAT_MELEE_1HAND] = "Straight Swords",
		[ITEMSUBCAT_MELEE_DAGGER] = "Daggers",
		[ITEMSUBCAT_MELEE_POLEARM] = "Polearms",
		[ITEMSUBCAT_MELEE_GS] = "Greatswords",
		[ITEMSUBCAT_MELEE_MISC] = "Misc.",
	},
}

GM.AmmoCategories = {
	[ITEMSUBCAT_GUNS_PISTOL] = "pistolammo",
	[ITEMSUBCAT_GUNS_SMG] = "smgammo",
	[ITEMSUBCAT_GUNS_AR] = "assaultrifleammo",
	[ITEMSUBCAT_GUNS_SHOTGUN] = "shotgunammo",
	[ITEMSUBCAT_GUNS_RIF] = "rifleammo",
	[ITEMSUBCAT_GUNS_BR] = "brammo",
	[ITEMSUBCAT_GUNS_MG] = "mgammo",
}
--]]

--[[
Humans select what weapons (or other things) they want to start with and can even save favorites. Each object has a number of 'Worth' points.
Signature is a unique signature to give in case the item is renamed or reordered. Don't use a number or a string number!
A human can only use 100 points (default) when they join. Redeeming or joining late starts you out with a random loadout from above.
SWEP is a swep given when the player spawns with that perk chosen.
Callback is a function called. Model is a display model. If model isn't defined then the SWEP model will try to be used.
swep, callback, and model can all be nil or empty
]]
GM.Items = {}
function GM:AddItem(signature, name, desc, category, worth, swep, callback, model, worthshop, pointshop)
	local tab = {Signature = signature, Name = name, Description = desc, Category = category, Worth = worth or 0, SWEP = swep, Callback = callback, Model = model, WorthShop = worthshop, PointShop = pointshop}
	self.Items[#self.Items + 1] = tab

	return tab
end

function GM:AddStartingItem(signature, name, desc, category, points, worth, callback, model)
	return self:AddItem(signature, name, desc, category, points, worth, callback, model, true, false)
end

function GM:AddPointShopItem(signature, name, desc, category, points, worth, callback, model)
	return self:AddItem("ps_"..signature, name, desc, category, points, worth, callback, model, false, true)
end

-- Weapons are registered after the gamemode.
timer.Simple(0, function()
	for _, tab in pairs(GAMEMODE.Items) do
		if not tab.Description and tab.SWEP then
			local sweptab = weapons.GetStored(tab.SWEP)
			if sweptab then
				tab.Description = sweptab.Description
			end
		end
	end
end)

-- How much ammo is considered one 'clip' of ammo? For use with setting up weapon defaults. Works directly with zs_survivalclips
GM.AmmoCache = {}
GM.AmmoCache["ar2"] = 40 -- Assault rifles.
GM.AmmoCache["alyxgun"] = 75 -- LMGs
GM.AmmoCache["pistol"] = 24 -- Pistols.
GM.AmmoCache["smg1"] = 50 -- SMG's and some rifles.
GM.AmmoCache["357"] = 8 -- Rifles, especially of the sniper variety.
GM.AmmoCache["xbowbolt"] = 5 -- Crossbows
GM.AmmoCache["buckshot"] = 12 -- Shotguns
GM.AmmoCache["ar2altfire"] = 1 -- deployable batteries
GM.AmmoCache["slam"] = 1 -- Teleporters
GM.AmmoCache["rpg_round"] = 1 -- Rockets
GM.AmmoCache["smg1_grenade"] = 1 -- medical stations
GM.AmmoCache["sniperround"] = 1 -- junk packs
GM.AmmoCache["sniperpenetratedround"] = 1 -- Remote Det pack.
GM.AmmoCache["grenade"] = 1 -- Grenades.
GM.AmmoCache["thumper"] = 1 -- Gun turret.
GM.AmmoCache["gravity"] = 15 -- Battle rifles
GM.AmmoCache["battery"] = 30 -- Used with the Medical Kit.
GM.AmmoCache["gaussenergy"] = 1 -- Nails used with the Carpenter's Hammer.
GM.AmmoCache["combinecannon"] = 1 -- shotgun turrets
GM.AmmoCache["airboatgun"] = 1 -- Arsenal crates.
GM.AmmoCache["striderminigun"] = 1 -- Message beacons.
GM.AmmoCache["helicoptergun"] = 1 --Resupply bags.
GM.AmmoCache["spotlamp"] = 1
GM.AmmoCache["manhack"] = 1
GM.AmmoCache["pulse"] = 70 --pulse weapons
GM.AmmoCache["40MM"] = 1 --40MM grenades
GM.AmmoCache["MP5_Grenade"] = 1 --claymores
GM.AmmoCache["Hornet"] = 1 --safe space meme
GM.AmmoCache["StriderMinigunDirect"] = 1 --Aegis ammo
GM.AmmoCache["CombineHeavyCannon"] = 5 --Heavy ammo
GM.AmmoCache["9mmRound"] = 1 --miniturret
--ammotypes below here are defined later
GM.AmmoCache["detslam"] = 1 --slams
GM.AmmoCache["detslap"] = 1 --slaps
GM.AmmoCache["impactmine"] = 1 --mines
GM.AmmoCache["molotov"] = 1 --molotovs
GM.AmmoCache["corgasgrenade"] = 1 --corrosive nades
GM.AmmoCache["crygasgrenade"] = 1 --freeze nades
GM.AmmoCache["drone"] = 1 --drones
GM.AmmoCache["repairfield"] = 1 --repair fields
GM.AmmoCache["chemical"] = 1 --chemicals (?)

--we ran out of unused ammotypes, time to add more
local tAmmoData = {}
tAmmoData.name = "detslam"
game.AddAmmoType(tAmmoData)

tAmmoData.name = "detslap"
game.AddAmmoType(tAmmoData)

tAmmoData.name = "impactmine"
game.AddAmmoType(tAmmoData)

tAmmoData.name = "molotov"
game.AddAmmoType(tAmmoData)

tAmmoData.name = "corgasgrenade"
game.AddAmmoType(tAmmoData)

tAmmoData.name = "crygasgrenade"
game.AddAmmoType(tAmmoData)

tAmmoData.name = "drone"
game.AddAmmoType(tAmmoData)

tAmmoData.name = "repairfield"
game.AddAmmoType(tAmmoData)

tAmmoData.name = "chemical"
game.AddAmmoType(tAmmoData)
-- These ammo types are available at ammunition bags.
-- The amount is the ammo to give them.
-- If the player isn't holding a weapon that uses one of these then they will get smg1 ammo.
GM.AmmoResupply = {}
GM.AmmoResupply["ar2"] = 80
GM.AmmoResupply["alyxgun"] = GM.AmmoCache["alyxgun"]
GM.AmmoResupply["pistol"] = 45
GM.AmmoResupply["smg1"] = 80
GM.AmmoResupply["357"] = 27
GM.AmmoResupply["xbowbolt"] = GM.AmmoCache["xbowbolt"]
GM.AmmoResupply["buckshot"] = 24
GM.AmmoResupply["battery"] = 50
GM.AmmoResupply["pulse"] = GM.AmmoCache["pulse"]
GM.AmmoResupply["gravity"] = 36
GM.AmmoResupply["gaussenergy"] = 3
GM.AmmoResupply["CombineHeavyCannon"] = 5

--GM.AmmoResupply["40MM"] = 3
-----------
-- Worth --
-----------

-- WORTH WEAPONS 


GM:AddStartingItem("pshtr", "'Peashooter' Handgun", nil, ITEMCAT_VANILLA, 20, "weapon_zs_peashooter")
GM:AddStartingItem("btlax", "'Battleaxe' Handgun", nil, ITEMCAT_VANILLA, 20, "weapon_zs_battleaxe")
GM:AddStartingItem("owens", "'Owens' Handgun", nil, ITEMCAT_VANILLA, 30, "weapon_zs_owens")
GM:AddStartingItem("blstr", "'Blaster' Shotgun", nil, ITEMCAT_VANILLA, 35, "weapon_zs_blaster")
GM:AddStartingItem("tossr", "'Tosser' SMG", nil, ITEMCAT_VANILLA, 30, "weapon_zs_tosser")
GM:AddStartingItem("stbbr", "'Stubber' Rifle", nil, ITEMCAT_VANILLA, 35, "weapon_zs_stubber")
GM:AddStartingItem("crklr", "'Crackler' Assault Rifle", nil, ITEMCAT_VANILLA, 30, "weapon_zs_crackler")
GM:AddStartingItem("z9000", "'Z9000' Pulse Pistol", nil, ITEMCAT_VANILLA, 20, "weapon_zs_z9000")


GM:AddStartingItem("m1carbine", "M1-Carbine [Battle Rifle]", "The M1 carbine is a lightweight semi-automatic carbine that was issued in the U.S. military during World War II", ITEMCAT_GUNS, 45, "cw_sniper_m1carbine")
GM:AddStartingItem("delisle", "Delisle [Sniper]", "This was chosen to discover if people in the street below heard it firing – they did not.", ITEMCAT_GUNS, 35, "cw_sniper_delisle")
GM:AddStartingItem("qz92", "QZ-92 [Pistol]", "The QSZ-92 is a semi-automatic pistol designed by Norinco.", ITEMCAT_GUNS, 25, "cw_pistol_qz92")  
GM:AddStartingItem("aksd", "AK-SD [SMG]", "A weapon consisting of a metal tube, with mechanical attachments, from which projectiles are shot by the force of an explosive; a piece of ordnance", ITEMCAT_GUNS, 35, "cw_smg_aksd") 
GM:AddStartingItem("famas", "Famas [Assualt Rifle]", "The FAMAS is recognised for its high rate of fire at around 900–1,100 rounds per minute.", ITEMCAT_GUNS, 40, "cw_ar_famasg2") 
GM:AddStartingItem("elephant", "Elephant Gun [Shotgun]", "An elephant gun is a large caliber gun, rifled or smoothbore, originally developed for use by big-game hunters for elephant and other large game.", ITEMCAT_GUNS, 45, "cw_shotgun_elephant") 
GM:AddStartingItem("serbu", "Serbu Super Shorty [Shotgun]", "The Serbu Super-Shorty is a compact, stockless, pump action shotgun chambered in 12-gauge (2¾ and 3inches)", ITEMCAT_GUNS, 45, "cw_shotgun_shotty") 
GM:AddStartingItem("cz75", "CZ-75 [Pistol]", "Simply put, the CZ 75 just shoots better. You're going to be hard-pressed to find somebody who doesn't agree with that.", ITEMCAT_GUNS, 25, "cw_pistol_cz75") 
GM:AddStartingItem("p226", "P226 [Pistol]", "Chambered in 9mm the new P226 PRO-CUT edition comes with a PRO-CUT lightened slide and is optics-ready, compatible with ROMEO1PRO.", ITEMCAT_GUNS, 25, "cw_pistol_p226") 


-- WORTH AMMO 

GM:AddStartingItem("2pcp", "72 pistol rounds", nil, ITEMCAT_AMMO, 15, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["pistol"] or 24) * 3, "pistol", true) end, "models/Items/BoxSRounds.mdl")
GM:AddStartingItem("2sgcp", "36 shotgun shells", nil, ITEMCAT_AMMO, 15, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["buckshot"] or 12) * 3, "buckshot", true) end, "models/Items/BoxBuckshot.mdl")
GM:AddStartingItem("2smgcp", "150 SMG rounds", nil, ITEMCAT_AMMO, 15, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["smg1"] or 50) * 3, "smg1", true) end, "models/Items/BoxMRounds.mdl")
GM:AddStartingItem("2arcp", "120 assault rifle rounds", nil, ITEMCAT_AMMO, 15, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["ar2"] or 40) * 3, "ar2", true) end, "models/props/pickup/ammo_armag.mdl")
GM:AddStartingItem("2rcp", "24 rifle cartridges", nil, ITEMCAT_AMMO, 15, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["357"] or 8) * 3, "357", true) end, "models/props/pickup/ammo_riflebox.mdl")
GM:AddStartingItem("2pls", "90 pulse charges", nil, ITEMCAT_AMMO, 7, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["pulse"] or 30) * 3, "pulse", true) end, "models/Items/combine_rifle_ammo01.mdl")
GM:AddStartingItem("2br", "45 battle rifle cartridges", nil, ITEMCAT_AMMO, 15, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["gravity"] or 15) * 3, "gravity", true) end, "models/props/pickup/ammo_brifle.mdl")
GM:AddStartingItem("2mg", "225 machine gun rounds", nil, ITEMCAT_AMMO, 15, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["alyxgun"] or 75) * 3, "alyxgun", true) end, "models/props/pickup/ammo_lmg.mdl")
GM:AddStartingItem("3pcp", "120 pistol rounds", nil, ITEMCAT_AMMO, 20, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["pistol"] or 24) * 5, "pistol", true) end, "models/Items/BoxSRounds.mdl")
GM:AddStartingItem("3sgcp", "60 shotgun shells", nil, ITEMCAT_AMMO, 20, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["buckshot"] or 12) * 5, "buckshot", true) end, "models/Items/BoxBuckshot.mdl")
GM:AddStartingItem("3smgcp", "250 SMG rounds", nil, ITEMCAT_AMMO, 20, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["smg1"] or 50) * 5, "smg1", true) end, "models/Items/BoxMRounds.mdl")
GM:AddStartingItem("3arcp", "200 assault rifle rounds", nil, ITEMCAT_AMMO, 20, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["ar2"] or 40) * 5, "ar2", true) end, "models/props/pickup/ammo_armag.mdl")
GM:AddStartingItem("3rcp", "40 rifle cartridges", nil, ITEMCAT_AMMO, 20, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["357"] or 8) * 5, "357", true) end, "models/props/pickup/ammo_riflebox.mdl")
GM:AddStartingItem("3pls", "150 pulse charges", nil, ITEMCAT_AMMO, 14, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["pulse"] or 30) * 5, "pulse", true) end, "models/Items/combine_rifle_ammo01.mdl")
GM:AddStartingItem("3br", "75 battle rifle cartridges", nil, ITEMCAT_AMMO, 20, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["gravity"] or 15) * 5, "gravity", true) end, "models/props/pickup/ammo_brifle.mdl")
GM:AddStartingItem("3mg", "375 machine gun rounds", nil, ITEMCAT_AMMO, 20, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["alyxgun"] or 75) * 5, "alyxgun", true) end, "models/props/pickup/ammo_lmg.mdl")


-- WORTH MELEE 

GM:AddStartingItem("csknf", "Knife", nil, ITEMCAT_MELEE, 25, "cw_melee_knife")
GM:AddStartingItem("crwbar", "Crowbar", nil, ITEMCAT_MELEE, 25, "cw_melee_crowbar")
GM:AddStartingItem("stnbtn", "Stun Baton", nil, ITEMCAT_MELEE, 25, "cw_melee_stunstick")
GM:AddStartingItem("brknswrd", "Broken Sword", "A sword with most of its blade broken off.\nOnly a madman would choose to fight with such a weapon.", ITEMCAT_MELEE, 30, "cw_melee_brokensword")
GM:AddStartingItem("cjavelin", "Cut Throwing Dagger", "A primitive dagger used for throwing. It could be used as a last resort.\n.Or, perhaps not.", ITEMCAT_MELEE, 25, "cw_melee_cutjavelin")
GM:AddStartingItem("sdagger", "Secret Dagger", "A dagger favored by many assassins for its powerful slashes.", ITEMCAT_MELEE, 30, "cw_melee_secretdagger")
GM:AddStartingItem("cutjavelin", "Cut Javelin", "A javelin cut into a makeshift spear.", ITEMCAT_MELEE, 30, "cw_melee_cjavelin")


GM:AddStartingItem("zpaxe", "Axe", nil, ITEMCAT_VMELEE, 30, "weapon_zs_axe")
GM:AddStartingItem("crwbar", "Crowbar", nil, ITEMCAT_VMELEE, 30, "weapon_zs_crowbar")
GM:AddStartingItem("stnbtn", "Stun Baton", nil, ITEMCAT_VMELEE, 25, "weapon_zs_stunbaton")
GM:AddStartingItem("csknf", "Knife", nil, ITEMCAT_VMELEE, 20, "weapon_zs_swissarmyknife")
GM:AddStartingItem("zpplnk", "Plank", nil, ITEMCAT_VMELEE, 20, "weapon_zs_plank")
GM:AddStartingItem("zpfryp", "Frying Pan", nil, ITEMCAT_VMELEE, 20, "weapon_zs_fryingpan")
GM:AddStartingItem("zpcpot", "Cooking Pot", nil, ITEMCAT_VMELEE, 20, "weapon_zs_pot")
GM:AddStartingItem("pipe", "Lead Pipe", nil, ITEMCAT_VMELEE, 25, "weapon_zs_pipe")
GM:AddStartingItem("hook", "Meat Hook", nil, ITEMCAT_VMELEE, 20, "weapon_zs_hook")


-- WORTH TOOLS 

GM:AddStartingItem("barricadekit", "'Aegis' Barricade Kit", nil, ITEMCAT_TOOLS, 25, "weapon_zs_barricadekit")
GM:AddStartingItem("medkit", "Medical Kit", nil, ITEMCAT_TOOLS, 15, "weapon_zs_medicalkit")
GM:AddStartingItem("medgun", "Refined Medic Gun", "An improved version of the medic gun, featuring an all new spring-loaded dart system.", ITEMCAT_TOOLS, 30, "weapon_zs_medicgun")
GM:AddStartingItem("medstat", "Medical Station", nil, ITEMCAT_TOOLS, 20, nil, function(pl)
	pl:GiveEmptyWeapon("weapon_zs_medstation")
	pl:GiveAmmo(1, "smg1_grenade")
	pl:GiveAmmo(75, "Battery", true) end).Countables = "prop_medstation"
GM:AddStartingItem("150mkit", "150 Medical Kit power", "150 extra power for the Medical Kit.", ITEMCAT_TOOLS, 20, nil, function(pl) pl:GiveAmmo(150, "Battery", true) end, "models/healthvial.mdl")
GM:AddStartingItem("arscrate", "Arsenal Crate", nil, ITEMCAT_TOOLS, 15, "weapon_zs_arsenalcrate").Countables = "prop_arsenalcrate"
GM:AddStartingItem("resupplybox", "Resupply Bag", nil, ITEMCAT_TOOLS, 15, "weapon_zs_resupplybox").Countables = "prop_resupplybox"
local item = GM:AddStartingItem("infturret", "Infrared Gun Turret", nil, ITEMCAT_TOOLS, 45, nil, function(pl)
	pl:GiveEmptyWeapon("weapon_zs_gunturret")
	pl:GiveAmmo(1, "thumper")
	pl:GiveAmmo(250, "smg1")
end)
item.Countables = {"weapon_zs_gunturret", "prop_gunturret"}
item.NoClassicMode = true
--[
local item = GM:AddStartingItem("miniturret", "AI-Deadly LMG Miniturret", nil, ITEMCAT_TOOLS, 30, nil, function(pl)
	pl:GiveEmptyWeapon("weapon_zs_miniturret")
	pl:GiveAmmo(1, "9mmRound")
	pl:GiveAmmo(250, "alyxgun")
end)
item.Countables = {"weapon_zs_miniturret", "prop_miniturret"}
item.NoClassicMode = true

local item = GM:AddStartingItem("infsturret", "Infrared Shotgun Turret", nil, ITEMCAT_TOOLS, 30, nil, function(pl)
	pl:GiveEmptyWeapon("weapon_zs_shotgunturret")
	pl:GiveAmmo(1, "combinecannon")
	pl:GiveAmmo(120, "buckshot")
end)
item.Countables = {"weapon_zs_shotgunturret", "prop_shotgunturret"}
item.NoClassicMode = true

local item = GM:AddStartingItem("manhack", "Manhack", nil, ITEMCAT_TOOLS, 35, "weapon_zs_manhack")
item.Countables = "prop_manhack"
local item = GM:AddStartingItem("drone", "Multi-Purpose Utility Drone", 
"A fully featured drone capable of scouting and retrieval of items using the USE key.\nIt has a one-second burst fire of approx 1kg of SMG ammo.",
ITEMCAT_TOOLS, 25, "weapon_zs_drone")
item.Countables = "prop_drone"
GM:AddStartingItem("wrench", "Mechanic's Wrench", nil, ITEMCAT_TOOLS, 15, "weapon_zs_wrench").NoClassicMode = true
GM:AddStartingItem("crphmr", "Hammer", nil, ITEMCAT_TOOLS, 15, "cw_tool_hammer").NoClassicMode = true
GM:AddStartingItem("hammerplank", "Hammer Plank", nil, ITEMCAT_TOOLS, 10, "weapon_zs_hammerplank").NoClassicMode = true
GM:AddStartingItem("stlhd", "Steel Hammerhead", nil, ITEMCAT_TOOLS, 5, nil, function(ply) CustomizableWeaponry:giveAttachment(ply, "md_m_steelhammer2", false) ply:GiveAmmo(5, "GaussEnergy", true) end).NoClassicMode = true
GM:AddStartingItem("pgrip", "Polymer Grip", nil, ITEMCAT_TOOLS, 5, nil, function(ply) CustomizableWeaponry:giveAttachment(ply, "md_m_polymergrip", false) ply:GiveAmmo(5, "GaussEnergy", true) end).NoClassicMode = true
GM:AddStartingItem("6nails", "Box of 12 nails", "An extra box of nails for all your barricading needs.", ITEMCAT_TOOLS, 5, nil, function(pl) pl:GiveAmmo(12, "GaussEnergy", true) end, "models/Items/BoxMRounds.mdl")
GM:AddStartingItem("junkpack", "Junk Pack", nil, ITEMCAT_TOOLS, 10, "weapon_zs_boardpack")
GM:AddStartingItem("spotlamp", "Spot Lamp", nil, ITEMCAT_TOOLS, 5, "weapon_zs_spotlamp").Countables = "prop_spotlamp"
GM:AddStartingItem("msgbeacon", "Message Beacon", nil, ITEMCAT_TOOLS, 0, "weapon_zs_messagebeacon").Countables = "prop_messagebeacon"
local item = GM:AddStartingItem("teleport", "2 Teleporters", "A device that can teleport individuals.", ITEMCAT_TOOLS, 10, nil, function(pl)
	pl:GiveEmptyWeapon("weapon_zs_teleporter")
	pl:GiveAmmo(2, "slam")
end)

-- MISCELLENOUS 

GM:AddStartingItem("stone", "Stone", nil, ITEMCAT_OTHER, 5, "weapon_zs_stone")
GM:AddStartingItem("grenade", "3 Grenades", nil, ITEMCAT_OTHER, 10, "weapon_zs_grenade", function(pl) pl:GiveAmmo(3, "grenade") pl:GiveEmptyWeapon("weapon_zs_grenade") end)
GM:AddStartingItem("molly", "Molotov", 
"A molotov made with a cheap beer and rag, useful for buying precious seconds to get away from a horde.",
ITEMCAT_OTHER, 5, "weapon_zs_molotov", function(pl) pl:Give("weapon_zs_molotov") end) --giving ammo doesnt work, check this out
GM:AddStartingItem("detpck", "Detonation Pack", nil, ITEMCAT_OTHER, 15, "weapon_zs_detpack").Countables = "prop_detpack"
GM:AddStartingItem("oxtank", "Oxygen Tank", "Grants signitifantly more underwater breathing time to the user.", ITEMCAT_OTHER, 5, "weapon_zs_oxygentank")
GM:AddStartingItem("nanite", "Nanite Cloud Bomb", "On throw, it releases a repair cloud that repairs all nearby props for a short time.", ITEMCAT_OTHER, 10, "weapon_zs_nanitecloudbomb")
GM:AddStartingItem("corogas", "Coro Gas", "Becareful when using this, will dissolve YOU and any zombies near by.", ITEMCAT_OTHER, 10, "weapon_zs_corogas")
GM:AddStartingItem("cryogas", "Cryo Gas", "Becareful when using this, will freeze and damage you and nearby zombies, and will reduce attack speeds.", ITEMCAT_OTHER, 10, "weapon_zs_crygasgrenade")


-- TRAITS 

-- STRENGTH 

GM:AddStartingItem("bfmusc", "Strength➜ I", "Applies extra melee damage.", ITEMCAT_TRAITS, 5, nil, function(pl) pl.BuffMuscular = true end, "models/props_wasteland/kitchen_shelf001a.mdl")
GM:AddStartingItem("10hp", "Strength➜ II", "Increases health by 10", ITEMCAT_TRAITS, 10, nil, function(pl) pl:SetMaxHealth(pl:GetMaxHealth() + 10) pl:SetHealth(pl:Health() + 10) end, "models/healthvial.mdl")
GM:AddStartingItem("25hp", "Strength➜ III", "Increases health by 25", ITEMCAT_TRAITS, 15, nil, function(pl) pl:SetMaxHealth(pl:GetMaxHealth() + 25) pl:SetHealth(pl:Health() + 25) end, "models/items/healthkit.mdl")
GM:AddStartingItem("100hp", "Strength➜ IV", "Increases health by 100", ITEMCAT_TRAITS, 20, nil, function(pl) pl:SetMaxHealth(pl:GetMaxHealth() + 100) pl:SetHealth(pl:Health() + 100) end, "models/items/healthkit.mdl")
GM:AddStartingItem("150hp", "Strength➜ V", "Increases health by 150", ITEMCAT_TRAITS, 25, nil, function(pl) pl:SetMaxHealth(pl:GetMaxHealth() + 150) pl:SetHealth(pl:Health() + 100) end, "models/items/healthkit.mdl")

-- POWER CELLS
GM:AddStartingItem("pc1", "Power Cell➜ I", "Power Armor +1", ITEMCAT_TRAITS, 5, nil, function(pl)  pl:SetArmor(pl:Armor() + 20) end, "models/Items/combine_rifle_ammo01.mdl")
GM:AddStartingItem("pc2", "Power Cell➜ II", "Power Armor +2", ITEMCAT_TRAITS, 10, nil, function(pl) pl:SetArmor(pl:Armor() + 40) end, "models/Items/combine_rifle_ammo01.mdl")
GM:AddStartingItem("pc3", "Power Cell➜ III", "Power Armor +3", ITEMCAT_TRAITS, 15, nil, function(pl)  pl:SetArmor(pl:Armor() + 60) end, "models/Items/combine_rifle_ammo01.mdl")
GM:AddStartingItem("pc4", "Power Cell➜ IV", "Power Armor +6", ITEMCAT_TRAITS, 20, nil, function(pl)  pl:SetArmor(pl:Armor() + 90) end, "models/Items/combine_rifle_ammo01.mdl")
GM:AddStartingItem("pc5", "Power Cell➜ V", "Power Armor +9", ITEMCAT_TRAITS, 25, nil, function(pl)  pl:SetArmor(pl:Armor() + 250) end, "models/Items/combine_rifle_ammo01.mdl")
GM:AddStartingItem("pc6", "Power Cell➜ VI", "Power Armor +15", ITEMCAT_TRAITS, 55, nil, function(pl)  pl:SetArmor(pl:Armor() + 300) end, "models/Items/combine_rifle_ammo01.mdl")

-- SPEED 
GM:AddStartingItem("5spd", "Speed➜ I", "5% Speed Increase", ITEMCAT_TRAITS, 5, nil, function(pl) pl.HumanSpeedAdder = (pl.HumanSpeedAdder or 0) + 7 pl:ResetSpeed() end, "models/props_lab/jar01a.mdl")
GM:AddStartingItem("10spd", "Speed➜ II", "10% Speed Increase", ITEMCAT_TRAITS, 10, nil, function(pl) pl.HumanSpeedAdder = (pl.HumanSpeedAdder or 0) + 14 pl:ResetSpeed() end, "models/props_lab/jar01a.mdl")
GM:AddStartingItem("50spd", "Speed➜ III", "50% Speed Increase", ITEMCAT_TRAITS, 15, nil, function(pl) pl.HumanSpeedAdder = (pl.HumanSpeedAdder or 0) + 54 pl:ResetSpeed() end, "models/props_lab/jar01a.mdl")
GM:AddStartingItem("70spd", "Speed➜ IV", "70% Speed Increase", ITEMCAT_TRAITS, 20, nil, function(pl) pl.HumanSpeedAdder = (pl.HumanSpeedAdder or 0) + 74 pl:ResetSpeed() end, "models/props_lab/jar01a.mdl")
GM:AddStartingItem("100spd", "Speed➜ V", "100% Speed Increase", ITEMCAT_TRAITS, 25, nil, function(pl) pl.HumanSpeedAdder = (pl.HumanSpeedAdder or 0) + 104 pl:ResetSpeed() end, "models/props_lab/jar01a.mdl")


-- MEDICAL
GM:AddStartingItem("bfresist", "Medical➜ I", "Resistance against Poison", ITEMCAT_TRAITS, 5, nil, function(pl) pl.BuffResistant = true end, "models/healthvial.mdl")
GM:AddStartingItem("bfsurgeon", "Medical➜ II", "33% Faster Healing", ITEMCAT_TRAITS, 10, nil, function(pl) pl.HumanHealMultiplier = (pl.HumanHealMultiplier or 1) + 0.4 end, "models/healthvial.mdl")
GM:AddStartingItem("bfregen", "Medical➜ III", "1 HP every 6 seconds after 75% HP loss", ITEMCAT_TRAITS, 15, nil, function(pl) pl.BuffRegenerative = true end, "models/healthvial.mdl")
GM:AddStartingItem("bfwpnmaster", "Medical➜ IV", "Adds Life Steal to CW Melee Weapons based on damage", ITEMCAT_TRAITS, 20, nil, function(pl) pl.WeaponMaster = 0.01 end, "models/healthvial.mdl")
GM:AddStartingItem("bfsurgeon2", "Medical➜ V", "70% Faster Healing", ITEMCAT_TRAITS, 25, nil, function(pl) pl.HumanHealMultiplier = (pl.HumanHealMultiplier or 1) + 0.7 end, "models/healthvial.mdl")
GM:AddStartingItem("bfwpnmaste2r", "Medical➜ VI", "Infuses Sadist with Life Steel", ITEMCAT_TRAITS, 35, nil, function(pl) pl.WeaponMaster = 0.2 end, "models/healthvial.mdl")

-- REPAIR
GM:AddStartingItem("bfhandy", "Repair➜ I", "Gives a 25% bonus to all repair rates", ITEMCAT_TRAITS, 5, nil, function(pl) pl.HumanRepairMultiplier = (pl.HumanRepairMultiplier or 1) + 0.25 end, "models/props_c17/tools_wrench01a.mdl")
GM:AddStartingItem("bfhandy2", "Repair➜ II", "Gives a 50% bonus to all repair rates", ITEMCAT_TRAITS, 10, nil, function(pl) pl.HumanRepairMultiplier = (pl.HumanRepairMultiplier or 1) + 0.50 end, "models/props_c17/tools_wrench01a.mdl")
GM:AddStartingItem("bfhandy3", "Repair➜ III", "Gives a 75% bonus to all repair rates", ITEMCAT_TRAITS, 15, nil, function(pl) pl.HumanRepairMultiplier = (pl.HumanRepairMultiplier or 1) + 0.75 end, "models/props_c17/tools_wrench01a.mdl")
GM:AddStartingItem("bfhandy4", "Repair➜ IV", "Gives a 100% bonus to all repair rates", ITEMCAT_TRAITS, 20, nil, function(pl) pl.HumanRepairMultiplier = (pl.HumanRepairMultiplier or 1) + 1.1 end, "models/props_c17/tools_wrench01a.mdl")
GM:AddStartingItem("bfhandy5", "Repair➜ V", "Gives a 125% bonus to all repair rates", ITEMCAT_TRAITS, 25, nil, function(pl) pl.HumanRepairMultiplier = (pl.HumanRepairMultiplier or 1) + 1.26 end, "models/props_c17/tools_wrench01a.mdl")

-- HASTE
GM:AddStartingItem("bfeyes", "Haste➜ I", "You can see fallen weapons and ammo through walls.", ITEMCAT_TRAITS, 10, nil, function(pl) pl:SetSnakeEyes(true) end)
GM:AddStartingItem("bfarms", "Haste➜ II", "You can grab weapons and ammo from farther away.", ITEMCAT_TRAITS, 15, nil, function(pl) pl:SetLongArms(true) end)

-- Health Tourments

GM:AddStartingItem("dbfweak1", "Health Tourment➜ I", "-10 Health", ITEMCAT_RETURNS, -15, nil, function(pl) pl:SetMaxHealth(math.max(1, pl:GetMaxHealth() - 10)) pl:SetHealth(pl:GetMaxHealth()) pl.IsWeak = true end, "models/gibs/HGIBS.mdl")
GM:AddStartingItem("dbfweak2", "Health Tourment➜ II", "-15 Health", ITEMCAT_RETURNS, -15, nil, function(pl) pl:SetMaxHealth(math.max(1, pl:GetMaxHealth() - 15)) pl:SetHealth(pl:GetMaxHealth()) pl.IsWeak = true end, "models/gibs/HGIBS.mdl")
GM:AddStartingItem("dbfweak3", "Health Tourment➜ III", "-25 Health", ITEMCAT_RETURNS, -15, nil, function(pl) pl:SetMaxHealth(math.max(1, pl:GetMaxHealth() - 25)) pl:SetHealth(pl:GetMaxHealth()) pl.IsWeak = true end, "models/gibs/HGIBS.mdl")
GM:AddStartingItem("dbfweak4", "Health Tourment➜ IV", "-50 Health", ITEMCAT_RETURNS, -25, nil, function(pl) pl:SetMaxHealth(math.max(1, pl:GetMaxHealth() - 50)) pl:SetHealth(pl:GetMaxHealth()) pl.IsWeak = true end, "models/gibs/HGIBS.mdl")
GM:AddStartingItem("dbfpalsy", "Health Tourment➜ V", "Increases Anxiety by 100%", ITEMCAT_RETURNS, -25, nil, function(pl) pl:SetPalsy(true) end, "models/gibs/HGIBS.mdl")
GM:AddStartingItem("dbfclumsy", "Health Tourment➜ VI", "Low Endurance: Zombie Knockdown", ITEMCAT_RETURNS, -35, nil, function(pl) pl.Clumsy = true end, "models/gibs/HGIBS.mdl")

-- Speed Tourments

GM:AddStartingItem("dbfslow1", "Speed Tourment➜ I", "-5% Speed", ITEMCAT_RETURNS, -10, nil, function(pl) pl.HumanSpeedAdder = (pl.HumanSpeedAdder or 1) - 20 pl:ResetSpeed() pl.IsSlow = true end, "models/gibs/HGIBS.mdl")
GM:AddStartingItem("dbfslow2", "Speed Tourment➜ II", "-15% Speed", ITEMCAT_RETURNS, -15, nil, function(pl) pl.HumanSpeedAdder = (pl.HumanSpeedAdder or 1) - 20 pl:ResetSpeed() pl.IsSlow = true end, "models/gibs/HGIBS.mdl")
GM:AddStartingItem("dbfslow3", "Speed Tourment➜ III", "-20% Speed", ITEMCAT_RETURNS, -15, nil, function(pl) pl.HumanSpeedAdder = (pl.HumanSpeedAdder or 1) - 20 pl:ResetSpeed() pl.IsSlow = true end, "models/gibs/HGIBS.mdl")
GM:AddStartingItem("dbfslow4", "Speed Tourment➜ IV", "-30% Speed", ITEMCAT_RETURNS, -15, nil, function(pl) pl.HumanSpeedAdder = (pl.HumanSpeedAdder or 1) - 20 pl:ResetSpeed() pl.IsSlow = true end, "models/gibs/HGIBS.mdl")
GM:AddStartingItem("dbfnoghosting", "Speed Tourment➜ V", "You lose the ability to walk through props.", ITEMCAT_RETURNS, -25, nil, function(pl) pl.NoGhosting = true end, "models/gibs/HGIBS.mdl").NoClassicMode = true

-- Strength Tourments 

GM:AddStartingItem("dbfhemo", "Strength Tourment➜ I", "Getting attacked causes you to bleed", ITEMCAT_RETURNS, -20, nil, function(pl) pl:SetHemophilia(true) end, "models/gibs/HGIBS.mdl")
GM:AddStartingItem("dbfnopickup", "Strength Tourment➜ II", "You lose the strength to pick up objects", ITEMCAT_RETURNS, -20, nil, function(pl) pl.NoObjectPickup = true end, "models/gibs/HGIBS.mdl")
GM:AddStartingItem("dbfreload", "Strength Tourment➜ III", "Increases reload time and handling", ITEMCAT_RETURNS, -25, nil, function(pl) pl:SetNWFloat("reloadScale", 0.7) end, "models/gibs/HGIBS.mdl")
GM:AddStartingItem("dbfreload2", "Strength Tourment➜ IV", "You have developed parkison's disease.", ITEMCAT_RETURNS, -35, nil, function(pl) pl:SetNWFloat("reloadScale", 0.5) end, "models/gibs/HGIBS.mdl")

-- Gadget Tourment

GM:AddStartingItem("dbfflash", "Equipment Tourment➜ I", "Your flashlight has malfunctioned", ITEMCAT_RETURNS, -5, nil, function(pl) pl.m_FlashDebuff = true end, "models/maxofs2d/lamp_flashlight.mdl")
GM:AddStartingItem("dbfgun", "Equipment Tourment➜ II", "Your weapons can malfunction after 8% of your bullets are released.", ITEMCAT_RETURNS, -10, nil, function(pl) pl.m_GunDebuff = true end, "models/gibs/HGIBS.mdl")
GM:AddStartingItem("dbfpoint", "Equipment Tourment➜ III", "You lose the ability to pick up currency bonuses from the end of the round.", ITEMCAT_RETURNS, -10, nil, function(pl) pl.m_PointDebuff = true end, "models/gibs/HGIBS.mdl")


-- PISTOLS 
-- GM:AddPointShopItem("", "", "", ITEMCAT_PISTOL, 0, "") 
-- BASE 

GM:AddPointShopItem("berreta", "Berreta", "The Samurai Edge, a series of fully customized firearm based on the Beretta 92FS and issued to the members of the R.P.D. S.T.A.R.S." , ITEMCAT_PISTOL, 50, "cw_pistol_berreta")
GM:AddPointShopItem("usp", "USP-40", "The HK USP 40 full-size is one of the most versatile pistols on the market and relied on every day by military and law enforcement.", ITEMCAT_PISTOL, 65, "cw_pistol_usp40") 
GM:AddPointShopItem("glock", "Glock", "Glock (stylized as GLOCK) is a brand of polymer-framed, short recoil-operated, locked-breech semi-automatic pistols." , ITEMCAT_PISTOL, 70, "cw_pistol_glock")
GM:AddPointShopItem("deagle", "Desert Eagle", "The Desert Eagle is a gas-operated, semi-automatic pistol known for chambering the .50 Action Express, the largest centerfire cartridge of any magazine-fed, self-loading pistol.", ITEMCAT_PISTOL, 100, "cw_pistol_deagle") 
GM:AddPointShopItem("mr96", "MR-96", "The weaknesses of this weapon is its slow fire rate to compensate its damage and its limited capacity. It also has a fairly slow reload time.", ITEMCAT_PISTOL, 150, "cw_pistol_mr96") 
GM:AddPointShopItem("g2", "G2-Contender", "The Thompson/Center Contender is a break-action single-shot pistol or rifle that was introduced in 1967 by Thompson/Center Arms.", ITEMCAT_PISTOL, 190, "cw_pistol_contender") 
GM:AddPointShopItem("czauto", "CZ Super Auto", "A CZ that not only shoots better, but has also been refined and is automatic. Also perfect for redeeming. ", ITEMCAT_PISTOL, 220, "cw_pistol_cz75_auto") 
GM:AddPointShopItem("627", "S&W 627", "Performance Center are the ultimate expression of old-world craftsmanship blended with modern technology.", ITEMCAT_PISTOL, 280, "cw_pistol_627") 
GM:AddPointShopItem("python", "Python", "Pythons have a reputation for accuracy, smooth trigger pull, and a tight cylinder lock-up.", ITEMCAT_PISTOL, 360, "cw_pistol_python") 
GM:AddPointShopItem("rex", "Rex", "The very name chosen for it communicates its core value: In fact, Rex comes from the Latin rex, regis and means king.", ITEMCAT_PISTOL, 440, "cw_pistol_rex") 
GM:AddPointShopItem("satan", "M29 Satan", "A real collectors piece and hard to come by.  Kokusai also made .44 Magnum Devil.  The difference between the Satan and Devil was the Satan has round barrel and Devil square barrel.", ITEMCAT_PISTOL, 470, "cw_pistol_satan") 
GM:AddPointShopItem("calico", "Calico M950", "The Calico M950 is a pistol manufactured by Calico Light Weapons Systems in the United States. Its main feature, along with all the other guns of the Calico system, is to feed from a proprietary helical magazine mounted on top, available in a 50 or 100-round capacity.", ITEMCAT_PISTOL, 600, "cw_pistol_calico") 



-- SUB MACHINE GUNS 
-- GM:AddPointShopItem("", "", "", ITEMCAT_SMG, 0, "") 
-- BASE 

GM:AddPointShopItem("mp5a4", "MP5-A4", "A submachine gun that fires 9x19mm Parabellum cartridges, developed in the 1960s by Heckler & Koch. ", ITEMCAT_SMG, 60, "cw_smg_mp5a4") 
GM:AddPointShopItem("mp5a5", "HK-MP5 Alpha 5", "Model with 5-3-1-0 trigger group and fixed stock.", ITEMCAT_SMG, 90, "cw_smg_mp5a5") 
GM:AddPointShopItem("mp40", "MP-40", "similar to the Thompson, but uses a smaller 9-mm round. This submachine gun evolved out of the MP38, which was prone to misfirings that had sometimes lethal results. A simple technical innovation to the hammer eliminated the problem, and the MP40 was born.", ITEMCAT_SMG, 150, "cw_smg_mp40") 
GM:AddPointShopItem("p90", "FN-P90", "a compact, lightweight weapon with a magazine capacity of 50 cartridges in 5.7x28mm NATO calibre making it the ideal Personal weapon.", ITEMCAT_SMG, 240, "cw_smg_p90") 
GM:AddPointShopItem("vector", "KRISS Vector", "ideal choice for law enforcement and military seeking a controllable, compact, weapon system for close quarter combat environments. The low bore axis and Super V recoil mitigation system allow for the most controllable select fire operation, or fast semi-automatic follow up shots.", ITEMCAT_SMG, 350, "cw_smg_vector") 
GM:AddPointShopItem("veresk", "SR-Veresk", "The SR-2 Veresk is a Russian submachine gun designed to fire the 9×21mm Gyurza pistol cartridge.", ITEMCAT_SMG, 420, "cw_smg_veresk") 
GM:AddPointShopItem("honey", "AAC Honey Badger", "The AAC Honey Badger is a personal defense weapon, frequently used in a suppressed configuration and is based on the AR-15.", ITEMCAT_SMG, 450, "cw_smg_hb") 
GM:AddPointShopItem("fmg9", "FMG-9", "The Magpul FMG-9 is a prototype folding submachine gun, designed by Magpul Industries in 2008. It is made out of polymer in place of metal, reducing weight. The FMG-9 never left the prototype stage, and never saw widespread production on any level, as the item was only produced by Magpul as a proof of concept.", ITEMCAT_SMG, 485, "cw_smg_fmg9") 
GM:AddPointShopItem("ump45", "UMP-45", "A truly modern submachine gun, the UMP is made using the latest in advanced polymers and high-tech materials.", ITEMCAT_SMG, 510, "cw_smg_ump45") 
GM:AddPointShopItem("vk10", "Vector-10", "Kriss Vector GEN II", ITEMCAT_SMG, 550, "cw_smg_vk10") 
GM:AddPointShopItem("sterling", "Sterling L2A3", "The Sterling submachine gun is a British submachine gun (SMG). It was tested by the British Army in 1944–1945, but did not start to replace the Sten until 1953. A successful and reliable design, it remained standard issue in the British Army until 1994, when it began to be replaced by the L85A1, a bullpup assault rifle. ", ITEMCAT_SMG, 600, "cw_smg_l2a3") 
GM:AddPointShopItem("thompson", "Thompson", "a blowback-operated, selective-fire submachine gun, invented and developed by United States Army Brigadier General John T. Thompson in 1918.", ITEMCAT_SMG, 710, "cw_smg_thompson") 

-- ASSUALT RIFLES 
-- GM:AddPointShopItem("", "", "", ITEMCAT_AR, 0, "") 
-- BASE 

GM:AddPointShopItem("masada", "Magnul Masada", "Compare the dimensions and specs of IWI Masada and Magnum Research Baby.", ITEMCAT_AR, 50, "cw_ar_masada") 
GM:AddPointShopItem("fal", "FN Fal", "Was designed to fire the intermediate 7.92×33mm Kurz cartridge developed and used by the forces of Germany during World War II with the Sturmgewehr 44 assault rifle.", ITEMCAT_AR, 80, "cw_ar_fal") 
GM:AddPointShopItem("ar15", "AR-15", "An AR-15–style rifle is any lightweight semi-automatic rifle based on or similar to the Colt AR-15 design. The Colt model removed the selective fire feature of its predecessor, the original ArmaLite AR-15, itself a scaled-down derivative of the AR-10 design by Eugene Stoner. ", ITEMCAT_AR, 150, "cw_ar_ar15") 
GM:AddPointShopItem("g36c", "G36C", "A compact variant and a further development of the G36K. It has a shorter barrel than the G36K, and a four-prong open-type flash hider", ITEMCAT_AR, 180, "cw_ar_g36c")
GM:AddPointShopItem("aek", "AEK-971", "The AEK-971 was developed to participate in a competition announced by the Ministry of Defense of the USSR, during which preference was given to the AN-94. The initial AEK version differs from modern samples, as many innovations were perceived as unnecessary by the Ministry of Defence, which led to a simplification of the early model. The AEK-971 is approximately 0.5 kg (1.1 lb) lighter than the AN-94, simpler in design and cheaper to manufacture.", ITEMCAT_AR, 220, "cw_ar_aek") 
GM:AddPointShopItem("xm8", "XM8", "The XM8 is a selective-fire 5.56mm assault rifle, firing from a closed rotary bolt. Its design and functioning is similar to that of the Heckler & Koch G36.", ITEMCAT_AR, 245, "cw_ar_xm8") 
GM:AddPointShopItem("an94", "AN-94", "The AN-94 is a Russian assault rifle.", ITEMCAT_AR, 270, "cw_ar_an94") 
GM:AddPointShopItem("ak103", "AK-103", "It is an AK-100 derivative of the AK-74M that is chambered for the 7.62x39mm M43 cartridge. ", ITEMCAT_AR, 290, "cw_ar_ak103") 
GM:AddPointShopItem("g3a3", "G3A3", "Chambered in .30 Carbine, 7.92×33 mm Kurz, and the experimental 7.65×35 mm French short cartridge developed by Cartoucherie de Valence in 1948. A 7.5×38 mm cartridge using a partial aluminium bullet was abandoned in 1947. Löffler's design, designated Carabine Mitrailleuse Modèle 1950, was retained for trials among 12 different prototypes designed by CEAM.", ITEMCAT_AR, 330, "cw_ar_g3a3") 
GM:AddPointShopItem("hcar", "HCAR", "Built and designed around the original Browning BAR rifle this auto variant reduces the weight of the BAR by almost 42%. Additionally the HCAR features updated components like a . 30 round detachable box magazine, reduced weight bolt, ambidextrous bolt release and hydraulic buffer system.", ITEMCAT_AR, 420, "cw_ar_hcar") 
GM:AddPointShopItem("masadaacr", "Masada ACR", "The Adaptive Combat Rifle (ACR) is a modular assault rifle designed by Magpul Industries of Austin, Texas, and known initially as the Masada.", ITEMCAT_AR, 480, "cw_ar_masada_acr") 
GM:AddPointShopItem("m4a4", "M4A4", "More accurate but less damaging than its AK-47 counterpart, the M4A4 is the full-auto assault rifle of choice for CTs. The M4 carbine is a family of firearms tracing its lineage back to earlier carbine versions of the M16 rifle, all based on the original AR-15 rifle designed by Eugene Stoner and made by ArmaLite.", ITEMCAT_AR, 550, "cw_ar_m4a4") 
GM:AddPointShopItem("m4a1", "M4A1", "First version of the M4, less accurate but does more damage.", ITEMCAT_AR, 630, "cw_ar_m4a1") 
GM:AddPointShopItem("akm", "AKM", "Introduced into service with the Soviet Army in 1959, the AKM is the most prevalent variant of the entire AK series of firearms and it has found widespread use with most member states of the former Warsaw Pact and its African and Asian allies as well as being widely exported and produced in many other countries. ", ITEMCAT_AR, 700, "cw_ar_akm") 
GM:AddPointShopItem("m16a4", "M16-A4", "The M16A4 is chambered to fire the 5.56x45mm (.223) NATO cartridge. It is a select fire rifle having semi-automatic and three-round-burst fire capabilities.", ITEMCAT_AR, 770, "cw_ar_m16a4") 
GM:AddPointShopItem("roku", "M4A4 ROKU", "Upgraded M4A4 fused with high voltage frequency.", ITEMCAT_AR, 900, "cw_ar_roku") 


-- SHOTGUNS  
-- GM:AddPointShopItem("", "", "", ITEMCAT_SHOTGUN, 0, "") 
-- BASE 

GM:AddPointShopItem("m620", "Stevens M620", "This shotgun is a hammerless, pump action, take-down design with a tubular magazine which holds 5 shells.", ITEMCAT_SHOTGUN, 85, "cw_shotgun_m620") 
GM:AddPointShopItem("m1014", "M1014", "M4 Tactical Shotguns. A.R.G.O.. Benelli's patented Auto-Regulating Gas-Operated (A.R.G.O.) system is a simple, self-cleaning, piston-driven action.", ITEMCAT_SHOTGUN, 165, "cw_shotgun_m1014") 
GM:AddPointShopItem("mossberg", "Mossberg", "America's favorite shotgun coupled with the innovative FLEX TLS (Tool-less Locking System) makes for the most adaptable shotgun platform in the world.", ITEMCAT_SHOTGUN, 280, "cw_shotgun_mossberg") 
GM:AddPointShopItem("saiga", "Saiga 12K", "Since shotgun shells are nearly twice as wide as 7.62×39mm cartridge, the extraction port in the side of the dust cover had to be increased in size. However, since the bolt had to remain the same length to fit inside the AK-47 sized receiver.", ITEMCAT_SHOTGUN, 375, "cw_shotgun_saiga") 
GM:AddPointShopItem("striker", "Striker 12", "This Sentinel Arms Striker-12 12ga rotating cylinder combat and riot control shotgun,  NFA Destructive Device, is currently on a Form 3 for easy eForm transfer.", ITEMCAT_SHOTGUN, 460, "cw_shotgun_dao12") 
GM:AddPointShopItem("ksg", "KSG-12", "The Kel-Tec KSG 12 Gauge Pump-Action Shotgun offers a 12-shell capacity and has a compact design and built-in forward and rear sling loops.", ITEMCAT_SHOTGUN, 540, "cw_shotgun_ksg12") 
GM:AddPointShopItem("ks23", "KS-23", "The KS-23 is a Soviet shotgun. Because it uses a rifled barrel, it is officially designated by the Russian military as a carbine", ITEMCAT_SHOTGUN, 610, "cw_shotgun_ks23")
GM:AddPointShopItem("jackhammer", "Jack Hammer", "The Jackhammer was designed by John A. Anderson, who formed the company Pancor Industries in New Mexico. Anderson designed it based on his experiences using pump action shotguns in the Korean War and believed he could create a better shotgun, finding reloading pump action shotguns awkward and time consuming.[1] Reportedly, several foreign governments expressed interest in the design and even ordered initial production units once ready for delivery.[1] However, export of the design was held up for production due to United States Department of Defense testing, though the design was eventually rejected. ", ITEMCAT_SHOTGUN, 680, "cw_shotgun_jackhammer") 
GM:AddPointShopItem("spas12", "SPAS-12", "The SPAS-12 is a dual-mode shotgun, adjustable for semi-automatic or pump-action operation. ", ITEMCAT_SHOTGUN, 770, "cw_shotgun_spas12") 
GM:AddPointShopItem("toz", "TOZ-BM16", "16 gauge heat-treated, detachable located in a horizontal plane. The barrels have a different choke constriction.", ITEMCAT_SHOTGUN, 850, "cw_shotgun_toz") 
GM:AddPointShopItem("aa12", "AA-12", "Designed and known as the Atchisson Assault Shotgun, is an automatic combat shotgun developed in 1972 by Maxwell.", ITEMCAT_SHOTGUN, 1050, "cw_shotgun_aa12") 

-- SNIPERS   
-- GM:AddPointShopItem("", "", "", ITEMCAT_RIFLE, 0, "") 
-- BASE 

GM:AddPointShopItem("mosin", "Mosin Nagant", "The Mosin Nagant is a bolt-action rifle. The bolt has a 90-degree throw, from the 3 o'clock position when locked to the 12 o'clock position when rotated.", ITEMCAT_RIFLE, 70, "cw_sniper_mosin")
GM:AddPointShopItem("sks", "SKS", "The SKS is a semi-automatic rifle designed by Soviet small arms designer Sergei Gavrilovich Simonov in 1945.", ITEMCAT_RIFLE, 120, "cw_sniper_sks") 
GM:AddPointShopItem("sksd", "SKS-D Auto ", "It is a gas-operated rifle that has a spring-loaded bolt carrier and a gas piston operating rod that work to unlock and cycle the action via gas pressure.", ITEMCAT_RIFLE, 185, "cw_sniper_sksd") 
GM:AddPointShopItem("svt", "SVT-40", "The SVT-40 is a Soviet semi-automatic battle rifle that saw widespread service during and after World War II.", ITEMCAT_RIFLE, 245, "cw_sniper_svt") 
GM:AddPointShopItem("m1garand", "M1-Garand", "The M1 Garand or M1 rifle is a semi-automatic rifle that was the service rifle of the U.S. Army during World War II and the Korean War.", ITEMCAT_RIFLE, 280, "cw_sniper_m1garand")
GM:AddPointShopItem("sr338", "SR-338", "Semi-Automatic rifle introduced in Battlefield 4.", ITEMCAT_RIFLE, 350, "cw_sniper_sr338") 
GM:AddPointShopItem("m82", "M82 Barret", "The Barrett M82 is a recoil-operated, semi-automatic anti-materiel rifle developed by the American company Barrett Firearms Manufacturing", ITEMCAT_RIFLE, 440, "cw_sniper_m82")
GM:AddPointShopItem("awm", "AWM", "The Accuracy International AWM is a bolt-action sniper rifle manufactured by Accuracy International designed for magnum rifle cartridges.", ITEMCAT_RIFLE, 500, "cw_sniper_awm") 
GM:AddPointShopItem("l115a3", "L115-A3", "In 2009, a British army sniper used a L115A3 to score the longest sniper shot in history when he took out 2 Taliban machine gunners from a distance of over 2400 meters.", ITEMCAT_RIFLE, 520, "cw_sniper_l115a3") 
--GM:AddPointShopItem("l115", "L115", "Adjustable cheek-pieces, a stabilizingrear monopod and an adjustable front bipod for improved shooting ergonomics.", ITEMCAT_RIFLE, 545, "cw_sniper_l115") 
GM:AddPointShopItem("t5000", "T-5000", "In its standard configuration the T-5000 is equipped with a 660 mm fluted, stainless steel barrel (698 mm when chambered in .338 Lapua Magnum), cut to a twist rate between 1-in-10 and 1-in-12 depending on customer requirements. ", ITEMCAT_RIFLE, 560, "cw_sniper_t5000")
GM:AddPointShopItem("m98b", "M98B", "The initial semi-auto design, the Model 98 was unveiled at the 1998 SHOT Show, but never went into full production.", ITEMCAT_RIFLE, 645, "cw_sniper_m98b") 
GM:AddPointShopItem("m95", "M95", "Bolt-action rifle in a bullpup design. The major difference between the M95 and the M90 is that the pistol grip and trigger have been moved forward 1 inch (25 mm) for better magazine clearance", ITEMCAT_RIFLE, 800, "cw_sniper_m95") 


-- LMGs
-- GM:AddPointShopItem("", "", "", ITEMCAT_MG , 0, "") 
-- BASE 
GM:AddPointShopItem("ar57", "AR-57", "", ITEMCAT_MG , 90, "cw_lmg_ar57") 
GM:AddPointShopItem("mg4", "MG-4", "", ITEMCAT_MG , 160, "cw_lmg_mg4") 
GM:AddPointShopItem("m240", "M240", "", ITEMCAT_MG , 250, "cw_lmg_m240") 
GM:AddPointShopItem("m27", "M27", "", ITEMCAT_MG , 365, "cw_lmg_m27") 
GM:AddPointShopItem("ares", "Ares Strike", "", ITEMCAT_MG , 445, "cw_lmg_ares") 
GM:AddPointShopItem("type88", "Type-88", "", ITEMCAT_MG , 500, "cw_lmg_type88") 
GM:AddPointShopItem("mg36", "MG-36", "", ITEMCAT_MG , 560, "cw_lmg_mg36")
GM:AddPointShopItem("pkm", "PKM", "", ITEMCAT_MG , 635, "cw_lmg_pkm")
GM:AddPointShopItem("m60", "M60", "", ITEMCAT_MG , 680, "cw_lmg_m60")
GM:AddPointShopItem("m60e4", "M60-E4", "", ITEMCAT_MG , 725, "cw_lmg_m60e4")  
GM:AddPointShopItem("hmg", "HMG", "", ITEMCAT_MG , 1400, "cw_lmg_hmg") 


-- VANILLA MELEE
--
-- BASE

GM:AddPointShopItem("knife", "Knife", nil, ITEMCAT_VMELEE, 35, "weapon_zs_swissarmyknife")
GM:AddPointShopItem("axe", "Axe", nil, ITEMCAT_VMELEE, 50, "weapon_zs_axe")
GM:AddPointShopItem("hooky", "Hook", "You for spending this much on a hook!", ITEMCAT_VMELEE, 55, "weapon_zs_hook")
GM:AddPointShopItem("crowbar", "Crowbar", nil, ITEMCAT_VMELEE, 60, "weapon_zs_crowbar")
GM:AddPointShopItem("stunbaton", "Stun Baton", nil, ITEMCAT_VMELEE, 60, "weapon_zs_stunbaton")
GM:AddPointShopItem("shovel", "Shovel", nil, ITEMCAT_VMELEE, 90, "weapon_zs_shovel")
GM:AddPointShopItem("sledgehammer", "Sledge Hammer", nil, ITEMCAT_VMELEE, 150, "weapon_zs_sledgehammer")
GM:AddPointShopItem("butcherknife", "Chef Blade", nil, ITEMCAT_VMELEE, 230, "weapon_zs_butcherknife")
GM:AddPointShopItem("carver", "Carving Blade", nil, ITEMCAT_VMELEE, 290, "weapon_zs_carver")
GM:AddPointShopItem("osiris", "Osiris", nil, ITEMCAT_VMELEE, 320, "weapon_zs_osiris")
GM:AddPointShopItem("excursion", "Excursion Blade", nil, ITEMCAT_VMELEE, 380, "weapon_zs_excursion")
GM:AddPointShopItem("sawhack", "Saw Hack", nil, ITEMCAT_VMELEE, 400, "weapon_zs_sawhack")
GM:AddPointShopItem("bustonstick", "Bluster Stick", nil, ITEMCAT_VMELEE, 430, "weapon_zs_bust")
GM:AddPointShopItem("nukeplank", "Nuclear Plank", nil, ITEMCAT_VMELEE, 480, "weapon_zs_nukeplank")
GM:AddPointShopItem("megamasher", "Mega-Masher", nil, ITEMCAT_VMELEE, 515, "weapon_zs_megamasher")
GM:AddPointShopItem("rebellion", "Rebellion", nil, ITEMCAT_VMELEE, 545, "weapon_zs_rebellion")
GM:AddPointShopItem("arbiter", "Arbiter", nil, ITEMCAT_VMELEE, 585, "weapon_zs_arbiter")
GM:AddPointShopItem("yamato", "Yamato Blade", nil, ITEMCAT_VMELEE, 635, "weapon_zs_katana")
GM:AddPointShopItem("psykin", "Psy-Kinetic Blade", nil, ITEMCAT_VMELEE, 780, "weapon_zs_psykineticblade")
GM:AddPointShopItem("cocknballs", "Golden Cock N Balls", nil, ITEMCAT_VMELEE, 900, "weapon_zs_cocknballs")
GM:AddPointShopItem("gravestone", "Gravestone", nil, ITEMCAT_VMELEE, 1000, "weapon_zs_gravestone")


-- PULSE WEAPONS
-- GM:AddPointShopItem("", "", nil, ITEMCAT_PULSE, 0, "") 
-- BASE

GM:AddPointShopItem("biopistol", "BIO-PISTOL-44z", nil, ITEMCAT_PULSE, 60, "weapon_zs_biopistol") 
GM:AddPointShopItem("biosmg", "BIO-SMG-TT4z", nil, ITEMCAT_PULSE, 90, "weapon_zs_biosmg") 
GM:AddPointShopItem("bioar", "BIO-AR-O5X", nil, ITEMCAT_PULSE, 160, "weapon_zs_bioar") 
GM:AddPointShopItem("aliensmg", "BIO-AX-SMG", nil, ITEMCAT_PULSE, 275, "weapon_zs_aliensmg")
GM:AddPointShopItem("alienrifle", "BIO-A-RIFLE", nil, ITEMCAT_PULSE, 380, "weapon_zs_alienrifle")
GM:AddPointShopItem("biorifle", "BIO-RIFLE-UTD", nil, ITEMCAT_PULSE, 470, "weapon_zs_biorifle") 
GM:AddPointShopItem("biocannon", "BIO-AUTO-CANNON", nil, ITEMCAT_PULSE, 600, "weapon_zs_bioshotgun")
GM:AddPointShopItem("avatarrifle", "BIO-AV-RIFLE", nil, ITEMCAT_PULSE, 750, "weapon_zs_avatarrifle")


-- VANILLA
-- GM:AddPointShopItem("", "", "", ITEMCAT_VANILLA, 0, "") 
-- BASE 

GM:AddPointShopItem("deserteagle", "'Zombie Drill' Desert Eagle", nil, ITEMCAT_VANILLA, 50, "weapon_zs_deagle")
GM:AddPointShopItem("glock3", "'Crossfire' Glock 3", nil, ITEMCAT_VANILLA, 50, "weapon_zs_glock3")
GM:AddPointShopItem("magnum", "'Ricochet' Magnum", nil, ITEMCAT_VANILLA, 75, "weapon_zs_magnum")
GM:AddPointShopItem("eraser", "'Eraser' Tactical Pistol", nil, ITEMCAT_VANILLA, 75, "weapon_zs_eraser")
GM:AddPointShopItem("uzi", "'Sprayer' Uzi 9mm", nil, ITEMCAT_VANILLA, 95, "weapon_zs_uzi")
GM:AddPointShopItem("shredder", "'Shredder' SMG", nil, ITEMCAT_VANILLA, 95, "weapon_zs_smg")
GM:AddPointShopItem("bulletstorm", "'Bullet Storm' SMG", nil, ITEMCAT_VANILLA, 150, "weapon_zs_bulletstorm")
GM:AddPointShopItem("silencer", "'Silencer' SMG", nil, ITEMCAT_VANILLA, 240, "weapon_zs_silencer")
GM:AddPointShopItem("hunter", "'Hunter' Rifle", nil, ITEMCAT_VANILLA, 350, "weapon_zs_hunter")
GM:AddPointShopItem("reaper", "'Reaper' UMP", nil, ITEMCAT_VANILLA, 390, "weapon_zs_reaper")
GM:AddPointShopItem("ender", "'Ender' Automatic Shotgun", nil, ITEMCAT_VANILLA, 425, "weapon_zs_ender")
GM:AddPointShopItem("akbar", "'Akbar' Assault Rifle", nil, ITEMCAT_VANILLA, 480, "weapon_zs_akbar")
GM:AddPointShopItem("sg550", "'Killer SG-550", nil, ITEMCAT_VANILLA, 520, "weapon_zs_sg550")
GM:AddPointShopItem("stalker", "'Stalker' Assault Rifle", nil, ITEMCAT_VANILLA, 585, "weapon_zs_m4")
GM:AddPointShopItem("inferno", "'Inferno' Assault Rifle", nil, ITEMCAT_VANILLA, 685, "weapon_zs_inferno")
GM:AddPointShopItem("annabelle", "'Annabelle' Rifle", nil, ITEMCAT_VANILLA, 740, "weapon_zs_annabelle")
GM:AddPointShopItem("crossbow", "'Impaler' Super Crossbow", nil, ITEMCAT_VANILLA, 785, "weapon_zs_crossbow")
GM:AddPointShopItem("sweeper", "'Sweeper' Shotgun", nil, ITEMCAT_VANILLA, 840, "weapon_zs_sweepershotgun")
GM:AddPointShopItem("boomstick", "Boom Stick", nil, ITEMCAT_VANILLA, 890, "weapon_zs_boomstick")
GM:AddPointShopItem("slugrifle", "Slug Rifle", nil, ITEMCAT_VANILLA, 950, "weapon_zs_slugrifle")
GM:AddPointShopItem("pulserifle", "'Adonis' Super Rifle", nil, ITEMCAT_VANILLA, 1000, "weapon_zs_pulserifle")



--ammo
GM:AddPointShopItem("pistolammo", "24 pistol rounds", nil, ITEMCAT_AMMO, 6, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoCache["pistol"] or 20, "pistol", true) end, "models/Items/BoxSRounds.mdl")
GM:AddPointShopItem("brammo", "15 battle rifle cartridges", nil, ITEMCAT_AMMO, 7, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoCache["gravity"] or 15, "gravity", true) end, "models/props/pickup/ammo_brifle.mdl")
GM:AddPointShopItem("shotgunammo", "12 shotgun shells", nil, ITEMCAT_AMMO, 7, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoCache["buckshot"] or 12, "buckshot", true) end, "models/Items/BoxBuckshot.mdl")
GM:AddPointShopItem("smgammo", "50 SMG rounds", nil, ITEMCAT_AMMO, 7, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoCache["smg1"] or 50, "smg1", true) end, "models/Items/BoxMRounds.mdl")
GM:AddPointShopItem("assaultrifleammo", "40 assault rifle rounds", nil, ITEMCAT_AMMO, 7, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoCache["ar2"] or 45, "ar2", true) end, "models/props/pickup/ammo_armag.mdl")
GM:AddPointShopItem("rifleammo", "8 rifle cartridges", nil, ITEMCAT_AMMO, 7, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoCache["357"] or 8, "357", true) end, "models/props/pickup/ammo_riflebox.mdl")
GM:AddPointShopItem("pulseammo", "30 pulse charges", nil, ITEMCAT_AMMO, 7, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoCache["pulse"] or 30, "pulse", true) end, "models/Items/combine_rifle_ammo01.mdl")
GM:AddPointShopItem("mgammo", "75 machine gun rounds", nil, ITEMCAT_AMMO, 7, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoCache["alyxgun"] or 75, "alyxgun", true) end, "models/props/pickup/ammo_lmg.mdl")
GM:AddPointShopItem("crossbowammo", "3 crossbow bolts", nil, ITEMCAT_AMMO, 7, nil, function(pl) pl:GiveAmmo(3, "XBowBolt", true) end, "models/Items/CrossbowRounds.mdl")
GM:AddPointShopItem("3pistolammo", "72 pistol rounds", nil, ITEMCAT_AMMO, 16, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["pistol"] or 24) * 3, "pistol", true) end, "models/Items/BoxSRounds.mdl")
GM:AddPointShopItem("3brammo", "45 battle rifle cartridges", nil, ITEMCAT_AMMO, 18, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["gravity"] or 15) * 3, "gravity", true) end, "models/props/pickup/ammo_brifle.mdl")
GM:AddPointShopItem("3shotgunammo", "36 shotgun shells", nil, ITEMCAT_AMMO, 18, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["buckshot"] or 12) * 3, "buckshot", true) end, "models/Items/BoxBuckshot.mdl")
GM:AddPointShopItem("3smgammo", "150 SMG rounds", nil, ITEMCAT_AMMO, 18, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["smg1"] or 50) * 3, "smg1", true) end, "models/Items/BoxMRounds.mdl")
GM:AddPointShopItem("3assaultrifleammo", "120 assault rifle rounds", nil, ITEMCAT_AMMO, 18, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["ar2"] or 40) * 3, "ar2", true) end, "models/props/pickup/ammo_armag.mdl")
GM:AddPointShopItem("3rifleammo", "24 rifle cartridges", nil, ITEMCAT_AMMO, 18, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["357"] or 8) * 3, "357", true) end, "models/props/pickup/ammo_riflebox.mdl")
GM:AddPointShopItem("3pulseammo", "90 pulse charges", nil, ITEMCAT_AMMO, 14, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["pulse"] or 30) * 3, "pulse", true) end, "models/Items/combine_rifle_ammo01.mdl")
GM:AddPointShopItem("3mgammo", "225 machine gun rounds", nil, ITEMCAT_AMMO, 18, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["alyxgun"] or 75) * 3, "alyxgun", true) end, "models/props/pickup/ammo_lmg.mdl")
GM:AddPointShopItem("40mm", "1 40MM M203-Ready Grenade", nil, ITEMCAT_AMMO, 30, nil, function(pl) pl:GiveAmmo(1, "40MM", true) end, "models/items/ar2_grenade.mdl")
GM:AddPointShopItem("rpg", "1 Rocket Propelled Grenade", nil, ITEMCAT_AMMO, 30, nil, function(pl) pl:GiveAmmo(1, "rpg_round", true) end, "models/items/ar2_grenade.mdl") --end,  "models/weapons/w_missle.mdl")
GM:AddPointShopItem("3rpg", "3 Rocket Propelled Grenades", nil, ITEMCAT_AMMO, 70, nil, function(pl) pl:GiveAmmo(3, "rpg_round", true) end, "models/items/ar2_grenade.mdl") --end,  "models/weapons/w_missle.mdl")

--melee
GM:AddPointShopItem("knife", "Knife", "A simple knife with no exceptional qualities.", ITEMCAT_MELEE, 5, "cw_melee_knife")
GM:AddPointShopItem("crowbar", "Crowbar", "A common crowbar, useful for destroying headcrabs.", ITEMCAT_MELEE, 10, "cw_melee_crowbar")
GM:AddPointShopItem("dagger", "Dagger", "A common dagger, favored for its quick slashes, but has poor range.", ITEMCAT_MELEE, 25, "cw_melee_dagger")
GM:AddPointShopItem("wspear", "Winged Spear", "A simple spear with pointed ends.", ITEMCAT_MELEE, 35, "cw_melee_wspear")
GM:AddPointShopItem("stunbaton", "Stun Baton", "A baton which carries an electric charge on power attack.", ITEMCAT_MELEE, 40, "cw_melee_stunstick")
GM:AddPointShopItem("ssword", "Short Sword", "A lightweight shortsword, which excels in thrusting attacks.", ITEMCAT_MELEE, 50, "cw_melee_shortsword")
GM:AddPointShopItem("mbreaker", "Mail Breaker", "A powerful dagger which excels in piercing damage.", ITEMCAT_MELEE, 70, "cw_melee_mailbreaker")
GM:AddPointShopItem("brsword", "Broad Sword", "A sword with a broad blade designed for slashing.", ITEMCAT_MELEE, 80, "cw_melee_broadsword")
GM:AddPointShopItem("mhammer", "Mirdan Hammer", "A long polearm with a forked hammerhead.", ITEMCAT_MELEE, 90, "cw_melee_mirdanhammer")
GM:AddPointShopItem("claymore", "Claymore", "A versatile greatsword which combines pointed stab attacks with heavy slashes.", ITEMCAT_MELEE, 100, "cw_melee_claymore")
GM:AddPointShopItem("ivory", "Ivory Sword", "A sword originally belonging to the ivory knights from an age long ago.", ITEMCAT_MELEE, 120, "cw_melee_ivorysword")
GM:AddPointShopItem("halberd", "Halberd", "A polearm combining spear and axe, requiring some skill to wield.", ITEMCAT_MELEE, 135, "cw_melee_halberd")
GM:AddPointShopItem("bivory", "Burnt Ivory Sword", "A sword belonging to the knights who followed the Burnt Ivory King.\nThe ivory is said to be burned by avarice.", ITEMCAT_MELEE, 150, "cw_melee_burntivorysword")
GM:AddPointShopItem("bnail", "Baby's Nail", "A dagger made from the tooth of a ferocious beast's infant.", ITEMCAT_MELEE, 180, "cw_melee_babynail")
GM:AddPointShopItem("flamegs", "Flamberge", "A greatsword with a unique, flame-like, blade pattern.", ITEMCAT_MELEE, 180, "cw_melee_flameberge")
GM:AddPointShopItem("sspear", "Scraping Spear", "A spear made with an extremely pointed tip.", ITEMCAT_MELEE, 215, "cw_melee_sspear")
GM:AddPointShopItem("strm", "Stormruler", "A sword used by kings that felled mighty giants.", ITEMCAT_MELEE, 240, "cw_melee_stormruler")
GM:AddPointShopItem("zwei", "Zweihander", "An ultra-greatsword which requires two hands to wield effectively.", ITEMCAT_MELEE, 265, "cw_melee_zweihander")
GM:AddPointShopItem("stil", "Stiletto", "A powerful and large dagger, used in ceremonies.", ITEMCAT_MELEE, 275, "cw_melee_stiletto")
GM:AddPointShopItem("scimmy", "Scimitar", "A simple weapon that causes intense bleeding on strikes.", ITEMCAT_MELEE, 370, "cw_melee_scimitar")
GM:AddPointShopItem("mcleaver", "Meat Cleaver", "A barbaric greatsword which easily slices meat. Fitting for a zombie apocalypse.", ITEMCAT_MELEE, 390, "cw_melee_cleaver")
GM:AddPointShopItem("lngswrd", "Long Sword", "Proclaimed as top tier by /dsg/, this sword is capable of a solid dps output.", ITEMCAT_MELEE, 450, "cw_melee_longsword")
GM:AddPointShopItem("moonblade", "Moonlight Greatsword", "A greatsword that is seen throughout history, seemingly outside time itself. Its origins are unknown.", ITEMCAT_MELEE, 475, "cw_melee_moonblade")
GM:AddPointShopItem("dbsmasher", "Dragon Bone Smasher", "An ultra-greatsword that requires inhuman strength to carry.", ITEMCAT_MELEE, 650, "cw_melee_dragonsmasher")
--GM:AddPointShopItem("rune", "Rune Sword", "A deeply enchanted sword capable of devastating damage.", ITEMCAT_MELEE, 800, "cw_melee_runesword")
GM:AddPointShopItem("dslayer", "Dragon Slayer Ultra-Greatsword", "A greatsword which resembles a large chunk of iron than a sword.\nToo big, too thick, too heavy to be a sword.\nBut a sword, none-the-less.", ITEMCAT_MELEE, 900, "cw_melee_dragonslayer")

--tools
GM:AddPointShopItem("crphmr", "Hammer", nil, ITEMCAT_TOOLS, 15, "cw_tool_hammer").NoClassicMode = true
GM:AddPointShopItem("wrench", "Mechanic's Wrench", nil, ITEMCAT_TOOLS, 25, "weapon_zs_wrench").NoClassicMode = true
GM:AddPointShopItem("constructor", "Constructor Nail Economy", nil, ITEMCAT_TOOLS, 150, "weapon_zs_constructor") 
GM:AddPointShopItem("arsenalcrate", "Arsenal Crate", nil, ITEMCAT_TOOLS, 40, "weapon_zs_arsenalcrate")
GM:AddPointShopItem("resupplybox", "Resupply Bag", nil, ITEMCAT_TOOLS, 50, "weapon_zs_resupplybox")
local item = GM:AddPointShopItem("infturret", "Infrared Gun Turret", nil, ITEMCAT_TOOLS, 40, nil, function(pl)
	pl:GiveEmptyWeapon("weapon_zs_gunturret")
	pl:GiveAmmo(1, "thumper")
	pl:GiveAmmo(250, "smg1")
end)
item.NoClassicMode = true
local item = GM:AddPointShopItem("infsturret", "Infrared Shotgun Turret", nil, ITEMCAT_TOOLS, 60, nil, function(pl)
	pl:GiveEmptyWeapon("weapon_zs_shotgunturret")
	pl:GiveAmmo(1, "combinecannon")
	pl:GiveAmmo(60, "buckshot")
end)
item.Countables = {"weapon_zs_shotgunturret", "prop_shotgunturret"}
item.NoClassicMode = true
--[
local item = GM:AddPointShopItem("miniturret", "AI-Deadly LMG Miniturret", nil, ITEMCAT_TOOLS, 60, nil, function(pl)
	pl:GiveEmptyWeapon("weapon_zs_miniturret")
	pl:GiveAmmo(1, "9mmRound")
	pl:GiveAmmo(250, "alyxgun")
end)
item.Countables = {"weapon_zs_miniturret", "prop_miniturret"}
item.NoClassicMode = true
--]]
GM:AddPointShopItem("manhack", "Manhack", nil, ITEMCAT_TOOLS, 25, "weapon_zs_manhack")
GM:AddPointShopItem("drone", "Multi-Purpose Utility Drone",
"A fully featured drone capable of scouting and retrieval of items using the USE key.\nIt has a one-second burst fire of approx. 1kg of SMG ammo.",
ITEMCAT_TOOLS, 35, "weapon_zs_drone").Countables = "prop_drone"
GM:AddPointShopItem("barricadekit", "'Aegis' Barricade Kit", nil, ITEMCAT_TOOLS, 125, "weapon_zs_barricadekit")
GM:AddPointShopItem("aegpackprop", "Extra Barricade Kit board", "It's just a board.", ITEMCAT_TOOLS, 32, nil, function(pl) pl:GiveAmmo(1, "StriderMinigunDirect", true) end, "models/crossbow_bolt.mdl").NoClassicMode = true
GM:AddPointShopItem("nail", "12 nails", "It's just twelve nails.", ITEMCAT_TOOLS, 25, nil, function(pl) pl:GiveAmmo(12, "GaussEnergy", true) end, "models/crossbow_bolt.mdl").NoClassicMode = true
GM:AddPointShopItem("jnkpackprop", "Extra Junk Pack prop", "It's just a prop.", ITEMCAT_TOOLS, 50, nil, function(pl) pl:GiveAmmo(1, "sniperround", true) end, "models/crossbow_bolt.mdl").NoClassicMode = true
GM:AddPointShopItem("50mkit", "50 Medical Kit power", "50 extra power for the Medical Kit.", ITEMCAT_TOOLS, 30, nil, function(pl) pl:GiveAmmo(50, "Battery", true) end, "models/healthvial.mdl")
GM:AddPointShopItem("medstat", "Medical Station", nil, ITEMCAT_TOOLS, 40, nil, function(pl)
	pl:GiveEmptyWeapon("weapon_zs_medstation")
	pl:GiveAmmo(1, "smg1_grenade")
	pl:GiveAmmo(50, "Battery", true) end).Countables = "prop_medstation"
GM:AddPointShopItem("teleport", "Teleporter", "A device that can teleport individuals.\nNeeds batteries for operation." , ITEMCAT_TOOLS, 25, "weapon_zs_teleporter").Countables = "prop_teleporter"

--other
GM:AddPointShopItem("grenade", "Grenade", nil, ITEMCAT_OTHER, 40, "weapon_zs_grenade")
GM:AddPointShopItem("molly", "Molotov",
"A molotov made with a cheap beer and rag, useful for buying precious seconds to get away from a horde.",
ITEMCAT_OTHER, 25, "weapon_zs_molotov")

GM:AddPointShopItem("detpck", "Detonation Pack", nil, ITEMCAT_OTHER, 50, "weapon_zs_detpack")
GM:AddPointShopItem("nanite", "Nanite Cloud Bomb", "On throw, it releases a repair cloud that repairs all nearby props for a short time.", ITEMCAT_OTHER, 50, "weapon_zs_nanitecloudbomb")
GM:AddPointShopItem("corogas", "Coro Gas", "Becareful when using this, will dissolve YOU and any zombies near by.", ITEMCAT_OTHER, 50, "weapon_zs_corogas")
GM:AddPointShopItem("cryogas", "Cryo Gas", "Becareful when using this, will freeze and damage you and nearby zombies, and will reduce attack speeds.", ITEMCAT_OTHER, 60, "weapon_zs_crygasgrenade")

-- TRAITS 

-- Misc Buffs

-- REPAIR
GM:AddPointShopItem("bfhandy", "Repair➜ I", "Gives a 25% bonus to all repair rates", ITEMCAT_TRAITS, 25, nil, function(pl) pl.HumanRepairMultiplier = (pl.HumanRepairMultiplier or 1) + 0.25 end, "models/props_c17/tools_wrench01a.mdl")
GM:AddPointShopItem("bfhandy2", "Repair➜ II", "Gives a 50% bonus to all repair rates", ITEMCAT_TRAITS, 50, nil, function(pl) pl.HumanRepairMultiplier = (pl.HumanRepairMultiplier or 1) + 0.50 end, "models/props_c17/tools_wrench01a.mdl")
GM:AddPointShopItem("bfhandy3", "Repair➜ III", "Gives a 75% bonus to all repair rates", ITEMCAT_TRAITS, 75, nil, function(pl) pl.HumanRepairMultiplier = (pl.HumanRepairMultiplier or 1) + 0.75 end, "models/props_c17/tools_wrench01a.mdl")
GM:AddPointShopItem("bfhandy4", "Repair➜ IV", "Gives a 100% bonus to all repair rates", ITEMCAT_TRAITS, 100, nil, function(pl) pl.HumanRepairMultiplier = (pl.HumanRepairMultiplier or 1) + 1.1 end, "models/props_c17/tools_wrench01a.mdl")
GM:AddPointShopItem("bfhandy5", "Repair➜ V", "Gives a 125% bonus to all repair rates", ITEMCAT_TRAITS, 125, nil, function(pl) pl.HumanRepairMultiplier = (pl.HumanRepairMultiplier or 1) + 1.26 end, "models/props_c17/tools_wrench01a.mdl")
GM:AddPointShopItem("bfhandy6", "Repair➜ VI", "Instant Repairs!", ITEMCAT_TRAITS, 300, nil, function(pl) pl.HumanRepairMultiplier = (pl.HumanRepairMultiplier or 1) + 10.26 end, "models/props_c17/tools_wrench01a.mdl")


-- HASTE
GM:AddPointShopItem("bfeyes", "Haste➜ I", "You can see fallen weapons and ammo through walls.", ITEMCAT_TRAITS, 15, nil, function(pl) pl:SetSnakeEyes(true) end)
GM:AddPointShopItem("bfarms", "Haste➜ II", "You can grab weapons and ammo from farther away.", ITEMCAT_TRAITS, 15, nil, function(pl) pl:SetLongArms(true) end)

-- MEDICAL 
GM:AddPointShopItem("bfmusc", "Strength➜ I", "Applies extra melee damage.", ITEMCAT_TRAITS, 25, nil, function(pl) pl.BuffMuscular = true end, "models/props_wasteland/kitchen_shelf001a.mdl")
GM:AddPointShopItem("10hp", "Strength➜ II", "Increases health by 10", ITEMCAT_TRAITS, 50, nil, function(pl) pl:SetMaxHealth(pl:GetMaxHealth() + 10) pl:SetHealth(pl:Health() + 10) end, "models/healthvial.mdl")
GM:AddPointShopItem("25hp", "Strength➜ III", "Increases health by 25", ITEMCAT_TRAITS, 75, nil, function(pl) pl:SetMaxHealth(pl:GetMaxHealth() + 25) pl:SetHealth(pl:Health() + 25) end, "models/items/healthkit.mdl")
GM:AddPointShopItem("100hp", "Strength➜ IV", "Increases health by 100", ITEMCAT_TRAITS, 100, nil, function(pl) pl:SetMaxHealth(pl:GetMaxHealth() + 100) pl:SetHealth(pl:Health() + 100) end, "models/items/healthkit.mdl")
GM:AddPointShopItem("150hp", "Strength➜ V", "Increases health by 150", ITEMCAT_TRAITS, 125, nil, function(pl) pl:SetMaxHealth(pl:GetMaxHealth() + 150) pl:SetHealth(pl:Health() + 100) end, "models/items/healthkit.mdl")

-- POWER CELLS
GM:AddPointShopItem("pc1", "Power Cell➜ I", "Power Armor +1", ITEMCAT_TRAITS, 25, nil, function(pl)  pl:SetArmor(pl:Armor() + 20) end, "models/Items/combine_rifle_ammo01.mdl")
GM:AddPointShopItem("pc2", "Power Cell➜ II", "Power Armor +2", ITEMCAT_TRAITS, 50, nil, function(pl) pl:SetArmor(pl:Armor() + 40) end, "models/Items/combine_rifle_ammo01.mdl")
GM:AddPointShopItem("pc3", "Power Cell➜ III", "Power Armor +3", ITEMCAT_TRAITS, 75, nil, function(pl)  pl:SetArmor(pl:Armor() + 60) end, "models/Items/combine_rifle_ammo01.mdl")
GM:AddPointShopItem("pc4", "Power Cell➜ IV", "Power Armor +6", ITEMCAT_TRAITS, 100, nil, function(pl)  pl:SetArmor(pl:Armor() + 90) end, "models/Items/combine_rifle_ammo01.mdl")
GM:AddPointShopItem("pc5", "Power Cell➜ V", "Power Armor +9", ITEMCAT_TRAITS, 125, nil, function(pl)  pl:SetArmor(pl:Armor() + 250) end, "models/Items/combine_rifle_ammo01.mdl")
GM:AddPointShopItem("pc6", "Power Cell➜ VI", "Power Armor +15", ITEMCAT_TRAITS, 250, nil, function(pl)  pl:SetArmor(pl:Armor() + 300) end, "models/Items/combine_rifle_ammo01.mdl")

-- SPEED 
GM:AddPointShopItem("5spd", "Speed➜ I", "5% Speed Increase", ITEMCAT_TRAITS, 25, nil, function(pl) pl.HumanSpeedAdder = (pl.HumanSpeedAdder or 0) + 7 pl:ResetSpeed() end, "models/props_lab/jar01a.mdl")
GM:AddPointShopItem("10spd", "Speed➜ II", "10% Speed Increase", ITEMCAT_TRAITS, 50, nil, function(pl) pl.HumanSpeedAdder = (pl.HumanSpeedAdder or 0) + 14 pl:ResetSpeed() end, "models/props_lab/jar01a.mdl")
GM:AddPointShopItem("50spd", "Speed➜ III", "50% Speed Increase", ITEMCAT_TRAITS, 75, nil, function(pl) pl.HumanSpeedAdder = (pl.HumanSpeedAdder or 0) + 54 pl:ResetSpeed() end, "models/props_lab/jar01a.mdl")
GM:AddPointShopItem("50spd", "Speed➜ IV", "70% Speed Increase", ITEMCAT_TRAITS, 100, nil, function(pl) pl.HumanSpeedAdder = (pl.HumanSpeedAdder or 0) + 74 pl:ResetSpeed() end, "models/props_lab/jar01a.mdl")
GM:AddPointShopItem("50spd", "Speed➜ V", "100% Speed Increase", ITEMCAT_TRAITS, 125, nil, function(pl) pl.HumanSpeedAdder = (pl.HumanSpeedAdder or 0) + 104 pl:ResetSpeed() end, "models/props_lab/jar01a.mdl")

-- Buffs 
GM:AddPointShopItem("bfresist", "Medical➜ I", "Resistance against Poison", ITEMCAT_TRAITS, 25, nil, function(pl) pl.BuffResistant = true end, "models/healthvial.mdl")
GM:AddPointShopItem("bfsurgeon", "Medical➜ II", "33% Faster Healing", ITEMCAT_TRAITS, 50, nil, function(pl) pl.HumanHealMultiplier = (pl.HumanHealMultiplier or 1) + 0.4 end, "models/healthvial.mdl")
GM:AddPointShopItem("bfregen", "Medical➜ III", "1 HP every 6 seconds after 75% HP loss", ITEMCAT_TRAITS, 75, nil, function(pl) pl.BuffRegenerative = true end, "models/healthvial.mdl")
GM:AddPointShopItem("bfwpnmaster", "Medical➜ IV", "Adds Life Steal to CW Melee Weapons based on damage", ITEMCAT_TRAITS, 100, nil, function(pl) pl.WeaponMaster = 0.01 end, "models/healthvial.mdl")
GM:AddPointShopItem("bfsurgeon2", "Medical➜ V", "70% Faster Healing", ITEMCAT_TRAITS, 125, nil, function(pl) pl.HumanHealMultiplier = (pl.HumanHealMultiplier or 1) + 0.7 end, "models/healthvial.mdl")
GM:AddPointShopItem("bfwpnmaster2", "Medical➜ VI", "Infuses Sadist with Life Steal", ITEMCAT_TRAITS, 200, nil, function(pl) pl.WeaponMaster = 0.2 end, "models/healthvial.mdl")

-- GIVE POINTS (ADMIN) 
--GM:AddPointShopItem("giveupthepoints", "Give Points", "Gives the user pointshop points" , ITEMCAT_OTHER, -100000, "")



-- These are the honorable mentions that come at the end of the round.

local function genericcallback(pl, magnitude) return pl:Name(), magnitude end
GM.HonorableMentions = {}
GM.HonorableMentions[HM_MOSTZOMBIESKILLED] = {Name = "Most zombies killed", String = "by %s, with %d killed zombies.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_MOSTDAMAGETOUNDEAD] = {Name = "Most damage to undead", String = "goes to %s, with a total of %d damage dealt to the undead.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_PACIFIST] = {Name = "Pacifist", String = "goes to %s for not killing a single zombie and still surviving!", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_MOSTHELPFUL] = {Name = "Most helpful", String = "goes to %s for assisting in the disposal of %d zombies.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_LASTHUMAN] = {Name = "Last Human", String = "goes to %s for being the last person alive.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_OUTLANDER] = {Name = "Outlander", String = "goes to %s for getting killed %d feet away from a zombie spawn.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_GOODDOCTOR] = {Name = "Good Doctor", String = "goes to %s for healing their team for %d points of health.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_HANDYMAN] = {Name = "Handy Man", String = "goes to %s for getting %d barricade assistance points.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_SCARECROW] = {Name = "Scarecrow", String = "goes to %s for killing %d poor crows.", Callback = genericcallback, Color = COLOR_WHITE}
GM.HonorableMentions[HM_MOSTBRAINSEATEN] = {Name = "Most brains eaten", String = "by %s, with %d brains eaten.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_MOSTDAMAGETOHUMANS] = {Name = "Most damage to humans", String = "goes to %s, with a total of %d damage given to living players.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_LASTBITE] = {Name = "Last Bite", String = "goes to %s for ending the round.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_USEFULTOOPPOSITE] = {Name = "Most useful to opposite team", String = "goes to %s for giving up a whopping %d kills!", Callback = genericcallback, Color = COLOR_RED}
GM.HonorableMentions[HM_STUPID] = {Name = "Retard", String = "is what %s is for getting killed %d feet away from a zombie spawn.", Callback = genericcallback, Color = COLOR_RED}
GM.HonorableMentions[HM_SALESMAN] = {Name = "Salesman", String = "is what %s is for having %d points worth of items taken from their arsenal crate.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_WAREHOUSE] = {Name = "Warehouse", String = "describes %s well since they had their resupply boxes used %d times.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_SPAWNPOINT] = {Name = "Spawn Point", String = "goes to %s for having %d zombies spawn on them.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_CROWFIGHTER] = {Name = "Crow Fighter", String = "goes to %s for annihilating %d of his crow brethren.", Callback = genericcallback, Color = COLOR_WHITE}
GM.HonorableMentions[HM_CROWBARRICADEDAMAGE] = {Name = "Minor Annoyance", String = "is what %s is for dealing %d damage to barricades while a crow.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_BARRICADEDESTROYER] = {Name = "Barricade Destroyer", String = "goes to %s for doing %d damage to barricades.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_NESTDESTROYER] = {Name = "Nest Destroyer", String = "goes to %s for destroying %d nests.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_NESTMASTER] = {Name = "Nest Master", String = "goes to %s for having %d zombies spawn through their nest.", Callback = genericcallback, Color = COLOR_LIMEGREEN}

-- Don't let humans use these models because they look like undead models. Must be lower case.
GM.RestrictedModels = {
	"models/player/zombie_classic.mdl",
	"models/player/zombine.mdl",
	"models/player/zombie_soldier.mdl",
	"models/player/zombie_fast.mdl",
	"models/player/corpse1.mdl",
	"models/player/charple.mdl",
	"models/player/skeleton.mdl",
	"models/player/combine_soldier_prisonguard.mdl",
	"models/player/soldier_stripped.mdl",
}

-- If a person has no player model then use one of these (auto-generated).
GM.RandomPlayerModels = {}
for name, mdl in pairs(player_manager.AllValidModels()) do
	if not table.HasValue(GM.RestrictedModels, string.lower(mdl)) then
		table.insert(GM.RandomPlayerModels, name)
	end
end

-- Utility function to setup a weapon's DefaultClip.
function GM:SetupDefaultClip(tab)
	tab.DefaultClip = math.ceil(tab.ClipSize * self.SurvivalClips * (tab.ClipMultiplier or 1))
end

GM.MaxSigils = CreateConVar("zs_maxsigils", "3", FCVAR_ARCHIVE + FCVAR_NOTIFY, "How many sigils to spawn. 0 for none."):GetInt()
cvars.AddChangeCallback("zs_maxsigils", function(cvar, oldvalue, newvalue)
	GAMEMODE.MaxSigils = math.Clamp(tonumber(newvalue) or 0, 0, 10)
end)

GM.DefaultRedeem = 3

GM.WaveOneZombies = math.ceil(100 * CreateConVar("zs_waveonezombies", "0.1", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "The percentage of players that will start as zombies when the game begins."):GetFloat()) * 0.01
cvars.AddChangeCallback("zs_waveonezombies", function(cvar, oldvalue, newvalue)
	GAMEMODE.WaveOneZombies = math.ceil(100 * (tonumber(newvalue) or 1)) * 0.01
end)

GM.NumberOfWaves = 5 --convar gets out of sync from server/client so lets just hardcode it here

-- Game feeling too easy? Just change these values!
GM.ZombieSpeedMultiplier = math.ceil(100 * CreateConVar("zs_zombiespeedmultiplier", "1", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "Zombie running speed will be scaled by this value."):GetFloat()) * 0.01
cvars.AddChangeCallback("zs_zombiespeedmultiplier", function(cvar, oldvalue, newvalue)
	GAMEMODE.ZombieSpeedMultiplier = math.ceil(100 * (tonumber(newvalue) or 1)) * 0.01
end)

-- This is a resistance, not for claw damage. 0.5 will make zombies take half damage, 0.25 makes them take 1/4, etc.
GM.ZombieDamageMultiplier = 1
--[[
math.ceil(100 * CreateConVar("zs_zombiedamagemultiplier", "1", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "Scales the amount of damage that zombies take. Use higher values for easy zombies, lower for harder."):GetFloat()) * 0.01
cvars.AddChangeCallback("zs_zombiedamagemultiplier", function(cvar, oldvalue, newvalue)
	GAMEMODE.ZombieDamageMultiplier = math.ceil(100 * (tonumber(newvalue) or 1)) * 0.01
end)
--]]
GM.TimeLimit = CreateConVar("zs_timelimit", "15", FCVAR_ARCHIVE + FCVAR_NOTIFY, "Time in minutes before the game will change maps. It will not change maps if a round is currently in progress but after the current round ends. -1 means never switch maps. 0 means always switch maps."):GetInt() * 60
cvars.AddChangeCallback("zs_timelimit", function(cvar, oldvalue, newvalue)
	GAMEMODE.TimeLimit = tonumber(newvalue) or 15
	if GAMEMODE.TimeLimit ~= -1 then
		GAMEMODE.TimeLimit = GAMEMODE.TimeLimit * 60
	end
end)

GM.RoundLimit = CreateConVar("zs_roundlimit", "1", FCVAR_ARCHIVE + FCVAR_NOTIFY, "How many times the game can be played on the same map. -1 means infinite or only use time limit. 0 means once."):GetInt()
cvars.AddChangeCallback("zs_roundlimit", function(cvar, oldvalue, newvalue)
	GAMEMODE.RoundLimit = tonumber(newvalue) or 1
end)

-- Static values that don't need convars...

-- Initial length for wave 1.
GM.WaveOneLength = 180

-- For Classic Mode
GM.WaveOneLengthClassic = 120

-- Add this many seconds for each additional wave.
GM.TimeAddedPerWave = 30

-- For Classic Mode
GM.TimeAddedPerWaveClassic = 10

-- New players are put on the zombie team if the current wave is this or higher. Do not put it lower than 1 or you'll break the game.
GM.NoNewHumansWave = 5

-- Humans can not commit suicide if the current wave is this or lower.
GM.NoSuicideWave = 0

-- How long 'wave 0' should last in seconds. This is the time you should give for new players to join and get ready.
GM.WaveZeroLength = 240 --210 is 3 minutes and 30 seconds, the previous values caused god cades to be made and give too much time for humans to prepare. Do not change this PLEASE.

-- Time humans have between waves to do stuff without NEW zombies spawning. Any dead zombies will be in spectator (crow) view and any living ones will still be living.
GM.WaveIntermissionLength = 90 --FUCK OFF. This should be no more than 60 seconds, otherwise with recading and everything else, it is simply unfair for zombies.
-- ^ ALSO PLEASE DONT CHANGE THIS OFF OF 60

-- For Classic Mode
GM.WaveIntermissionLengthClassic = 20

-- Time in seconds between end round and next map.
GM.EndGameTime = 30

-- How many clips of ammo guns from the Worth menu start with. Some guns such as shotguns and sniper rifles have multipliers on this.
GM.SurvivalClips = 2

-- Put your unoriginal, 5MB Rob Zombie and Metallica music here.
GM.LastHumanSound = Sound("music/HL2_song15.mp3")

-- Sound played when humans all die.
GM.AllLoseSound = Sound("music/HL2_song16.mp3") -- music/HL2_song16.mp3

-- Sound played when humans survive.
GM.HumanWinSound = Sound("music/HL1_song25_REMIX3.mp3")

-- Sound played to a person when they die as a human.
GM.DeathSound = Sound("")

GM.UseBossScaling = false 
GM.UseWaveBossScaling = true

--Scaling factor function that takes the current playercount and outputs a fraction for boss health. In sh_options since the equation can be modified.
function GM:GetScaledHP(iPlys, fHP)
	local wave = self:GetWave()
	local factor = math.Clamp((0.00078125 * iPlys^2 + -0.0146635 * iPlys + 0.666346), 0.5, 1) --TODO: Find a better equation
	local wfactor = 0
	if GAMEMODE.UseWaveBossScaling and wave and wave > 1 then
		wfactor = 175 * (wave - 1)
	end
	return math.Round(factor * fHP + wfactor)
end

--custom redeem loadouts, table format is [WaveTheLoadoutShouldChange] = {Weapon = weaponame, Melee = meleename, AmmoType = additional ammotype, Amt = additional ammo}
--[[ --Disabled, will be implemented sometime later
GM.RedeemWeps = {
  Default = {Weapon = "cw_pist_taurus", Melee = "weapon_zs_swissarmyknife", AmmoType = "pistol", Amt = 60}
  [3] = {Weapon = "cw_smg_mpx", Melee = "weapon_zs_swissarmyknife", AmmoType = "smg1", Amt = 300}
  [5] = {Weapon = "cw_ar_hk33", Melee = "weapon_zs_swissarmyknife", AmmoType = "ar2", Amt = 240}
  }
GM.DynamicRedeemLoadout = GM.RedeemWeps.Default

hook.Add("SetWave", "UpdateRedeemLoadouts", function(wave)
    GAMEMODE.DynamicRedeemLoadout = GAMEMODE.RedeemWeps[wave] or GAMEMODE.DynamicRedeemLoadout
end)

function GM:GiveRedeemLoadout(ply, override)
  if ply then
  	loadout = override or GAMEMODE.DynamicRedeemLoadout
    ply:Give(loadout.Weapon or "")
    ply:Give(loadout.Melee or "")
    ply:GiveAmmo(loadout.Amt or 0, loadout.AmmoType or "", true)
  end
end
--]]
  
