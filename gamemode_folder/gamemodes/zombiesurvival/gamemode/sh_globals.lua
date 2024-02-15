TEAM_ZOMBIE = 3
TEAM_ZOMBIES = TEAM_ZOMBIE
TEAM_UNDEAD = TEAM_ZOMBIE
TEAM_SURVIVOR = 4
TEAM_SURVIVORS = TEAM_SURVIVOR
TEAM_HUMAN = TEAM_SURVIVOR
TEAM_HUMANS = TEAM_SURVIVOR

DISMEMBER_HEAD = 1
DISMEMBER_LEFTARM = 2
DISMEMBER_RIGHTARM = 4
DISMEMBER_LEFTLEG = 8
DISMEMBER_RIGHTLEG = 16

ARMOR_REGEN_AMOUNT = 15
ARMOR_REGEN_INTERVAL = 15
HM_MOSTZOMBIESKILLED = 1
HM_MOSTDAMAGETOUNDEAD = 2
HM_PACIFIST = 3
HM_MOSTHELPFUL = 4
HM_LASTHUMAN = 5
HM_OUTLANDER = 6
HM_GOODDOCTOR = 7
HM_HANDYMAN = 8
HM_SCARECROW = 9
HM_MOSTBRAINSEATEN = 10
HM_MOSTDAMAGETOHUMANS = 11
HM_LASTBITE = 12
HM_USEFULTOOPPOSITE = 13
HM_STUPID = 14
HM_SALESMAN = 15
HM_WAREHOUSE = 16
HM_BARRICADEDESTROYER = 17
HM_SPAWNPOINT = 18
HM_CROWFIGHTER = 19
HM_CROWBARRICADEDAMAGE = 20
HM_NESTDESTROYER = 21
HM_NESTMASTER = 22

--the set/get dt functions are bad news, why couldn't there have been a player class hook?
DT_PLAYER_INT_REMORTLEVEL = 5
DT_PLAYER_INT_XP = 6
DT_PLAYER_INT_BLOODARMOR = 7
DT_PLAYER_INT_VOICESET = 8
DT_PLAYER_BOOL_BARRICADEEXPERT = 6
DT_PLAYER_BOOL_NECRO = 7
DT_PLAYER_BOOL_FRAIL = 8
DT_PLAYER_FLOAT_WIDELOAD = 5
DT_PLAYER_FLOAT_PHANTOMHEALTH = 6

VOICESET_MALE = 0
VOICESET_FEMALE = 1
VOICESET_COMBINE = 2
VOICESET_BARNEY = 3
VOICESET_ALYX = 4
VOICESET_MONK = 5

VOICELINE_PAIN_LIGHT = 0
VOICELINE_PAIN_MED = 1
VOICELINE_PAIN_HEAVY = 2
VOICELINE_DEATH = 3
VOICELINE_EYEPAIN = 4
VOICELINE_GIVEAMMO = 5

FM_NONE = 0
FM_LOCALKILLOTHERASSIST = 1
FM_LOCALASSISTOTHERKILL = 2

DIR_FORWARD = 0
DIR_RIGHT = 1
DIR_BACK = 2
DIR_LEFT = 3

DEFAULT_VIEW_OFFSET = Vector(0, 0, 64)
DEFAULT_VIEW_OFFSET_DUCKED = Vector(0, 0, 28)
DEFAULT_JUMP_POWER = 185
DEFAULT_STEP_SIZE = 18
DEFAULT_MASS = 80
DEFAULT_MODELSCALE = 1

-- Humans can not carry OR drag anything heavier than this (in kg.)
CARRY_MAXIMUM_MASS = 1500--350
-- Humans can not carry anything with a volume more than this (OBBMins():Length() + OBBMaxs():Length()).
CARRY_MAXIMUM_VOLUME = 1500--150
-- Objects with more mass than this will be dragged instead of carried.
CARRY_DRAG_MASS = 9000
-- Anything bigger than this is dragged regardless of mass.
CARRY_DRAG_VOLUME = 999999
-- Humans are slowed by this amount per kg carried...
CARRY_SPEEDLOSS_PERKG = 4
-- but can never be slower than this.
CARRY_SPEEDLOSS_MINSPEED = 150

GM.MaxLegDamage = 2

GM.UtilityKey = IN_SPEED
GM.MenuKey = IN_WALK -- I would use the spawn menu but it has no IN_ key assignment.

-- Cost multiplier for being near an arsenal crate.
GM.ArsenalCrateMultiplier = 0.9
GM.ArsenalCrateDiscount = 1 - GM.ArsenalCrateMultiplier
GM.ArsenalCrateDiscountPercentage = GM.ArsenalCrateDiscount * 100

SPEED_NORMAL = 225
SPEED_SLOWEST = SPEED_NORMAL - 20
SPEED_SLOWER = SPEED_NORMAL - 14
SPEED_SLOW = SPEED_NORMAL - 7
SPEED_FAST = SPEED_NORMAL + 7
SPEED_FASTER = SPEED_NORMAL + 14
SPEED_FASTEST = SPEED_NORMAL + 20

SPEED_ZOMBIEESCAPE_SLOWEST = 220
SPEED_ZOMBIEESCAPE_SLOWER = 230
SPEED_ZOMBIEESCAPE_SLOW = 240
SPEED_ZOMBIEESCAPE_NORMAL = 250
SPEED_ZOMBIEESCAPE_ZOMBIE = 280

ZE_KNOCKBACKSCALE = 0.1

MASK_HOVER = bit.bor(CONTENTS_OPAQUE, CONTENTS_GRATE, CONTENTS_HITBOX, CONTENTS_DEBRIS, CONTENTS_SOLID, CONTENTS_WATER, CONTENTS_SLIME, CONTENTS_WINDOW, CONTENTS_LADDER, CONTENTS_PLAYERCLIP, CONTENTS_MOVEABLE, CONTENTS_DETAIL, CONTENTS_TRANSLUCENT)

GM.BarricadeHealthMin = 300
GM.BarricadeHealthMax = 3100
GM.BarricadeHealthMassFactor = 3
GM.BarricadeHealthVolumeFactor = 4

GM.BossZombiePlayersRequired = 5

GM.HumanGibs = {
Model("models/gibs/HGIBS.mdl"),
Model("models/gibs/HGIBS_spine.mdl"),

Model("models/gibs/HGIBS_rib.mdl"),
Model("models/gibs/HGIBS_scapula.mdl"),
Model("models/gibs/antlion_gib_medium_2.mdl"),
Model("models/gibs/Antlion_gib_Large_1.mdl"),
Model("models/gibs/Strider_Gib4.mdl")
}

GM.BannedProps = {
	--"models/props_wasteland/kitchen_shelf001a.mdl"
}

GM.PropHealthMultipliers = {
}

GM.CleanupFilter = {
	"zs_hands"
}

GM.AmmoNames = {}
GM.AmmoNames["ar2"] = "Assault Rifle"
GM.AmmoNames["pistol"] = "Pistol"
GM.AmmoNames["smg1"] = "SMG"
GM.AmmoNames["357"] = "Rifle"
GM.AmmoNames["xbowbolt"] = "Bolts"
GM.AmmoNames["buckshot"] = "Buckshot"
GM.AmmoNames["sniperround"] = "Boards"
GM.AmmoNames["grenade"] = "Grenades"
GM.AmmoNames["thumper"] = "Turrets"
GM.AmmoNames["battery"] = "Medical Supplies"
GM.AmmoNames["gaussenergy"] = "Nails"
GM.AmmoNames["airboatgun"] = "Arsenal Crates"
GM.AmmoNames["striderminigun"] = "Beacons"
GM.AmmoNames["slam"] = "Teleporters"
GM.AmmoNames["spotlamp"] = "Spot Lamps"
GM.AmmoNames["stone"] = "Stones"
GM.AmmoNames["pulse"] = "Pulse Shots"
GM.AmmoNames["alyxgun"] = "LMG"
GM.AmmoNames["gravity"] = "Battle Rifle"
GM.AmmoNames["rpg_round"] = "RPG"
GM.AmmoNames["CombineHeavyCannon"] = "Heavy"

GM.PointShopAmmoNames = {
	["pistol"] = "pistolammo",
	["buckshot"] = "shotgunammo",
	["smg1"] = "smgammo",
	["ar2"] = "assaultrifleammo",
	["357"] = "rifleammo",
	["XBowBolt"] = "crossbowammo",
	["gravity"] = "brammo",
	["alyxgun"] = "mgammo",
	["rpg_round"] = "rpg",
	["combineheavycannon"] = "heavyammo",
	["impactmine"] = "impactmine",
	["pulse"] = "pulseammo",
}

GM.AmmoTranslations = {}
GM.AmmoTranslations["weapon_physcannon"] = "pistol"
GM.AmmoTranslations["weapon_ar2"] = "ar2"
GM.AmmoTranslations["weapon_shotgun"] = "buckshot"
GM.AmmoTranslations["weapon_smg1"] = "smg1"
GM.AmmoTranslations["weapon_pistol"] = "pistol"
GM.AmmoTranslations["weapon_357"] = "357"
GM.AmmoTranslations["weapon_slam"] = "pistol"
GM.AmmoTranslations["weapon_crowbar"] = "pistol"
GM.AmmoTranslations["weapon_stunstick"] = "pistol"

GM.AmmoModels = {}
GM.AmmoModels["pistol"] = "models/Items/BoxSRounds.mdl" -- Pistols
GM.AmmoModels["smg1"] = "models/Items/BoxMRounds.mdl" -- SMGs
GM.AmmoModels["ar2"] = "models/props/pickup/ammo_armag.mdl" -- Assault rifles
GM.AmmoModels["battery"] = "models/healthvial.mdl" -- Medical Kit charge
GM.AmmoModels["buckshot"] = "models/Items/BoxBuckshot.mdl" -- Buckshot
GM.AmmoModels["357"] = "models/props/pickup/ammo_riflebox.mdl" -- Slugs
GM.AmmoModels["xbowbolt"] = "models/Items/CrossbowRounds.mdl" -- Bolts
GM.AmmoModels["gaussenergy"] = "models/Items/CrossbowRounds.mdl" -- Nails
GM.AmmoModels["grenade"] = "models/weapons/w_grenade.mdl" -- Grenades
GM.AmmoModels["thumper"] = "models/Combine_turrets/Floor_turret.mdl" -- Gun turrets
GM.AmmoModels["airboatgun"] = "models/Items/item_item_crate.mdl" -- Arsenal crates
GM.AmmoModels["striderminigun"] = "models/props_combine/combine_mine01.mdl" -- Message beacons
GM.AmmoModels["helicoptergun"] = "models/Items/ammocrate_ar2.mdl" -- Resupply boxes
GM.AmmoModels["slam"] = "models/props_lab/lab_flourescentlight002b.mdl" -- Force Field Emitters
GM.AmmoModels["spotlamp"] = "models/props_combine/combine_light001a.mdl"
GM.AmmoModels["stone"] = "models/props_junk/rock001a.mdl"
GM.AmmoModels["pulse"] = "models/Items/combine_rifle_ammo01.mdl"
GM.AmmoModels["gravity"] = "models/props/pickup/ammo_brifle.mdl" -- battle rifles
GM.AmmoModels["alyxgun"] = "models/props/pickup/ammo_lmg.mdl" -- machine guns

GM.AmmoIcons = {}
GM.AmmoIcons["pistol"] = "ammo_pistol"
GM.AmmoIcons["smg1"] = "ammo_smg"
GM.AmmoIcons["ar2"] = "ammo_assault"
GM.AmmoIcons["battery"] = "ammo_medpower"
GM.AmmoIcons["buckshot"] = "ammo_shotgun"
GM.AmmoIcons["357"] = "ammo_rifle"
GM.AmmoIcons["xbowbolt"] = "ammo_bolts"
GM.AmmoIcons["gaussenergy"] = "ammo_nail"
GM.AmmoIcons["pulse"] = "ammo_pulse"
GM.AmmoIcons["impactmine"] = "ammo_explosive"
GM.AmmoIcons["chemical"] = "ammo_chemical"
GM.AmmoIcons["scrap"] = "ammo_scrap"

GM.FriendlyAmmoNames = {
	["pistol"] = "Pistol",
	["buckshot"] = "Shotgun",
	["smg1"] = "SMG",
	["ar2"] = "Assault Rifle",
	["357"] = "Rifle",
	["XBowBolt"] = "Crossbow",
	["gravity"] = "Battle Rifle",
	["alyxgun"] = "Machine Gun",
	["rpg_round"] = "RPG",
	["CombineHeavyCannon"] = "Heavy"

}
-- Handled in languages file.
GM.ValidBeaconMessages = {
	"message_beacon_1",
	"message_beacon_2",
	"message_beacon_3",
	"message_beacon_4",
	"message_beacon_5",
	"message_beacon_6",
	"message_beacon_7",
	--"message_beacon_8",
	"message_beacon_9",
	"message_beacon_10",
	"message_beacon_11",
	"message_beacon_12",
	"message_beacon_13",
	"message_beacon_14",
	"message_beacon_15",
	"message_beacon_16",
	"message_beacon_17",
	"message_beacon_18",
	"message_beacon_19",
	"message_beacon_20",
	"message_beacon_21",
	"message_beacon_22",
	"message_beacon_23",
	"message_beacon_24",
	"message_beacon_25"
}

GM.FanList = {
	"1418945843",
	"1595085577",
	"3311458935",
	"3023059541",
	"2000875318",
	"778584317",
	"6086255",
	"2867054481"
}
