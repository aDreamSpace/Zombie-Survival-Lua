hook.Add("InitPostEntity", "RemoveFlares", function()
	util.RemoveAll("func_physbox")
end)