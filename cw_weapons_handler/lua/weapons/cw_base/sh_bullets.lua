local Dir, Dir2, dot, sp, ent, trace, seed, hm

SWEP.NormalTraceMask = bit.bor(CONTENTS_SOLID, CONTENTS_OPAQUE, CONTENTS_MOVEABLE, CONTENTS_DEBRIS, CONTENTS_MONSTER, CONTENTS_HITBOX, 402653442, CONTENTS_WATER)
SWEP.WallTraceMask = bit.bor(CONTENTS_TESTFOGVOLUME, CONTENTS_EMPTY, CONTENTS_MONSTER, CONTENTS_HITBOX)

SWEP.NoPenetration = {[MAT_SLOSH] = true}
SWEP.NoRicochet = {[MAT_WOOD] = true, [MAT_FLESH] = true, [MAT_ANTLION] = true, [MAT_BLOODYFLESH] = true, [MAT_DIRT] = true, [MAT_SAND] = true, [MAT_GLASS] = true, [MAT_ALIENFLESH] = true, [MAT_GRASS] = true}
SWEP.PenetrationMaterialInteraction = {[MAT_SAND] = 0.5, [MAT_DIRT] = 0.8, [MAT_METAL] = 1.1, [MAT_TILE] = 0.9, [MAT_WOOD] = 1.2}
local bul, tr = {}, {}
local SP = game.SinglePlayer()
local zeroVec = Vector(0, 0, 0)

local reg = debug.getregistry()
local GetShootPos = reg.Player.GetShootPos

function SWEP:GetAuraRange()
	return self.AuraRange or 2048
end

SWEP.bulletCallback = function(ply, traceResult, dmgInfo) -- create the callback function once, to avoid function spam
	CustomizableWeaponry.callbacks.processCategory(ply:GetActiveWeapon(), "bulletCallback", ply, traceResult, dmgInfo)
end

function SWEP:canPenetrate(traceData, direction)
	local dot = nil
	
	if not self.NoPenetration[traceData.MatType] then
		dot = self:getSurfaceReflectionDotProduct(traceData, direction)
		ent = traceData.Entity
	
		if not ent:IsNPC() and not ent:IsPlayer() then
			if dot > 0.26 and self.CanPenetrate then
				return true, dot
			end
		end
	end
	
	return false, dot
end

function SWEP:getSurfaceReflectionDotProduct(traceData, dir)
	return -dir:DotProduct(traceData.HitNormal)
end

function SWEP:canRicochet(traceData, penetrativeRange)
	penetrativeRange = penetrativeRange or self.PenetrativeRange

	if self.CanRicochet and not self.NoRicochet[traceData.MatType] and penetrativeRange * traceData.Fraction < penetrativeRange then
		return true
	end
	
	return false
end

local tPen = {
	start = nil,
	endpos = nil,
	filter = nil
}
local function FireAnotherTrace(start, filter, ang)
	tPen.start = start
	tPen.endpos = start + ang * 10000
	tPen.filter = filter
	
	local tr = util.TraceLine(tPen)

	return tr.Entity
end

--enumerations
BULTYPE_NONE = 0
BULTYPE_GLASS = 1
BULTYPE_BOOM = 2
BULTYPE_FLASH = 3
BULTYPE_PEN = 4
BULTYPE_FIRE = 5
BULTYPE_SHRAPNEL = 6

--Store all bullet callback operations in a lookup table, so that custom ones can be used
local bultypeFunctions = {}

bultypeFunctions[BULTYPE_GLASS] = function(attacker, tr, dmginfo)
	local data = EffectData()
	data:SetOrigin(tr.HitPos)
	util.Effect("GlassImpact", data)
	if tr.Entity:IsPlayer() and tr.Entity:Alive() and tr.Entity:Team() == TEAM_UNDEAD then
		local bleed = tr.Entity:GiveStatus("zbleed")
		if bleed and bleed:IsValid() then
			bleed:AddDamage(5)
			bleed.Damager = attacker
		end
	end
end

local wep, dmg, pos
bultypeFunctions[BULTYPE_BOOM] = function(attacker, tr, dmginfo)
	--util.BlastDamage(wep, attacker, pos, 64, wep.Damage * 0.5)
	wep = attacker:GetActiveWeapon()
	dmg = DamageInfo()
	pos = tr.HitPos

	dmg:SetDamage(wep.Damage * 0.5)
	dmg:SetDamageType(DMG_GENERIC)
	dmg:SetInflictor(wep)
	dmg:SetAttacker(attacker)
	util.BlastDamageInfo(dmg, pos, 96)
	timer.Simple(0, function()
		data = EffectData()
		data:SetOrigin(pos)
		util.Effect("ManhackSparks", data)
	end)
end

local ShadeDMGPercent = GAMEMODE.ZombieClasses.Shade and GAMEMODE.ZombieClasses.Shade.Health and GAMEMODE.ZombieClasses.Shade.Health * 0.0016 or 10
local tInfo = {start = nil, endpos = nil, filter = nil}
bultypeFunctions[BULTYPE_FLASH] = function(attacker, tr, dmginfo)
	if SERVER then
		tInfo.start = attacker:GetShootPos()
		tInfo.endpos = tr.HitPos + attacker:GetAimVector() * 64 --extend a bit out
		tInfo.filter = team.GetPlayers(attacker:Team())

		local tEnts = util.EnumTraceLine(tInfo)
		wep = attacker:GetActiveWeapon()
		for _, ent in pairs(tEnts) do
			if ent and ent:IsValid() and ent:IsPlayer() and ent:Alive() and ent:Team() == TEAM_UNDEAD and ent:GetZombieClassTable().Name == "Shade" then
				SHADEFLASHLIGHTDAMAGE = true
				ent:TakeDamage(ShadeDMGPercent, attacker, wep)
				SHADEFLASHLIGHTDAMAGE = false
			end
		end
	end
end

local ang
local start
local dmgFalloff
local dmg
local hitEnts
bultypeFunctions[BULTYPE_PEN] = function(attacker, tr, dmginfo)
	ang = tr.Normal --use tr.Normal since that will take bullet spread into account
	wep = attacker:GetActiveWeapon()
	start = attacker:GetShootPos()
	dmgFalloff = wep.dmgFalloff or (1/2)
	dmg = nil
	hitEnts = {}
	--lets build a list of all the ents that are in our way
	--we'll run our traces only 10 times since by then our damage will be small enough to not matter
	--I should probably find a better way to do this but this breaks out of it automatically, so that should manage itself
	for i = 1, 10 do
		local ent = FireAnotherTrace(start, hitEnts, ang)
		if ent and ent:IsValid() and ent:IsPlayer() then
			table.insert(hitEnts, ent)
		else --as soon as we hit something that isn't a player? stop doing calculations
			break
		end
	end

	--now lets loop through all of our ents and deal damage to all of them
	for i = 1, #hitEnts do
		local ply = hitEnts[i]
		if ply and ply:IsValid() and ply:Team() == TEAM_UNDEAD and ply ~= tr.Entity and ply ~= attacker then
			dmg = dmg or dmginfo:GetDamage()
			dmg = dmg * dmgFalloff
			if SERVER then
				ply:TakeDamage(dmg, attacker, wep)
			end
		end
	end		
end


local strF = "fire"
bultypeFunctions[BULTYPE_FIRE] = function(attacker, tr, dmginfo)
	--local data = EffectData() --reuse for fire effect later
	--data:SetOrigin(tr.HitPos)
	--util.Effect("GlassImpact", data)
	local ent = tr.Entity
	if ent:IsPlayer() and ent:Alive() and ent:Team() == TEAM_UNDEAD then
		wep = attacker:GetActiveWeapon()
		local dmg = dmginfo:GetDamage()
		if wep and wep:IsValid() and wep.Shots then
			dmg = math.floor(dmg / (wep.Shots / 1.5))
		end

		local flame = ent:GiveStatus(strF)
		if flame and flame:IsValid() then
			flame:AddDamage(dmg)
			flame.Damager = attacker
		end
	end
end

bultypeFunctions[BULTYPE_SHRAPNEL] = function(attacker, tr, dmginfo)
	local data = EffectData()
	data:SetOrigin(tr.HitPos)
	util.Effect("GlassImpact", data)
	if tr.Entity:IsPlayer() and tr.Entity:Alive() and tr.Entity:Team() == TEAM_UNDEAD then
		local bleed = tr.Entity:GiveStatus("zbleed")
		if bleed and bleed:IsValid() then
			bleed:AddDamage(5)
			bleed.Damager = attacker
		end
	end
end


local colClient = Color(240, 160, 65)
local colServer = Color(65, 130, 255)

if SERVER then
	util.AddNetworkString("zs_buldebug")
end

if CLIENT then
	function SendImpactToClient(pos)
		if pos then
			debugoverlay.Sphere(pos, 2, 12, colServer, true)
			print(pos)
		end
	end

	net.Receive("zs_buldebug", function()
		SendImpactToClient(net.ReadVector())
	end)
end

function GenericBulletCallback2(attacker, tr, dmginfo)
	dmginfo:SetDamageType(DMG_BULLET)
	local range = tr.Fraction * 56756
	local wep = attacker:GetActiveWeapon()
	if wep and wep:IsValid() and wep.EffectiveRange and range and range > wep.EffectiveRange then
		dmginfo:SetDamage(dmginfo:GetDamage() / 2)
	end

	if tr.Hit and wep.bulType and bultypeFunctions[wep.bulType] then
		bultypeFunctions[wep.bulType](attacker, tr, dmginfo)
	end
	--[[
	debugoverlay.Sphere(tr.HitPos, 2, 12, SERVER and colServer or colClient, true)
	if SERVER then
		net.Start("zs_buldebug")
			net.WriteVector(tr.HitPos)
		net.Send(attacker)
	end
	--]]
end

SWEP.Callbackfunk = GenericBulletCallback2

function ZSSpreadMod(wep)
	--Purpose: To add spread to weps depending on current fearmeter power.
	--Potential to multiply spread by 2, final value can be modified at any time by other variables.
	local ply = wep.Owner
	wep.SpreadCache = wep.SpreadCache or 0
	if not ply then print("Could not find owner for stat mod callback!") return nil, nil end
	local spreadMod = spreadMod or 1
	if wep.SpreadCache < CurTime() then
		spreadMod = 1 + GAMEMODE:GetFearMeterPower(ply:GetPos(), TEAM_UNDEAD)
		wep.SpreadCache = CurTime() + 0.1
	end
	
	return nil, spreadMod
	--and then multiply this by anything to nerf humans
end
CustomizableWeaponry.callbacks:addNew("calculateAccuracy", "SpreadModifierZS", ZSSpreadMod)

function EasyReload(wep)
	--Purpose: To change reload behavior with presence of variables on players, such as speedloading, slowloading.
	local cached = cached or 0
	local speedVar
	local ply = wep.Owner
	if not ply then print("Could not find owner for stat mod callback!") return end
	if cached < CurTime() then
		speedVar = ply:GetNWFloat("reloadScale", 1)
		cached = CurTime() + 3
	end
	wep.OldReloadSpeed = wep.OldReloadSpeed or wep.ReloadSpeed
	--print(ply:GetNWFloat("reloadScale", 1))
	--print(speedVar)
	--print(wep.ReloadSpeed)
	wep.ReloadSpeed = wep.OldReloadSpeed * (speedVar or 1)
end
CustomizableWeaponry.callbacks:addNew("canReload", "ReloadModifierZS", EasyReload)

function SWEP:FireBullet(damage, cone, clumpSpread, bullets)
	local owner = self:GetOwner()
	sp = GetShootPos(owner)
	local commandNumber = owner:GetCurrentCommand():CommandNumber()
	--print("cmd num", commandNumber, owner)
	math.randomseed(commandNumber)
	
	if owner:Crouching() then
		cone = cone * 0.85
	end
	
	if self.bulType == BULTYPE_GLASS then
		bullets = math.floor((math.random(8, 32)/8) * self.Shots)
	end
	
	if self.bulType == BULTYPE_SHRAPNEL then
		bullets = math.floor((math.Clamp(math.random(-200, 200),0 , 600 )/8) * self.Shots) 
		self.EffectiveRange = math.Rand(0, 1000)
	end
	
	if bullets == 0 then return end
	local angEyes = owner:EyeAngles()
	local angVP = owner:GetViewPunchAngles()
	Dir = (angEyes + angVP + Angle(math.Rand(-cone, cone), math.Rand(-cone, cone), 0) * 25):Forward()
	--Dir = (self.Owner:EyeAngles() + self.Owner:GetViewPunchAngles() + Angle(math.SharedRand(-cone, cone, self:GetClass(), commandNumber), math.SharedRand(-cone, cone, self:GetClass(), commandNumber), 0) * 25):Forward()
	--print("EA VPA Dir", angEyes, angVP, Dir, owner)
	clumpSpread = clumpSpread or self.ClumpSpread
	
	CustomizableWeaponry.callbacks.processCategory(self, "adjustBulletStructure", bul)

	owner.m_WeaponLightTime = RealTime() + 0.1
	
	for i = 1, bullets do
		Dir2 = Dir
		
		if clumpSpread and clumpSpread > 0 then
			math.randomseed(commandNumber + i)
			--Dir2 = Dir + Vector(math.SharedRand(-1, 1, self:GetClass(), commandNumber + 1), math.SharedRand(-1, 1, self:GetClass(), commandNumber + 2), math.SharedRand(-1, 1, self:GetClass(), commandNumber + 3)) * clumpSpread
			Dir2 = Dir + Vector(math.Rand(-1, 1), math.Rand(-1, 1), math.Rand(-1, 1)) * clumpSpread
			if i == 1 then
				--print("EA VPA Dir2", angEyes, angVP, Dir2, owner)
				--print("cs", clumpSpread, owner)
				--print("sp", sp, owner)
			end
		end
		
		if not CustomizableWeaponry.callbacks.processCategory(self, "suppressDefaultBullet", sp, Dir2, commandNumber) then
			bul.Num = 1
			bul.Src = sp
			bul.Dir = Dir2
			bul.Spread 	= zeroVec --Vector(0, 0, 0)
			bul.Tracer	= 3
			bul.Force	= 1
			bul.Damage = math.Round(damage)
			bul.Callback = self.Callbackfunk
			
			owner:FireBullets(bul)
		end
	end
end