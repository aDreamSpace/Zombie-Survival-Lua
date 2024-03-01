AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "APS"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	SWEP.LuaVMRecoilAxisMod = {vert = 0.05, hor = 0.3, roll = 0.2, forward = 0.1, pitch = 0.5}
	killicon.AddFont("cw_ak74", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.6
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 1, y = -3, z = 4}
	
	SWEP.BoltBone = "bone_bolt"
	
	SWEP.BoltShootOffset =  Vector(0, -6, 0)
	SWEP.ReloadBoltBonePositionMoveSpeed = 100
	SWEP.HoldBoltWhileEmpty = true
	SWEP.OffsetBoltDuringNonEmptyReload = false
	SWEP.DontHoldWhenReloading = true

	--[[if wep:Clip1() <= 1  then 
		
			else 
	
		SWEP.BoltShootOffset =  Vector(0, 6, 0)
		SWEP.ReloadBoltBonePositionMoveSpeed = -1000000000000
	end ]]
	
	
	
	
	
	SWEP.ACOGPos = Vector(-3.54, -6.035, -0.19)
	SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.M203OffsetCycle_Reload = 0.74
	SWEP.M203OffsetCycle_Reload_Empty = 0.8
	SWEP.M203OffsetCycle_Draw = 0.4
	
	SWEP.M203ArmBone = 9 
	SWEP.M203Pos = Vector(0, 0, 0)
	SWEP.M203Ang = Vector(0, 0, 0)
	
	SWEP.BaseArm = "Bip001 L UpperArm"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.IronsightPos = Vector(-3, -7.84, 0.2)
	SWEP.IronsightAng = Vector(0, 0, 0) 
	
	SWEP.AimpointPos = Vector(-3, -5, -0.361)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.279, -6.736, 0.36)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-3, -5, -0.181)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ShortDotPos = Vector(-3.54, -7.443, 0.04) 
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.PSOPos = Vector(-2.75, -3, 0.3)
	SWEP.PSOAng = Vector(0, 0, 0)
	
	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	 
	SWEP.CustomizePos = Vector(10.05, -2.412, -3.016)
	SWEP.CustomizeAng = Vector(27.437, 37.285, 19.697)

	SWEP.SprintPos = Vector(1.004, -0.403, -4.624)
	SWEP.SprintAng = Vector(-3.518, 48.542, -27.438)	
	
	SWEP.BarskaRDPos = Vector(-3.55, -4.639, 0.5)
	SWEP.BarskaRDAng = Vector(-2.3, 0, 0)
	
	SWEP.KR_CMOREPos =  Vector(-3.56, -6.252, 0.12) 
	SWEP.KR_CMOREAng =  Vector(-0.704, 0, 0)

	
	SWEP.ZFSG1Pos = Vector(-3.56, -4.643, -0.75)
	SWEP.ZFSG1Ang = Vector(0, 0, 0)

	SWEP.PSO1AxisAlign = {right = 0, up = 0.4, forward = 90}

	SWEP.AttachmentModelsVM = {
	["md_pso1"] = { type = "Model", model = "models/cw2/attachments/pso.mdl", bone = "bone_main", rel = "", pos = Vector(1, 1, -0.16), angle = Angle(90, -90, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rail"] = { type = "Model", model = "models/wystan/attachments/akrailmount.mdl", bone = "bone_main", rel = "", pos = Vector(5.199, -0.7, 0.172), angle = Angle(-90, 90, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_aimpoint"]	= { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "bone_main", rel = "", pos = Vector(0.2, 1.87, 0.17), angle = Angle(-90, 90, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_microt1"]	= { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "bone_main", rel = "", pos = Vector(4, -2.181, -0.01), angle = Angle(90, 0, -90), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

	}
	
	
	
	SWEP.ForeGripHoldPos = {
	
}

		SWEP.M203HoldPos = {
	
		}

	SWEP.ForegripOverridePos = {
		
					
	}	
	
	
	
	
	SWEP.LaserPosAdjust = Vector(0, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 0, 0) 
	SWEP.SightWithRail = true 
	SWEP.CustomizationMenuScale = 0.015 
	
function SWEP:RenderTargetFunc()


	if self.AimPos != self.IronsightPos then -- if we have a sight/scope equiped, hide the front and rar sights
			self:setBodygroup(self.SightBGs.main, self.SightBGs.none)
		else
			self:setBodygroup(self.SightBGs.main, self.SightBGs.irons)
	end
end
end


SWEP.LuaViewmodelRecoil = true
SWEP.FullAimViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.MuzzleVelocity = 340 -- in meter/s


SWEP.SightBGs = {main = 2,  irons = 0, none = 1}
SWEP.StockBGs = {main = 3,  none = 0, stock = 1}

SWEP.Attachments = {[1] = {header = "Sight", offset = {200, 0}, atts = {"md_microt1", "md_aimpoint", "md_pso1"}},
[2] = {header = "Stock", offset = {200, 400}, atts = {"bg_apsstock"}},
["+reload"] = {header = "Ammo", offset = {1000, 0}, atts = {"am_magnum", "am_matchgrade"}}}
	
SWEP.Animations = {fire = {"fire1","fire2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"
}
	--[[mag release - 20 frame
		magout - 30
		magin - 90
		magtap - 118
		boltpull - 160-164
		]]
SWEP.Sounds = {
	draw = {[1] = {time = 0.2, sound = "CW_FOLEY_LIGHT"}},
	
	
	
	reload = {[1] = {time = 0.8, sound = "CW_APS_MAGREL"},
	[2] = {time = 1, sound = "CW_APS_MAGOUT"},
	[3] = {time = 3.25, sound = "CW_APS_MAGIN"},
	[4] = {time = 3.8, sound = "CW_APS_MAGTAP"},
	[5] = {time = 4.25, sound = "CW_FOLEY_LIGHT"}, 
	[6] = {time = 5, sound = "CW_APS_BOLTPULL"}}, 
		
		
}

SWEP.SpeedDec = 25

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "shotgun"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 Korangedragon"

SWEP.Author			= "Who cares"
SWEP.Contact		= ""
SWEP.Purpose		= "Bullet"
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.AimViewModelFOV = 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/weapons/aps/v_aps.mdl"
SWEP.WorldModel		= "models/weapons/w_rif_ak47.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 26
SWEP.Primary.DefaultClip	= 52
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ar2"
SWEP.BulletDiameter         = 5.66
SWEP.CaseLength 			= 6
SWEP.Chamberable 			= false

SWEP.FireDelay = 60 / 600
SWEP.FireSound = "CW_APS_FIRE"

SWEP.Recoil = 1.04

SWEP.HipSpread = 0.041
SWEP.AimSpread = 0.0035
SWEP.VelocitySensitivity = 1.7
SWEP.MaxSpreadInc = 0.037
SWEP.SpreadPerShot = 0.009
SWEP.SpreadCooldown = 0.09
SWEP.Shots = 1
SWEP.Damage = 40
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 4.25
SWEP.ReloadTime_Empty = 6.6
SWEP.ReloadHalt = 4.25
SWEP.ReloadHalt_Empty = 7
SWEP.SnapToIdlePostReload = true
SWEP.HolsterUnderwater = false

