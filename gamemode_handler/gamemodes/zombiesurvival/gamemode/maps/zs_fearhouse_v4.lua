local tMapIDs = {
	1412,
	1236,
}
hook.Add("InitPostEntity", "IsThisTouhou?", function()
	for _, id in pairs(tMapIDs) do
		local ent = ents.GetMapCreatedEntity(id)
		if ent and ent:IsValid() then
			ent:Remove()
		end
	end
end)