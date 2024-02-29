function ulx.setxp( calling_ply, target_ply, xp, reason )

	for k,v in pairs(target_ply) do
		SimpleXPSetXPText(v,xp,string.upper(reason),true)
	end
	
	ulx.fancyLogAdmin( calling_ply, "#A set the xp of #T to #i with the reason of #s", target_ply,xp,reason )
	
end

function ulx.addxp( calling_ply, target_ply, xp, reason )

	for k,v in pairs(target_ply) do
		SimpleXPAddXPText(v,xp,string.upper(reason),true,false)
	end
	
	ulx.fancyLogAdmin( calling_ply, "#A gave #T #i xp with the reason of #s", target_ply,xp,reason )

end

function ulx.setlevel( calling_ply, target_ply, level, reason )

	for k,v in pairs(target_ply) do
		SimpleXPSetXPText(v,SimpleXPCalculateLevelToXP(level),string.upper(reason),true)
	end
	
	ulx.fancyLogAdmin( calling_ply, "#A set the level of #T to #s with the reason of #s", target_ply,SimpleXPCheckRank(level),reason )

end

local ULXSETXP = ulx.command("Fun","ulx setxp",ulx.setxp,"!setxp",true,true)
ULXSETXP:addParam{type=ULib.cmds.PlayersArg}
ULXSETXP:addParam{type=ULib.cmds.NumArg, default=0, hint="xp", ULib.cmds.round }
ULXSETXP:addParam{type=ULib.cmds.StringArg,default="", hint="reason",ULib.cmds.optional}
ULXSETXP:defaultAccess( ULib.ACCESS_ADMIN )
ULXSETXP:help( "Sets the player's XP." )

local ULXADDXP = ulx.command("Fun","ulx addxp",ulx.addxp,"!addxp",true,true)
ULXADDXP:addParam{type=ULib.cmds.PlayersArg}
ULXADDXP:addParam{type=ULib.cmds.NumArg, default=100, hint="xp", ULib.cmds.round }
ULXADDXP:addParam{type=ULib.cmds.StringArg,default="Cool Guy", hint="reason",ULib.cmds.optional}
ULXADDXP:defaultAccess( ULib.ACCESS_ADMIN )
ULXADDXP:help( "Adds to the player's XP." )

local ULXSETLEVEL = ulx.command("Fun","ulx setlevel",ulx.setlevel,"!setlevel",true,true)
ULXSETLEVEL:addParam{type=ULib.cmds.PlayersArg}
ULXSETLEVEL:addParam{type=ULib.cmds.NumArg, default=0, hint="level", ULib.cmds.round }
ULXSETLEVEL:addParam{type=ULib.cmds.StringArg,default="Cool Guy", hint="reason",ULib.cmds.optional}
ULXSETLEVEL:defaultAccess( ULib.ACCESS_ADMIN )
ULXSETLEVEL:help( "Sets the player's level." )



