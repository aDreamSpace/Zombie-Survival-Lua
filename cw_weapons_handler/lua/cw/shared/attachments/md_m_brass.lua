local att = {}
att.name = "md_m_brass"
att.displayName = "Brass Knuckles"
att.displayNameShort = "Brass"

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/grooved")
	att.description = {[1] = {t = "Brass knuckles increase fisting potential", c = CustomizableWeaponry.textColors.POSITIVE}}
	
end
att.price = 5
att.model = "models/items/battery.mdl"

function att:attachFunc()
	self.PrimaryAttackDamage_Orig = self.PrimaryAttackDamage_Orig or {self.PrimaryAttackDamage[1], self.PrimaryAttackDamage[2]}
	self.PrimaryAttackDamage[2] = math.Round(self.PrimaryAttackDamage_Orig[2] * 1.25)
end

function att:detachFunc()
	self.PrimaryAttackDamage = {self.PrimaryAttackDamage_Orig[1], self.PrimaryAttackDamage_Orig[2]}
end

CustomizableWeaponry:registerAttachment(att)
