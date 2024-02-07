local att = {}
att.name = "bg_hk416_foldsight"
att.displayName = "Illuminated sights"
att.displayNameShort = "IFS"
att.isBG = true
att.isSight = true
att.aimPos = {"FoldSightPos", "FoldSightAng"}
att.isSight = true
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/foldsight")
	att.description = {
		[1] = {t = "Folding iron sights that glow in dark.", c = CustomizableWeaponry.textColors.POSITIVE}
	}
	
	att.reticle = "qq_sprites/bigdot"
	att._reticleSize = 20
	
	function att:elementRender()
		local rc = self:getSightColor(att.name)
		-- local vec = Vector( 1 - (rc.r / 255), 1 - (rc.g / 255), 1 - (rc.b / 255)) // inverted
		-- local vec = Vector(rc.r / 255, rc.g / 255, rc.b / 255) // original
		local vec = Vector((rc.r / 255)*(rc.r / 255), (rc.g / 255)*(rc.g / 255), (rc.b / 255)*(rc.b / 255)) // saturated
		local mat = Material("models/qq_rec/shared/battlesight_diffuse")
		
		mat:SetVector("$selfillumtint", vec)
		-- mat:SetVector("$selfillumtint", Vector(0,0,0))
	end
end

function att:attachFunc()
	if CLIENT then
		self:setBodygroup(self.SightBGs.main, self.SightBGs.foldsight)
	end
	
	-- self.SightColors[att.name].color = 
	-- CustomizableWeaponry.colorableParts.setColor("bg_hk416_foldsight", "ret_green")
	-- "ret_green"
end
	
CustomizableWeaponry:registerAttachment(att)