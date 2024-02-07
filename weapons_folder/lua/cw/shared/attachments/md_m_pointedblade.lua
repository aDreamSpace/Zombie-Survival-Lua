local att = {}
att.name = "md_m_pointedblade"
att.displayName = "Pointed Blade"
att.displayNameShort = "Pointed"

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("zombiesurvival/cwicons/pointed")
	att.description = {[1] = {t = "Pointed blade raises stab damage", c = CustomizableWeaponry.textColors.POSITIVE}}
	
end
att.price = 32
att.model = "models/items/battery.mdl"

function att:attachFunc()
	self.SecondaryAttackDamage_Orig = self.SecondaryAttackDamage_Orig or {self.SecondaryAttackDamage[1], self.SecondaryAttackDamage[2]}
	self.SecondaryAttackDamage[1] = math.Round(self.SecondaryAttackDamage_Orig[1] * 1.25)
	self.SecondaryAttackDamage[2] = math.Round(self.SecondaryAttackDamage_Orig[2] * 1.25)
end

function att:detachFunc()
	self.SecondaryAttackDamage = {self.SecondaryAttackDamage_Orig[1], self.SecondaryAttackDamage_Orig[2]}
end

CustomizableWeaponry:registerAttachment(att)
