local att = {}
att.name = "md_m_refinedblade"
att.displayName = "Refined Blade"
att.displayNameShort = "Refined"

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/refined")
	att.description = {[1] = {t = "Reforged blade raises potential damage", c = CustomizableWeaponry.textColors.POSITIVE}}
	
end
att.price = 80
att.model = "models/items/battery.mdl"


function att:attachFunc()
	self.PrimaryAttackDamage_Orig = self.PrimaryAttackDamage_Orig or {self.PrimaryAttackDamage[1], self.PrimaryAttackDamage[2]}
	self.PrimaryAttackDamage[2] = math.Round(self.PrimaryAttackDamage_Orig[2] * 1.5)
end

function att:detachFunc()
	self.PrimaryAttackDamage = {self.PrimaryAttackDamage_Orig[1], self.PrimaryAttackDamage_Orig[2]}
end

CustomizableWeaponry:registerAttachment(att)
