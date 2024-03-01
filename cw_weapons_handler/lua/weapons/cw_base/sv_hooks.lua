local att, wep, dist, mul, vwep, zatt

local vTgtFwd, dot, degrees

local function CW_EntityTakeDamage(ent, d)
	att = d:GetInflictor()
	zatt = d:GetAttacker()
	if att:IsPlayer() then
		wep = att:GetActiveWeapon()

		if IsValid(wep) and wep.CW20Weapon then
			if not wep.NoDistance and wep.EffectiveRange then
				dist = ent:GetPos():Distance(att:GetPos())
				
				if dist >= wep.EffectiveRange * 0.5 then
					dist = dist - wep.EffectiveRange * 0.5
					mul = math.Clamp(dist / wep.EffectiveRange, 0, 1)

					d:ScaleDamage(1 - wep.DamageFallOff * mul)
				end
			end
		end
	end
	if zatt:IsPlayer() then
		if ent and ent:IsValid() and ent:IsPlayer() then
			vwep = ent:GetActiveWeapon()
			if vwep and vwep:IsValid() and vwep.CanBlock and vwep.IsBlocking then
				--dot product calculation
				vTgtFwd = (ent:GetPos() - zatt:GetPos())
				vTgtFwd:Normalize()
				dot = zatt:GetAimVector():Dot(vTgtFwd)
				if math.deg(math.acos(dot)) < 90 then
					d:ScaleDamage(vwep.BlockFactor)
					ent:EmitSound("weapons/cw_melee/block.ogg", 75, 100, 1)
				end
			end
		end
	end
end

hook.Add("EntityTakeDamage", "CW_EntityTakeDamage", CW_EntityTakeDamage)