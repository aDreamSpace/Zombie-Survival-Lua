SimpleXPConfig = {} -- DON'T MODIFY THIS. IF YOU DO, NOTHING WILL WORK.

-- SIMPLE LEVELING CONFIGURATION --
-- IF YOU DON'T KNOW WHAT YOU'RE DOING, --
-- ITS BEST NOT TO DO IT OR AT LEAST READ THE README--



---- Core

SimpleXPConfig.DefaultFolder = "playerxpdata" 
-- Values: string, lowercase letters and numbers only.
-- Changes the default data storage folder for this addon.
-- WARNING: DO NOT EDIT THIS VALUE WHILE YOUR SERVER IS RUNNING OR YOU WILL EXPERIENCE DATA FUCKUPS THAT I AM ABSOLUTELY NOT RESPONSIBLE FOR.
-- WARNING: EDITING THIS VALUE WILL CAUSE EVERYONE'S XP TO BE SET TO 0 UNLESS YOU RENAME THE VALUE TO THE PREVIOUS FILE STORAGE NAME (DEFAULT: simplexp)
-- YOU SHOULD ONLY EDIT THIS IF YOU DON'T LIKE THIS DATA STORAGE NAME OR YOU WANT TO HARD RESET EVERYONE'S XP.

-- NEW IN 1.2
SimpleXPConfig.PlayerCount = 0
-- Values: Integers between 0 and maxplayers
-- Allows combat XP to be gained only when this amount of players and more are present on the server.

---- Visual
-- All of these settings are fine to edit, EXCEPT for DisplayTargetXP

SimpleXPConfig.DisplayHints = true
--Values: true, false
--When set to true, it will display hints about how to use this addon to each player when they join and every 20 minutes after.
--Disable this if you already have these hints in your motd or a similar addon.

SimpleXPConfig.DisplayTargetXP = true
--Values: true, false
--When set to true, it displays target information similar to the default target information when looking at a player. 
--Disable this if you already have custom target information HUD.

SimpleXPConfig.UseFixedColors = true
--Values: true, false
-- When set to true, it doesn't use the current player's team/job color but instead a fixed color set below.
-- Changes are not overwritten for players who have already joined your server with this addon installed.
-- Players can change the colour themselves by using the command !xphud.

SimpleXPConfig.DefaultRed = 255
SimpleXPConfig.DefaultGreen = 255
SimpleXPConfig.DefaultBlue = 255
SimpleXPConfig.DefaultAlpha = 255
--Values: 0 to 255
-- Color values for the HUD
--These colors use RGBA http://www.rapidtables.com/web/color/RGB_Color.htm

SimpleXPConfig.HUD_Length = 0.5
-- Values: any number between 0 and 1. Recommended to keep above 0.1
-- Length multiplier for the XP bar relative to the length of the player's screen.
-- 1 = Entire screen width, 0.5 = half screen width, 0 = no screen width (not reccommended).

SimpleXPConfig.HUD_Pos = 0
-- Values: any number between 0 and 1
-- Position multiplier for the XP bar relative to the height of the player's screen.
-- 1 = bottom, 0.5, = center, 0 = top.

SimpleXPConfig.HUD_Flip = true
-- Values: true, false
-- Setting this to true will place the xp text under the xp bar. Useful for when the xp bar is at the top.



---- Scales

SimpleXPConfig.LevelScale = 1
-- Values: Any positive value greater than 0. Recommended to keep around 1.
-- Capped between 0.01 and 100 to prevent math logic errors.
-- Scales for the xp requirement for XP. High values increase the amount of time to reach the next level.
-- WARNING: IT IS RECCOMMENDED THAT YOU DO NOT CHANGE THIS VALUE WHEN THE SERVER IS RUNNING.
-- Lower values decrease the amount of time to reach the next level.
-- Higher numbers require more xp for a level up, lower numbers require less xp for a level up.
-- All player's levels will change upon changing this value.

SimpleXPConfig.WeekdayScale = 0.5
-- Values: Any real positive number.
-- XP multiplier earned on Monday, Tuesday, Wednesday, Thursday, Friday.
-- Time is based on the server's operating time, so be sure to have that set up properly if you're using dedicated servers.
-- Higher numbers give more xp, lower numbers give less xp.
-- Values multiplied are rounded down.
-- Negative XP rewards are unaffected by this multiplier.

SimpleXPConfig.WeekendScale = 0.5
-- Values: Any real positive number.
-- XP multiplier earned on Saturday, Sunday.
-- Time is based on the server's operating time, so be sure to have that set up properly if you're using dedicated servers.
-- Higher numbers give more xp, lower numbers give less xp.
-- Values multiplied are rounded down.
-- Negative XP rewards are unaffected by this multiplier.



---- Interval XP
-- XP given over time.

SimpleXPConfig.GiveXPOnTimeEnable = true
-- Values: true, false.
-- Automaticly gives XP every so often for being on the server.
-- Based on the below settings.

SimpleXPConfig.GiveXPOnTimeAmount = 500
-- Values: Any real number.
-- Gives this amount of XP for being on the server.
-- Affected by weekend and weekday multipliers.

SimpleXPConfig.GiveXPOnTimeDelay = 600
-- Values: Any positive real number.
-- Delay in seconds where it gives XP for being on the server.
-- Everyone receives this bonus at once.

SimpleXPConfig.GiveXPOnTimeMessage = "PLAYTIME BONUS"
-- Values: Any text message in quotes.
-- Message Displayed when receiving a playtime bonus, if there is one.



---- Kill Triggers
-- XP given on kills. Fractional Values will be rounded down.

SimpleXPConfig.Kills = 5 
-- Values: Any real number.
-- XP given to the player when the player performs a kill on another player.

SimpleXPConfig.Assist	= 5
-- Values: Any real number.
-- XP given to the player per point of damage done to another player that died from another player.

SimpleXPConfig.Suicide = -400
-- Values: Any real number.
-- XP given to the player when the player committed suicide.

SimpleXPConfig.Headshots = 5
-- Values: Any real number.
-- XP given to the player from killing another player with a headshot.

SimpleXPConfig.Multikills	= 1
-- Values: Any real number.
-- XP given to the player per other player killed in a period of 7 seconds.

SimpleXPConfig.Spree = 1
-- Values: Any real number.
-- XP given to the player per additional kill in a killing spree. (Kills in one life.)

SimpleXPConfig.Survivor = 25
-- Values: Any real number.
-- XP given to the player for having below 25 HP when killing another player.

SimpleXPConfig.Range = 100
-- Values: Any real number.
-- XP given to the player when the player performs a long range kill on another player.

SimpleXPConfig.Overkill = 0.5
-- Values: Any real number.
-- XP given to the player per point of fatal damage dealt to another player past 0hp.
-- Total value must exceed 25 for the reward to be given.
-- Example: Killing someone at 25 hp with a 100 damage weapon will give you 75 bonus XP at the default setting of 1.

SimpleXPConfig.RepeatOffender	= 25
-- Values: Any real number.
-- XP given to the player for killing the same person that the player killed previously.

SimpleXPConfig.Revenge = 100
-- Values: Any real number.
-- XP given to the player for killing the person that killed them previously.

SimpleXPConfig.HigherLevel = 5
-- Values: Any real number.
-- XP given to the player per level difference when killing a higher level player.
-- Example: If you're level 4, and you kill someone who is level 10, you will receive 30xp. [ (10 - 4)*5 = 30 ]



---- Weapon based XP triggers
-- These are based on all the holdtypes available in gmod. 
-- See: https://wiki.garrysmod.com/page/Hold_Types

SimpleXPConfig.Pistol	= 100
-- Values: Any real number
-- XP given to the player for pistol, revolver, or duel kills.

SimpleXPConfig.SMG = 0
-- Values: Any real number
-- XP given to the player for smg kills

SimpleXPConfig.Equipment = 0
-- Values: Any real number
-- XP given to the player for grenade or slam kills

SimpleXPConfig.Rifle = 0
-- Values: Any real number
-- XP given to the player for ar2 kills

SimpleXPConfig.Shotgun = 0
-- Values: Any real number
-- XP given to the player for shotgun kills

SimpleXPConfig.Launcher = 0
-- Values: Any real number
-- XP given to the player for rpg kills

SimpleXPConfig.Phys = 0
-- Values: Any real number
-- XP given to the player for physgun kills

SimpleXPConfig.Crossbow = 0
-- Values: Any real number
-- XP given to the player for crossbow kills

SimpleXPConfig.Melee = 500
-- Values: Any real number
-- XP given to the player for melee, melee1, fist, and knife kills

SimpleXPConfig.Magic = 0
-- Values: Any real number
-- XP given to the player for normal, passive, magic, and camera kills



---- NPC Settings
-- XP Settings for killing an NPC

SimpleXPConfig.NpcKillsBase = 5
-- Values: Any real number
-- Base XP given to the player for killing an NPC

SimpleXPConfig.NpcMaxHealth = 1
-- Values: Any real number
-- Bonus XP given to the player for each point of max HP the NPC has.



---- Health/Armor Settings
-- Health/Armor regen/bonus settings that you may or may not like
-- Settings are applied on spawn

SimpleXPConfig.TickTime = 5
-- Values: Any real positive number.
-- Time it takes to regen health/armor amount.
-- Example: A hp regen rate of 0.2 and a ticktime of 0.1 will give 2hp per second per level. [0.2/0.1 = 2]
-- If you don't want to do math, just set this to 1.

SimpleXPConfig.BonusHP = 1
-- Values: Any real number. Final Health Value clamped between 1 and 9999.
-- Bonus health given per level
-- NOTICE: The health is rounded down, meaning that if the value is set at 0.1, the health will increase by one every ten levels.

SimpleXPConfig.BonusHPRegen = 0.001
-- Values: Any real number
-- Bonus health regeneration given per level. Stops at max health.

SimpleXPConfig.BonusArmor = 1
-- Values: Any real number. Final Armor Value clamped between 0 and 250.
-- Bonus armor given per level

SimpleXPConfig.BonusArmorRegen = 0.1
-- Values: Any real number
-- Bonus armor regeneration given per level. Stops at BonusArmor * CurrentLevel.
-- NOTICE: The regen is rounded down, meaning that if the value is set at 0.1, the armor regen will increase by one armor per second every ten levels.



---- Rank Settings
-- Levelcaps and custom ranks.

SimpleXPConfig.LevelCap = 3000
-- Values: Any positive full number.
-- Puts a level cap in place, this is the point where experience is no longer collected.
-- If the level cap is lowered, then all players who exceeded that level cap will have their XP reduced to that level.
-- If you don't want a level cap, its best to set the value to something impossibly high like 1000 or 5000.

SimpleXPConfig.EnableCustomRanks = true
-- Values: true, false
-- Enables custom ranks. See below.

SimpleXPConfig.CustomRanks = {} -- DON'T TOUCH THIS
-- How it works: number is converted into an actual rank
-- Example: SimpleXPConfig.CustomRanks[0] = "Recruit"
-- This means that if the person is rank 0, it will display "Recruit" instead
-- If someone is higher than the maximum ranks, in this case rank 66, it will add prestige <number passed maximum rank> at the end of the rank if it is passed the level cap.

SimpleXPConfig.CustomRanks[0] = "Recruit"

SimpleXPConfig.CustomRanks[1] = "Private I"
SimpleXPConfig.CustomRanks[2] = "Private II"

SimpleXPConfig.CustomRanks[3] = "Private First Class I"
SimpleXPConfig.CustomRanks[4] = "Private First Class II"

SimpleXPConfig.CustomRanks[5] = "Specialist I"
SimpleXPConfig.CustomRanks[6] = "Specialist II"
SimpleXPConfig.CustomRanks[7] = "Specialist III"

SimpleXPConfig.CustomRanks[8] = "Corporal I"
SimpleXPConfig.CustomRanks[9] = "Corporal II"
SimpleXPConfig.CustomRanks[10] = "Corporal III"

SimpleXPConfig.CustomRanks[11] = "Sergeant I"
SimpleXPConfig.CustomRanks[12] = "Sergeant II"
SimpleXPConfig.CustomRanks[13] = "Sergeant III"

SimpleXPConfig.CustomRanks[14] = "Staff Sergeant I"
SimpleXPConfig.CustomRanks[15] = "Staff Sergeant II"
SimpleXPConfig.CustomRanks[16] = "Staff Sergeant III"
SimpleXPConfig.CustomRanks[17] = "Staff Sergeant IV"

SimpleXPConfig.CustomRanks[18] = "Sergeant First Class I"
SimpleXPConfig.CustomRanks[19] = "Sergeant First Class II"
SimpleXPConfig.CustomRanks[20] = "Sergeant First Class III"
SimpleXPConfig.CustomRanks[21] = "Sergeant First Class IV"

SimpleXPConfig.CustomRanks[22] = "Master Sergeant I"
SimpleXPConfig.CustomRanks[23] = "Master Sergeant II"
SimpleXPConfig.CustomRanks[24] = "Master Sergeant III"
SimpleXPConfig.CustomRanks[25] = "Master Sergeant IV"

SimpleXPConfig.CustomRanks[26] = "First Sergeant I"
SimpleXPConfig.CustomRanks[27] = "First Sergeant II"
SimpleXPConfig.CustomRanks[28] = "First Sergeant III"
SimpleXPConfig.CustomRanks[29] = "First Sergeant IV"

SimpleXPConfig.CustomRanks[30] = "Sergeant Major I"
SimpleXPConfig.CustomRanks[31] = "Sergeant Major II"
SimpleXPConfig.CustomRanks[32] = "Sergeant Major III"
SimpleXPConfig.CustomRanks[33] = "Sergeant Major IV"
SimpleXPConfig.CustomRanks[34] = "Sergeant Major V"

SimpleXPConfig.CustomRanks[35] = "Command Sergeant Major I"
SimpleXPConfig.CustomRanks[36] = "Command Sergeant Major II"
SimpleXPConfig.CustomRanks[37] = "Command Sergeant Major III"
SimpleXPConfig.CustomRanks[38] = "Command Sergeant Major IV"
SimpleXPConfig.CustomRanks[39] = "Command Sergeant Major V"

SimpleXPConfig.CustomRanks[40] = "Sergeant Major of the Army I"
SimpleXPConfig.CustomRanks[41] = "Sergeant Major of the Army II"
SimpleXPConfig.CustomRanks[42] = "Sergeant Major of the Army III"
SimpleXPConfig.CustomRanks[43] = "Sergeant Major of the Army IV"
SimpleXPConfig.CustomRanks[44] = "Sergeant Major of the Army V"

SimpleXPConfig.CustomRanks[45] = "Warrant Officer I"
SimpleXPConfig.CustomRanks[46] = "Warrant Officer II"
SimpleXPConfig.CustomRanks[47] = "Warrant Officer III"
SimpleXPConfig.CustomRanks[48] = "Warrant Officer IV"
SimpleXPConfig.CustomRanks[49] = "Warrant Officer V"

SimpleXPConfig.CustomRanks[50] = "Chief Warrant Officer I"
SimpleXPConfig.CustomRanks[51] = "Chief Warrant Officer II"
SimpleXPConfig.CustomRanks[52] = "Chief Warrant Officer III"
SimpleXPConfig.CustomRanks[53] = "Chief Warrant Officer IV"
SimpleXPConfig.CustomRanks[54] = "Chief Warrant Officer V"

SimpleXPConfig.CustomRanks[55] = "Second Lieutenant"
SimpleXPConfig.CustomRanks[56] = "First Lieutenant"
SimpleXPConfig.CustomRanks[57] = "Captain"
SimpleXPConfig.CustomRanks[58] = "Major"
SimpleXPConfig.CustomRanks[59] = "Lieutenant Colonel"

SimpleXPConfig.CustomRanks[60] = "Colonel"
SimpleXPConfig.CustomRanks[61] = "Brigadier General"
SimpleXPConfig.CustomRanks[62] = "Major General"
SimpleXPConfig.CustomRanks[63] = "Lieutenant General"
SimpleXPConfig.CustomRanks[64] = "General"
SimpleXPConfig.CustomRanks[65] = "General of the Army"

SimpleXPConfig.CustomRanks[66] = "Supreme General I"
SimpleXPConfig.CustomRanks[67] = "Supreme General II"
SimpleXPConfig.CustomRanks[68] = "Supreme General III"
SimpleXPConfig.CustomRanks[69] = "Supreme General IV"
SimpleXPConfig.CustomRanks[70] = "Supreme General V"

local rankWords = {
    "Private",
    "Corporal",
    "Sergeant",
    "Lieutenant",
    "Captain",
    "Major",
    "Colonel",
    "General",
    "Supreme General",
    "Commander",
    "Admiral",
    "Marshal",
    "Warlord",
    "Champion",
    "Hero",
    "Legend",
    "Master",
    "Grandmaster",
    "Epic",
    "Mythic",
    "Titan",
    "Deity",
    "Immortal",
    "Eternal",
    "Infinite",
    "Prime",
    "Ultimate",
    "Absolute",
    "Paramount",
    "Pinnacle",
    "Apex",
    "Zenith",
    "Transcendent",
    "Unseen",
    "Cosmic",
    "Galactic",
    "Universal",
    "Aficionado",
    "Enthusiast",
    "Devotee",
    "Fanatic",
    "Wallop",
    "Thwack",
    "Whack",
    "Clobber",
    "Belt",
    "Sock",
    "Bop",
    "Smack",
    "Slap",
    "Pat",
    "Tap",
    "Touch",
    "Contact",
    "Connection",
    "Link",
    "Tie",
    "Bond",
    "Relation",
    "Relationship",
    "Kinship",
    "Affinity",
    "Sympathy",
    "Empathy",
    "Understanding",
    "Comprehension",
    "Grasp",
    "Grip",
    "Hold",
    "Clasp",
    "Clutch",
    "Grasp",
    "Mythic"
}

for i = 71, 200 do
    local rankIndex = ((i - 1) % #rankWords) + 1  -- Calculate the rank index
    local level = math.floor((i - 1) / #rankWords) + 15  -- Calculate the level
    local rank = rankWords[rankIndex]  -- Get the rank word based on the index
    SimpleXPConfig.CustomRanks[i] = "Level " .. level .. " " .. rank
end
