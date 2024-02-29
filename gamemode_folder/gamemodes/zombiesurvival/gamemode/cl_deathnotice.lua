if not killicon.GetFont then
	killicon.OldAddFont = killicon.AddFont
	killicon.OldAddAlias = killicon.AddAlias
	killicon.OldAdd = killicon.Add

	local storedfonts = {}
	local storedicons = {}

	function killicon.AddFont(sClass, sFont, sLetter, cColor)
		storedfonts[sClass] = {sFont, sLetter, cColor}
		return killicon.OldAddFont(sClass, sFont, sLetter, cColor)
	end

	function killicon.Add(sClass, sTexture, cColor)
		storedicons[sClass] = {sTexture, cColor}
		return killicon.OldAdd(sClass, sTexture, cColor)
	end

	function killicon.AddAlias(sClass, sBaseClass)
		if storedfonts[sClass] then
			return killicon.AddFont(sBaseClass, storedfonts[sClass][1], storedfonts[sClass][2], storedfonts[sClass][3])
		elseif storedicons[sClass] then
			return killicon.Add(sBaseClass, storedicons[sClass][1], storedicons[sClass][2])
		end
	end

	function killicon.Get(sClass)
		return killicon.GetFont(sClass) or killicon.GetIcon(sClass)
	end

	function killicon.GetFont(sClass)
		return storedfonts[sClass]
	end

	function killicon.GetIcon(sClass)
		return storedicons[sClass]
	end
end

killicon.AddFont("default", "zsdeathnoticecs", "C", color_white)
killicon.AddFont("suicide", "zsdeathnoticecs", "C", color_white)
killicon.AddFont("player", "zsdeathnoticecs", "C", color_white)
killicon.AddFont("worldspawn", "zsdeathnoticecs", "C", color_white)
killicon.AddFont("func_move_linear", "zsdeathnoticecs", "C", color_white)
killicon.AddFont("func_rotating", "zsdeathnoticecs", "C", color_white)
killicon.AddFont("trigger_hurt", "zsdeathnoticecs", "C", color_white)

killicon.AddFont("prop_physics", "zsdeathnotice", "9", color_white)
killicon.AddFont("prop_physics_multiplayer", "zsdeathnotice", "9", color_white)
killicon.AddFont("func_physbox", "zsdeathnotice", "9", color_white)
killicon.AddFont("weapon_smg1", "zsdeathnotice", "/", color_white)
killicon.AddFont("weapon_357", "zsdeathnotice", ".", color_white)
killicon.AddFont("weapon_ar2", "zsdeathnotice", "2", color_white)
killicon.AddFont("crossbow_bolt", "zsdeathnotice", "1", color_white)
killicon.AddFont("weapon_shotgun", "zsdeathnotice", "0", color_white)
killicon.AddFont("rpg_missile", "zsdeathnotice", "3", color_white)
killicon.AddFont("npc_grenade_frag", "zsdeathnotice", "4", color_white)
killicon.AddFont("weapon_pistol", "zsdeathnotice", "-", color_white)
killicon.AddFont("prop_combine_ball", "zsdeathnotice", "8", color_white)
killicon.AddFont("grenade_ar2", "zsdeathnotice", "7", color_white)
killicon.AddFont("weapon_stunstick", "zsdeathnotice", "!", color_white)
killicon.AddFont("weapon_slam", "zsdeathnotice", "*", color_white)
killicon.AddFont("weapon_crowbar", "zsdeathnotice", "6", color_white)


killicon.Add("redeem", "killicon/redeem_v2", color_white)
killicon.Add("headshot", "materials/zombiesurvival/weapons/headshot.png", color_white)

killicon.Add("weapon_zs_constructor", "materials/zombiesurvival/weapons/constructor.png", COLOR_PURPLE)
killicon.Add("weapon_zs_medstation", "materials/zombiesurvival/weapons/medstation.png", COLOR_PURPLE)
killicon.Add("weapon_zs_medgun", "materials/zombiesurvival/weapons/medkit.png", COLOR_CYAN)
killicon.Add("weapon_zs_stone", "materials/zombiesurvival/weapons/stone.png", COLOR_ORANGE)
killicon.Add("projectile_stone", "materials/zombiesurvival/weapons/stone.png", COLOR_ORANGE)
killicon.Add("weapon_zs_arsenalcrate", "materials/zombiesurvival/weapons/arsenalcrate.png", color_white)
killicon.Add("weapon_zs_messagebeacon", "materials/zombiesurvival/weapons/messagebeacon.png", COLOR_RED)
killicon.Add("weapon_zs_resupplybox", "materials/zombiesurvival/weapons/resupplybag.png", color_white)
killicon.Add("weapon_zs_medicalkit", "materials/zombiesurvival/weapons/medkit.png", color_white)
killicon.Add("weapon_zs_barricadekit", "materials/zombiesurvival/weapons/aegisbarricadekit.png", COLOR_RED)
killicon.Add("weapon_zs_wrench", "materials/zombiesurvival/weapons/wrench.png", COLOR_YELLOW)
killicon.Add("weapon_zs_gunturret", "materials/zombiesurvival/weapons/infraredgunturret.png", COLOR_RORANGE)
killicon.Add("weapon_zs_shotgunturret", "materials/zombiesurvival/weapons/infraredshotgunturret.png", COLOR_BLUE)
killicon.Add("weapon_zs_drone", "materials/zombiesurvival/weapons/multipurposutilitydrone.png", COLOR_BLUE)
killicon.Add("weapon_zs_boardpack", "materials/zombiesurvival/weapons/extrajunkpackprop.png", COLOR_BLUE)
killicon.Add("weapon_zs_spotlamp", "materials/zombiesurvival/weapons/spotlight.png", COLOR_BLUE)
killicon.Add("weapon_zs_teleporter", "materials/zombiesurvival/weapons/teleporter.png", COLOR_BLUE)

killicon.Add("weapon_zs_nanitecloudbomb", "materials/zombiesurvival/weapons/nanitecloud.png", COLOR_YELLOW)
killicon.Add("weapon_zs_crygasgrenade", "materials/zombiesurvival/weapons/cryogas.png", COLOR_RORANGE)
killicon.Add("weapon_zs_corogas", "materials/zombiesurvival/weapons/corogas.png", COLOR_BLUE)
killicon.Add("weapon_zs_mediccloudbomb", "materials/zombiesurvival/weapons/mediccloudbomb.png", COLOR_BLUE)

killicon.Add("weapon_zs_grenade", "materials/zombiesurvival/weapons/grenade.png", COLOR_BLUE)
killicon.Add("weapon_zs_detpack", "materials/zombiesurvival/weapons/detpack.png", COLOR_BLUE)
killicon.Add("weapon_zs_molotov", "materials/zombiesurvival/weapons/molotav.png", COLOR_BLUE)
killicon.Add("weapon_zs_hunter", "materials/zombiesurvival/weapons/hunterrifle.png", COLOR_BLUE)



killicon.Add("m9k_rpg7", "materials/zombiesurvival/weapons/rpg7.png", COLOR_BLUE)

 
--CW2.0

killicon.Add("cw_sniper_m1carbine", "materials/zombiesurvival/weapons/m1carbine.png", color_white )
killicon.Add("cw_sniper_delisle", "materials/zombiesurvival/weapons/delilse.png", color_white)
killicon.Add("cw_pistol_qz92", "materials/zombiesurvival/weapons/qz92.png", color_white)  
killicon.Add("cw_smg_aksd", "materials/zombiesurvival/weapons/aksd.png", color_white) 
killicon.Add("cw_ar_famasg2", "materials/zombiesurvival/weapons/famas.png", color_white) 
killicon.Add("cw_shotgun_elephant", "materials/zombiesurvival/weapons/elephantgun.png", color_white) 
killicon.Add("cw_shotgun_shotty", "materials/zombiesurvival/weapons/supershotty.png", color_white) 
killicon.Add("cw_pistol_cz75", "materials/zombiesurvival/weapons/cz75.png", color_white) 
killicon.Add("cw_pistol_p226", "materials/zombiesurvival/weapons/p226.png", color_white) 

-- Vanilla Weapons 

killicon.Add("weapon_zs_peashooter", "materials/zombiesurvival/weapons/peashooter.png", color_white)
killicon.Add("weapon_zs_battleaxe", "materials/zombiesurvival/weapons/battleaxe.png", color_white)  
killicon.Add("weapon_zs_owens", "materials/zombiesurvival/weapons/owenshandgun.png", color_white) 
killicon.Add("weapon_zs_tosser", "materials/zombiesurvival/weapons/tossersmg.png", color_white) 
killicon.Add("weapon_zs_blaster", "materials/zombiesurvival/weapons/blastershotgun.png", color_white) 
killicon.Add("weapon_zs_stubber", "materials/zombiesurvival/weapons/stubberrifle.png", color_white) 
killicon.Add("weapon_zs_crackler", "materials/zombiesurvival/weapons/cracklerassaultrifle.png", color_white) 
killicon.Add("weapon_zs_z9000", "materials/zombiesurvival/weapons/z900pulsepistol.png", color_white) 

killicon.Add("weapon_zs_boomstick", "materials/zombiesurvival/weapons/boomstick.png", COLOR_ORANGE)
killicon.Add("weapon_zs_sg550", "materials/zombiesurvival/weapons/killersg550rifle.png", COLOR_RED)
killicon.Add("weapon_zs_annabelle", "materials/zombiesurvival/weapons/annabellerifle.png", COLOR_LIMEGREEN)
killicon.Add("weapon_zs_silencer", "materials/zombiesurvival/weapons/silencersmg.png", COLOR_DARKGREEN)
killicon.Add("weapon_zs_eraser", "materials/zombiesurvival/weapons/eraser.png", COLOR_YELLOW)
killicon.Add("weapon_zs_sweepershotgun", "materials/zombiesurvival/weapons/sweepershotgun.png", COLOR_DARKRED)
killicon.Add("weapon_zs_bulletstorm", "materials/zombiesurvival/weapons/bulletstormsmg.png", COLOR_LBLUE)
killicon.Add("weapon_zs_crossbow", "materials/zombiesurvival/weapons/impalersupercrossbow.png", COLOR_RPINK)
killicon.Add("projectile_arrow", "materials/zombiesurvival/weapons/impalersupercrossbow.png", COLOR_BLUE)
killicon.Add("weapon_zs_deagle", "materials/zombiesurvival/weapons/zombiedrillerdeserteagle.png", COLOR_RPURPLE)
killicon.Add("weapon_zs_glock3", "materials/zombiesurvival/weapons/crossfireglock3.png", COLOR_BLUE)
killicon.Add("weapon_zs_magnum", "materials/zombiesurvival/weapons/ricochetmagnum.png", COLOR_RPURPLE)
killicon.Add("weapon_zs_slugrifle", "materials/zombiesurvival/weapons/tinyslugrifle.png", COLOR_RORANGE)
killicon.Add("weapon_zs_smg", "materials/zombiesurvival/weapons/shreddersmg.png", COLOR_TAN)
killicon.Add("weapon_zs_swissarmyknife", "materials/zombiesurvival/weapons/zknife.png", COLOR_RPINK)
killicon.Add("weapon_zs_uzi", "materials/zombiesurvival/weapons/sprayeruzi9mm.png", COLOR_LBLUE)
killicon.Add("weapon_zs_inferno", "materials/zombiesurvival/weapons/aug.png", COLOR_DARKRED)
killicon.Add("weapon_zs_m4", "materials/zombiesurvival/weapons/m4.png", COLOR_YELLOW)
killicon.Add("weapon_zs_reaper", "materials/zombiesurvival/weapons/reaperump.png", COLOR_DARKGREEN)
killicon.Add("weapon_zs_pulserifle", "materials/zombiesurvival/weapons/adonispulserifle.png", COLOR_CYAN)
killicon.Add("weapon_zs_akbar", "materials/zombiesurvival/weapons/akbarassaultrifle.png", COLOR_ORANGE)
killicon.Add("weapon_zs_ender", "materials/zombiesurvival/weapons/enderautomaticshotgun.png", COLOR_CYAN)
killicon.Add("weapon_zs_redeemers", "materials/zombiesurvival/weapons/pistol.png", COLOR_BLUE)

killicon.Add("weapon_zs_biopistol", "materials/zombiesurvival/weapons/biopistol.png", COLOR_DARKGREEN)
killicon.Add("weapon_zs_biosmg", "materials/zombiesurvival/weapons/bio2.png", COLOR_CYAN)
killicon.Add("weapon_zs_bioar", "materials/zombiesurvival/weapons/bio5.png", COLOR_ORANGE)
killicon.Add("weapon_zs_aliensmg", "materials/zombiesurvival/weapons/bio3.png", COLOR_CYAN)
killicon.Add("weapon_zs_alienrifle", "materials/zombiesurvival/weapons/bio4.png", COLOR_BLUE)
killicon.Add("weapon_zs_biorifle", "materials/zombiesurvival/weapons/bio6.png", COLOR_DARKGREEN)
killicon.Add("weapon_zs_bioshotgun", "materials/zombiesurvival/weapons/bio1.png", COLOR_CYAN)
killicon.Add("weapon_zs_avatarrifle", "materials/zombiesurvival/weapons/bio3.png", COLOR_ORANGE)


-- CW MELEE

killicon.Add("cw_melee_knife","materials/zombiesurvival/weapons/knife.png", color_white)
killicon.Add("cw_melee_crowbar","materials/zombiesurvival/weapons/crowbar.png", color_white)
killicon.Add("cw_melee_stunstick","materials/zombiesurvival/weapons/stunbaton.png", color_white)
killicon.Add("cw_melee_dagger","materials/zombiesurvival/weapons/dagger.png", color_white)
killicon.Add("cw_melee_brokensword","materials/zombiesurvival/weapons/brokensword.png", color_white)
killicon.Add("cw_melee_cutjavelin","materials/zombiesurvival/weapons/cutjavelin.png", color_white)
killicon.Add("cw_melee_secretdagger","materials/zombiesurvival/weapons/secretdagger.png", color_white)
killicon.Add("cw_melee_cjavelin","materials/zombiesurvival/weapons/cutthrowingdagger.png", color_white)
killicon.Add("cw_melee_shortsword","materials/zombiesurvival/weapons/shortsword.png", color_white)
killicon.Add("cw_melee_stiletto","materials/zombiesurvival/weapons/shortsword.png", color_white)
killicon.Add("cw_melee_scimitar","materials/zombiesurvival/weapons/scimitar.png", color_white)
killicon.Add("cw_melee_cleaver","materials/zombiesurvival/weapons/cleaver.png", color_white)




killicon.Add("cw_melee_mailbreaker","materials/zombiesurvival/weapons/mailbreaker.png", color_white)
killicon.Add("cw_melee_wspear","materials/zombiesurvival/weapons/winged_spear.png", color_white)
killicon.Add("cw_melee_broadsword","materials/zombiesurvival/weapons/broad_sword.png", color_white)
killicon.Add("cw_melee_mirdanhammer","materials/zombiesurvival/weapons/mirdan_hammer.png", color_white)
killicon.Add("cw_melee_claymore","materials/zombiesurvival/weapons/claymore.png", color_white)
killicon.Add("cw_melee_ivorysword","materials/zombiesurvival/weapons/ivorysword.png", color_white)
killicon.Add("cw_melee_halberd","materials/zombiesurvival/weapons/halberd.png", color_white)

killicon.Add("cw_melee_burntivorysword","materials/zombiesurvival/weapons/burntivorysword.png", color_white)
killicon.Add("cw_melee_babynail","materials/zombiesurvival/weapons/babynail.png", color_white)
killicon.Add("cw_melee_flameberge","materials/zombiesurvival/weapons/flamberge.png", color_white)
killicon.Add("cw_melee_sspear","materials/zombiesurvival/weapons/scrapingspear.png", color_white)
killicon.Add("cw_melee_stormruler","materials/zombiesurvival/weapons/stormruler.png", color_white)
killicon.Add("cw_melee_zweihander","materials/zombiesurvival/weapons/zweihander.png", color_white)
killicon.Add("cw_melee_longsword","materials/zombiesurvival/weapons/longsword.png", color_white)

killicon.Add("cw_melee_moonblade","materials/zombiesurvival/weapons/moonlight.png", color_white)
killicon.Add("cw_melee_dragonsmasher","materials/zombiesurvival/weapons/dragonbone.png", color_white)
killicon.Add("cw_melee_dragonslayer","materials/zombiesurvival/weapons/dragonslayer.png", color_white)





-- VANILLA MELEE 

killicon.Add("weapon_zs_axe", "materials/zombiesurvival/weapons/axe.png", color_white)
killicon.Add("weapon_zs_crowbar","materials/zombiesurvival/weapons/zcrowbar.png", color_white)
killicon.Add("weapon_zs_stunbaton","materials/zombiesurvival/weapons/zstunbaton.png", color_white)
killicon.Add("weapon_zs_swissarmyknife","materials/zombiesurvival/weapons/zknife.png", color_white)
killicon.Add("weapon_zs_plank","materials/zombiesurvival/weapons/plank.png", color_white)
killicon.Add("weapon_zs_fryingpan","materials/zombiesurvival/weapons/fryingpan.png", color_white)
killicon.Add("weapon_zs_pot","materials/zombiesurvival/weapons/pot.png", color_white)
killicon.Add("weapon_zs_pipe","materials/zombiesurvival/weapons/pipe.png", color_white)
killicon.Add("weapon_zs_hook","materials/zombiesurvival/weapons/hook.png", color_white)
killicon.Add("weapon_zs_bust", "materials/zombiesurvival/weapons/bust.png", color_white)
killicon.Add("weapon_zs_butcherknife", "materials/zombiesurvival/weapons/cleaver.png", color_white)
killicon.Add("weapon_zs_butcherknifez", "materials/zombiesurvival/weapons/cleaver.png", color_white)
killicon.Add("cw_tool_hammer", "materials/zombiesurvival/weapons/hammer.png", COLOR_WHITE)
killicon.Add("weapon_zs_hammerplank", "materials/zombiesurvival/weapons/hammerplank.png", COLOR_BLUE)

killicon.Add("weapon_zs_shovel", "materials/zombiesurvival/weapons/shovel.png", COLOR_BLUE)
killicon.Add("weapon_zs_sledgehammer", "materials/zombiesurvival/weapons/sledgehammer.png", COLOR_BLUE)
killicon.Add("weapon_zs_carver", "materials/zombiesurvival/weapons/carvingblade.png", COLOR_BLUE)
killicon.Add("weapon_zs_osiris", "materials/zombiesurvival/weapons/osiris.png", COLOR_BLUE)
killicon.Add("weapon_zs_excursion", "materials/zombiesurvival/weapons/excursionblade.png", COLOR_BLUE)
killicon.Add("weapon_zs_sawhack", "materials/zombiesurvival/weapons/sawhack.png", COLOR_BLUE)
killicon.Add("weapon_zs_bust", "materials/zombiesurvival/weapons/bustonastick.png", COLOR_BLUE)
killicon.Add("weapon_zs_nukeplank", "materials/zombiesurvival/weapons/nuclearplank.png", COLOR_BLUE)
killicon.Add("weapon_zs_megamasher", "materials/zombiesurvival/weapons/megamasher.png", COLOR_BLUE)
killicon.Add("weapon_zs_rebellion", "materials/zombiesurvival/weapons/rebellion.png", COLOR_BLUE)
killicon.Add("weapon_zs_arbiter", "materials/zombiesurvival/weapons/arbiter.png", COLOR_BLUE)
killicon.Add("weapon_zs_katana", "materials/zombiesurvival/weapons/yomato.png", COLOR_BLUE)
killicon.Add("weapon_zs_psykineticblade", "materials/zombiesurvival/weapons/psycheticknife.png", COLOR_BLUE)
killicon.Add("weapon_zs_cocknballs", "materials/zombiesurvival/weapons/cocknballs.png", COLOR_BLUE)
killicon.Add("weapon_zs_gravestone", "materials/zombiesurvival/weapons/gravestone.png", COLOR_BLUE)


killicon.Add("weapon_zs_crow", "materials/zombiesurvival/killicons2/crow.png", COLOR_YELLOW)



killicon.Add("weapon_zs_zombietorso", "materials/zombiesurvival/killicons2/zombie.png", COLOR_YELLOW)
killicon.Add("weapon_zs_zombielegs", "materials/zombiesurvival/killicons2/zombie.png", COLOR_ORANGE)
killicon.Add("weapon_zs_freshdead", "materials/zombiesurvival/killicons2/zombie.png", COLOR_RORANGE)
killicon.Add("weapon_zs_classiczombie", "materials/zombiesurvival/killicons2/zombie.png", COLOR_RED)


killicon.Add("weapon_zs_zombie", "materials/zombiesurvival/killicons2/zombie.png", COLOR_GREEN)
killicon.Add("weapon_zs_ghoul", "materials/zombiesurvival/killicons2/ghoul.png", COLOR_PURPLE)
killicon.Add("weapon_zs_headcrab", "materials/zombiesurvival/killicons2/headcrab.png", COLOR_BLUE)
killicon.Add("weapon_zs_alphacrab", "materials/zombiesurvival/killicons2/chadcrab.png", COLOR_WHITE)
killicon.Add("weapon_zs_fastheadcrab", "materials/zombiesurvival/killicons2/fastheadcrab.png", COLOR_LIMEGREEN)
killicon.Add("weapon_zs_shadowlurker", "materials/zombiesurvival/killicons2/shadowlurker.png", COLOR_YELLOW)
killicon.Add("weapon_zs_fleshcreeper", "materials/zombiesurvival/killicons2/fleshcreeper.png", COLOR_YELLOW)

killicon.Add("weapon_zs_gorebuster", "materials/zombiesurvival/killicons2/gorebuster.png", COLOR_WHITE)
killicon.Add("weapon_zs_bloatedzombie", "materials/zombiesurvival/killicons2/bloatedzombie.png", COLOR_YELLOW)
killicon.Add("weapon_zs_wraith", "materials/zombiesurvival/killicons2/wraith.png", COLOR_PURPLE)

killicon.Add("weapon_zs_fastzombie", "materials/zombiesurvival/killicons2/fastzombie.png", COLOR_ORANGE)
killicon.Add("weapon_zs_fastzombielegs", "materials/zombiesurvival/killicons2/fastzombie.png", COLOR_RED)
killicon.Add("weapon_zs_lacerator", "materials/zombiesurvival/killicons2/lacerator.png", COLOR_WHITE)

killicon.Add("weapon_zs_poisonheadcrab", "materials/zombiesurvival/killicons2/poisonheadcrab.png", COLOR_BLUE)
killicon.Add("weapon_zs_poisonzombie", "materials/zombiesurvival/killicons2/poisonzombie.png", COLOR_GREEN)

killicon.Add("weapon_zs_chemzombie", "materials/zombiesurvival/killicons2/chemzombie.png", COLOR_WHITE)
killicon.Add("dummy_chemzombie", "materials/zombiesurvival/killicons2/chemzombie.png", COLOR_WHITE)
killicon.Add("weapon_zs_nightowl", "materials/zombiesurvival/killicons2/nightowl.png", COLOR_RPURPLE)
killicon.Add("weapon_zs_hulkingzombie", "materials/zombiesurvival/killicons2/hulkingzombie.png", COLOR_LIMEGREEN)
killicon.Add("weapon_zs_eradicator", "materials/zombiesurvival/killicons2/eradicator.png", COLOR_PURPLE)

killicon.Add("weapon_zs_juggernaut", "materials/zombiesurvival/killicons2/juggernaut.png", COLOR_DARKBLUE)
killicon.Add("weapon_zs_ticklemonster", "materials/zombiesurvival/killicons2/ticklemonster.png", COLOR_WHITE)
killicon.Add("weapon_zs_nightmare", "materials/zombiesurvival/killicons2/nightmare.png", COLOR_WHITE)

-- Super Zombie 
killicon.Add("weapon_zs_superzombie", "materials/zombiesurvival/killicons2/zombie.png", COLOR_CYAN)


-- Bosses
killicon.Add("weapon_zs_pukepus", "materials/zombiesurvival/killicons2/pukepus.png", COLOR_WHITE)
killicon.Add("weapon_zs_bonemesh", "materials/zombiesurvival/killicons2/bonemesh.png", COLOR_WHITE)
killicon.Add("weapon_zs_zblaster", "materials/zombiesurvival/killicons2/bioblaster.png", COLOR_DARKBLUE)
killicon.Add("weapon_zs_gravedigger", "materials/zombiesurvival/killicons2/gravedigger.png", COLOR_WHITE)
killicon.Add("weapon_zs_howler", "materials/zombiesurvival/killicons2/howler.png", COLOR_RED)
killicon.Add("weapon_zs_lurker", "materials/zombiesurvival/killicons2/lurker.png", COLOR_ORANGE)
killicon.Add("weapon_zs_shade", "materials/zombiesurvival/killicons2/shade.png", COLOR_WHITE)
killicon.Add("cw_melee_zugs", "materials/zombiesurvival/killicons2/executioner.png", COLOR_WHITE)




-- CW 2.0 

killicon.Add("cw_pistol_berreta", "materials/zombiesurvival/weapons/berreta.png", COLOR_YELLOW)
killicon.Add("cw_pistol_usp40","materials/zombiesurvival/weapons/usp40.png", COLOR_ORANGE)
killicon.Add("cw_pistol_glock","materials/zombiesurvival/weapons/glock.png", COLOR_RED)
killicon.Add("cw_pistol_deagle","materials/zombiesurvival/weapons/deagle.png", COLOR_DARKRED)
killicon.Add("cw_pistol_mr96", "materials/zombiesurvival/weapons/mr95.png", COLOR_RPURPLE)
killicon.Add("cw_pistol_contender","materials/zombiesurvival/weapons/g2contender.png", COLOR_PURPLE)
killicon.Add("cw_pistol_cz75_auto","materials/zombiesurvival/weapons/czsuperauto.png", COLOR_DARKBLUE)
killicon.Add("cw_pistol_627", "materials/zombiesurvival/weapons/sw627.png", COLOR_LBLUE)
killicon.Add("cw_pistol_python", "materials/zombiesurvival/weapons/python.png", COLOR_CYAN)
killicon.Add("cw_pistol_rex","materials/zombiesurvival/weapons/rex.png", COLOR_LIMEGREEN)
killicon.Add("cw_pistol_satan", "materials/zombiesurvival/weapons/m29satan.png", COLOR_GREEN)
killicon.Add("cw_pistol_calico", "materials/zombiesurvival/weapons/calico.png", COLOR_DARKGREEN)

killicon.Add("cw_smg_mp5a4","materials/zombiesurvival/weapons/mp5a4.png", COLOR_YELLOW)
killicon.Add("cw_smg_mp5a5", "materials/zombiesurvival/weapons/mp5a5.png", COLOR_ORANGE)
killicon.Add("cw_smg_mp40", "materials/zombiesurvival/weapons/mp40.png", COLOR_RED)
killicon.Add("cw_smg_p90","materials/zombiesurvival/weapons/fnp90.png", COLOR_DARKRED)
killicon.Add("cw_smg_vector","materials/zombiesurvival/weapons/krissvector.png", COLOR_RPURPLE)
killicon.Add("cw_smg_veresk", "materials/zombiesurvival/weapons/srveresk.png", COLOR_PURPLE)
killicon.Add("cw_smg_hb","materials/zombiesurvival/weapons/honeybadger.png", COLOR_DARKBLUE)
killicon.Add("cw_smg_fmg9", "materials/zombiesurvival/weapons/fmg9.png", COLOR_LBLUE)
killicon.Add("cw_smg_ump45", "materials/zombiesurvival/weapons/ump45.png", COLOR_CYAN)
killicon.Add("cw_smg_vk10", "materials/zombiesurvival/weapons/vector10.png", COLOR_LIMEGREEN)
killicon.Add("cw_smg_l2a3", "materials/zombiesurvival/weapons/sterling.png", COLOR_GREEN)
killicon.Add("cw_smg_thompson", "materials/zombiesurvival/weapons/thompson.png", COLOR_DARKGREEN)


killicon.Add("cw_ar_masada","materials/zombiesurvival/weapons/magpullmasada.png",  COLOR_YELLOW)
killicon.Add("cw_ar_fal","materials/zombiesurvival/weapons/fal.png", COLOR_ORANGE)
killicon.Add("cw_ar_ar15", "materials/zombiesurvival/weapons/ar15.png", COLOR_RED)
killicon.Add("cw_ar_g36c","materials/zombiesurvival/weapons/g36c.png", COLOR_DARKRED)
killicon.Add("cw_ar_aek", "materials/zombiesurvival/weapons/aek971.png", COLOR_RPURPLE)
killicon.Add("cw_ar_xm8", "materials/zombiesurvival/weapons/xm8.png",  COLOR_PURPLE)
killicon.Add("cw_ar_an94","materials/zombiesurvival/weapons/an94.png", COLOR_YELLOW)
killicon.Add("cw_ar_ak103", "materials/zombiesurvival/weapons/ak103.png", COLOR_DARKBLUE)
killicon.Add("cw_ar_g3a3", "materials/zombiesurvival/weapons/g3a3.png", COLOR_LBLUE)
killicon.Add("cw_ar_hcar", "materials/zombiesurvival/weapons/hcar.png", COLOR_CYAN)
killicon.Add("cw_ar_masada_acr", "materials/zombiesurvival/weapons/masadaacr.png", COLOR_LIMEGREEN)
killicon.Add("cw_ar_m4a4", "materials/zombiesurvival/weapons/m4a4.png", COLOR_DARKGREEN)
killicon.Add("cw_ar_m4a1", "materials/zombiesurvival/weapons/m4a1.png", COLOR_RORANGE)
killicon.Add("cw_ar_akm", "materials/zombiesurvival/weapons/akm.png", COLOR_RPINK)
killicon.Add("cw_ar_m16a4", "materials/zombiesurvival/weapons/m16a4.png", COLOR_RPURPLE)
killicon.Add("cw_ar_roku","materials/zombiesurvival/weapons/m4a4roku.png", COLOR_SOFTRED)

killicon.Add("cw_shotgun_m620", "materials/zombiesurvival/weapons/stevensmodel.png", COLOR_YELLOW)
killicon.Add("cw_shotgun_m1014","materials/zombiesurvival/weapons/m1014.png", COLOR_ORANGE)
killicon.Add("cw_shotgun_mossberg", "materials/zombiesurvival/weapons/mossberg.png", COLOR_RED)
killicon.Add("cw_shotgun_saiga","materials/zombiesurvival/weapons/saiga12k.png", COLOR_DARKRED)
killicon.Add("cw_shotgun_dao12", "materials/zombiesurvival/weapons/striker.png", COLOR_RPURPLE)
killicon.Add("cw_shotgun_ksg12", "materials/zombiesurvival/weapons/ksg12.png", COLOR_PURPLE)
killicon.Add("cw_shotgun_ks23","materials/zombiesurvival/weapons/ks23.png", COLOR_DARKBLUE)
killicon.Add("cw_shotgun_jackhammer", "materials/zombiesurvival/weapons/jackhammer.png",  COLOR_LBLUE)
killicon.Add("cw_shotgun_spas12", "materials/zombiesurvival/weapons/spas12.png", COLOR_CYAN)
killicon.Add("cw_shotgun_toz","materials/zombiesurvival/weapons/tozbm16.png", COLOR_LIMEGREEN)
killicon.Add("cw_shotgun_aa12", "materials/zombiesurvival/weapons/aa12.png", COLOR_DARKGREEN)

killicon.Add("cw_sniper_mosin","materials/zombiesurvival/weapons/mosin.png", COLOR_YELLOW)
killicon.Add("cw_sniper_sks", "materials/zombiesurvival/weapons/sks.png", COLOR_BLUE)
killicon.Add("cw_sniper_sksd", "materials/zombiesurvival/weapons/sksd.png", COLOR_ORANGE)
killicon.Add("cw_sniper_svt","materials/zombiesurvival/weapons/svt.png", COLOR_RED)
killicon.Add("cw_sniper_m1garand","materials/zombiesurvival/weapons/m1garand.png", COLOR_DARKRED)
killicon.Add("cw_sniper_sr338", "materials/zombiesurvival/weapons/sr338.png",  COLOR_RPURPLE)
killicon.Add("cw_sniper_m82","materials/zombiesurvival/weapons/m82.png",  COLOR_PURPLE)
killicon.Add("cw_sniper_awm", "materials/zombiesurvival/weapons/awm.png", COLOR_DARKBLUE)
killicon.Add("cw_sniper_l115a3", "materials/zombiesurvival/weapons/l115a3.png", COLOR_LBLUE)
killicon.Add("cw_sniper_t5000","materials/zombiesurvival/weapons/t5000.png", COLOR_CYAN)
killicon.Add("cw_sniper_m98b", "materials/zombiesurvival/weapons/m98b.png", COLOR_LIMEGREEN)
killicon.Add("cw_sniper_m95", "materials/zombiesurvival/weapons/m95.png", COLOR_DARKGREEN)

killicon.Add("cw_lmg_ar57", "materials/zombiesurvival/weapons/ar57.png", COLOR_YELLOW)
killicon.Add("cw_lmg_mg4", "materials/zombiesurvival/weapons/mg4.png", COLOR_ORANGE)
killicon.Add("cw_lmg_m240", "materials/zombiesurvival/weapons/m240.png",COLOR_RED)
killicon.Add("cw_lmg_m27","materials/zombiesurvival/weapons/m27.png", COLOR_DARKRED)
killicon.Add("cw_lmg_ares", "materials/zombiesurvival/weapons/ares.png", COLOR_RPURPLE)
killicon.Add("cw_lmg_type88", "materials/zombiesurvival/weapons/type88.png", COLOR_PURPLE)
killicon.Add("cw_lmg_mg36","materials/zombiesurvival/weapons/mg36.png", COLOR_DARKBLUE)
killicon.Add("cw_lmg_pkm","materials/zombiesurvival/weapons/pkm.png", COLOR_LBLUE)
killicon.Add("cw_lmg_m60","materials/zombiesurvival/weapons/m60.png", COLOR_CYAN)
killicon.Add("cw_lmg_m60e4", "materials/zombiesurvival/weapons/m60e4.png", COLOR_LIMEGREEN)
killicon.Add("cw_lmg_hmg", "materials/zombiesurvival/weapons/hmg.png", COLOR_DARKGREEN)

--killicon.Add("thedrucilucy", "FINDANICON", color_white)
killicon.Add("vz61", "killicon/vz61", color_white)


--TODO: Use the shared listeners to save on networking overhead
net.Receive("zs_crow_kill_crow", function(length)
	local victim = net.ReadString()
	local attacker = net.ReadString()

	--gamemode.Call("AddDeathNotice", attacker, TEAM_UNDEAD, "weapon_zs_crow", victim, TEAM_UNDEAD)
	GAMEMODE:TopNotify(attacker, " ", {killicon = "weapon_zs_crow"}, " ", victim)
end)

net.Receive("zs_pl_kill_pl", function(length)
	local victim = net.ReadEntity()
	local attacker = net.ReadEntity()

	local inflictor = net.ReadString()

	local victimteam = net.ReadUInt(16)
	local attackerteam = net.ReadUInt(16)

	local headshot = net.ReadBit() == 1

	if victim:IsValid() and attacker:IsValid() then
		local attackername = attacker:Name()
		local victimname = victim:Name()

		if victim == MySelf then
			if victimteam == TEAM_HUMAN then
				gamemode.Call("LocalPlayerDied", attackername)
			end
		elseif attacker == MySelf then
			if attacker:Team() == TEAM_UNDEAD then
				gamemode.Call("FloatingScore", victim, "floatingscore_und", 1, 0)
			end
		end

		victim:CallZombieFunction("OnKilled", attacker, attacker, attacker == victim, headshot, DamageInfo())

		print(attackername.." killed "..victimname.." with "..inflictor)

		--gamemode.Call("AddDeathNotice", attackername, attackerteam, inflictor, victimname, victimteam, headshot)
		--GAMEMODE:TopNotify(attacker, " ", {killicon = "default", headshot = headshot}, " ", victim)
		GAMEMODE:TopNotify(attacker, " ", {killicon = inflictor, headshot = headshot}, " ", victim)
		--revert this when killicons are fixed
	end
end)

net.Receive("zs_pls_kill_pl", function(length)
	local victim = net.ReadEntity()
	local attacker = net.ReadEntity()
	local assister = net.ReadEntity()

	local inflictor = net.ReadString()

	local victimteam = net.ReadUInt(16)
	local attackerteam = net.ReadUInt(16)

	local headshot = net.ReadBit() == 1

	if victim:IsValid() and attacker:IsValid() and assister:IsValid() then
		local victimname = victim:Name()
		local attackername = attacker:Name()
		local assistername = assister:Name()

		if victim == MySelf and victimteam == TEAM_HUMAN then
			gamemode.Call("LocalPlayerDied", attackername.." and "..assistername)
		end

		victim:CallZombieFunction("OnKilled", attacker, attacker, attacker == victim, headshot, DamageInfo())

		print(attackername.." and "..assistername.." killed "..victimname.." with "..inflictor)

		--gamemode.Call("AddDeathNotice", attackername.." and "..assistername, attackerteam, inflictor, victimname, victimteam, headshot)
		GAMEMODE:TopNotify(attacker, " and ", assister, " ", {killicon = inflictor, headshot = headshot}, " ", victim)
	end
end)

net.Receive("zs_pl_kill_self", function(length)
	local victim = net.ReadEntity()
	local victimteam = net.ReadUInt(16)

	if victim:IsValid() then
		if victim == MySelf and victimteam == TEAM_HUMAN then
			gamemode.Call("LocalPlayerDied")
		end

		victim:CallZombieFunction("OnKilled", victim, victim, true, false, DamageInfo())

		local victimname = victim:Name()

		print(victimname.." killed themself")

		--gamemode.Call("AddDeathNotice", nil, 0, "suicide", victimname, victimteam)
		GAMEMODE:TopNotify({killicon = "suicide"}, " ", victim)
	end
end)

net.Receive("zs_playerredeemed", function(length)
	local pl = net.ReadEntity()
	local name = net.ReadString()

	--gamemode.Call("AddDeathNotice", nil, 0, "redeem", name, TEAM_HUMAN)

	if pl:IsValid() then
		GAMEMODE:TopNotify(pl, " has redeemed! ", {killicon = "redeem"})

		if pl == MySelf then
			GAMEMODE:CenterNotify(COLOR_CYAN, translate.Get("you_redeemed"))
		end
	end
end)

net.Receive("zs_death", function(length)
	local victim = net.ReadEntity()
	local inflictor = net.ReadString()
	local attacker = "#" .. net.ReadString()
	local victimteam = net.ReadUInt(16)

	if victim:IsValid() then
		if victim == MySelf and victimteam == TEAM_HUMAN then
			gamemode.Call("LocalPlayerDied")
		end

		victim:CallZombieFunction("OnKilled", attacker, NULL, attacker == victim, false, DamageInfo())

		local victimname = victim:Name()

		print(victimname.." was killed by "..attacker.." with "..inflictor)

		--gamemode.Call("AddDeathNotice", attacker, -1, inflictor, victimname, victimteam)
		GAMEMODE:TopNotify(COLOR_RED, attacker, " ", {deathicon = inflictor}, " ", victim)
	end
end)

local entNames = {
	["prop_creepernest"] = "Fleshcreeper Nest",


}


net.Receive("zs_pl_kill_ent", function(ln) 
	local victim = net.ReadEntity()
	local attacker = net.ReadEntity()
	--local attacker = net.ReadString()
	if !attacker:IsValid() or !attacker:IsPlayer() then return end
	if !victim:IsValid() then return end
	if entNames[victim:GetClass()] then
		victimname = entNames[victim:GetClass()]
	end
	attackername = attacker:Nick()
	

	print(victimname.." was killed by "..attackername)
	GAMEMODE:TopNotify(attacker, " ", {killicon = "default"}, " ", victimname)
end)

-- Handled above.
function GM:AddDeathNotice()
end
