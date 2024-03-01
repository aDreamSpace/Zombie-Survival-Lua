local SP = game.SinglePlayer()

-- lol
function SWEP:sendWeaponAnim(anim, speed, cycle)
	-- what the fuck are you doing without an anim name
	if not anim then
		return
	end
	
	-- make sure we don't set/send nil args
	speed = speed or 1
	cycle = cycle or 0
	
	-- prediction is disabled in SP, so just send the anim via UMSG
	if SP and SERVER then
		umsg.Start("CW20_ANIMATE", self.Owner)
			umsg.String(anim)
			umsg.Float(speed)
			umsg.Float(cycle)
		umsg.End()
		
		return
	end
	
	if self.animCallbacks and self.animCallbacks[anim] then
		self.animCallbacks[anim](self)
	end
	
	-- in MP just play the anim on the player, clientside
	
	if CLIENT then
		if anim:find("reload") then
			if self:Clip1() == 0 then
				self.wasEmpty = true
				
				if self.BoltBoneID and self.DontHoldWhenReloading then
					self:setBoltBonePosition(Vector(0, 0, 0))
				end
			else
				self.wasEmpty = false
			end
		end
	end
	
	self:playAnim(anim, speed, cycle)
end

function SWEP:sendMeleeAnim(anim, speed, cycle)
	-- make sure we don't set/send nil args
	speed = speed or 1
	cycle = cycle or 0
	self:playMeleeAnim(anim, speed, cycle)
end

local tInfo = {start = Vector(0, 0, 0), endpos = Vector(0, 0, 0)}
function SWEP:DetermineHitOrMiss(range)
	local owner = self:GetOwner()
	local vSP = owner:GetShootPos()
	tInfo.start = vSP
	tInfo.endpos = vSP + owner:GetAimVector() * range
	tInfo.filter = team.GetPlayers(owner:Team())

	local tr = util.TraceLine(tInfo)
	if tr.Hit then
		return true
	else
		return false
	end
end

SWEP.m_Right = true
function SWEP:playMeleeAnim(anim, speed, cycle, ent, bPrimary, bHit)
	ent = ent or self.CW_VM
	cycle = cycle or 0
	speed = speed or 1
	bPrimary = true
	
	local foundAnim = anim
	
	if ent == self.CW_VM then
		foundAnim = self.Animations[anim] --first cache our animation here for legacy support

		--then load our new animations depending on what we need
		local tAnims = self.Animations
		if bPrimary and self.UseLRAnimsPrimary then
			if bHit then
				foundAnim = tAnims[self.m_Right and "hit_primaryR" or "hit_primaryL"]
			else
				foundAnim = tAnims[self.m_Right and "miss_primaryR" or "miss_primaryL"]
			end
			
			self.m_Right = not self.m_Right --change this for the next animation
		elseif self.UseLRAnimsSecondary then
			if bHit then
				foundAnim = tAnims[self.m_Right and "hit_secondaryR" or "hit_secondaryL"]
			else
				foundAnim = tAnims[self.m_Right and "miss_secondaryR" or "miss_secondaryL"]
			end
			self.m_Right = not self.m_Right --change this for the next animation
		end

		if not foundAnim then
			return
		end
		
		if type(foundAnim) == "table" then
			foundAnim = table.Random(foundAnim)
		end
		
		if self.Sounds[foundAnim] then
			self:setCurSoundTable(self.Sounds[foundAnim], speed, cycle, foundAnim)
		else
			self:removeCurSoundTable()
		end
	end
	if SERVER then
		return
	end
	
	ent:ResetSequence(foundAnim)
	ent:SetCycle(cycle)
	ent:SetPlaybackRate(speed)
end

if SERVER then
	util.AddNetworkString("cw_serveranims")
end

if CLIENT then
	net.Receive("cw_serveranims", function(ln)
		local sp = net.ReadFloat()
		local f = net.ReadCString()
		local e = net.ReadEntity()
		if MySelf:GetActiveWeapon() == e then
			MySelf:GetActiveWeapon():playAnim(nil, sp, nil, nil, f)
		end
	end)
end

function SWEP:playAnim(anim, speed, cycle, ent, force)
	ent = ent or self.CW_VM
	cycle = cycle or 0
	speed = speed or 1
	
	if SERVER and force then
		net.Start("cw_serveranims")
			net.WriteFloat(speed)
			net.WriteCString(force)
			net.WriteEntity(self)
		net.Send(self:GetOwner())
		return
	end

	local foundAnim = anim
	
	if ent == self.CW_VM then
		foundAnim = force or self.Animations[anim]
		
		if not foundAnim then
			return
		end
		
		if type(foundAnim) == "table" then
			foundAnim = table.Random(foundAnim)
		end
		
		if self.Sounds[foundAnim] then
			self:setCurSoundTable(self.Sounds[foundAnim], speed, cycle, foundAnim)
		else
			self:removeCurSoundTable()
		end
	end

	if SERVER then
		return
	end
	
	ent:ResetSequence(foundAnim)
	
	if cycle > 0 then
		ent:SetCycle(cycle)
	else
		ent:SetCycle(0)
	end
	
	ent:SetPlaybackRate(speed)
end

function SWEP:setCurSoundTable(animTable, speed, cycle, origAnim)
	local found = 1
	
	if cycle ~= 0 then
		-- get the length of the animation and relative time to animation
		local animLen = self.CW_VM:SequenceDuration()
		local timeRel = animLen * cycle
		local foundInTable = false
		
		-- loop through the table, and find the entry which the cycle has not passed yet
		for k, v in ipairs(animTable) do
			if timeRel < v.time then
				found = k
				foundInTable = true
				break
			end
		end
		
		if not foundInTable then
			found = false
		end
	end
	
	if found then
		self.CurSoundTable = animTable
		self.CurSoundEntry = found
		self.SoundTime = (CLIENT and UnPredictedCurTime() or CurTime())
		self.SoundSpeed = speed
		
		if CLIENT then
			if origAnim == self.Animations.draw then
				if self.drawnFirstTime then
					self.SoundTime = self.SoundTime - 0.22
				end
			
				self.drawnFirstTime = true
			end
		end
	else
		self:removeCurSoundTable()
	end
end

function SWEP:removeCurSoundTable()
	-- wipes all current animation sound table information to turn it off
	self.CurSoundTable = nil
	self.CurSoundEntry = nil
	self.SoundTime = nil
	self.SoundSpeed = nil
end

if CLIENT then
	local function CW20_ANIMATE(um)
		local anim = um:ReadString()
		local speed = um:ReadFloat()
		local cycle = um:ReadFloat()
		
		local ply = MySelf 
		local wep = ply:GetActiveWeapon()
		
		if not IsValid(wep) then
			return
		end
		
		if wep.sendWeaponAnim then
			wep:sendWeaponAnim(anim, speed, cycle)
		end
	end
	
	usermessage.Hook("CW20_ANIMATE", CW20_ANIMATE)
	
	local function CW20_EFFECTS()
		local ply = MySelf 
		local wep = ply:GetActiveWeapon()
		
		if not IsValid(wep) or not  wep.CW20Weapon then
			return
		end
		
		wep:makeFireEffects()
	end
	
	usermessage.Hook("CW20_EFFECTS", CW20_EFFECTS)
end