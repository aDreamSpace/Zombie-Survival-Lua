hook.Add("EntityTakeDamage", "m9k_damagestop", function(target, dmg)
	if TEAM_HUMAN then -- IF ZOMBIE SURVIVAL
		if target:IsPlayer() then
			if target:Team() == TEAM_HUMAN  and dmg:IsDamageType(64) then return true end
		end
	end
end)

hook.Add("EntityTakeDamage", "StopExplosiveDamage", function(ent, dmg)
	if ent:GetClass() then
		if dmg:IsDamageType(DMG_BLAST) and table.HasValue({"prop_physics", "prop_physics_multiplayer", "prop_arsenalcrate", "prop_resupplybox", "prop_constructor", "prop_medstation", "prop_teleporter", "prop_nail"}, ent:GetClass()) then
			return true
		end
	end
end)

