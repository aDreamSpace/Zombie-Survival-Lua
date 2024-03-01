local att = {}
att.name = "md_myfuckingbipod3"
att.displayName = "PPSh-41 Bipod"
att.displayNameShort = "PPs Bipod"

att.statModifiers = {
	OverallMouseSensMult = -0.1,
	DrawSpeedMult = -0.15
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bipod")
	att.description = {
		[1] = {t = "When deployed:", c = CustomizableWeaponry.textColors.REGULAR},
		[2] = {t = "Decreases recoil by 70%", c = CustomizableWeaponry.textColors.POSITIVE},
		[3] = {t = "Greatly increases hip fire accuracy", c = CustomizableWeaponry.textColors.POSITIVE},
		[4] = {t = "Aids in killing nazis", c = CustomizableWeaponry.textColors.POSITIVE},
		[5] = {t = "Real snipers don't need bipods", c = CustomizableWeaponry.textColors.NEGATIVE}
	}
end

function att:attachFunc()
	self.BipodInstalled = true
	self.BipodWasDeployed = false
end

function att:detachFunc()
	self.BipodInstalled = false
	
	self:restoreSound()
end

	
function att:elementRender()
	local yes = self.dt.BipodDeployed	
	local no = self.BipodWasDeployed
	local bipod = self.AttachmentModelsVM.md_myfuckingbipod3.ent	
	
	if yes != no then
	
		if yes then
		
			bipod:SetBodygroup(1,1)
			
		else
		
			bipod:SetBodygroup(1,0)
			
		end	
		
	end
	
	self.BipodWasDeployed = yes
	
end

CustomizableWeaponry:registerAttachment(att)

/*
If you think of using this attachment without asking 

________________$$$$$
 ______________$$____$$
 ______________$$____$$
 ______________$$____$$
 ______________$$____$$
 ______________$$____$$
 __________$$$$$$____$$$$$$
 ________$$____$$____$$____$$$$
 ________$$____$$____$$____$$__$$
 $$$$$$__$$____$$____$$____$$____$$
 $$____$$$$________________$$____$$
 $$______$$______________________$$
 __$$____$$______________________$$
 ___$$$__$$______________________$$
 ____$$__________________________$$
 _____$$$________________________$$
 ______$$______________________$$$
 _______$$$____________________$$
 ________$$____________________$$
 _________$$$________________$$$
 __________$$________________$$
 __________$$$$$$$$$$$$$$$$$$$$

*/