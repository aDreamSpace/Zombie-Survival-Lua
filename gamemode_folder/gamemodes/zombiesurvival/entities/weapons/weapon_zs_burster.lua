AddCSLuaFile()

SWEP.PrintName = "Burster"

SWEP.Base = "weapon_zs_zombie"

SWEP.MeleeDamage = 46
SWEP.SlowDownScale = 2

SWEP.AlertDelay = 3.5

function SWEP:Reload()
	self:SecondaryAttack()
end

function SWEP:PlayAlertSound()
	self:GetOwner():EmitSound("npc/combine_gunship/gunship_moan.wav", 75, math.random(60,72))
end
SWEP.PlayIdleSound = SWEP.PlayAlertSound

function SWEP:PlayAttackSound()
	self:EmitSound("npc/antlion_guard/angry"..math.random(3)..".wav", 75, math.random(60,72))
end

if not CLIENT then return end

function SWEP:ViewModelDrawn()
	render.ModelMaterialOverride(0)
end

local matSheet = Material("models/zombie_fast/fast_zombie_sheet")
function SWEP:PreDrawViewModel(vm)
	render.ModelMaterialOverride(matSheet)
end
