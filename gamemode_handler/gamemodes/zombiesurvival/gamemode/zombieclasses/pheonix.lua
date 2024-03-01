CLASS.Name = "Pheonix"
CLASS.TranslationName = "class_pheonix"
CLASS.Description = "description_pheonix"

CLASS.Health = 700
CLASS.Wave = 4 / 5
CLASS.Threshold = 0
CLASS.SWEP = "weapon_zs_pheonix"
CLASS.Model = Model("models/crow.mdl")
CLASS.Speed = 200
CLASS.JumpPower = 330
CLASS.ModelScale = 6

CLASS.PainSounds = {"NPC_Crow.Pain"}
CLASS.DeathSounds = {"NPC_Crow.Die"}

CLASS.Unlocked = false 


CLASS.Hull = {Vector(-4, -4, 0), Vector(4, 4, 9)}
CLASS.HullDuck = {Vector(-4, -4, 0), Vector(4, 4, 9)}
CLASS.ViewOffset = Vector(0,0,40)
CLASS.ViewOffsetDucked = Vector(0,0,40)
CLASS.CrouchedWalkSpeed = 1
CLASS.StepSize = 8
CLASS.Mass = 2

CLASS.NoFallDamage = true
CLASS.NoFallSlowdown = true
CLASS.Points = 8


function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)
	return true
end

function CLASS:CalcMainActivity(pl, velocity)
	if pl:OnGround() then
		local wep = pl:GetActiveWeapon()
		if wep:IsValid() and wep.IsPecking and wep:IsPecking() then
			return 1, 5
		end

		if velocity:Length2DSqr() > 1 then
			return ACT_RUN, -1
		end

		return ACT_IDLE, -1
	end

	if velocity:LengthSqr() > 122500 then --350^2
		return ACT_FLY, -1
	end

	return 1, 7
end

function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)
	pl:FixModelAngles(velocity)
	pl:SetPlaybackRate(1)
	return true
end

function CLASS:DoAnimationEvent(pl, event, data)
	if event == PLAYERANIMEVENT_ATTACK_PRIMARY then
		pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_MELEE_ATTACK1, true)
		return ACT_INVALID
	end
end

function CLASS:Move(pl, mv)

	if not pl:IsOnGround() and pl:KeyDown(IN_JUMP) then
		local dir = pl:EyeAngles()
		if pl:KeyDown(IN_MOVELEFT) then
			dir:RotateAroundAxis(dir:Up(), 20)
		elseif pl:KeyDown(IN_MOVERIGHT) then
			dir:RotateAroundAxis(dir:Up(), -20)
		end

		if pl:KeyDown(IN_FORWARD) then
			mv:SetVelocity(dir:Forward() * 450)
		else
			mv:SetVelocity(dir:Forward() * 300)
		end

		return true
	end
end

if SERVER then

function CLASS:SwitchedAway(pl)
	pl:SetAllowFullRotation(false)
end

function CLASS:OnKilled(pl, attacker, inflictor, suicide, headshot, dmginfo)
	pl:SetAllowFullRotation(false)
	if pl:Health() < -45 then
		local amount = pl:OBBMaxs():Length()
		local vel = pl:GetVelocity()
		util.Blood(pl:LocalToWorld(pl:OBBCenter()), math.Rand(amount * 0.25, amount * 0.5), vel:GetNormalized(), vel:Length() * 0.75)

		return true
	elseif not pl.KnockedDown then
		pl:CreateRagdoll()
	end

	pl:SetHealth(pl:GetMaxHealth())
	pl:StripWeapons()
	pl:Spectate(OBS_MODE_ROAMING)
end
end

if not CLIENT then return end

function CLASS:ShouldDrawLocalPlayer(pl)
	return true
end

CLASS.Icon = "materials/zombiesurvival/killicons2/crow.png"

CLASS.IconColor = COLOR_CYAN

local render_SetMaterial = render.SetMaterial
local render_DrawSprite = render.DrawSprite
local angle_zero = angle_zero
local LocalToWorld = LocalToWorld
local matSkin = Material("models/weapons/v_crossbow/rebar_glow")
local colGlow = Color(240, 36, 0)
local matGlow = Material("sprites/glow04_noz")
local vecEyeLeft = Vector(4, -4.6, -1)
local vecEyeRight = Vector(4, -4.6, 1)

function CLASS:PrePlayerDraw(pl)
	render.SetColorModulation(0.984, 0.576, 0.012)
end

function CLASS:PostPlayerDraw(pl)
    render.SetColorModulation(0.984, 0.576, 0.012)
    render.ModelMaterialOverride()
    if pl == MySelf and not pl:ShouldDrawLocalPlayer() or pl.SpawnProtection then return end

    -- Get the player's bounding box
    local min, max = pl:GetModelBounds()

    -- Calculate the number of particles to emit
    local numParticles = 2 -- Adjust this to the desired number of particles

    -- Create a particle emitter
    local emitter = ParticleEmitter(pl:GetPos())

    -- Emit particles at random points within the bounding box
    for i = 1, numParticles do
        local pos = Vector(
            math.Rand(min.x, max.x),
            math.Rand(min.y, max.y),
            math.Rand(min.z, max.z)
        )

        -- Create a new particle at the position
        local particle = emitter:Add("sprites/glow04_noz", pl:LocalToWorld(pos))

        if particle then
            particle:SetDieTime(1) -- Set the lifetime to 2 seconds
            particle:SetStartAlpha(255)
            particle:SetEndAlpha(0)
            particle:SetStartSize(25) -- Set the size to 10
            particle:SetEndSize(0)
            particle:SetColor(255, 102, 0)-- Set the color to red
        end
    end
--Color(255, 102, 0)
    -- Release the emitter
    emitter:Finish()
end

if CLIENT then
    hook.Add("CalcView", "PheonixThirdPersonView", function(ply, pos, angles, fov)
        if ply:Alive() and ply:GetZombieClassTable().Name == "Pheonix" then
            local view = {}
            view.origin = pos - (angles:Forward() * 180) -- Decrease this value to make the camera closer
            view.angles = angles
            view.fov = fov
            view.drawviewer = true

            return view
        end
    end)
end
