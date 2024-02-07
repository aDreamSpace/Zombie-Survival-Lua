function GM:RenderScreenspaceEffects()
end

GM.PostProcessingEnabled = CreateClientConVar("zs_postprocessing", 1, true, false):GetBool()
cvars.AddChangeCallback("zs_postprocessing", function(cvar, oldvalue, newvalue)
	GAMEMODE.PostProcessingEnabled = tonumber(newvalue) == 1
end)

GM.Auras = CreateClientConVar("zs_auras", 1, true, false):GetBool()
cvars.AddChangeCallback("zs_auras", function(cvar, oldvalue, newvalue)
	GAMEMODE.Auras = tonumber(newvalue) == 1
end)

GM.AuraColorEmpty = Color(CreateClientConVar("zs_auracolor_empty_r", 255, true, false):GetInt(), CreateClientConVar("zs_auracolor_empty_g", 0, true, false):GetInt(), CreateClientConVar("zs_auracolor_empty_b", 0, true, false):GetInt(), 255)
GM.AuraColorFull = Color(CreateClientConVar("zs_auracolor_full_r", 20, true, false):GetInt(), CreateClientConVar("zs_auracolor_full_g", 255, true, false):GetInt(), CreateClientConVar("zs_auracolor_full_b", 20, true, false):GetInt(), 255)

cvars.AddChangeCallback("zs_auracolor_empty_r", function(cvar, oldvalue, newvalue)
	GAMEMODE.AuraColorEmpty.r = math.Clamp(math.ceil(tonumber(newvalue) or 0), 0, 255)
end)

cvars.AddChangeCallback("zs_auracolor_empty_g", function(cvar, oldvalue, newvalue)
	GAMEMODE.AuraColorEmpty.g = math.Clamp(math.ceil(tonumber(newvalue) or 0), 0, 255)
end)

cvars.AddChangeCallback("zs_auracolor_empty_b", function(cvar, oldvalue, newvalue)
	GAMEMODE.AuraColorEmpty.b = math.Clamp(math.ceil(tonumber(newvalue) or 0), 0, 255)
end)

cvars.AddChangeCallback("zs_auracolor_full_r", function(cvar, oldvalue, newvalue)
	GAMEMODE.AuraColorFull.r = math.Clamp(math.ceil(tonumber(newvalue) or 0), 0, 255)
end)

cvars.AddChangeCallback("zs_auracolor_full_g", function(cvar, oldvalue, newvalue)
	GAMEMODE.AuraColorFull.g = math.Clamp(math.ceil(tonumber(newvalue) or 0), 0, 255)
end)

cvars.AddChangeCallback("zs_auracolor_full_b", function(cvar, oldvalue, newvalue)
	GAMEMODE.AuraColorFull.b = math.Clamp(math.ceil(tonumber(newvalue) or 0), 0, 255)
end)


local DrawColorModify = DrawColorModify
local DrawSharpen = DrawSharpen
local EyePos = EyePos
local TEAM_HUMAN = TEAM_HUMAN
local TEAM_UNDEAD = TEAM_UNDEAD
local render_UpdateScreenEffectTexture = render.UpdateScreenEffectTexture
local render_SetMaterial = render.SetMaterial
local render_DrawScreenQuad = render.DrawScreenQuad
local render_DrawSprite = render.DrawSprite
local render_DrawBeam = render.DrawBeam
local render_GetLightRGB = render.GetLightRGB
local math_Approach = math.Approach
local FrameTime = FrameTime
local CurTime = CurTime
local math_sin = math.sin
local math_min = math.min
local math_max = math.max
local math_abs = math.abs
local team_GetPlayers = team.GetPlayers

local tColorModDead = {
	["$pp_colour_contrast"] = 1.25,
	["$pp_colour_colour"] = 0,
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = -0.02,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0
}

local tColorModHuman = {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = 0,
	["$pp_colour_contrast"] = 1,
	["$pp_colour_colour"] = 1,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0
}

local tColorModZombie = {
	["$pp_colour_brightness"] = 0,
	["$pp_colour_contrast"] = 1.25,
	["$pp_colour_colour"] = 0.5,
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0
}

local tColorModZombieVision = {
	["$pp_colour_colour"] = 0.75,
	["$pp_colour_brightness"] = -0.15,
	["$pp_colour_contrast"] = 1.5,
	["$pp_colour_mulr"]	= 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0,
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0
}

local redview = 0
local fear = 0
local matTankGlass = Material("models/props_lab/Tank_Glass001")
function GM:_RenderScreenspaceEffects()
	if MySelf.Confusion and MySelf.Confusion:IsValid() then
		MySelf.Confusion:RenderScreenSpaceEffects()
	end

	if not self.PostProcessingEnabled then return end

	fear = math_Approach(fear, self:CachedFearPower(), FrameTime())
end

local matGlow = Material("Sprites/light_glow02_add_noz")
local colHealthEmpty = GM.AuraColorEmpty
local colHealthFull = GM.AuraColorFull
local colHealth = Color(255, 255, 255, 255)
local matPullBeam = Material("cable/rope")
local colPullBeam = Color(255, 255, 255, 255)
local eyepos
local healthfrac
local pos
local size

local nextAll = 0
local CPLY
local function CPlayerGetAll()
	if nextAll < CurTime() then
		nextAll = CurTime() + 1
		CPLY = player.GetAll()
	end
	return CPLY
end

local plys
local holding
local object
local pullpos, hingepos
local r, g, b
-- -MagicSwap: did a bunch of changes to make this faster, used to kill perf for zombies
function GM:_PostDrawOpaqueRenderables()
	if MySelf:Team() == TEAM_UNDEAD then
		if self.Auras then
			eyepos = EyePos()
			plys = CPlayerGetAll() --use a CFunction instead of calling player.GetAll() god knows how many times a frame
			--bad thing about these cached players is now we need an isvalid check, but thats not too bad compared to the frames we save
			for i = 1, #plys do
				pl = plys[i]
				if pl:IsValid() and pl:Team() == TEAM_HUMAN and pl:Alive() and pl:GetPos():Distance(eyepos) <= pl:GetAuraRange() then
					healthfrac = math_max(pl:Health(), 0) / pl:GetMaxHealth()
					colHealth.r = math_Approach(colHealthEmpty.r, colHealthFull.r, math_abs(colHealthEmpty.r - colHealthFull.r) * healthfrac)
					colHealth.g = math_Approach(colHealthEmpty.g, colHealthFull.g, math_abs(colHealthEmpty.g - colHealthFull.g) * healthfrac)
					colHealth.b = math_Approach(colHealthEmpty.b, colHealthFull.b, math_abs(colHealthEmpty.b - colHealthFull.b) * healthfrac)

					pos = pl:WorldSpaceCenter()

					render_SetMaterial(matGlow)
					render_DrawSprite(pos, 13, 13, colHealth)
					size = math_sin(self.HeartBeatTime + pl:EntIndex()) * 50 - 21
					if size > 0 then
						render_DrawSprite(pos, size * 1.5, size, colHealth)
						render_DrawSprite(pos, size, size * 1.5, colHealth)
					end
				end
			end
		end
	elseif MySelf:Team() == TEAM_HUMAN then
		self:DrawCraftingEntity()

		holding = MySelf.status_human_holding
		if holding and holding:IsValid() and holding:GetIsHeavy() then
			object = holding:GetObject()
			if object:IsValid() then
				pullpos = holding:GetPullPos()
				hingepos = holding:GetHingePos()
				r, g, b = render_GetLightRGB(hingepos)
				colPullBeam.r = r * 255
				colPullBeam.g = g * 255
				colPullBeam.b = b * 255
				render_SetMaterial(matPullBeam)
				render_DrawBeam(hingepos, pullpos, 0.5, 0, pullpos:Distance(hingepos) / 128, colPullBeam)
			end
		end
	end
end

function GM:ToggleZombieVision(onoff)
	if onoff == nil then
		onoff = not self.m_ZombieVision
	end

	if onoff then
		if not self.m_ZombieVision then
			self.m_ZombieVision = true
			MySelf:EmitSound("npc/stalker/breathing3.wav", 0, 230)
			MySelf:SetDSP(30)
		end
	elseif self.m_ZombieVision then
		self.m_ZombieVision = nil
		MySelf:EmitSound("npc/zombie/zombie_pain6.wav", 0, 110)
		MySelf:SetDSP(0)
	end
end
