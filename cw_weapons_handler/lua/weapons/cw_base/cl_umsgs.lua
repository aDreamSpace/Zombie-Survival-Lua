local function CW20_DEPLOYANGLE(um)
	local ang = um:ReadAngle()
	local ply = MySelf 
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep.DeployAngle = ang
	end
end

usermessage.Hook("CW20_DEPLOYANGLE", CW20_DEPLOYANGLE)

local function CW20_DEPLOY()
	local ply = MySelf 
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep:Deploy()
	end
end

usermessage.Hook("CW20_DEPLOY", CW20_DEPLOY)

local function CW20_THROWGRENADE()
	local ply = MySelf 
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		CustomizableWeaponry.quickGrenade.throw(wep)
	end
end

usermessage.Hook("CW20_THROWGRENADE", CW20_THROWGRENADE)

local function CW20_GLOBALDELAY(um)
	local delay = um:ReadFloat()
	local ply = MySelf 
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep:delayEverything(delay)
		wep:setGlobalDelay(delay)
	end
end

usermessage.Hook("CW20_GLOBALDELAY", CW20_GLOBALDELAY)

local function CW20_FORCESTATE(um)
	local ply = MySelf 
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep:forceState(um:ReadShort(), um:ReadFloat())
	end
end

usermessage.Hook("CW20_FORCESTATE", CW20_FORCESTATE)

local function CW20_M203ON()
	local ply = MySelf 
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep:enableM203()
	end
end

usermessage.Hook("CW20_M203ON", CW20_M203ON)

local function CW20_M203OFF()
	local ply = MySelf 
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep:disableM203(true)
	end
end

usermessage.Hook("CW20_M203OFF", CW20_M203OFF)

local function CW20_M203OFF_RELOAD()
	local ply = MySelf 
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep:disableM203(false)
	end
end

usermessage.Hook("CW20_M203OFF_RELOAD", CW20_M203OFF_RELOAD)

local function CW20_FIREM203()
	local ply = MySelf 
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep:fireM203()
	end
end

usermessage.Hook("CW20_FIREM203", CW20_FIREM203)

local function CW20_RELOADM203()
	local ply = MySelf 
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep:reloadM203()
	end
end

usermessage.Hook("CW20_RELOADM203", CW20_RELOADM203)

local function CW20_GRENADETYPE(um)
	local grenType = um:ReadShort()
	local ply = MySelf 
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep.Grenade40MM = grenType
		
		if CustomizableWeaponry.playSoundsOnInteract then
			wep:EmitSound("CW_M203_OPEN")
		end
	end
end

usermessage.Hook("CW20_GP25ON", CW20_GP25ON)

local function CW20_GP25OFF()
	local ply = MySelf 
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep:disableGP25(true)
	end
end

usermessage.Hook("CW20_GP25OFF", CW20_GP25OFF)

local function CW20_GP25OFF_RELOAD()
	local ply = MySelf 
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep:disableGP25(false)
	end
end

usermessage.Hook("CW20_GP25OFF_RELOAD", CW20_GP25OFF_RELOAD)

local function CW20_FIREGP25()
	local ply = MySelf 
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep:fireGP25()
	end
end

usermessage.Hook("CW20_FIREGP25", CW20_FIREGP25)

local function CW20_RELOADGP25()
	local ply = MySelf 
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep:reloadGP25()
	end
end

usermessage.Hook("CW20_RELOADGP25", CW20_RELOADGP25)

local function CW20_GRENADETYPE(um)
	local grenType = um:ReadShort()
	local ply = MySelf 
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep.Grenade40MM = grenType
		
		if CustomizableWeaponry.playSoundsOnInteract then
			wep:EmitSound("CW_GP25_OPEN")
		end
	end
end

usermessage.Hook("CW20_GRENADETYPE", CW20_GRENADETYPE)

local function CW20_M203CHAMBER(um)
	local wep = um:ReadEntity()
	local state = um:ReadBool()
	
	wep.M203Chamber = state
end

local function CW20_GP25CHAMBER(um)
	local wep = um:ReadEntity()
	local state = um:ReadBool()
	
	wep.GP25Chamber = state
end

usermessage.Hook("CW20_M203CHAMBER", CW20_M203CHAMBER)
usermessage.Hook("CW20_GP25CHAMBER", CW20_GP25CHAMBER)