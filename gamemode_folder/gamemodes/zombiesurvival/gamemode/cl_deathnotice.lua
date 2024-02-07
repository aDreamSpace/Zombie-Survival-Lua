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

killicon.AddFont("headshot", "zsdeathnoticecs", "D", color_white)
killicon.Add("redeem", "killicon/redeem_v2", color_white)


killicon.Add("prop_gunturret", "zombiesurvival/killicons/prop_gunturret", color_white)
killicon.Add("weapon_zs_gunturret", "zombiesurvival/killicons/prop_gunturret", color_white)
killicon.Add("weapon_zs_gunturretremove", "zombiesurvival/killicons/prop_gunturret", color_white)
killicon.AddFont("projectile_zsgrenade", "zsdeathnotice", "4", color_white)
killicon.AddFont("weapon_zs_grenade", "zsdeathnotice", "4", color_white)
killicon.AddFont("prop_detpack", "zsdeathnotice", "*", color_white)
killicon.AddFont("weapon_zs_detpack", "zsdeathnotice", "*", color_white)
killicon.AddFont("weapon_zs_detpackremote", "zsdeathnotice", "*", color_white)
killicon.AddFont("weapon_zs_stubber", "zsdeathnoticecs", "n", color_white)
killicon.AddFont("weapon_zs_hunter", "zsdeathnoticecs", "r", color_white)
killicon.AddFont("weapon_zs_tosser", "zsdeathnotice", "/", color_white)
killicon.AddFont("weapon_zs_owens", "zsdeathnotice", "-", color_white)
killicon.AddFont("weapon_zs_battleaxe", "zsdeathnoticecs", "c", color_white)
killicon.AddFont("weapon_zs_boomstick", "zsdeathnotice", "0", color_white)
killicon.AddFont("weapon_zs_annabelle", "zsdeathnotice", "0", color_white)
killicon.AddFont("weapon_zs_silencer", "zsdeathnoticecs", "d", color_white)
killicon.Add("weapon_zs_blaster", "killicon/blaster", color_white)
killicon.AddFont("weapon_zs_eraser", "zsdeathnoticecs", "u", color_white)
killicon.AddFont("weapon_zs_sweepershotgun", "zsdeathnoticecs", "k", color_white)
killicon.AddFont("weapon_zs_zesweeper", "zsdeathnoticecs", "k", color_white)
killicon.AddFont("weapon_zs_barricadekit", "zsdeathnotice", "3", color_white)
killicon.AddFont("weapon_zs_bulletstorm", "zsdeathnoticecs", "m", color_white)
killicon.AddFont("weapon_zs_crossbow", "zsdeathnotice", "1", color_white)
killicon.AddFont("projectile_arrow", "zsdeathnotice", "1", color_white)
killicon.AddFont("weapon_zs_deagle", "zsdeathnoticecs", "f", color_white)
killicon.AddFont("weapon_zs_zedeagle", "zsdeathnoticecs", "f", color_white)
killicon.AddFont("weapon_zs_glock3", "zsdeathnoticecs", "c", color_white)
killicon.AddFont("weapon_zs_magnum", "zsdeathnotice", ".", color_white)
killicon.AddFont("weapon_zs_peashooter", "zsdeathnoticecs", "a", color_white)
killicon.AddFont("weapon_zs_slugrifle", "zsdeathnoticecs", "n", color_white)
killicon.AddFont("weapon_zs_smg", "zsdeathnoticecs", "x", color_white)
killicon.AddFont("weapon_zs_zesmg", "zsdeathnoticecs", "x", color_white)
killicon.AddFont("weapon_zs_swissarmyknife", "zsdeathnoticecs", "j", color_white)
killicon.AddFont("weapon_zs_zeknife", "zsdeathnoticecs", "j", color_white)
killicon.AddFont("weapon_zs_uzi", "zsdeathnoticecs", "l", color_white)
killicon.AddFont("weapon_zs_inferno", "zsdeathnoticecs", "e", color_white)
killicon.AddFont("weapon_zs_m4", "zsdeathnoticecs", "w", color_white)
killicon.AddFont("weapon_zs_reaper", "zsdeathnoticecs", "q", color_white)
killicon.AddFont("weapon_zs_crackler", "zsdeathnoticecs", "t", color_white)
killicon.AddFont("weapon_zs_pulserifle", "zsdeathnotice", "2", color_white)
killicon.AddFont("weapon_zs_akbar", "zsdeathnoticecs", "b", color_white)
killicon.AddFont("weapon_zs_zeakbar", "zsdeathnoticecs", "b", color_white)
killicon.AddFont("weapon_zs_ender", "zsdeathnoticecs", "v", color_white)
killicon.AddFont("weapon_zs_redeemers", "zsdeathnoticecs", "s", color_white)
killicon.Add("weapon_zs_axe", "killicon/axe", color_white)
killicon.Add("weapon_zs_sawhack", "killicon/axe", color_white)
killicon.Add("weapon_zs_keyboard", "killicon/keyboard", color_white)
killicon.Add("weapon_zs_sledgehammer", "killicon/sledgehammer", color_white)
killicon.Add("weapon_zs_megamasher", "killicon/megamasher", color_white)
killicon.Add("weapon_zs_fryingpan", "killicon/fryingpan", color_white)
killicon.Add("weapon_zs_pot", "killicon/pot", color_white)
killicon.Add("weapon_zs_plank", "killicon/plank", color_white)
killicon.Add("weapon_zs_hammer", "killicon/hammer", color_white)
killicon.Add("weapon_zs_electrohammer", "killicon/hammer", color_white)
killicon.Add("weapon_zs_shovel", "killicon/shovel", color_white)
killicon.AddFont("weapon_zs_crowbar", "zsdeathnotice", "6", color_white)
killicon.AddFont("weapon_zs_stunbaton", "zsdeathnotice", "!", color_white)


killicon.Add("weapon_zs_constructor", "materials/zombiesurvival/deployables/constructor.png", COLOR_PURPLE)
killicon.Add("weapon_zs_medstation", "materials/zombiesurvival/deployables/medstation.png", COLOR_PURPLE)




killicon.Add("weapon_zs_medgun", "materials/zombiesurvival/weapons/medkit.png", COLOR_CYAN)

killicon.Add("weapon_zs_stone", "materials/zombiesurvival/weapons/stone.png", COLOR_ORANGE)
killicon.Add("projectile_stone", "materials/zombiesurvival/weapons/stone.png", COLOR_ORANGE)

killicon.Add("weapon_zs_arsenalcrate", "materials/zombiesurvival/deployables/arsenalcrate.png", color_white)
killicon.Add("weapon_zs_messagebeacon", "materials/zombiesurvival/deployables/barricadekit.png", COLOR_RED)
killicon.Add("weapon_zs_resupplybox", "materials/zombiesurvival/deployables/resupply.png", color_white)

--CW2.0

killicon.Add("cw_sniper_m1carbine", "materials/zombiesurvival/weapons/sniper.png", color_white )
killicon.Add("cw_sniper_delisle", "materials/zombiesurvival/weapons/sniper.png", color_white)
killicon.Add("cw_pistol_qz92", "materials/zombiesurvival/weapons/pistol.png", color_white)  
killicon.Add("cw_smg_aksd", "materials/zombiesurvival/weapons/smg.png", color_white) 
killicon.Add("cw_ar_famasg2", "materials/zombiesurvival/weapons/ar2.png", color_white) 
killicon.Add("cw_shotgun_elephant", "materials/zombiesurvival/weapons/shotgun.png", color_white) 
killicon.Add("cw_shotgun_shotty", "materials/zombiesurvival/weapons/shotgun.png", color_white) 
killicon.Add("cw_pistol_cz75", "materials/zombiesurvival/weapons/pistol.png", color_white) 
killicon.Add("cw_pistol_p226", "materials/zombiesurvival/weapons/pistol.png", color_white) 

killicon.Add("weapon_zs_peashooter", "materials/zombiesurvival/weapons/pistol.png", color_white)
killicon.Add("weapon_zs_battleaxe", "materials/zombiesurvival/weapons/pistol.png", color_white)  
killicon.Add("weapon_zs_owens", "materials/zombiesurvival/weapons/pistol.png", color_white) 
killicon.Add("weapon_zs_tosser", "materials/zombiesurvival/weapons/smg.png", color_white) 
killicon.Add("weapon_zs_blaster", "materials/zombiesurvival/weapons/shotgun.png", color_white) 
killicon.Add("weapon_zs_stubber", "materials/zombiesurvival/weapons/sniper.png", color_white) 
killicon.Add("weapon_zs_crackler", "materials/zombiesurvival/weapons/ar2.png", color_white) 
killicon.Add("weapon_zs_z9000", "materials/zombiesurvival/weapons/pistol.png", color_white) 

killicon.Add("cw_melee_knife","materials/zombiesurvival/weapons/melee.png", color_white)
killicon.Add("cw_melee_crowbar","materials/zombiesurvival/weapons/melee.png", color_white)
killicon.Add("cw_melee_stunstick","materials/zombiesurvival/weapons/melee.png", color_white)
killicon.Add("cw_melee_brokensword","materials/zombiesurvival/weapons/melee.png", color_white)
killicon.Add("cw_melee_cutjavelin","materials/zombiesurvival/weapons/melee.png", color_white)
killicon.Add("cw_melee_secretdagger","materials/zombiesurvival/weapons/melee.png", color_white)
killicon.Add("cw_melee_cjavelin","materials/zombiesurvival/weapons/melee.png", color_white)




-- VANILLA MELEE 

killicon.Add("weapon_zs_axe", "materials/zombiesurvival/weapons/melee.png", color_white)
killicon.Add("weapon_zs_crowbar","materials/zombiesurvival/weapons/melee.png", color_white)
killicon.Add("weapon_zs_stunbaton","materials/zombiesurvival/weapons/melee.png", color_white)
killicon.Add("weapon_zs_swissarmyknife","materials/zombiesurvival/weapons/melee.png", color_white)
killicon.Add("weapon_zs_plank","materials/zombiesurvival/weapons/melee.png", color_white)
killicon.Add("weapon_zs_fryingpan","materials/zombiesurvival/weapons/melee.png", color_white)
killicon.Add("weapon_zs_pot","materials/zombiesurvival/weapons/melee.png", color_white)
killicon.Add("weapon_zs_pipe","materials/zombiesurvival/weapons/melee.png", color_white)
killicon.Add("weapon_zs_hook","materials/zombiesurvival/weapons/melee.png", color_white)
killicon.Add("weapon_zs_bust", "materials/zombiesurvival/weapons/melee.png", color_white)
killicon.Add("weapon_zs_butcherknife", "materials/zombiesurvival/weapons/melee.png", color_white)
killicon.Add("weapon_zs_butcherknifez", "materials/zombiesurvival/weapons/melee.png", color_white)
killicon.Add("cw_tool_hammer", "materials/zombiesurvival/weapons/hammer.png", COLOR_WHITE)
killicon.Add("weapon_zs_hammerplank", "materials/zombiesurvival/weapons/hammer.png", COLOR_BLUE)

-- BIO WEAPONS

killicon.Add("weapon_zs_biopistol", "materials/zombiesurvival/weapons/pulse.png", COLOR_ORANGE)
killicon.Add("weapon_zs_biosmg", "materials/zombiesurvival/weapons/pulse.png", COLOR_RED)
killicon.Add("weapon_zs_bioar", "materials/zombiesurvival/weapons/pulse.png", COLOR_LIMEGREEN)
killicon.Add("weapon_zs_aliensmg", "materials/zombiesurvival/weapons/pulse.png", COLOR_DARKGREEN)
killicon.Add("weapon_zs_alienrifle", "materials/zombiesurvival/weapons/pulse.png", COLOR_YELLOW)
killicon.Add("weapon_zs_biorifle", "materials/zombiesurvival/weapons/pulse.png", COLOR_DARKRED)
killicon.Add("weapon_zs_bioshotgun", "materials/zombiesurvival/weapons/pulse.png", COLOR_LBLUE)
killicon.Add("weapon_zs_avatarrifle", "materials/zombiesurvival/weapons/pulse.png", COLOR_RPINK)

killicon.Add("projectile_biopistol", "materials/zombiesurvival/weapons/pulse.png", COLOR_ORANGE)
killicon.Add("projectile_biosmg", "materials/zombiesurvival/weapons/pulse.png", COLOR_RED)
killicon.Add("projectile_bioar", "materials/zombiesurvival/weapons/pulse.png", COLOR_LIMEGREEN)
killicon.Add("projectile_aliensmg", "materials/zombiesurvival/weapons/pulse.png", COLOR_DARKGREEN)
killicon.Add("projectile_alienrifle", "materials/zombiesurvival/weapons/pulse.png", COLOR_YELLOW)
killicon.Add("projectile_biorifle", "materials/zombiesurvival/weapons/pulse.png", COLOR_DARKRED)
killicon.Add("projectile__bioshotgun", "materials/zombiesurvival/weapons/pulse.png", COLOR_LBLUE)
killicon.Add("projectile__avatarrifle", "materials/zombiesurvival/weapons/pulse.png", COLOR_RPINK)



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




-- VANILLA GUN

killicon.Add("weapon_zs_boomstick", "materials/zombiesurvival/weapons/shotgun.png", COLOR_ORANGE)
killicon.Add("weapon_zs_sg550", "materials/zombiesurvival/weapons/sniper.png", COLOR_RED)
killicon.Add("weapon_zs_annabelle", "materials/zombiesurvival/weapons/shotgun.png", COLOR_LIMEGREEN)
killicon.Add("weapon_zs_silencer", "materials/zombiesurvival/weapons/smg.png", COLOR_DARKGREEN)
killicon.Add("weapon_zs_eraser", "materials/zombiesurvival/weapons/pistol.png", COLOR_YELLOW)
killicon.Add("weapon_zs_sweepershotgun", "materials/zombiesurvival/weapons/shotgun.png", COLOR_DARKRED)
killicon.Add("weapon_zs_bulletstorm", "materials/zombiesurvival/weapons/smg.png", COLOR_LBLUE)
killicon.Add("weapon_zs_crossbow", "materials/zombiesurvival/weapons/sniper.png", COLOR_RPINK)
killicon.Add("projectile_arrow", "materials/zombiesurvival/weapons/sniper.png", COLOR_BLUE)
killicon.Add("weapon_zs_deagle", "materials/zombiesurvival/weapons/pistol.png", COLOR_RPURPLE)
killicon.Add("weapon_zs_glock3", "materials/zombiesurvival/weapons/pistol.png", COLOR_BLUE)
killicon.Add("weapon_zs_magnum", "materials/zombiesurvival/weapons/pistol.png", COLOR_RPURPLE)
killicon.Add("weapon_zs_slugrifle", "materials/zombiesurvival/weapons/sniper.png", COLOR_RORANGE)
killicon.Add("weapon_zs_smg", "materials/zombiesurvival/weapons/smg.png", COLOR_TAN)
killicon.Add("weapon_zs_swissarmyknife", "materials/zombiesurvival/weapons/melee.png", COLOR_RPINK)
killicon.Add("weapon_zs_uzi", "materials/zombiesurvival/weapons/smg.png", COLOR_LBLUE)
killicon.Add("weapon_zs_inferno", "materials/zombiesurvival/weapons/ar2.png", COLOR_DARKRED)
killicon.Add("weapon_zs_m4", "materials/zombiesurvival/weapons/ar2.png", COLOR_YELLOW)
killicon.Add("weapon_zs_reaper", "materials/zombiesurvival/weapons/smg.png", COLOR_DARKGREEN)
killicon.Add("weapon_zs_crackler", "materials/zombiesurvival/weapons/ar2.png", COLOR_LIMEGREEN)
killicon.Add("weapon_zs_pulserifle", "materials/zombiesurvival/weapons/pulse.png", COLOR_CYAN)
killicon.Add("weapon_zs_akbar", "materials/zombiesurvival/weapons/ar2.png", COLOR_ORANGE)
killicon.Add("weapon_zs_ender", "materials/zombiesurvival/weapons/shotgun.png", COLOR_CYAN)
killicon.Add("weapon_zs_redeemers", "materials/zombiesurvival/weapons/pistol.png", COLOR_BLUE)


killicon.Add("cw_pistol_berreta", "materials/zombiesurvival/weapons/pistol.png", COLOR_YELLOW)
killicon.Add("cw_pistol_usp40","materials/zombiesurvival/weapons/pistol.png", COLOR_ORANGE)
killicon.Add("cw_pistol_glock","materials/zombiesurvival/weapons/pistol.png", COLOR_RED)
killicon.Add("cw_pistol_deagle","materials/zombiesurvival/weapons/pistol.png", COLOR_DARKRED)
killicon.Add("cw_pistol_mr96", "materials/zombiesurvival/weapons/pistol.png", COLOR_RPURPLE)
killicon.Add("cw_pistol_contender","materials/zombiesurvival/weapons/pistol.png", COLOR_PURPLE)
killicon.Add("cw_pistol_cz75_auto","materials/zombiesurvival/weapons/pistol.png", COLOR_DARKBLUE)
killicon.Add("cw_pistol_627", "materials/zombiesurvival/weapons/pistol.png", COLOR_LBLUE)
killicon.Add("cw_pistol_python", "materials/zombiesurvival/weapons/pistol.png", COLOR_CYAN)
killicon.Add("cw_pistol_rex","materials/zombiesurvival/weapons/pistol.png", COLOR_LIMEGREEN)
killicon.Add("cw_pistol_satan", "materials/zombiesurvival/weapons/pistol.png", COLOR_GREEN)
killicon.Add("cw_pistol_calico", "materials/zombiesurvival/weapons/pistol.png", COLOR_DARKGREEN)

killicon.Add("cw_smg_mp5a4","materials/zombiesurvival/weapons/smg.png", COLOR_YELLOW)
killicon.Add("cw_smg_mp5a5", "materials/zombiesurvival/weapons/smg.png", COLOR_ORANGE)
killicon.Add("cw_smg_mp40", "materials/zombiesurvival/weapons/smg.png", COLOR_RED)
killicon.Add("cw_smg_p90","materials/zombiesurvival/weapons/smg.png", COLOR_DARKRED)
killicon.Add("cw_smg_vector","materials/zombiesurvival/weapons/smg.png", COLOR_RPURPLE)
killicon.Add("cw_smg_veresk", "materials/zombiesurvival/weapons/smg.png", COLOR_PURPLE)
killicon.Add("cw_smg_hb","materials/zombiesurvival/weapons/smg.png", COLOR_DARKBLUE)
killicon.Add("cw_smg_fmg9", "materials/zombiesurvival/weapons/smg.png", COLOR_LBLUE)
killicon.Add("cw_smg_ump45", "materials/zombiesurvival/weapons/smg.png", COLOR_CYAN)
killicon.Add("cw_smg_vk10", "materials/zombiesurvival/weapons/smg.png", COLOR_LIMEGREEN)
killicon.Add("cw_smg_l2a3", "materials/zombiesurvival/weapons/smg.png", COLOR_GREEN)
killicon.Add("cw_smg_thompson", "materials/zombiesurvival/weapons/smg.png", COLOR_DARKGREEN)


killicon.Add("cw_ar_masada","materials/zombiesurvival/weapons/ar2.png",  COLOR_YELLOW)
killicon.Add("cw_ar_fal","materials/zombiesurvival/weapons/ar2.png", COLOR_ORANGE)
killicon.Add("cw_ar_ar15", "materials/zombiesurvival/weapons/ar2.png", COLOR_RED)
killicon.Add("cw_ar_g36c","materials/zombiesurvival/weapons/ar2.png", COLOR_DARKRED)
killicon.Add("cw_ar_aek", "materials/zombiesurvival/weapons/ar2.png", COLOR_RPURPLE)
killicon.Add("cw_ar_xm8", "materials/zombiesurvival/weapons/ar2.png",  COLOR_PURPLE)
killicon.Add("cw_ar_ak103", "materials/zombiesurvival/weapons/ar2.png", COLOR_DARKBLUE)
killicon.Add("cw_ar_g3a3", "materials/zombiesurvival/weapons/ar2.png", COLOR_LBLUE)
killicon.Add("cw_ar_hcar", "materials/zombiesurvival/weapons/ar2.png", COLOR_CYAN)
killicon.Add("cw_ar_masada_acr", "materials/zombiesurvival/weapons/ar2.png", COLOR_LIMEGREEN)
killicon.Add("cw_ar_m4a4", "materials/zombiesurvival/weapons/ar2.png", COLOR_DARKGREEN)
killicon.Add("cw_ar_m4a1", "materials/zombiesurvival/weapons/ar2.png", COLOR_RORANGE)
killicon.Add("cw_ar_akm", "materials/zombiesurvival/weapons/ar2.png", COLOR_RPINK)
killicon.Add("cw_ar_m16a4", "materials/zombiesurvival/weapons/ar2.png", COLOR_RPURPLE)
killicon.Add("cw_ar_roku","materials/zombiesurvival/weapons/ar2.png", COLOR_SOFTRED)

killicon.Add("cw_shotgun_m620", "materials/zombiesurvival/weapons/shotgun.png", COLOR_YELLOW)
killicon.Add("cw_shotgun_m1014","materials/zombiesurvival/weapons/shotgun.png", COLOR_ORANGE)
killicon.Add("cw_shotgun_mossberg", "materials/zombiesurvival/weapons/shotgun.png", COLOR_RED)
killicon.Add("cw_shotgun_saiga","materials/zombiesurvival/weapons/shotgun.png", COLOR_DARKRED)
killicon.Add("cw_shotgun_dao12", "materials/zombiesurvival/weapons/shotgun.png", COLOR_RPURPLE)
killicon.Add("cw_shotgun_ksg12", "materials/zombiesurvival/weapons/shotgun.png", COLOR_PURPLE)
killicon.Add("cw_shotgun_ks23","materials/zombiesurvival/weapons/shotgun.png", COLOR_DARKBLUE)
killicon.Add("cw_shotgun_jackhammer", "materials/zombiesurvival/weapons/shotgun.png",  COLOR_LBLUE)
killicon.Add("cw_shotgun_spas12", "materials/zombiesurvival/weapons/shotgun.png", COLOR_CYAN)
killicon.Add("cw_shotgun_toz","materials/zombiesurvival/weapons/shotgun.png", COLOR_LIMEGREEN)
killicon.Add("cw_shotgun_aa12", "materials/zombiesurvival/weapons/shotgun.png", COLOR_DARKGREEN)

killicon.Add("cw_sniper_mosin","materials/zombiesurvival/weapons/sniper.png", COLOR_YELLOW)
killicon.Add("cw_sniper_sksd", "materials/zombiesurvival/weapons/sniper.png", COLOR_ORANGE)
killicon.Add("cw_sniper_svt","materials/zombiesurvival/weapons/sniper.png", COLOR_RED)
killicon.Add("cw_sniper_m1garand","materials/zombiesurvival/weapons/sniper.png", COLOR_DARKRED)
killicon.Add("cw_sniper_sr338", "materials/zombiesurvival/weapons/sniper.png",  COLOR_RPURPLE)
killicon.Add("cw_sniper_m82","materials/zombiesurvival/weapons/sniper.png",  COLOR_PURPLE)
killicon.Add("cw_sniper_awm", "materials/zombiesurvival/weapons/sniper.png", COLOR_DARKBLUE)
killicon.Add("cw_sniper_l115a3", "materials/zombiesurvival/weapons/sniper.png", COLOR_LBLUE)
killicon.Add("cw_sniper_t5000","materials/zombiesurvival/weapons/sniper.png", COLOR_CYAN)
killicon.Add("cw_sniper_m98b", "materials/zombiesurvival/weapons/sniper.png", COLOR_LIMEGREEN)
killicon.Add("cw_sniper_m95", "materials/zombiesurvival/weapons/sniper.png", COLOR_DARKGREEN)

killicon.Add("cw_lmg_ar57", "materials/zombiesurvival/weapons/lmg.png", COLOR_YELLOW)
killicon.Add("cw_lmg_mg4", "materials/zombiesurvival/weapons/lmg.png", COLOR_ORANGE)
killicon.Add("cw_lmg_m240", "materials/zombiesurvival/weapons/lmg.png",COLOR_RED)
killicon.Add("cw_lmg_m27","materials/zombiesurvival/weapons/lmg.png", COLOR_DARKRED)
killicon.Add("cw_lmg_ares", "materials/zombiesurvival/weapons/lmg.png", COLOR_RPURPLE)
killicon.Add("cw_lmg_type88", "materials/zombiesurvival/weapons/lmg.png", COLOR_PURPLE)
killicon.Add("cw_lmg_mg36","materials/zombiesurvival/weapons/lmg.png", COLOR_DARKBLUE)
killicon.Add("cw_lmg_pkm","materials/zombiesurvival/weapons/lmg.png", COLOR_LBLUE)
killicon.Add("cw_lmg_m60","materials/zombiesurvival/weapons/lmg.png", COLOR_CYAN)
killicon.Add("cw_lmg_m60e4", "materials/zombiesurvival/weapons/lmg.png", COLOR_LIMEGREEN)
killicon.Add("cw_lmg_hmg", "materials/zombiesurvival/weapons/lmg.png", COLOR_DARKGREEN)

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
