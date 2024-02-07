AddCSLuaFile()

CustomizableWeaponry.registeredSoundNames = {}
CustomizableWeaponry.reloadSoundVolume = 60

-- default settings
CustomizableWeaponry.reloadSoundTable = {
	channel = CHAN_AUTO, 
	volume = 1,
	level = CustomizableWeaponry.reloadSoundVolume, 
	pitchstart = 100,
	pitchend = 100,
	name = "noName",
	sound = "path/to/sound"
	}
	
CustomizableWeaponry.fireSoundTable = {
	channel = CHAN_AUTO, 
	volume = 1,
	level = 97, 
	pitchstart = 92,
	pitchend = 112,
	name = "noName",
	sound = "path/to/sound"
	}
	
CustomizableWeaponry.fire2SoundTable = {
	channel = CHAN_AUTO, 
	volume = 1,
	level = 100, 
	pitchstart = 100,
	pitchend = 100,
	name = "noName",
	sound = "path/to/sound"
	}
	
CustomizableWeaponry.regularSoundTable = {
	channel = CHAN_AUTO,
	volume = 1,
	level = 65, 
	pitchstart = 92,
	pitchend = 112,
	name = "noName",
	sound = "path/to/sound"
	}

-- "<" makes the sound directional, refer to https://developer.valvesoftware.com/wiki/Soundscripts#Sound_Characters
function CustomizableWeaponry:makeSoundDirectional(snd)
	if type(snd) == "table" then
		for key, sound in ipairs(snd) do
			--maybe should be bWav :V
			local bOgg = string.sub(sound, -1, -4) == ".ogg"
			if not bOgg then
				snd[key] = "<" .. sound
			end
		end
	elseif string.sub(snd, -1, -4) ~= ".ogg" then
		snd = "<" .. snd
	end
	
	return snd
end
	
function CustomizableWeaponry:addFireSound(name, snd, volume, soundLevel, channel, pitchStart, pitchEnd, noDirection)
	-- use defaults if no args are provided
	volume = volume or 1
	soundLevel = soundLevel or 97
	channel = channel or CHAN_AUTO
	pitchStart = pitchStart or 92
	pitchEnd = pitchEnd or 112
	
	if not noDirection then
		snd = self:makeSoundDirectional(snd)
	end
	
	self.fireSoundTable.name = name
	self.fireSoundTable.sound = snd
	
	self.fireSoundTable.channel = channel
	self.fireSoundTable.volume = volume
	self.fireSoundTable.level = soundLevel
	self.fireSoundTable.pitchstart = pitchStart
	self.fireSoundTable.pitchend = pitchEnd
	
	sound.Add(self.fireSoundTable)
	
	-- precache the registered sounds
	
	if type(self.fireSoundTable.sound) == "table" then
		for k, v in pairs(self.fireSoundTable.sound) do
			util.PrecacheSound(v)
		end
	else
		util.PrecacheSound(snd)
	end
	
	-- store all registered sound names so that we can retrieve them with findFireSound (in case someone names their firing sound in a lowercase manner and then uses upper case in the SWEP file)
	self.registeredSoundNames[string.lower(name)] = name
end

function CustomizableWeaponry:addFire2Sound(name, snd, volume, soundLevel, channel, pitchStart, pitchEnd, noDirection)
	-- use defaults if no args are provided
	volume =  1
	soundLevel =  150
	channel = CHAN_AUTO
	pitchStart =  100
	pitchEnd =  100
	
	if not noDirection then
		snd = self:makeSoundDirectional(snd)
	end
	
	self.fire2SoundTable.name = name
	self.fire2SoundTable.sound = snd
	
	self.fire2SoundTable.channel = channel
	self.fire2SoundTable.volume = volume
	self.fire2SoundTable.level = soundLevel
	self.fire2SoundTable.pitchstart = pitchStart
	self.fire2SoundTable.pitchend = pitchEnd
	
	sound.Add(self.fire2SoundTable)
	
	-- precache the registered sounds
	
	if type(self.fire2SoundTable.sound) == "table" then
		for k, v in pairs(self.fire2SoundTable.sound) do
			util.PrecacheSound(v)
		end
	else
		util.PrecacheSound(snd)
	end
	
	-- store all registered sound names so that we can retrieve them with findFireSound (in case someone names their firing sound in a lowercase manner and then uses upper case in the SWEP file)
	self.registeredSoundNames[string.lower(name)] = name
end

function CustomizableWeaponry:addReloadSound(name, snd, noDirection)
	if not noDirection then
		snd = self:makeSoundDirectional(snd)
	end
	
	self.reloadSoundTable.name = name
	self.reloadSoundTable.sound = snd

	sound.Add(self.reloadSoundTable)
	
	-- precache the registered sounds
	
	if type(self.reloadSoundTable.sound) == "table" then
		for k, v in pairs(self.reloadSoundTable.sound) do
			util.PrecacheSound(v)
		end
	else
		util.PrecacheSound(snd)
	end
end

function CustomizableWeaponry:addRegularSound(name, snd, level, noDirection)
	if not noDirection then
		snd = self:makeSoundDirectional(snd)
	end
	
	level = level or 65
	self.regularSoundTable.name = name
	self.regularSoundTable.sound = snd
	self.regularSoundTable.level = level

	sound.Add(self.regularSoundTable)
	
	-- precache the registered sounds
	
	if type(self.regularSoundTable.sound) == "table" then
		for k, v in pairs(self.regularSoundTable.sound) do
			util.PrecacheSound(v)
		end
	else
		util.PrecacheSound(snd)
	end
end

function CustomizableWeaponry:findFireSound(snd)
	snd = string.lower(snd)
	
	if self.registeredSoundNames[snd] then
		return self.registeredSoundNames[snd]
	end
	
	-- welp
	return nil
end