if CLIENT then
	matproxy.Add({
		name = "IronsightVectorResult",
		
		init = function(self, mat, values)
			self.ResultTo = values.resultvar
			self.ResultBase = Vector(values.resultdefault)
			self.ResultAdd = Vector(values.resultzoomed) - self.ResultBase
		end,
		
		bind = function(self, mat, ent)
			if !IsValid(ent) then return end
			
			local mul = ent._cw_kk_ins2_matproxy_mul or 0.5
			
			if IsValid(ent._SWEP) and ent._SWEP.CW20Weapon and ent._SWEP:isAiming() then
				mul = math.Approach(mul, 1, FrameTime() * 2)
			else
				mul = math.Approach(mul, 0, FrameTime() * 2)
			end
			
			ent._cw_kk_ins2_matproxy_mul = mul
			mat:SetVector(self.ResultTo, self.ResultBase + mul * self.ResultAdd)
		end
	})
end