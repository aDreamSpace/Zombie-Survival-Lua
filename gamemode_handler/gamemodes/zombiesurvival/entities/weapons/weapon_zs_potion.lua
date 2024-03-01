AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Potiontest"

	SWEP.ViewModelFOV = 66

	SWEP.VElements = {
		["potiontest"] = { type = "Model", model = "models/sohald_spike/props/potion_3.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.5, 2, 3), angle = Angle(0, 0, 146.104), size = Vector(1.35, 1.35, 1.35), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} }
	}


	SWEP.WElements = {
		["potiontest"] = { type = "Model", model = "models/sohald_spike/props/potion_3.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.25, 2.5, 2.2), angle = Angle(0, 0, -180), size = Vector(1.2, 1.2, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {[1] = 1} }
	}

end

--enums
local POTION_MAXHP = 0
local POTION_HP = 1
local POTION_POINTS = 2
local POTION_SPEED = 3
local POTION_MELEE = 4
local POTION_AMMO = 5

local tPotionInfo = {}
tPotionInfo[POTION_MAXHP] = Color(255, 100, 100)
tPotionInfo[POTION_HP] = Color(255, 0, 0)
tPotionInfo[POTION_POINTS] = Color(255, 255, 255)
tPotionInfo[POTION_SPEED] = Color(100, 100, 255)
tPotionInfo[POTION_MELEE] = Color(100, 255, 100)
tPotionInfo[POTION_AMMO] = Color(0, 0, 255)


SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/v_bugbait.mdl"
SWEP.WorldModel = "models/weapons/w_bugbait.mdl"
SWEP.UseHands = false

SWEP.HoldType = "knife"
SWEP.AmmoIfHas = true

SWEP.Primary.ClipSize = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "stone"
SWEP.Primary.Delay = 1
SWEP.Primary.DefaultClip = 1

SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "dummy"

SWEP.WalkSpeed = SPEED_FAST

function SWEP:Initialize()
	self:SetWeaponHoldType("knife")
	self:SetDeploySpeed(1.1)
	if SERVER then
		local t = math.random(0, 5)
		self.PotionType = t
		self:SetPotionType(t)

		self:SetColor(tPotionInfo[self.PotionType])
	end

	if CLIENT then
		self:Anim_Initialize()
	end
end

function SWEP:SetupDataTables()
	self:NetworkVar("Int", 0, "PotionType")
end

function SWEP:CanPrimaryAttack()
	if self.Owner:IsHolding() or self.Owner:GetBarricadeGhosting() then return false end

	if self:GetPrimaryAmmoCount() <= 0 then
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		return false
	end

	return true
end

local tRandAmmo = {
	"smg1",
	"pistol",
	"ar2",
	"357",
	"alyxgun",
	"gravity",
	"buckshot",
}

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	local owner = self.Owner
	self:SendWeaponAnim(ACT_VM_THROW)
	owner:DoAttackEvent()

	self:TakePrimaryAmmo(1)
	self.NextDeploy = CurTime() + 0.75

	if SERVER then
		--bad coding practices below, but its just a fast solution for a 1 week event so it is fine
		local type = self.PotionType
		if type == POTION_MAXHP then
			owner:SetMaxHealth(owner:GetMaxHealth() + 5)
			owner:CenterNotify(COLOR_GREEN, "You got your max HP raised by 5!")
		elseif type == POTION_HP then
			owner:SetHealth(math.min(owner:Health() + 25, owner:GetMaxHealth()))
			owner:CenterNotify(COLOR_GREEN, "You got 25 health!")
		elseif type == POTION_POINTS then
			owner:AddPoints(10)
			owner:CenterNotify(COLOR_GREEN, "You got 10 points!")
		elseif type == POTION_MELEE then
			pl.BuffMuscular = true
			owner:SendLua("MySelf.BuffMuscular = true")
			owner:CenterNotify(COLOR_GREEN, "You got muscular!")
		elseif type == POTION_SPEED then
			pl.HumanSpeedAdder = (pl.HumanSpeedAdder or 0) + 5
			owner:SendLua("MySelf.HumanSpeedAdder = (MySelf.HumanSpeedAdder or 0) + 5")
			owner:CenterNotify(COLOR_GREEN, "You got 5 extra speed!")
		elseif type == POTION_AMMO then
			local ammo = tRandAmmo[math.random(#tRandAmmo)]
			owner:GiveAmmo(40, ammo, true)
			owner:CenterNotify(COLOR_GREEN, "You got 40 of ammotype "..ammo.."!")
		end
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:CanSecondaryAttack()
	return false
end

function SWEP:Reload()
	return false
end

function SWEP:Deploy()
	GAMEMODE:WeaponDeployed(self.Owner, self)

	if self:GetPrimaryAmmoCount() <= 0 then
		self:SendWeaponAnim(ACT_VM_THROW)
	end

	return true
end

function SWEP:Holster()
	self.NextDeploy = nil

	if CLIENT then
		self:Anim_Holster()
	end

	return true
end

function SWEP:Think()
	if self.NextDeploy and self.NextDeploy <= CurTime() then
		self.NextDeploy = nil

		if 0 < self:GetPrimaryAmmoCount() then
			self:SendWeaponAnim(ACT_VM_DRAW)
		else
			self:SendWeaponAnim(ACT_VM_THROW)
			if SERVER then
				self:Remove()
			end
		end
	end

	local col = tPotionInfo[self:GetPotionType()]
	if col then
		self.VElements.potiontest.color = col
	end
end
