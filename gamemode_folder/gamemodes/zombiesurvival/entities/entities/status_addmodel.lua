AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "status__base"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()
	self:SetSolid(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
	self:AddEffects(bit.bor(EF_BONEMERGE, EF_BONEMERGE_FASTCULL, EF_PARENT_ANIMATES))
end

function ENT:PlayerSet(pPlayer, bExists)
	pPlayer.status_addmodel = self
end

function ENT:OnRemove()
	local owner = self:GetOwner()
	if SERVER and owner and owner:IsValid() then
		owner:SetRenderMode(RENDERMODE_NORMAL)
	end
end

function ENT:Think()
	local owner = self:GetOwner()
	if SERVER and not (owner and owner:IsValid() and owner:Alive() and owner:Team() == TEAM_UNDEAD) then
		self:Remove()
	end
end

if CLIENT then
	function ENT:Draw()
		local owner = self:GetOwner()
		if owner:IsValid() and (not owner:IsPlayer() or owner:Alive()) then
			self:DrawModel()
		end
	end
	ENT.DrawTranslucent = ENT.Draw
end
