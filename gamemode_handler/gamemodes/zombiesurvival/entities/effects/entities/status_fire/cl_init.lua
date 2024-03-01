include("shared.lua")

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetRenderBounds(Vector(-40, -40, -18), Vector(40, 40, 90))

	self:GetOwner().Fire = self
end

--caching variables
--local matFire = Material("sprites/fire") --cause ugly black box, so now we just create it ourselves

--i hate vmt
local matFire = CreateMaterial("flame", "UnlitGeneric", {
	["$basetexture"] = "sprites/fire",
	["$additive"] = 1,
	["$vertexcolor"] = 1,
	["$vertexalpha"] = 1,
})
local colWhite = color_white
function ENT:DrawTranslucent()
	local owner = self:GetOwner()
	if owner:IsValid() and (owner ~= MySelf or owner:ShouldDrawLocalPlayer()) then
		local pos = owner:WorldSpaceCenter()
		render.SetMaterial(matFire)
		render.DrawSprite(pos, 32, 72, colWhite)
	end
end