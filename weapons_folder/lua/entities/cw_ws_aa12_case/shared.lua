if CustomizableWeaponry_WS_CASES then

ENT.Type = "anim"
ENT.Base = "cw_ws_case_base"
ENT.Category = "CW 2.0 Cases"
 
ENT.PrintName = "AA-12 Shotgun Case"
ENT.Author = "White Snow"
ENT.Contact = "Steam"
ENT.Purpose = "Case of AA-12s"
ENT.Instructions = "stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true

ENT.HealthAmount = 250 
ENT.Model = "models/cw2/cases/AA12_case.mdl"
ENT.WepWorldModel = "models/weapons/cw2/w_ws_aa12.mdl"

ENT.BodyGroupCoverMain = 1
ENT.BodyGroupOpenSet = 1
ENT.BodyGroupCloseSet = 0

ENT.WeaponUsed= "cw_ws_aa12"

ENT.GunsNum = 2
ENT.upOffset = Vector(0, 0, 50)

ENT.wepBGGunsTableMain = {2,3} 
ENT.wepBGAmmoTableMain = {4,5} 

ENT.wepBGGunsTableStored = {0,0} 
ENT.wepBGAmmoTableStored = {0,0} 

ENT.wepBGGunsTableGone = {1,1} 
ENT.wepBGAmmoTableGone = {1,1} 

end