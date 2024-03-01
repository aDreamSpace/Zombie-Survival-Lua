AddCSLuaFile()

------------------ 20 ROUND MAG

local att = {}
att.name = "bg_asval_20rnd"
att.displayName = "20 round mag"
att.displayNameShort = "20RND"
att.isBG = true
att.price = 15

att.statModifiers = {ReloadSpeedMult = -0.05,
MagMult = 1,
OverallMouseSensMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/asval_20rndmag")
	att.description = {[1] = {t = "Increases mag size to 20 rounds.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.round20)
	self:unloadWeapon()
end

function att:detachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.regular)
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end

CustomizableWeaponry:registerAttachment(att)

------------------ 30 ROUND MAG

local att = {}
att.name = "bg_asval_30rnd"
att.displayName = "30 round mag"
att.displayNameShort = "30RND"
att.isBG = true
att.price = 24

att.statModifiers = {ReloadSpeedMult = -0.1,
MagMult = 2,
OverallMouseSensMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/asval_30rndmag")
	att.description = {[1] = {t = "Increases mag size to 30 rounds.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.round30)
	self:unloadWeapon()

end

function att:detachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.regular)
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
	
end

CustomizableWeaponry:registerAttachment(att)

------------------ AS VAL VARIANT

local att = {}
att.name = "bg_asval"
att.displayName = "AS VAL variant"
att.displayNameShort = "AS VAL"
att.isBG = true

att.statModifiers = {FireDelayMult = -0.3333333333333}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/asval_variant")
end

function att:detachFunc()
	self:setBodygroup(self.VariantBGs.main, self.VariantBGs.vss)
end

CustomizableWeaponry:registerAttachment(att)

------------------ SR-3M VARIANT

local att = {}
att.name = "bg_sr3m"
att.displayName = "SR-3M variant"
att.displayNameShort = "SR-3M"
att.isBG = true
att.overrideSuppressorStatus = false -- it will override the weapon's default suppressor status to FALSE
att.SpeedDec = -3

att.statModifiers = {
RecoilMult = -0.1,
DamageMult = -0.45, --prev .55
AimSpreadMult = 0.6,
FireDelayMult = -0.3333333}--previously .222222222

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/sr3m_variant")
	att.description = {[1] = {t = "Changes ammo type to SMG\nMust be switched to 'automatic' (E+R)", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.VariantBGs.main, self.VariantBGs.sr3m)
	self:updateSoundTo("CW_SR3M_FIRE", CustomizableWeaponry.sounds.UNSUPPRESSED)
	self:updateSoundTo("CW_SR3M_FIRE_SUPPRESSED", CustomizableWeaponry.sounds.SUPPRESSED)
	self:setupCurrentIronsights(self.SR3MPos, self.SR3MAng)
	self.dt.Suppressed = false
	self.SuppressedOnEquip = false
	self:unloadWeapon()
	self.Primary.Ammo = "smg1"
	self.Primary.Ammo_orig = "gravity"
	self.FireModes = {"auto", "semi","safe"}
	self.FireModes_orig = {"semi"}
	self.Primary.Automatic		= true
	self.FireDelay = 0.000000000000000001
	self.FireDelay_orig = 0.3
	self.Damage = 48
	self.Damage_orig = 115

	if not self:isAttachmentActive("sights") then
		self:updateIronsights("SR3M")
	end
end

function att:detachFunc()
	self:setBodygroup(self.VariantBGs.main, self.VariantBGs.vss)
	self:restoreSound()
	self:revertToOriginalIronsights()
	self.dt.Suppressed = true
	self.SuppressedOnEquip = true
	self:unloadWeapon()
	self.Primary.Ammo = self.Primary.Ammo_orig
	self.Primary.Ammo_orig = self.Primary.Ammo_orig
	self.FireModes = self.FireModes_orig
	self.FireModes_orig = self.FireModes_orig
	self.Primary.Automatic		= false
	self.FireDelay = self.FireDelay_orig
	self.FireDelay_orig = self.FireDelay_orig
	self.Damage = self.FireDelay_orig
	self.Damage_orig = self.FireDelay_orig
end
att.price = 200


CustomizableWeaponry:registerAttachment(att)

------------------ FOLDABLE STOCK

local att = {}
att.name = "bg_vss_foldable_stock"
att.displayName = "Foldable stock"
att.displayNameShort = "Fold"
att.isBG = true
att.SpeedDec = -3

att.statModifiers = {DrawSpeedMult = 0.2,
OverallMouseSensMult = 0.15,
RecoilMult = 0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/asval_foldable_stock")
end

function att:attachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.foldable)
end

function att:detachFunc()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.vss)
end

CustomizableWeaponry:registerAttachment(att)
