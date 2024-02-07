AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "KSG-12"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "k"
	killicon.Add("cw_tr09_ksg12", "vgui/kills/cw_tr09_ksg12_kill", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("vgui/kills/cw_tr09_ksg12_select")
	
	function SWEP:getMuzzlePosition()
		return self.CW_VM:GetAttachment(self.CW_VM:LookupAttachment(self.MuzzleAttachmentName))
	end
	
	SWEP.MuzzleEffect = "muzzleflash_m3"
	SWEP.MuzzleAttachmentName = "muzzle"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 0
	SWEP.Shell = "shotshell"
	SWEP.ShellDelay = 0.5
	
	SWEP.ShellPosOffset = {x = 3, y = -15, z = -1}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 1
	
	SWEP.SightWithRail = false
		
	SWEP.IronsightPos = Vector(-2.41, -5, 0.4)
	SWEP.IronsightAng = Vector(-0.3, 0.08, 0)
	SWEP.FOVPerShot = 0

	SWEP.MicroT1Pos = Vector(-2.425, -3, 0.43)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.CmorePos = Vector(-2.425, -7, 0.235)
	SWEP.CmoreAng = Vector(0, 0, 0)
	
	SWEP.WS_CMOREPos = Vector(-2.41, -7, 0.235)
	SWEP.WS_CMOREAng = Vector(0, 0, 0)
	
	SWEP.ReflexPos = Vector(-2.425, -7, 0.43)
	SWEP.ReflexAng = Vector(0, 0, 0)
	
	SWEP.CoD4ReflexPos = Vector(-2.405, -8, 0.53)
	SWEP.CoD4ReflexAng = Vector(0, 0, 0)
	
	SWEP.WS_BarskaPos = Vector(-2.425, -7, 0.18)
	SWEP.WS_BarskaAng = Vector(0, 0, 0)
	
	SWEP.TrijiconPos = Vector(-2.385, -7, 0.295)
	SWEP.TrijiconAng = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.445, -6, -0.22)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.EoTech553Pos = Vector(-2.44, -6, -0.08)
	SWEP.EoTech553Ang = Vector(0, 0, 0)
	
	SWEP.WS_EoTech557Pos = Vector(-2.43, -6, 0.08)
	SWEP.WS_EoTech557Ang = Vector(0, 0, 0)
	
	SWEP.HoloPos = Vector(-2.385, -6, 0.06)
	SWEP.HoloAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-2.44, -7, 0.21)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.FAS2AimpointPos = Vector(-2.4, -7, 0.45)
	SWEP.FAS2AimpointAng = Vector(0, 0, 0)
	
	SWEP.CoD4TascoPos = Vector(-2.435, -7, 0.57)
	SWEP.CoD4TascoAng = Vector(0, 0, 0)
	
	SWEP.ELCANPos = Vector(-2.405, -6, 0.315)
	SWEP.ELCANAng = Vector(0, 0, 0)
	
	SWEP.WS_ELCANPos = Vector(-2.4, -6, -0.08)
	SWEP.WS_ELCANAng = Vector(0, 0, 0)
	SWEP.WS_ELCANAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.ACOGPos = Vector(-2.405, -6, 0.025)
	SWEP.ACOGAng = Vector(0, 0, 0)
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.SprintPos = Vector(3, -2, -1.5)
	SWEP.SprintAng = Vector(-7, 35, -15)
		
	SWEP.CustomizePos = Vector(4.431, -1.841, -1.031)
	SWEP.CustomizeAng = Vector(18.952, 31.639, 10)
	
	SWEP.AlternativePos = Vector(-0.8, 1.5, -0.32)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.41, -7, -0.92), [2] = Vector(0, 0, 0)},
	["md_elcan"] = {[1] = Vector(-2.405, -6.5, -0.305), [2] = Vector(0, -0.1, 0)}}
	
	SWEP.CustomizationMenuScale = 0.011
	SWEP.ReticleInactivityPostFire = 0.6

	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "KSG_Main", pos = Vector(-2.5, 3.41, 0.235), angle = Angle(-90, 0, -90), size = Vector(0.9, 0.9, 0.9)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "KSG_Main", pos = Vector(-10, 11.82, -0.33), angle = Angle(0, 3, -90), size = Vector(1.2, 1.2, 1.2)},
		["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "KSG_Main", rel = "", pos = Vector(6.2, -1.1, -0.03), angle = Angle(0, 0, -90), size = Vector(1.2, 1.2, 1.2)},
		["md_cod4_aimpoint_v2"] = { type = "Model", model = "models/v_cod4_aimpoint.mdl", bone = "KSG_Main", rel = "", pos = Vector(-0.7, 0.9, 0), angle = Angle(180, 0, -90), size = Vector(0.8, 0.8, 0.8)},
		["md_cod4_reflex"] = {model = "models/v_cod4_reflex.mdl", bone = "KSG_Main", rel = "", pos = Vector(0.4, 0.56, -0.01), angle = Angle(180, 0, -90), size = Vector(0.66, 0.66, 0.66)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "KSG_Main", rel = "", pos = Vector(5.4, -1.87, 0), angle = Angle(-90, 0, -90), size = Vector(0.65, 0.65, 0.65)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "KSG_Main", rel = "", pos = Vector(3.55, -1.64, 0), angle = Angle(-90, 0, -90), size = Vector(0.7, 0.7, 0.7)},
		["md_fas2_aimpoint"] = {model = "models/c_fas2_aimpoint_rigged.mdl", bone = "KSG_Main", rel = "", pos = Vector(5.5, -0.95, -0.03), angle = Angle(0, 0, -90), size = Vector(1, 1, 1)},
		["md_elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "KSG_Main", rel = "", pos = Vector(-1.2, 2.08, 0.22), angle = Angle(-90, 0, -90), size = Vector(0.65, 0.65, 0.65)},
		["md_trijicon"] = { type = "Model", model = "models/att_trijicon.mdl", bone = "KSG_Main", rel = "", pos = Vector(5.5, 0.68, -0.04), angle = Angle(-90, 0, -90), size = Vector(2, 2, 2)},
		["md_ws_c_more"] = { type = "Model", model = "models/attachments/white_snow/ws_c_more.mdl", bone = "KSG_Main", rel = "", pos = Vector(3.6, -1.77, 0.05), angle = Angle(-90, 0, -90), size = Vector(0.25, 0.25, 0.25), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
		["md_ws_elcan"] = { type = "Model", model = "models/attachments/ws_elcan.mdl", bone = "KSG_Main", rel = "", pos = Vector(-2, 1.8, 0.1), angle = Angle(0, 0, -90), size = Vector(0.7, 0.7, 0.7)},
		["md_ws_barska"] = { type = "Model", model = "models/attachments/white_snow/ws_barska.mdl", bone = "KSG_Main", rel = "", pos = Vector(3.4, -1.77, -0.01), angle = Angle(-90, 0, -90), size = Vector(0.2, 0.2, 0.2)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "KSG_Main", pos = Vector(3.2, -1.78, -0.02), angle = Angle(90, 0, -90), size = Vector(0.36, 0.36, 0.36)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "KSG_Main", pos = Vector(-1.7, 3.17, 0.3), angle = Angle(-90, 0, -90), size = Vector(0.85, 0.85, 0.85)},
		["md_fas2_holo"] = { type = "Model", model = "models/v_holo_sight_kkrc.mdl", bone = "KSG_Main", rel = "", pos = Vector(0.6, 2.48, -0.03), angle = Angle(0, 0, -90), size = Vector(0.75, 0.75, 0.75)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "KSG_Foreend", rel = "", pos = Vector(7.5, 3.1, -0.35), angle = Angle(90, 0, -90), size = Vector(0.7, 0.7, 0.7)},
		["md_ws_eotech557"] = {model = "models/attachments/ws_eotech557.mdl", bone = "KSG_Main", pos = Vector(-5.2, 3.85, 0.9), angle = Angle(0, 0, -90), size = Vector(1, 1, 1)},
		["md_ws_scifi_silencer"] = {model = "models/attachments/white_snow/ws_scifi_silencer.mdl", bone = "KSG_Main", pos = Vector(-22.07, 5.43, 2.815), angle = Angle(-90, 90, 0), size = Vector(1.05, 1.05, 1.05)},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "KSG_Main", pos = Vector(14.44, -0.55, -1.23), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "KSG_Main", pos = Vector(8, -1.58, 0.1), angle = Angle(180, 0, -90), size = Vector(0.5, 0.5, 0.5)}
	}
	
	function SWEP:RenderTargetFunc()
		local fagal = self.AttachmentModelsVM.md_ws_c_more.ent
		fagal:SetSkin(1)
	end
	
	SWEP.ForeGripHoldPos = {
		["L Finger1"] = {pos = Vector(0, 0, 0), angle = Angle(-23.357, 60, -10)},
		["L Finger32"] = {pos = Vector(0, 0, 0), angle = Angle(13.309, 47.661, 10.407)},
		["L Finger12"] = {pos = Vector(0, 0, 0), angle = Angle(0, 12.979, 7.466)},
		["L ForeTwist2"] = {pos = Vector(0, 0, 0), angle = Angle(0, 0, 31.034)},
		["L Clavicle"] = {pos = Vector(-4.35, -0.101, -3.701), angle = Angle(-45.389, 11.843, 0)},
		["L Finger41"] = {pos = Vector(0, 0, 0), angle = Angle(0, 4.442, 0)},
		["L Hand"] = {pos = Vector(0, 0, 0), angle = Angle(-6, 4, 5)},
		["L Forearm"] = {pos = Vector(0, 0, 0), angle = Angle(0, 0, 42.409)},
		["L Finger3"] = {pos = Vector(0, 0, 0), angle = Angle(-18.639, 30.143, 32.513)},
		["L Finger01"] = {pos = Vector(0, 0, 0), angle = Angle(-10.24, 20, -10)},
		["L Finger0"] = {pos = Vector(0, 0, 0), angle = Angle(25, 25, -15)},
		["L Finger42"] = {pos = Vector(0, 0, 0), angle = Angle(-3.692, 75.577, 9.937)},
		["L UpperArm"] = {pos = Vector(-0.027, -0.058, 0), angle = Angle(-11.436, 0, -9.714)},
		["L Finger22"] = {pos = Vector(0, 0, 0), angle = Angle(5, 56.577, 16.069)},
		["L Finger4"] = {pos = Vector(0, 0, 0), angle = Angle(-36.786, 12.656, 7.21)},
		["L Finger02"] = {pos = Vector(0, 0, 0), angle = Angle(0, 72, 0)},
		["L Finger31"] = {pos = Vector(0, 0, 0), angle = Angle(-1.043, 4.705, 0)},
		["L ForeTwist4"] = {pos = Vector(0, 0, 0), angle = Angle(0, 0, 27)},
		["L Finger11"] = {pos = Vector(0, 0, 0), angle = Angle(-25.38, -17.873, 7.16)},
		["L Finger21"] = {pos = Vector(0, 0, 0), angle = Angle(4.458, -23.292, 0)},
		["L ForeTwist"] = {pos = Vector(0, 0, 0), angle = Angle(0, 0, -46.444)},
		["L Finger2"] = {pos = Vector(0, 0, 0), angle = Angle(-22.543, 57.407, 30.131)}
	}
	
	SWEP.LuaVMRecoilAxisMod = {vert = 0, hor = 0, roll = 0, forward = 0, pitch = 0}
	
	SWEP.LaserPosAdjust = Vector(0.5, 0, 0.3)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
end

SWEP.SightBGs = {main = 1, none = 1}
SWEP.ADSFireAnim = true

SWEP.AttachmentDependencies = {["md_ws_scifi_silencer"] = {"bg_tr09_ksg12_scifi"}}

	SWEP.Attachments = {[1] = {header = "Sight", offset = {-50, -400}, atts = {"md_microt1",  "md_reflex", "md_trijicon", "md_eotech", "md_fas2_eotech",  "md_aimpoint", "md_fas2_aimpoint", "md_acog"}},
		[2] = {header = "Suppressor", offset = {-500, -250}, atts = {"md_tundra9mm"}},
		[3] = {header = "Laser", offset = {-500, 150}, atts = {"md_anpeq15"}},
		[4] = {header = "Grip", offset = {150, 400}, atts = {"md_foregrip"}},
		[5] = {header = "Perks", offset = {-100, -50}, atts = {"Cod_Extreme_Conditioning", "Cod_Fast_Hands", "Cod_Steady_Aim", "Perk_Force", "Cod_Double_Tap", "Perk_Stopping_Power"}},
		["impulse 100"] = {header = "Skins", offset = {600, 400}, atts = {"bg_tr09_ksg12_dirty", "bg_tr09_ksg12_scifi"}},
		["+reload"] = {header = "Ammo", offset = {750, 0}, atts = {"am_flechetterounds2", "am_slugrounds2", "am_shrapnel2", "am_minishells2", "am_sabots2", "am_dragonsbreath2", "am_explosive2", "am_kristallnacht2"}}}
	


SWEP.Animations = {fire = {"base_fire", "base_fire2"},
	reload_start = "base_reload_start",
	insert = "base_reload_insert",
	reload_end = "base_reload_end",
	empty = "base_dryfire",
	idle = "base_idle",
	draw = "base_ready"}
	
	
SWEP.Sounds = {base_fire = {{time = 0.3, sound = "CW_KSG12_PUMP"}},
	
	base_fire2 = {{time = 0.3, sound = "CW_KSG12_PUMP"}},

	base_reload_start = {{time = 0, sound = "CW_FOLEY_LIGHT"}},
	
	base_reload_insert = {{time = 0.07, sound = "CW_KSG12_INSERT"}},
	
	base_reload_end_empty = {{time = 0.3, sound = "CW_KSG12_PUMP"}},
	
	base_ready = {{time = 0.6, sound = "CW_KSG12_PUMP"}}}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "shotgun"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"pump"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 TheRambotnic09"

SWEP.Author			= "TheRambotnic09, White Snow & Niggarto El Negro" --These guys are such awesome friends! (^_^)
SWEP.Contact		= ""
SWEP.Purpose		= "To kill bad guys. Duh!"
SWEP.Instructions	= "Press your primary PEW-PEW key to kill the bad guys."

SWEP.ViewModelFOV	= 65
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/therambotnic09/v_rafael_ksg.mdl"
SWEP.WorldModel		= "models/weapons/therambotnic09/w_rafael_ksg.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/therambotnic09/w_rafael_ksg.mdl"
SWEP.WMPos = Vector(-1, 5, 1.5)
SWEP.WMAng = Vector(0, 0, 180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 14
SWEP.Primary.DefaultClip	= 70
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Buckshot"

SWEP.FireDelay = 1
SWEP.FireSound = "CW_KSG12_FIRE"
SWEP.FireSoundSuppressed = "CW_KSG12_FIRE_SILENCED"
SWEP.Recoil = 3

SWEP.HipSpread = 0.06
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.9
SWEP.MaxSpreadInc = 0.06
SWEP.ClumpSpread = 0.015
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.8
SWEP.Shots = 12
SWEP.Damage = 27
SWEP.DeployTime = 2

SWEP.ReloadStartTime = 0.2
SWEP.InsertShellTime = 0.2
SWEP.ReloadFinishWait = nil
SWEP.ShotgunReload = true

SWEP.Chamberable = false

function SWEP:IndividualThink()
	self.Animations.draw = "base_draw"

	if self.Animations.draw == "base_draw" then
		self.DeployTime = 0.3
	end
 
 
	if self:Clip1() <= 0 then
		empty = true
	end
  
	if empty then
		self.Animations.reload_end = "base_reload_end_empty"    
		self.ReloadFinishWait = 1
	else
		self.Animations.reload_end = "base_reload_end"
		self.ReloadFinishWait = 0.4
		empty = false
	end

end