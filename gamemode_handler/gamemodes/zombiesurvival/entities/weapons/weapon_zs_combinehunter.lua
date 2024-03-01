AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Hunter"
end

SWEP.Base = "weapon_zs_zombie"

SWEP.MeleeDamage = 62
SWEP.SlowDownScale = 25
SWEP.MeleeForceScale = 8


function SWEP:Reload()
	self:SecondaryAttack()
end

function SWEP:PlayAlertSound()
	self.Owner:EmitSound("npc/barnacle/barnacle_tongue_pull"..math.random(3)..".wav")
end
SWEP.PlayIdleSound = SWEP.PlayAlertSound

function SWEP:PlayAttackSound()
	self.Owner:EmitSound("zsound/attack/nightmare/nightmare0"..math.random(1, 5)..".wav")
end

if not CLIENT then return end

function SWEP:ViewModelDrawn()
	render.ModelMaterialOverride(0)
end

local matSheet = Material("Models/Charple/Charple1_sheet")
function SWEP:PreDrawViewModel(vm)
	render.ModelMaterialOverride(matSheet)
end
