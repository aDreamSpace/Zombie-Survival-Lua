include("shared.lua")

ENT.ColorModulation = Color(0.25, 1, 0.25)

function ENT:Initialize()
    hook.Add("RenderScreenspaceEffects", self, self.RenderScreenspaceEffects)
end

local baseFont = "CW_HUD72"
local ammoText = "CW_HUD60"

ENT.upOffset = Vector(0, 0, 25)

local strPoint = "'s Soul"
local strPoint2 = "Soul"
local white = Color(255, 255, 255, 255)
local black = Color(0, 0, 0, 255)
ENT.setup = false
local matSpr = Material("sprites/glow04_noz")
local colTemp = Color(255, 255, 255)
function ENT:Draw()
	if not self.setup then
        surface.SetFont(baseFont)
		self.x, self.y = surface.GetTextSize(tostring(self:GetPointValue()))
		self.baseHorSize, self.vertFontSize = self.x, 50
		self.baseHorSize = self.baseHorSize < 180 and 180 or self.baseHorSize
		self.baseHorSize = self.baseHorSize + 20
		self.halfBaseHorSize = self.baseHorSize * 0.5
		self.halfVertFontSize = self.vertFontSize * 0.5
		
		self.setup = true

		self.halfw = ScrW() / 2
		self.halfh = ScrH() / 2
		self.fracw = ScrW() / 6
	end

	local ply = MySelf
	
	local eyeAng = EyeAngles()
	eyeAng.p = 0
	eyeAng.y = eyeAng.y - 90
	eyeAng.r = 90

	local owner = self:GetPointOwner()
    if owner and owner:IsValid() then
        colTemp = owner:GetPlayerColor():ToColor()
		--strPoint2 = owner:ClippedName()..strPoint
    end
	
	cam.Start3D2D(self:GetPos() + self.upOffset, eyeAng, 0.05)
		local r, g, b, a = 150, 150, 255, 200
		surface.SetDrawColor(r, g, b, a)
		surface.DrawRect(-self.halfBaseHorSize, 0, self.baseHorSize, self.vertFontSize * 2)
		
		surface.SetDrawColor(0, 0, 0, 150)
		surface.DrawRect(-self.halfBaseHorSize, self.vertFontSize, self.baseHorSize, self.vertFontSize * 3)

		draw.ShadowText(strPoint2, baseFont, 0, self.halfVertFontSize * 2, white, black, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.ShadowText(tostring(self:GetPointValue()), ammoText, 0, self.vertFontSize + self.halfVertFontSize * 3, white, black, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	cam.End3D2D()

    local curtime = CurTime()
    --self:DrawModel()

    render.SetMaterial(matSpr)
    render.DrawSprite(self:WorldSpaceCenter(), 16, 16, colTemp)

    local dlight = DynamicLight(self:EntIndex())
	if dlight then
		local size = 32 + self:GetPointValue() * 5
		size = size * TimedCos(0.75, 1, 1.2, 1)
		dlight.Pos = self:WorldSpaceCenter()
		dlight.r = colTemp.r
		dlight.g = colTemp.g
		dlight.b = colTemp.b
		dlight.Brightness = 1
		dlight.Size = size
		dlight.Decay = size * 2
		dlight.DieTime = curtime + 1
	end

    self:HandleEffects()
end

function ENT:HandleEffects()
    self.NextEffect = self.NextEffect or 0
    if self.NextEffect > CurTime() then return end
    self.NextEffect = CurTime() + math.Rand(0.1, 3)

    local effectdata = EffectData()
    effectdata:SetOrigin(self:WorldSpaceCenter())
    effectdata:SetMagnitude(3)
    effectdata:SetScale(3)
    effectdata:SetRadius(500)
    effectdata:SetEntity(self)
    for i = 1, 8 do
        util.Effect("TeslaHitboxes", effectdata)
    end
    local Zap = math.random(1,9)
    if Zap == 4 then Zap = 3 end
    self:EmitSound("ambient/energy/zap" .. Zap .. ".wav", 75, 175, 0.6)
end


local CModWhiteOut = {
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

function ENT:RenderScreenspaceEffects()
    if MySelf:Team() == TEAM_UNDEAD then return end
    if not self:GetPos():ToScreen().visible then return end
	local eyepos = EyePos()
	local nearest = self:NearestPoint(eyepos)
	local dist = eyepos:Distance(nearest)
	local power = math.Clamp(1 - dist / 300, 0, 1) ^ 2 * math.Clamp(self:GetPointValue(), 0, 100) * 0.005

	if power > 0 then
		local size = 5 + power * 10

		CModWhiteOut["$pp_colour_brightness"] = power * 0.5
		DrawBloom(0.8, power * 4, size, size, 1, 1, 1, 1, 1)
		DrawColorModify(CModWhiteOut)

		if render.SupportsPixelShaders_2_0() then
			local eyevec = EyeVector()
			local pos = self:LocalToWorld(self:OBBCenter()) - eyevec * 16
			local distance = eyepos:Distance(pos)
			local dot = (pos - eyepos):GetNormalized():Dot(eyevec) - distance * 0.0005
			if dot > 0 then
				local srcpos = pos:ToScreen()
				--DrawSunbeams(0.8, dot * power, 0.1, srcpos.x / w, srcpos.y / h)
                DrawSunbeams(0.82, 0.09, 0.01, srcpos.x / w, srcpos.y / h)
			end
		end
	end
end