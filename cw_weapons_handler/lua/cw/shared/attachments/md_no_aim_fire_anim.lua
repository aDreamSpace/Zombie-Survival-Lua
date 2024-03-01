local att = {}
att.name = "md_no_aim_fire_anim"
att.displayName = "No Aim Fire Anim"
att.displayNameShort = "AimAnim"

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/rmr")
	att.description = {[1] = {t = "No Fire Anim when shoot in aim, uses cw lua", c = CustomizableWeaponry.textColors.INFO}}
	
	function att:attachFunc()
		self.ReticleInactivityPostFire = 0
		self.ADSFireAnim = true
        self.BoltBone = "sig_slide"
	    self.BoltShootOffset = Vector(0, 1, 0)
	end
	
	function att:detachFunc()
		self.ReticleInactivityPostFire = 0.2
		self.ADSFireAnim = false
		self.BoltBone = "null"
	    self.BoltShootOffset = Vector(0, 1, 0)
	end	
	
end
	
CustomizableWeaponry:registerAttachment(att)
