include("shared.lua")

SWEP.PrintName = "Phantom"
SWEP.ViewModelFOV = 70

--[[function SWEP:Holster()
	if self.Owner:IsValid() and self.Owner == MySelf then
		self.Owner:SetBarricadeGhosting(false)
	end

	return self.BaseClass.Holster(self)
end]]

function SWEP:PreDrawViewModel(vm)
	self.Owner:CallZombieFunction("PrePlayerDraw")
end

function SWEP:PostDrawViewModel(vm)
	self.Owner:CallZombieFunction("PostPlayerDraw")
end

--[[function SWEP:Think()
	self.BaseClass.Think(self)

	if self.Owner:IsValid() and MySelf == self.Owner then
		self:BarricadeGhostingThink()
	end
end]]
