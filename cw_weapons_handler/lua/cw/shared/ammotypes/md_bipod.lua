local att = {}
att.name = "md_bipod"
att.displayName = "Deployable Bipod"
att.displayNameShort = "Bipod"

att.statModifiers = {OverallMouseSensMult = -0.1,
DrawSpeedMult = -0.15}

if CLIENT then
	att.displayIcon = surface.GetTextureID("cw20_extras/icons/upgr_bipod")
	att.description = {[1] = {t = "When deployed:", c = CustomizableWeaponry.textColors.REGULAR},
	[2] = {t = "Decreases recoil by 70%", c = CustomizableWeaponry.textColors.POSITIVE},
	[3] = {t = "Decreases aim breathing movement", c = CustomizableWeaponry.textColors.POSITIVE},
	[4] = {t = "Greatly increases hip fire accuracy", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.BipodInstalled = true
end

function att:detachFunc()
	self.BipodInstalled = false
	self:restoreSound()
end

	
function att:elementRender()
	local bipod = self.AttachmentModelsVM.md_bipod.ent	
	if self.dt.BipodDeployed and self.DeployAngle then
	bipod:SetBodygroup(1,1)
	self.AimBreathingIntensity = 0.25
	else
	bipod:SetBodygroup(1,0)
	self.AimBreathingIntensity = 1
	end
end

CustomizableWeaponry:registerAttachment(att)