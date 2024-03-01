local function CW_Flashbanged(data)
	local intensity = data:ReadFloat()
	local duration = data:ReadFloat()
	
	MySelf:cwFlashbang(intensity, duration)
end

usermessage.Hook("CW_FLASHBANGED", CW_Flashbanged)