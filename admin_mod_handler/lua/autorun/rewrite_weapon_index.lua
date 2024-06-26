local M_Weapon = FindMetaTable("Weapon")
local M_Entity = FindMetaTable("Entity")

local E_GetTable = M_Entity.GetTable
local E_GetOwner = M_Entity.GetOwner

local val
local wt
local nilValue = nil
function M_Weapon:__index(key)
	val = M_Weapon[key]
	if val ~= nilValue then return val end

	val = M_Entity[key]
	if val ~= nilValue then return val end

	-- Deprecated
	if key == "Owner" then return E_GetOwner(self) end

	wt = E_GetTable(self)
	if wt then
		return wt[key]
	end
end