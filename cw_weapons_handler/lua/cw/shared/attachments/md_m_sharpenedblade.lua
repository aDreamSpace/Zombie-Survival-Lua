local att = {}
att.name = "md_m_sharpenedblade"
att.displayName = "Sharpened Blade"
att.displayNameShort = "Sharpened"

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/sharpened")
	att.description = {[1] = {t = "Careful sharpening increases overall attack power", c = CustomizableWeaponry.textColors.POSITIVE}}
	
end
att.price = 60
att.model = "models/items/battery.mdl"


function att:attachFunc()
	self.PrimaryAttackDamage_Orig = self.PrimaryAttackDamage_Orig or {self.PrimaryAttackDamage[1], self.PrimaryAttackDamage[2]}
	self.PrimaryAttackDamage[1] = math.Round(self.PrimaryAttackDamage_Orig[1] * 1.15)
	self.PrimaryAttackDamage[2] = math.Round(self.PrimaryAttackDamage_Orig[2] * 1.15)
end

function att:detachFunc()
	self.PrimaryAttackDamage = {self.PrimaryAttackDamage_Orig[1], self.PrimaryAttackDamage_Orig[2]}
end

CustomizableWeaponry:registerAttachment(att)
