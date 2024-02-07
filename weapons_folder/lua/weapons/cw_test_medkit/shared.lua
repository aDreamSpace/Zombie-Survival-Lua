AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Medical Kit"
	SWEP.Description = "An advanced kit of medicine, bandages, and morphine.\nVery useful for keeping a group of survivors healthy.\nUse PRIMARY FIRE to heal other players.\nUse SECONDARY FIRE to heal yourself.\nHealing other players is not only faster but you get a nice point bonus!"

	SWEP.ViewModelMovementScale = 0.75
	
	SWEP.DrawTraditionalWorldModel = true
	
	local wid, hei = 256, 16
	local x, y = ScrW() - wid - 32, ScrH() - hei - 72
	local texGradDown = surface.GetTextureID("VGUI/gradient_down")
	--TODO: Rewrite this with a fancy 3d2d hud style like in CW 2.0
	function SWEP:DrawHUD()
		local screenscale = screenscale or BetterScreenScale()

		local texty = texty or y - 4 - draw.GetFontHeight("ZSHUDFontSmall")

		local timeleft = self:GetNextCharge() - CurTime()
		if 0 < timeleft then
			surface.SetDrawColor(5, 5, 5, 180)
			surface.DrawRect(x, y, wid, hei)

			surface.SetDrawColor(255, 0, 0, 180)
			surface.SetTexture(texGradDown)
			surface.DrawTexturedRect(x, y, math.min(1, timeleft / math.max(self.Primary.Delay, self.Secondary.Delay)) * wid, hei)

			surface.SetDrawColor(255, 0, 0, 180)
			surface.DrawOutlinedRect(x, y, wid, hei)
		end

		draw.SimpleText("Medical Kit", "ZSHUDFontSmall", x, texty, COLOR_GREEN, TEXT_ALIGN_LEFT)

		local charges = self:GetPrimaryAmmoCount()
		if charges > 0 then
			draw.SimpleText(charges, "ZSHUDFontSmall", x + wid, texty, COLOR_GREEN, TEXT_ALIGN_RIGHT)
		else
			draw.SimpleText(charges, "ZSHUDFontSmall", x + wid, texty, COLOR_DARKRED, TEXT_ALIGN_RIGHT)
		end
	end
end

SWEP.CW20Melee = true
SWEP.UseHands = true

SWEP.Attachments = {

}

SWEP.Animations = {

}
	
SWEP.Sounds = {

}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "slam"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/c_medkit.mdl"
SWEP.WorldModel		= "models/weapons/w_medkit.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "battery"
SWEP.Primary.Delay = 1
SWEP.Primary.DefaultClip = 150

SWEP.FireDelay = 0.1

SWEP.Damage = 36
SWEP.DeployTime = 0.6

function SWEP:IndividualInitialize()

	SWEP.Primary.ClipSize = -1
	SWEP.Primary.Automatic = true
	SWEP.Primary.Ammo = "battery"
	SWEP.Primary.Delay = 1
	SWEP.Primary.DefaultClip = 150

end

function SWEP:CanPrimaryAttack()


	return self.BaseClass.CanPrimaryAttack(self)
end


function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	local owner = self.Owner

	owner:LagCompensation(true)
	local ent = owner:MeleeTrace(32, 2).Entity
	owner:LagCompensation(false)

	if ent and ent:IsValid() and ent:IsPlayer() and ent:Team() == owner:Team() and ent:Alive() and gamemode.Call("PlayerCanBeHealed", ent) then
		local health, maxhealth = ent:Health(), ent:GetMaxHealth()
		local multiplier = owner.HumanHealMultiplier or 1
		local toheal = math.min(self:GetPrimaryAmmoCount(), math.ceil(math.min(self.Primary.Heal * multiplier, maxhealth - health)))
		local totake = math.ceil(toheal / multiplier)
		if toheal > 0 then
			self:SetNextCharge(CurTime() + self.Primary.Delay * math.min(1, toheal / self.Primary.Heal))
			owner.NextMedKitUse = self:GetNextCharge()

			self:TakePrimaryAmmo(totake)

			ent:SetHealth(health + toheal)
			self:EmitSound("items/medshot4.wav")

			self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

			owner:DoAttackEvent()
			self.IdleAnimation = CurTime() + self:SequenceDuration()

			gamemode.Call("PlayerHealedTeamMember", owner, ent, toheal, self)
		end
	end
end

function SWEP:SecondaryAttack()
	local owner = self.Owner
	if not self:CanPrimaryAttack() or not gamemode.Call("PlayerCanBeHealed", owner) then return end

	local health, maxhealth = owner:Health(), owner:GetMaxHealth()
	local multiplier = owner.HumanHealMultiplier or 1
	local toheal = math.min(self:GetPrimaryAmmoCount(), math.ceil(math.min(self.Secondary.Heal * multiplier, maxhealth - health)))
	local totake = math.ceil(toheal / multiplier)
	if toheal > 0 then
		self:SetNextCharge(CurTime() + self.Secondary.Delay * math.min(1, toheal / self.Secondary.Heal))
		owner.NextMedKitUse = self:GetNextCharge()

		self:TakeCombinedPrimaryAmmo(totake)

		owner:SetHealth(health + toheal)
		self:EmitSound("items/smallmedkit1.wav")

		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

		owner:DoAttackEvent()
		self.IdleAnimation = CurTime() + self:SequenceDuration()
	end
end


function SWEP:Deploy()
	if CLIENT then
		hook.Add("PostPlayerDraw", "PostPlayerDrawMedical", GAMEMODE.PostPlayerDrawMedical)
		GAMEMODE.MedicalAura = true
	end

	return self.BaseClass.Deploy(self)
end

function SWEP:Holster()
	if CLIENT then
		hook.Remove("PostPlayerDraw", "PostPlayerDrawMedical")
		GAMEMODE.MedicalAura = false
	end

	return self.BaseClass.Holster(self)
end

function SWEP:OnRemove()
	if CLIENT and self.Owner == MySelf then
		hook.Remove("PostPlayerDraw", "PostPlayerDrawMedical")
		GAMEMODE.MedicalAura = false
	end
	
	return self.BaseClass.OnRemove(self)
end

function SWEP:Reload()
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 11, "NextCharge")

	return self.BaseClass.SetupDataTables(self)
end

