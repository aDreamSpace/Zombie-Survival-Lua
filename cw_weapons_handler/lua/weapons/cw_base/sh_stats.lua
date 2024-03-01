-- various weapon stat related convenience functions

function SWEP:addStatModifiers(tbl)
	if tbl then
		-- loop through the table and modify multipliers
		for k, v in pairs(tbl) do
			if self[k] then
				self[k] = self[k] + v
			end
		end
	end
end

function SWEP:removeStatModifiers(tbl)
	if tbl then
		for k, v in pairs(tbl) do
			if self[k] then
				self[k] = self[k] - v
			end
		end
	end
end


function SWEP:recalculateDamage()
	if not self.Damage then
		return
	end
	self.Damage = self.Damage_Orig * self.DamageMult
end

function SWEP:recalculateRecoil()
	self.Recoil = self.Recoil_Orig * self.RecoilMult
end

function SWEP:recalculateFirerate()
	self.FireDelay = self.FireDelay_Orig * self.FireDelayMult
end

function SWEP:recalculateVelocitySensitivity()
	self.VelocitySensitivity = self.VelocitySensitivity_Orig * self.VelocitySensitivityMult
end

function SWEP:recalculateAimSpread()
	self.AimSpread = self.AimSpread_Orig * self.AimSpreadMult
end

function SWEP:recalculateHipSpread()
	self.HipSpread = self.HipSpread_Orig * self.HipSpreadMult
end

function SWEP:recalculateDeployTime()
	self.DrawSpeed = self.DrawSpeed_Orig * self.DrawSpeedMult
end

function SWEP:recalculateReloadSpeed()
	self.ReloadSpeed = self.ReloadSpeed_Orig * self.ReloadSpeedMult
end

function SWEP:recalculateMouseSens()
	self.OverallMouseSens = self.OverallMouseSens_Orig --* self.OverallMouseSensMult
end

function SWEP:recalculateMaxSpreadInc()
	self.MaxSpreadInc = self.MaxSpreadInc_Orig * self.MaxSpreadIncMult
end

function SWEP:recalculateClumpSpread()
	if not self.ClumpSpread then
		return
	end
	
	self.ClumpSpread = self.ClumpSpread_Orig * self.ClumpSpreadMult
end

--custom functions for the custom multipliers!
function SWEP:recalculateMagSize()
	if not self.Chamberable then
		self.Primary.ClipSize = math.Round(self.Primary.ClipSize_ORIG_REAL * self.MagMult)
	else
		self.Primary.ClipSize_Orig = math.Round(self.Primary.ClipSize_ORIG_REAL * self.MagMult)
	end
end

function SWEP:recalculateSpeedDec()
	self.SpeedDec = self.SpeedDec_Orig * self.SpeedDecMult
end

function SWEP:recalculateShots()
	if not self.Shots then
		return
	end
	self.Shots = math.ceil(self.Shots_Orig * self.ShotsMult)
end

function SWEP:recalculateAuraRange()
	self.AuraRange = self.AuraRange_Orig * self.AuraRangeMult
end

function SWEP:recalculateEffectiveRange()
	self.EffectiveRange = self.EffectiveRange_Orig * self.EffectiveRangeMult
end

function SWEP:recalculateStats()
	-- recalculates all stats

	--we skip ones that do not pertain to CW melee
	if not self.CW20Melee then
		self:recalculateRecoil()
		self:recalculateAimSpread()
		self:recalculateHipSpread()
		self:recalculateReloadSpeed()
		self:recalculateClumpSpread()
		self:recalculateFirerate()
		--custom!
		self:recalculateMagSize()
		self:recalculateShots()
		self:recalculateEffectiveRange()
		self:recalculateMaxSpreadInc()
		self:recalculateSpeedDec()
	end

	self:recalculateDamage()
	self:recalculateVelocitySensitivity()
	self:recalculateDeployTime()
	
	--custom!
	self:recalculateAuraRange()
	self:recalculateSpeedDec()
	
	if CLIENT then
		self:recalculateMouseSens()
	end
end
