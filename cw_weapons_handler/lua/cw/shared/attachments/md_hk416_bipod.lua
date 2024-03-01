local att = {}
att.name = "md_hk416_bipod"
att.displayName = "Harris Bipod"
att.displayNameShort = "Bipod"

att.statModifiers = {
	OverallMouseSensMult = -0.1,
	DrawSpeedMult = -0.15
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("entities/md_hk416_bipod")
	att.description = {
		[1] = {t = "When deployed:", c = CustomizableWeaponry.textColors.REGULAR},
		[2] = {t = "Decreases recoil by 70%", c = CustomizableWeaponry.textColors.POSITIVE},
		[3] = {t = "Greatly increases hip fire accuracy", c = CustomizableWeaponry.textColors.POSITIVE}
	}
end

function att:attachFunc()
	self.BipodInstalled = true
	self.BipodWasDeployed = false
	
	-- if self.WElements and self.WElements["md_hk416_bipod"] then
		-- local bipodWE = self.WElements["md_hk416_bipod"]
		-- self.md_hk416_bipod_WMEnt = ClientsideModel(bipodWE.model, RENDERGROUP_BOTH)
	-- end
end

function att:detachFunc()
	self.BipodInstalled = false
	
	-- if self.md_hk416_bipod_WMEnt then // destructor
	-- end
end

function att:elementRender()
	local is = self.dt.BipodDeployed	
	local was = self.BipodWasDeployed
	
	if is != was then
		if is then
			self.AttachmentModelsVM.md_hk416_bipod.ent:SetBodygroup(1,1)
			self:EmitSound("CW_HarrisBipod_KK_Down")
		else
			self.AttachmentModelsVM.md_hk416_bipod.ent:SetBodygroup(1,0)
			self:EmitSound("CW_HarrisBipod_KK_Up")
		end	
	end
	
	self.BipodWasDeployed = is
end

CustomizableWeaponry:registerAttachment(att)

CustomizableWeaponry:addReloadSound("CW_HarrisBipod_KK_Down", {
	"weapons/cw_2_fas2_kk/harrisbipod_down1.wav",
	"weapons/cw_2_fas2_kk/harrisbipod_down2.wav",
})
CustomizableWeaponry:addReloadSound("CW_HarrisBipod_KK_Up", {
	"weapons/cw_2_fas2_kk/harrisbipod_up1.wav",
	"weapons/cw_2_fas2_kk/harrisbipod_up2.wav",
})