ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.NoNails = true

function ENT:HumanHoldable(pl)
	return pl:KeyDown(GAMEMODE.UtilityKey)
end

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "PointValue")
	self:NetworkVar("Entity", 0, "PointOwner")
end
