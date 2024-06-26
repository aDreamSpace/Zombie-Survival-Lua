CLASS.Name = "Shade"
CLASS.TranslationName = "class_shade"
CLASS.Description = "description_shade"
CLASS.Help = "controls_shade"

CLASS.Wave = 0
CLASS.Threshold = 0
CLASS.Unlocked = true
CLASS.Hidden = true
CLASS.Boss = true

CLASS.NoGibs = true
CLASS.NoFallDamage = true
CLASS.NoFallSlowdown = true

CLASS.NoShadow = true

CLASS.Health = 3900
CLASS.Speed = 260

CLASS.FearPerInstance = 1

CLASS.Points = 70

CLASS.SWEP = "weapon_zs_shade"

CLASS.Model = Model("models/player/zombie_fast.mdl")

CLASS.VoicePitch = 0.8

CLASS.PainSounds = {Sound("npc/barnacle/barnacle_pull1.wav"), Sound("npc/barnacle/barnacle_pull2.wav"), Sound("npc/barnacle/barnacle_pull3.wav"), Sound("npc/barnacle/barnacle_pull4.wav")}
CLASS.DeathSounds = {Sound("zombiesurvival/wraithdeath1.ogg"), Sound("zombiesurvival/wraithdeath2.ogg"), Sound("zombiesurvival/wraithdeath3.ogg"), Sound("zombiesurvival/wraithdeath4.ogg")}

local ACT_HL2MP_IDLE_MAGIC = ACT_HL2MP_IDLE_MAGIC
local ACT_HL2MP_RUN_MAGIC = ACT_HL2MP_RUN_MAGIC
local ACT_HL2MP_RUN_ZOMBIE = ACT_HL2MP_RUN_ZOMBIE

function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)
	return true
end

function CLASS:PlayerStepSoundTime(pl, iType, bWalking)
	return 1000
end

function CLASS:CalcMainActivity(pl, velocity)
	if (pl.ShadeControl and pl.ShadeControl:IsValid()) or (pl.ShadeShield and pl.ShadeShield:IsValid()) then
		if velocity:Length2DSqr() <= 1 then
			return ACT_HL2MP_IDLE_MAGIC, -1
		end

		return ACT_HL2MP_RUN_MAGIC, -1
	end

	return ACT_HL2MP_RUN_ZOMBIE, -1
end

function CLASS:DoAnimationEvent(pl, event, data)
	if event == PLAYERANIMEVENT_ATTACK_PRIMARY then
		pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2, true)
		return ACT_INVALID
	end
end

function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)
	pl:SetPlaybackRate(1)
	pl:SetCycle(0.35 + math.abs(math.sin(CurTime() * 1.5)) * 0.3)

	return true
end

function CLASS:ProcessDamage(pl, dmginfo)
	local attacker = dmginfo:GetAttacker()
	if not SHADEFLASHLIGHTDAMAGE and attacker:IsPlayer() and attacker:Team() == TEAM_HUMAN then
		dmginfo:SetDamage(0)
		dmginfo:ScaleDamage(0)

		if SERVER then
			local center = pl:LocalToWorld(pl:OBBCenter())
			local hitpos = pl:NearestPoint(dmginfo:GetDamagePosition())
			local effectdata = EffectData()
				effectdata:SetOrigin(center)
				effectdata:SetStart(pl:WorldToLocal(hitpos))
				effectdata:SetAngles((center - hitpos):Angle())
				effectdata:SetEntity(pl)
			util.Effect("shadedeflect", effectdata, true, true)

			local status = pl.status_shadeambience
			if status and status:IsValid() then
				status:SetLastReflect(CurTime())
			end
		end
	end
end

function CLASS:OnKilled(pl, attacker, inflictor, suicide, headshot, dmginfo, assister)
	return true
end

if SERVER then
    function CLASS:OnSpawned(pl)
        pl:CreateAmbience("shadeambience")
        pl:SetRenderMode(RENDERMODE_TRANSALPHA)

        -- Start a timer that runs every second
        timer.Create("DrainArmor"..pl:EntIndex(), 1, 0, function()
            if not IsValid(pl) then return end  -- Stop if the Shade is no longer valid

            -- Get all entities in a certain radius around the Shade
            local entities = ents.FindInSphere(pl:GetPos(), 200)

            -- Loop over all entities
            for _, ent in pairs(entities) do
                -- If the entity is a player and is on TEAM_HUMAN, reduce their armor
                if ent:IsPlayer() and ent:Team() == TEAM_HUMAN then
                    ent:SetArmor(math.max(0, ent:Armor() - 5))  -- Reduce armor by 5, but don't go below 0
                end
            end
        end)
    end

    function CLASS:SwitchedAway(pl)
        pl:SetRenderMode(RENDERMODE_NORMAL)
        timer.Remove("DrainArmor"..pl:EntIndex())  -- Stop the timer when the Shade is no longer the current class
    end
end



if not CLIENT then return end

CLASS.Icon = "materials/zombiesurvival/killicons2/shade.png"

local ToZero = {"ValveBiped.Bip01_L_Thigh", "ValveBiped.Bip01_R_Thigh", "ValveBiped.Bip01_L_Calf", "ValveBiped.Bip01_R_Calf", "ValveBiped.Bip01_L_Foot", "ValveBiped.Bip01_R_Foot"}
function CLASS:BuildBonePositions(pl)
	for _, bonename in pairs(ToZero) do
		local boneid = pl:LookupBone(bonename)
		if boneid and boneid > 0 then
			pl:ManipulateBoneScale(boneid, vector_tiny)
		end
	end
end

local nodraw = false
local matWhite = Material("models/debug/debugwhite")
local matRefract = Material("models/spawn_effect")
function CLASS:PreRenderEffects(pl)
	if render.SupportsVertexShaders_2_0() then
		local normal = pl:GetUp()
		render.EnableClipping(true)
		render.PushCustomClipPlane(normal, normal:Dot(pl:GetPos() + normal * 16))
	end

	if nodraw then return end

	local red = 0
	local baseblend = 0.1
	local status = pl.status_shadeambience
	if status and status:IsValid() then
		red = 1 - math.Clamp((CurTime() - status:GetLastDamaged()) * 3, 0, 1) ^ 3
		baseblend = baseblend + (1 - math.Clamp((CurTime() - status:GetLastReflect()) * 2, 0, 1) ^ 0.5) * 0.75
	end

	render.SetColorModulation(red, 0.1, 1 - red)
	render.SetBlend(baseblend + math.abs(math.cos(CurTime())) ^ 2 * 0.1)
	render.SuppressEngineLighting(true)
	render.ModelMaterialOverride(matWhite)
end

function CLASS:PostRenderEffects(pl)
	if render.SupportsVertexShaders_2_0() then
		render.PopCustomClipPlane()
		render.EnableClipping(false)
	end

	if nodraw then return end

	render.SetColorModulation(1, 1, 1)
	render.SetBlend(1)
	render.SuppressEngineLighting(false)
	render.ModelMaterialOverride()

	if render.SupportsPixelShaders_2_0() then
		render.UpdateRefractTexture()

		matRefract:SetFloat("$refractamount", 0.01)

		render.ModelMaterialOverride(matRefract)
		nodraw = true
		pl:DrawModel()
		nodraw = false
		render.ModelMaterialOverride(0)
	end
end

function CLASS:PrePlayerDraw(pl)
	pl:RemoveAllDecals()

	self:PreRenderEffects(pl)
end

function CLASS:PostPlayerDraw(pl)
	self:PostRenderEffects(pl)
end
