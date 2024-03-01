SWEP.Base = "weapon_zs_zombie"

SWEP.MeleeDamage = 49

function SWEP:Reload()
	self.BaseClass.SecondaryAttack(self)
end

function SWEP:StartMoaning()
end

function SWEP:StopMoaning()
end

function SWEP:IsMoaning()
	return false
end

