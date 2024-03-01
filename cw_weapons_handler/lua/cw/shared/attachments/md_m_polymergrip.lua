local att = {}
att.name = "md_m_polymergrip"
att.displayName = "Polymer Grip"
att.displayNameShort = "Polymer"

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/poly")
	att.description = {[1] = {t = "Comfy polymer grip increases attack speed", c = CustomizableWeaponry.textColors.POSITIVE}}
	
end
att.price = 16
att.model = "models/items/battery.mdl"


function att:attachFunc()
	self.PrimaryAttackDelay_Orig = self.PrimaryAttackDelay_Orig or self.PrimaryAttackDelay
	self.PrimaryAttackDelay = self.PrimaryAttackDelay_Orig * 0.6
end

function att:detachFunc()
	self.PrimaryAttackDelay = self.PrimaryAttackDelay_Orig
end

CustomizableWeaponry:registerAttachment(att)
