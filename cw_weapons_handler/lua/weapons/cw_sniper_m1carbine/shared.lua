AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "pistolMag"
	
	CustomizableWeaponry:registerAmmo(".30 Carbine", ".30 Caliber Rounds", 7.62, 33)

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M1 Carbine"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "w"
	killicon.Add( "khr_m1carbine", "icons/killicons/khr_m1carbine", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_m1carbine")
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = true
	SWEP.ShellScale = 0.3
	SWEP.FireMoveMod = 1
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 1, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.SightWithRail = true
	SWEP.DisableSprintViewSimulation = false
	SWEP.SnapToIdlePostReload = true
	
	SWEP.EffectiveRange_Orig = 136.8 * 39.37
	SWEP.DamageFallOff_Orig = .34
						
	SWEP.BoltBone = "Bolt"
	SWEP.BoltBonePositionRecoverySpeed = 40
	SWEP.BoltShootOffset = Vector(0, 2, 0)
	
	SWEP.IronsightPos = Vector(-3.108, -3, 0.98)
	SWEP.IronsightAng = Vector(0.92, 0.03, 0)
	
	SWEP.EoTech553Pos = Vector(-3.108, -4.5, .15)
	SWEP.EoTech553Ang = Vector(.92, 0, 0)	
	
	SWEP.CSGOACOGPos = Vector(0, 0, 0)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(0, 0, 0)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.KR_CMOREPos =  Vector(-3.0885, -4.5, .159)
	SWEP.KR_CMOREAng =  Vector(.92, 0, 0)
	
	SWEP.ShortDotPos = Vector(-3.0885, -5.5, .159)
	SWEP.ShortDotAng = Vector(.92, 0, 0)
	
	SWEP.FAS2AimpointPos = Vector(-3.05, -5, .585)
	SWEP.FAS2AimpointAng = Vector(-.5, 0, 0)
	
	SWEP.SprintPos = Vector(0.079, 0, -1.68)
	SWEP.SprintAng = Vector(-20.403, 30.25, -26.031)
	
	SWEP.CustomizePos = Vector(2.839, -1.407, -0.561)
	SWEP.CustomizeAng = Vector(12.663, 22.513, 14.774)
	
	SWEP.AlternativePos = Vector(-1, -1.6667, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.023
	SWEP.ViewModelMovementScale = 1
	
	SWEP.AttachmentModelsVM = {
	["md_saker222"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "receiver", rel = "", pos = Vector(0, 6.752, -1.15), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_foregrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "receiver", rel = "", pos = Vector(-0.24, -3.636, -2.201), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rail"] = { type = "Model", model = "models/wystan/attachments/rail.mdl", bone = "receiver", rel = "", pos = Vector(0.28, 3, 0.15), angle = Angle(0, 90, 0), size = Vector(0.5, 1, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "receiver", rel = "", pos = Vector(0.039, 5, 0.689), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint.mdl", bone = "receiver", rel = "", pos = Vector(0.1, 4.5, 0.55), angle = Angle(0, -90, 0), size = Vector(0.819, 0.819, 0.819), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "receiver", rel = "", pos = Vector(-0.171, -1, -2.61), angle = Angle(0, -90, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["odec3d_cmore_kry"] = { type = "Model", model = "models/weapons/krycek/sights/odec3d_cmore_reddot.mdl", bone = "receiver", rel = "", pos = Vector(0, 2.7, 1.149), angle = Angle(0, -90, 0), size = Vector(0.219, 0.219, 0.219), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.ForeGripHoldPos = {
	["l_wrist"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(12.222, -3.333, -10) },
	["l_upperarm"] = { scale = Vector(1, 1, 1), pos = Vector(0.185, -0.186, 0.185), angle = Angle(0, 0, 0) },
	["l_index_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 16.666) },
	["l_armtwist_1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(3.332, 0, 0) },
	["l_forearm"] = { scale = Vector(1, 1, 1), pos = Vector(-0.186, 0.185, -1.297), angle = Angle(63.333, 0, 7.777) }}
	
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}

	
end

SWEP.MuzzleVelocity = 700 -- in meter/s
SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = true


SWEP.Attachments = {[1] = {header = "Sight", offset = {400, -150},  atts = {"odec3d_cmore_kry", "md_fas2_eotech", "md_fas2_aimpoint"}},
	[2] = {header = "Conversion", offset = {1000, -200},  atts = {"md_m2carbine"}},
	[3] = {header = "Barrel", offset = {-380, -200}, atts = {"md_saker222"}},
	[4] = {header = "Magazine Upgrade", offset = {-200, -250}, atts = {"a_zsmagssniper1", "a_zsmagssniper2", "a_zsmagssniper3"}},
	[5] = {header = "Perks", offset = {400, 300}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
	
	["+reload"] = {header = "Ammo", offset = {-600, 100}, atts = {"am_magnum2", "am_matchgrade2", "am_heavyhandload2", "am_grapeshot2", "am_rifdepleteduranium2", "am_ricochet2"}}}

SWEP.Animations = {fire = {"shoot1","shoot2","shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw2"}
	
SWEP.Sounds = {	draw2 = {{time = 0, sound = "KSKS.Deploy"}},

	reload = {[1] = {time = .5, sound = "M1C.CLIPOUT"},
	[2] = {time = 2.15, sound = "KRISS_Magin"},
	[3] = {time = 2.55, sound = "KRISS_Maghit"},
	[4] = {time = 3.5, sound = "M1C.BOLT"}}}

SWEP.HoldBoltWhileEmpty = false
SWEP.DontHoldWhenReloading = true
SWEP.LuaVMRecoilAxisMod = {vert = 1.25, hor = .5, roll = .25, forward = .5, pitch = 1.5}

SWEP.SpeedDec = 30

SWEP.OverallMouseSens = .9
SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Khris"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.AimViewModelFOV = 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khri_m1car.mdl"
SWEP.WorldModel		= "models/khrcw2/w_khri_m1car.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 15
SWEP.Primary.DefaultClip	= 15
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Gravity"

SWEP.FireDelay = 60/600
SWEP.FireSound = "M1C.Fire"
SWEP.FireSoundSuppressed = "M1C.SupFire"
SWEP.Recoil = 2.25

SWEP.HipSpread = 0.040
SWEP.AimSpread = 0.0046
SWEP.VelocitySensitivity = .6
SWEP.MaxSpreadInc = 0.0135
SWEP.SpreadPerShot = 0.002
SWEP.SpreadCooldown = 60/400
SWEP.Shots = 1
SWEP.Damage = 75
SWEP.DeployTime = 0.6
SWEP.RecoilToSpread = 0

SWEP.ReloadSpeed = 1.2
SWEP.ReloadTime = 3
SWEP.ReloadTime_Empty = 4.4
SWEP.ReloadHalt = 3
SWEP.ReloadHalt_Empty = 4.4
SWEP.SnapToIdlePostReload = true


SWEP.Offset = {
Pos = {
Up = 2,
Right = 1,
Forward = -3,
},
Ang = {
Up = 1,
Right = -10,
Forward = 180,
}
}

function SWEP:DrawWorldModel( )
        local hand, offset, rotate

        local pl = self:GetOwner()

        if IsValid( pl ) then
                        local boneIndex = pl:LookupBone( "ValveBiped.Bip01_R_Hand" )
                        if boneIndex then
                                local pos, ang = pl:GetBonePosition( boneIndex )
                                pos = pos + ang:Forward() * self.Offset.Pos.Forward + ang:Right() * self.Offset.Pos.Right + ang:Up() * self.Offset.Pos.Up

                                ang:RotateAroundAxis( ang:Up(), self.Offset.Ang.Up)
                                ang:RotateAroundAxis( ang:Right(), self.Offset.Ang.Right )
                                ang:RotateAroundAxis( ang:Forward(),  self.Offset.Ang.Forward )

                                self:SetRenderOrigin( pos )
                                self:SetRenderAngles( ang )
                                self:DrawModel()
                        end
        else
                self:SetRenderOrigin( nil )
                self:SetRenderAngles( nil )
                self:DrawModel()
        end
end

function SWEP:IndividualThink()
	self.EffectiveRange = 136.8 * 39.37
	self.DamageFallOff = .34
	
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 20.52 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .051))
	end
	if self.ActiveAttachments.md_saker222 then
	self.EffectiveRange = ((self.EffectiveRange - 34.2 * 39.37))
	end
end