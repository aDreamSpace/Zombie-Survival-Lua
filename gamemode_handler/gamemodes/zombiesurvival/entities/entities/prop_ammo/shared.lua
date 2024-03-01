ENT.Type = "anim"
ENT.Base = "prop_baseoutlined"

ENT.NoNails = true

function ENT:HumanHoldable(pl)
	return pl:KeyDown(GAMEMODE.UtilityKey)
end

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "AmmoName")
	self:NetworkVar("String", 1, "_AmmoType")
	self:NetworkVar("Int", 0, "AmmoAmount")
end

--workaround so we can access the ammotype on client
function ENT:SetAmmoType(ammotype)
	self:Set_AmmoType(ammotype)
	self:SetModel(GAMEMODE.AmmoModels[string.lower(ammotype)] or "models/Items/BoxMRounds.mdl")
	self.m_AmmoType = ammotype
	self:SetAmmoName(GAMEMODE.AmmoNames[ammotype] or "Unknown")
end

function ENT:GetAmmoType(realName)
	if realName == true then return GAMEMODE.AmmoNames[self.m_AmmoType] or "Unknown" end
	return self.m_AmmoType or self:Get_AmmoType() or "pistol"
end