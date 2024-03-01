timer.Create("BootlegTriggerHurt", 3, 0, function()
	local tblEnts = ents.FindInBox(Vector(-1585, 1196, -90), Vector(-1102, 1265, 70))
	for _, ent in pairs(tblEnts) do
		if ent and ent:IsValid() and ent:IsPlayer() then
			ent:TakeDamage(5000, ent, ent)
		end
	end
end)