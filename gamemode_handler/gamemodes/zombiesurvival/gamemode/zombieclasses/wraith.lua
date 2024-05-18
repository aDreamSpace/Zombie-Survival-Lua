CLASS.Name = "Wraith"
CLASS.TranslationName = "class_wraith"
CLASS.Description = "description_wraith"
CLASS.Help = "controls_wraith"

CLASS.Wave = 2 / 5
CLASS.Health = 280
CLASS.SWEP = "weapon_zs_wraith"
CLASS.Model = Model("models/wraith_zsv1.mdl")
CLASS.Speed = 175

--[[
CLASS.ZTraits = {
	["10spd"] = {safename = "+10% Speed", cost = 200},
	--["mach5"] = {safename = "Mach 5", cost = 300, desc = "Increases force of props hit"}
}
]]

CLASS.Points = 7

CLASS.VoicePitch = 0.65
CLASS.DamageResistance = 0.3

CLASS.PainSounds = {Sound("npc/barnacle/barnacle_pull1.wav"), Sound("npc/barnacle/barnacle_pull2.wav"), Sound("npc/barnacle/barnacle_pull3.wav"), Sound("npc/barnacle/barnacle_pull4.wav")}
CLASS.DeathSounds = {Sound("zombiesurvival/wraithdeath1.ogg"), Sound("zombiesurvival/wraithdeath2.ogg"), Sound("zombiesurvival/wraithdeath3.ogg"), Sound("zombiesurvival/wraithdeath4.ogg")}

CLASS.NoShadow = true

--CLASS.GhostSpeed = 35

function CLASS:Move(pl, move)
	--[[if pl:GetBarricadeGhosting() then
		move:SetMaxSpeed(self.GhostSpeed)
		move:SetMaxClientSpeed(self.GhostSpeed)
	end]]

	if pl:KeyDown(IN_SPEED) then
		move:SetMaxSpeed(50)
		move:SetMaxClientSpeed(50)
	end
end

--[[function CLASS:GetJumpPower(pl)
	return pl:IsBarricadeGhosting() and 0 or DEFAULT_JUMP_POWER
end

function CLASS:SwitchedAway(pl)
	pl:SetBarricadeGhosting(false)
end]]
function CLASS:CalcMainActivity(pl, velocity)
	local wep = pl:GetActiveWeapon()
	if wep:IsValid() and wep.IsAttacking and wep:IsAttacking() then
		return 1, 10
	elseif velocity:Length2DSqr() > 1 then
		return 1, 3
	end

	return 1, 1
end

function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)
	return true
end

function CLASS:ScalePlayerDamage(pl, hitgroup, dmginfo)
	--[[if pl:IsBarricadeGhosting() then
		dmginfo:SetDamage(dmginfo:GetDamage() * 1.5)
	end]]

	-- The Wraith model doesn't have hitboxes.
	return true
end

function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)
	pl:FixModelAngles(velocity)

	local seq = pl:GetSequence()
	if seq == 10 then
		if not pl.m_PrevFrameCycle then
			pl.m_PrevFrameCycle = true
			pl:SetCycle(0)
		end
	elseif pl.m_PrevFrameCycle then
		pl.m_PrevFrameCycle = nil
	end
end

function CLASS:GetAlpha(pl)
	local wep = pl:GetActiveWeapon()
	if not wep.IsAttacking then wep = NULL end

	if wep:IsValid() and wep:IsAttacking() then
		return 0.7
	elseif MySelf:IsValid() and MySelf:Team() == TEAM_UNDEAD then
		local eyepos = EyePos()
		return math.Clamp(pl:GetVelocity():Length() - pl:NearestPoint(eyepos):Distance(eyepos) * 0.5, 35, 180) / 255
	else
		local eyepos = EyePos()
		return math.Clamp(pl:GetVelocity():Length() - pl:NearestPoint(eyepos):Distance(eyepos) * 0.5, 0, 180) / 255
	end
end

function CLASS:OnKilled(pl, attacker, inflictor, suicide, headshot, dmginfo, assister)
	if SERVER then
		local effectdata = EffectData()
			effectdata:SetOrigin(pl:GetPos())
			effectdata:SetNormal(pl:GetForward())
			effectdata:SetEntity(pl)
		util.Effect("wraithdeath", effectdata, nil, true)
	end

	return true
end

if not CLIENT then return end

CLASS.Icon = "materials/zombiesurvival/killicons2/wraith.png"

function CLASS:PrePlayerDraw(pl)
	pl:RemoveAllDecals()

	--[[if pl:GetBarricadeGhosting() then
		render.SetBlend(0.7)
		render.SetColorModulation(1, 1, 5)
	else]]
		local alpha = self:GetAlpha(pl)
		if alpha == 0 then return true end

		render.SetBlend(alpha)
		render.SetColorModulation(0.3, 0.3, 0.3)
	--end
end

function CLASS:PostPlayerDraw(pl)
	render.SetColorModulation(1, 1, 1)
	render.SetBlend(1)
end
