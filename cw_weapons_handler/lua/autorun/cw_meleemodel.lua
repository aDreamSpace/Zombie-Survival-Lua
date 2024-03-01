if not CustomizableWeaponry then return end

AddCSLuaFile()

if CLIENT then
	CustomizableWeaponry.callbacks:addNew("initialize", "MeleeModel", function(self)
		if self and self.UsePropModel and self.PropModel and self.elementRender then
			local tInfo = self.PropModel
			tInfo.boneid = self:LookupBone(tInfo.bone)
			self.CW_MELEEMODEL = ClientsideModel(tInfo.name, RENDERGROUP_OPAQUE)
			self.CW_MELEEMODEL:SetNoDraw(true)
        
			self.elementRender.MeleeModel = function(self)
				local mdl = self.CW_MELEEMODEL
				local pos, ang = self:getBoneOrientation(tInfo.boneid)
          		local fwd = ang:Forward()
          		local rt = ang:Right()
          		local up = ang:Up()
				pos:Add(fwd * tInfo.pos.x)
				pos:Add(rt * tInfo.pos.y)
				pos:Add(up * tInfo.pos.z)
          		mdl:SetPos(pos)
          
          		ang:RotateAroundAxis(fwd, tInfo.ang.r)
          		ang:RotateAroundAxis(rt, tInfo.ang.p)
          		ang:RotateAroundAxis(up, tInfo.ang.y)
          		mdl:SetAngles(ang)
          		mdl:DrawModel()
			end
		end
	end)

	CustomizableWeaponry.callbacks:addNew("onRemove", "UndoMeleeModel", function(self) 
		--free memory since clientside props aren't garbage collected for some reason
		local mdl = self.CW_MELEEMODEL
      	--THIS BRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPS
		if mdl and mdl:IsValid() then
			mdl:Remove()
		end
	end)
end