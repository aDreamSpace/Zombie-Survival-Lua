local meta = FindMetaTable("Weapon")

function meta:DrawWeaponCrosshair()
	if GetConVar("crosshair"):GetInt() ~= 1 then return end

	self:DrawCrosshairCross()
	self:DrawCrosshairDot()
end
